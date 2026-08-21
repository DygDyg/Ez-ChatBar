local _, ns = ...

local buttons = {}

local SKIN = {
    [1] = { -- square
        bubble = "Interface\\AddOns\\EZChatBar\\image\\skins\\square1\\bubble",
        glow = "Interface\\AddOns\\EZChatBar\\image\\skins\\square1\\glow",
    },
    [2] = { -- circle
        bubble = "Interface\\AddOns\\EZChatBar\\image\\skins\\bubble1\\bubble",
        glow = "Interface\\AddOns\\EZChatBar\\image\\skins\\bubble1\\glow",
    },
}

local function NormalizeShape(shape)
    shape = tonumber(shape) or 1
    if shape ~= 1 and shape ~= 2 then
        return 1
    end
    return shape
end

local function IsAllowed(perm)
    perm = tonumber(perm) or 1

    if perm == 1 then
        return true
    elseif perm == 2 then
        return IsInGroup() and not IsInRaid()
    elseif perm == 3 then
        return IsInRaid()
    elseif perm == 4 then
        return IsInRaid() and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))
    elseif perm == 5 then
        return IsInGuild()
    elseif perm == 6 then
        return IsInGuild() and C_GuildInfo.CanEditOfficerNote()
    elseif perm == 7 then
        -- LE_PARTY_CATEGORY_INSTANCE == 2 (instance/LFG group)
        local category = LE_PARTY_CATEGORY_INSTANCE or 2
        return IsInGroup(category)
    end

    return false
end

-- Clicking a bubble steals focus from chat BEFORE OnClick, so live GetText() is often empty.
-- Cache text from edit boxes while the player is typing / on focus loss.
local lastChatText = ""

local function CacheChatText(editBox)
    if editBox and editBox.GetText then
        lastChatText = editBox:GetText() or ""
    end
end

local function HookChatEditBox(editBox)
    if not editBox or editBox.ezcbHooked then
        return
    end
    editBox.ezcbHooked = true
    editBox:HookScript("OnTextChanged", function(self)
        CacheChatText(self)
    end)
    editBox:HookScript("OnEditFocusLost", function(self)
        CacheChatText(self)
    end)
    editBox:HookScript("OnEditFocusGained", function(self)
        CacheChatText(self)
    end)
end

local function HookAllChatEditBoxes()
    local n = NUM_CHAT_WINDOWS or 10
    for i = 1, n do
        HookChatEditBox(_G["ChatFrame" .. i .. "EditBox"])
    end
    if DEFAULT_CHAT_FRAME then
        HookChatEditBox(DEFAULT_CHAT_FRAME.editBox)
    end
end

local chatHookFrame = CreateFrame("Frame")
chatHookFrame:RegisterEvent("PLAYER_LOGIN")
chatHookFrame:SetScript("OnEvent", function()
    HookAllChatEditBoxes()
end)
HookAllChatEditBoxes()

local function GetChatInputText()
    local active = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow()
    if active then
        CacheChatText(active)
        return lastChatText
    end

    local n = NUM_CHAT_WINDOWS or 10
    for i = 1, n do
        local editBox = _G["ChatFrame" .. i .. "EditBox"]
        if editBox and editBox.GetText then
            local text = editBox:GetText() or ""
            if text ~= "" then
                lastChatText = text
                return text
            end
        end
    end

    return lastChatText or ""
end

local function IsKeystoneItem(itemID, link)
    if itemID and C_Item.IsItemKeystoneByID(itemID) then
        return true
    end
    if type(link) == "string" then
        if link:find("|Hkeystone:", 1, true) then
            return true
        end
        if C_Item.IsItemKeystoneByID(link) then
            return true
        end
    end
    if itemID then
        local _, _, _, _, _, classID, subClassID = C_Item.GetItemInfoInstant(itemID)
        if classID and Enum and Enum.ItemClass and Enum.ItemReagentSubclass then
            if classID == Enum.ItemClass.Reagent and subClassID == Enum.ItemReagentSubclass.Keystone then
                return true
            end
        end
    end
    return false
end

local function GetKeystoneLink()
    local bagIDs
    if Enum and Enum.BagIndex then
        bagIDs = {
            Enum.BagIndex.Backpack,
            Enum.BagIndex.Bag_1,
            Enum.BagIndex.Bag_2,
            Enum.BagIndex.Bag_3,
            Enum.BagIndex.Bag_4,
            Enum.BagIndex.ReagentBag,
        }
    else
        local maxBag = NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS or 4
        bagIDs = {}
        for bag = (BACKPACK_CONTAINER or 0), maxBag do
            bagIDs[#bagIDs + 1] = bag
        end
    end

    local hasOwned = C_MythicPlus and C_MythicPlus.GetOwnedKeystoneLevel and C_MythicPlus.GetOwnedKeystoneLevel()

    for _, bag in ipairs(bagIDs) do
        local slots = C_Container.GetContainerNumSlots(bag) or 0
        for slot = 1, slots do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            local itemID = (info and info.itemID) or C_Container.GetContainerItemID(bag, slot)
            local link = (info and info.hyperlink) or C_Container.GetContainerItemLink(bag, slot)

            if (itemID or link) and IsKeystoneItem(itemID, link) then
                if (not link or link == "") and ItemLocation and C_Item.GetItemLink then
                    local loc = ItemLocation:CreateFromBagAndSlot(bag, slot)
                    if loc and C_Item.DoesItemExist(loc) then
                        link = C_Item.GetItemLink(loc)
                    end
                end
                if link and link ~= "" then
                    return link
                end
            end

            -- Last-resort: owned keystone exists, accept any keystone hyperlink shape.
            if hasOwned and type(link) == "string" and link:lower():find("keystone", 1, true) then
                return link
            end
        end
    end

    return ""
end

local function AppendToEditBox(editBox, value)
    if not editBox or not value or value == "" then
        return
    end
    if editBox.Insert then
        editBox:Insert(value)
    else
        editBox:SetText((editBox:GetText() or "") .. value)
    end
end

-- Open slash/literal first, then append #text# / #key# after the edit box is active.
local function OpenChatWithTemplates(cmd, preText, preKey)
    if type(cmd) ~= "string" or cmd == "" then
        return
    end

    HookAllChatEditBoxes()

    local chatFrame = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
    local textVal = preText
    if textVal == nil or textVal == "" then
        textVal = GetChatInputText()
    end
    local keyVal = preKey
    if keyVal == nil or keyVal == "" then
        keyVal = GetKeystoneLink()
    end

    if not cmd:find("#text#", 1, true) and not cmd:find("#key#", 1, true) then
        ChatFrame_OpenChat(cmd, chatFrame)
        return
    end

    local segments = {}
    local pos = 1
    local cmdLen = #cmd
    while pos <= cmdLen do
        local textPos = cmd:find("#text#", pos, true)
        local keyPos = cmd:find("#key#", pos, true)
        local nextPos, tokenLen, tokenType

        if textPos and (not keyPos or textPos <= keyPos) then
            nextPos, tokenLen, tokenType = textPos, 6, "text"
        elseif keyPos then
            nextPos, tokenLen, tokenType = keyPos, 5, "key"
        else
            segments[#segments + 1] = { kind = "lit", value = cmd:sub(pos) }
            break
        end

        if nextPos > pos then
            segments[#segments + 1] = { kind = "lit", value = cmd:sub(pos, nextPos - 1) }
        end

        if tokenType == "text" then
            segments[#segments + 1] = { kind = "text", value = textVal }
        else
            segments[#segments + 1] = { kind = "key", value = keyVal }
        end

        pos = nextPos + tokenLen
    end

    local openText = ""
    local startIndex = 1
    if segments[1] and segments[1].kind == "lit" then
        openText = segments[1].value
        startIndex = 2
    end

    ChatFrame_OpenChat(openText, chatFrame)

    local function finishInsert()
        local editBox = ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow()
        if not editBox and chatFrame then
            editBox = chatFrame.editBox
        end
        if not editBox then
            return
        end

        for i = startIndex, #segments do
            local seg = segments[i]
            if seg and seg.value and seg.value ~= "" then
                AppendToEditBox(editBox, seg.value)
            end
        end
    end

    -- Defer one frame so OpenChat finishes activating the edit box.
    if C_Timer and C_Timer.After then
        C_Timer.After(0, finishInsert)
    else
        finishInsert()
    end
end

local function FirstCommandLetter(cmd)
    if type(cmd) ~= "string" then
        return "?"
    end
    local token = cmd:match("^/?(%a+)") or cmd:match("(%a)")
    if token and token ~= "" then
        return token:sub(1, 1):upper()
    end
    return "?"
end

local function RecreateTexture(btn, key, layer)
    if btn[key] then
        btn[key]:Hide()
        btn[key]:SetParent(nil)
        btn[key] = nil
    end
    local tex = btn:CreateTexture(nil, layer or "BACKGROUND")
    btn[key] = tex
    return tex
end

local function SetLabelContrast(btn, r, g, b)
    if not btn.label then
        return
    end
    local lum = 0.299 * r + 0.587 * g + 0.114 * b
    if lum > 0.55 then
        btn.label:SetTextColor(0, 0, 0, 1)
    else
        btn.label:SetTextColor(1, 1, 1, 1)
    end
end

local function ApplyShape(btn, shape, r, g, b)
    shape = NormalizeShape(shape)
    local skin = SKIN[shape] or SKIN[1]

    if btn._shape ~= shape then
        RecreateTexture(btn, "bg", "BACKGROUND")
        RecreateTexture(btn, "glow", "ARTWORK")
        btn._shape = shape
    end

    if not btn.bg then
        btn.bg = btn:CreateTexture(nil, "BACKGROUND")
    end
    if not btn.glow then
        btn.glow = btn:CreateTexture(nil, "ARTWORK")
    end

    btn.bg:ClearAllPoints()
    btn.bg:SetAllPoints()
    btn.bg:SetTexture(skin.bubble)
    btn.bg:SetVertexColor(r, g, b, 1)
    btn.bg:Show()

    btn.glow:ClearAllPoints()
    btn.glow:SetAllPoints()
    btn.glow:SetTexture(skin.glow)
    btn.glow:SetVertexColor(r, g, b, 1)
    btn.glow:Hide()

    if btn.SetBackdropColor then
        btn:SetBackdropColor(0, 0, 0, 0)
    end

    SetLabelContrast(btn, r, g, b)
end

local function GetButton(index)
    if buttons[index] then
        return buttons[index]
    end

    local btn = CreateFrame("Button", nil, ns.anchor, "BackdropTemplate")
    btn:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8" })
    btn:RegisterForClicks("AnyUp")
    btn:EnableMouse(true)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(10 + index)

    btn.label = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    btn.label:SetPoint("CENTER")
    btn.label:SetTextColor(0, 0, 0, 1)

    btn:SetScript("OnEnter", function(self)
        self:SetAlpha(1)
        if self.glow then
            self.glow:Show()
        end
        if self.cmd then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.cmd, 1, 1, 1, 1, true)
            GameTooltip:Show()
        end
    end)

    btn:SetScript("OnLeave", function(self)
        if self.glow then
            self.glow:Hide()
        end
        GameTooltip:Hide()
    end)

    btn:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            -- Snapshot before focus fully leaves the chat edit box.
            self._ezcbText = GetChatInputText()
            self._ezcbKey = GetKeystoneLink()
        end
    end)

    btn:SetScript("OnClick", function(self, button)
        if button ~= "LeftButton" or not self.cmd then
            return
        end
        OpenChatWithTemplates(self.cmd, self._ezcbText, self._ezcbKey)
        self._ezcbText, self._ezcbKey = nil, nil
    end)

    buttons[index] = btn
    return btn
end

function ns:UpdateBubbles()
    self:EnsureConfig()
    if not self.anchor then
        return
    end

    local cfg = self.config
    local bubbles = cfg.bubbles or {}
    local size = tonumber(cfg.size_btn) or 14
    local gap = tonumber(cfg.interval_btn) or 4
    local orient = tonumber(cfg.Orientation) or 1
    local shape = NormalizeShape(cfg.shape)
    cfg.shape = shape
    local showLabel = not not cfg.button_label

    -- pairs: #buttons breaks on holes when some bubbles are permission-hidden
    for _, btn in pairs(buttons) do
        btn:Hide()
    end

    local last
    local shown = 0
    for _, bubble in ipairs(bubbles) do
        if IsAllowed(bubble.perm) then
            shown = shown + 1
            local btn = GetButton(shown)
            btn:SetSize(size, size)
            btn:ClearAllPoints()

            if not last then
                if orient == 2 then
                    btn:SetPoint("LEFT", self.anchor, "RIGHT", gap, 0)
                else
                    btn:SetPoint("TOP", self.anchor, "BOTTOM", 0, -gap)
                end
            else
                if orient == 2 then
                    btn:SetPoint("LEFT", last, "RIGHT", gap, 0)
                else
                    btn:SetPoint("TOP", last, "BOTTOM", 0, -gap)
                end
            end

            local r, g, b = 1, 1, 1
            if type(bubble.color) == "table" then
                r = tonumber(bubble.color[1]) or 1
                g = tonumber(bubble.color[2]) or 1
                b = tonumber(bubble.color[3]) or 1
            end

            ApplyShape(btn, shape, r, g, b)
            btn.cmd = bubble.cmd

            if showLabel then
                btn.label:SetText(FirstCommandLetter(bubble.cmd))
                btn.label:Show()
            else
                btn.label:Hide()
            end

            btn:Show()
            last = btn
        end
    end
end
