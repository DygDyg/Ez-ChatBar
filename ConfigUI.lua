local _, ns = ...
local L = ns.L

local UI

local PERM_LABELS = {
    [1] = L.PERM_ALL,
    [2] = L.PERM_PARTY,
    [3] = L.PERM_RAID,
    [4] = L.PERM_RW,
    [5] = L.PERM_GUILD,
    [6] = L.PERM_OFFICER,
    [7] = L.PERM_INSTANCE,
}

local ORIENT_LABELS = {
    [1] = L.VERTICAL,
    [2] = L.HORIZONTAL,
}

local SHAPE_LABELS = {
    [1] = L.SHAPE_DEFAULT,
    [2] = L.SHAPE_CIRCLE,
}

local function SaveAndRefresh()
    EZ_ChatBar_Bubble.config = ns.config
    ns:Refresh()
end

local function CreateDropdown(parent, width, values, onSelect)
    local frame = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(frame, width - 20)

    function frame:SetValue(val)
        UIDropDownMenu_SetText(frame, values[val] or "")
        frame.value = val
    end

    UIDropDownMenu_Initialize(frame, function()
        local keys = {}
        for k in pairs(values) do
            keys[#keys + 1] = k
        end
        table.sort(keys)
        for _, k in ipairs(keys) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = values[k]
            info.checked = (frame.value == k)
            info.func = function()
                frame:SetValue(k)
                onSelect(k)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    return frame
end

local function OpenColorPicker(r, g, b, onChanged)
    if ColorPickerFrame and ColorPickerFrame.SetupColorPickerAndShow then
        ColorPickerFrame:SetupColorPickerAndShow({
            r = r,
            g = g,
            b = b,
            hasOpacity = false,
            swatchFunc = function()
                local nr, ng, nb = ColorPickerFrame:GetColorRGB()
                onChanged(nr, ng, nb)
            end,
            cancelFunc = function(previous)
                if previous then
                    onChanged(previous.r or r, previous.g or g, previous.b or b)
                end
            end,
        })
        return
    end

    -- Fallback for older ColorPickerFrame API
    ColorPickerFrame.hasOpacity = false
    ColorPickerFrame.previousValues = { r = r, g = g, b = b }
    ColorPickerFrame.func = function()
        local nr, ng, nb = ColorPickerFrame:GetColorRGB()
        onChanged(nr, ng, nb)
    end
    ColorPickerFrame.cancelFunc = function(previous)
        previous = previous or ColorPickerFrame.previousValues
        if previous then
            onChanged(previous.r or previous[1], previous.g or previous[2], previous.b or previous[3])
        end
    end
    ColorPickerFrame:SetColorRGB(r, g, b)
    ColorPickerFrame:Show()
end

local function RefreshBubbleList()
    if not UI or not UI.content then
        return
    end
    ns:EnsureConfig()

    if UI.rows then
        for _, row in ipairs(UI.rows) do
            row:Hide()
        end
    end
    UI.rows = {}

    local bubbles = ns.config.bubbles
    local y = -8

    for i, bubble in ipairs(bubbles) do
        local row = CreateFrame("Frame", nil, UI.content)
        row:SetSize(720, 28)
        row:SetPoint("TOPLEFT", 0, y)

        local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("LEFT", 6, 0)
        label:SetText(L.BUBBLE .. i)

        local cmd = CreateFrame("EditBox", nil, row, "InputBoxTemplate")
        cmd:SetSize(280, 22)
        cmd:SetPoint("LEFT", 90, 0)
        cmd:SetAutoFocus(false)
        cmd:SetText(bubble.cmd or "")
        cmd:SetScript("OnEnterPressed", function(self)
            bubbles[i].cmd = self:GetText()
            SaveAndRefresh()
            self:ClearFocus()
        end)
        cmd:SetScript("OnEditFocusLost", function(self)
            bubbles[i].cmd = self:GetText()
            SaveAndRefresh()
        end)

        local permDD = CreateDropdown(row, 140, PERM_LABELS, function(val)
            bubbles[i].perm = val
            SaveAndRefresh()
        end)
        permDD:SetPoint("LEFT", cmd, "RIGHT", -4, -2)
        permDD:SetValue(bubble.perm or 1)

        local colorBox = CreateFrame("Button", nil, row, "BackdropTemplate")
        colorBox:SetSize(22, 22)
        colorBox:SetPoint("LEFT", permDD, "RIGHT", 0, 2)
        colorBox:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 10,
        })

        local r, g, b = 1, 1, 1
        if type(bubble.color) == "table" then
            r = bubble.color[1] or 1
            g = bubble.color[2] or 1
            b = bubble.color[3] or 1
        end
        colorBox:SetBackdropColor(r, g, b, 1)

        colorBox:SetScript("OnClick", function()
            OpenColorPicker(r, g, b, function(nr, ng, nb)
                bubble.color = { nr, ng, nb }
                r, g, b = nr, ng, nb
                colorBox:SetBackdropColor(nr, ng, nb, 1)
                SaveAndRefresh()
            end)
        end)

        local del = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
        del:SetSize(100, 22)
        del:SetPoint("LEFT", colorBox, "RIGHT", 8, 0)
        del:SetText(L.DELETE)
        del:SetScript("OnClick", function()
            table.remove(bubbles, i)
            SaveAndRefresh()
            RefreshBubbleList()
        end)

        UI.rows[#UI.rows + 1] = row
        y = y - 32
    end

    UI.content:SetHeight(math.max(1, -y + 10))
end

function ns:ToggleConfig()
    self:EnsureConfig()
    if not UI then
        self:CreateConfigUI()
    end
    UI:SetShown(not UI:IsShown())
    if UI:IsShown() then
        RefreshBubbleList()
    end
end

function ns:CreateConfigUI()
    self:EnsureConfig()
    if UI then
        return
    end

    UI = CreateFrame("Frame", "EZChatBarConfig", UIParent, "BackdropTemplate")
    UI:SetSize(780, 560)
    UI:SetPoint("CENTER")
    UI:SetMovable(true)
    UI:EnableMouse(true)
    UI:RegisterForDrag("LeftButton")
    UI:SetScript("OnDragStart", UI.StartMoving)
    UI:SetScript("OnDragStop", UI.StopMovingOrSizing)
    UI:SetClampedToScreen(true)
    UI:SetFrameStrata("DIALOG")
    UI:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    UI:SetBackdropColor(0, 0, 0, 0.92)

    local title = UI:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", 0, -12)
    title:SetText("EZChatBar")

    local close = CreateFrame("Button", nil, UI, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)

    local hint = UI:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    hint:SetPoint("TOPLEFT", 20, -40)
    hint:SetPoint("RIGHT", -20, 0)
    hint:SetJustifyH("LEFT")
    hint:SetText(L.HINT)

    local orientDD = CreateDropdown(UI, 160, ORIENT_LABELS, function(val)
        ns.config.Orientation = val
        SaveAndRefresh()
    end)
    orientDD:SetPoint("TOPLEFT", 8, -70)
    orientDD:SetValue(ns.config.Orientation or 1)

    local orientLabel = UI:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    orientLabel:SetPoint("LEFT", orientDD, "RIGHT", 8, 2)
    orientLabel:SetText(L.ORIENTATION)

    local shapeDD = CreateDropdown(UI, 160, SHAPE_LABELS, function(val)
        ns.config.shape = (val == 2) and 2 or 1
        SaveAndRefresh()
    end)
    shapeDD:SetPoint("TOPLEFT", 8, -110)
    shapeDD:SetValue((ns.config.shape == 2) and 2 or 1)

    local shapeLabel = UI:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    shapeLabel:SetPoint("LEFT", shapeDD, "RIGHT", 8, 2)
    shapeLabel:SetText(L.SHAPE)

    local size = CreateFrame("Slider", "EZChatBarSizeSlider", UI, "OptionsSliderTemplate")
    size:SetPoint("TOPLEFT", 30, -165)
    size:SetMinMaxValues(8, 40)
    size:SetValueStep(1)
    size:SetObeyStepOnDrag(true)
    size:SetWidth(240)
    size:SetValue(ns.config.size_btn or 14)
    size:SetScript("OnValueChanged", function(_, v)
        ns.config.size_btn = math.floor(v + 0.5)
        SaveAndRefresh()
    end)
    _G.EZChatBarSizeSliderText:SetText(L.SIZE)

    local gap = CreateFrame("Slider", "EZChatBarGapSlider", UI, "OptionsSliderTemplate")
    gap:SetPoint("TOPLEFT", 30, -220)
    gap:SetMinMaxValues(0, 20)
    gap:SetValueStep(1)
    gap:SetObeyStepOnDrag(true)
    gap:SetWidth(240)
    gap:SetValue(ns.config.interval_btn or 4)
    gap:SetScript("OnValueChanged", function(_, v)
        ns.config.interval_btn = math.floor(v + 0.5)
        SaveAndRefresh()
    end)
    _G.EZChatBarGapSliderText:SetText(L.INTERVAL)

    local labels = CreateFrame("CheckButton", nil, UI, "UICheckButtonTemplate")
    labels:SetPoint("TOPLEFT", 320, -150)
    labels:SetChecked(ns.config.button_label)
    labels:SetScript("OnClick", function(self)
        ns.config.button_label = self:GetChecked() and true or false
        SaveAndRefresh()
    end)
    local labelsText = labels:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    labelsText:SetPoint("LEFT", labels, "RIGHT", 4, 0)
    labelsText:SetText(L.LABELS)

    local add = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate")
    add:SetSize(180, 26)
    add:SetPoint("TOPLEFT", 320, -190)
    add:SetText(L.ADD)
    add:SetScript("OnClick", function()
        table.insert(ns.config.bubbles, {
            cmd = "/SAY #text#",
            perm = 1,
            color = { 1, 1, 1 },
        })
        SaveAndRefresh()
        RefreshBubbleList()
    end)

    local reset = CreateFrame("Button", nil, UI, "UIPanelButtonTemplate")
    reset:SetSize(180, 26)
    reset:SetPoint("TOPLEFT", 510, -190)
    reset:SetText(L.RESET_POS)
    reset:SetScript("OnClick", function()
        if ns.ResetAnchorPosition then
            ns:ResetAnchorPosition()
        end
    end)

    local scroll = CreateFrame("ScrollFrame", "EZChatBarBubbleScroll", UI, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 18, -270)
    scroll:SetPoint("BOTTOMRIGHT", -30, 18)

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(720, 1)
    scroll:SetScrollChild(content)

    UI.scroll = scroll
    UI.content = content
    UI:Hide()
end

function ns:ShowConfig()
    self:EnsureConfig()
    if not UI then
        self:CreateConfigUI()
    end
    UI:Show()
    RefreshBubbleList()
end

function ns:RegisterBlizzardOptions()
    if self.settingsCategory then
        return
    end
    if not (Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory) then
        return
    end

    self:EnsureConfig()

    local panel = CreateFrame("Frame", "EZChatBarBlizzardOptions")
    panel:Hide()
    panel.name = "EZChatBar"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("EZChatBar")

    local desc = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    desc:SetPoint("RIGHT", -16, 0)
    desc:SetJustifyH("LEFT")
    desc:SetNonSpaceWrap(true)
    desc:SetText(L.SETTINGS_DESC)

    local hint = panel:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    hint:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -8)
    hint:SetPoint("RIGHT", -16, 0)
    hint:SetJustifyH("LEFT")
    hint:SetText(L.HINT)

    local orientDD = CreateDropdown(panel, 160, ORIENT_LABELS, function(val)
        ns.config.Orientation = val
        SaveAndRefresh()
    end)
    orientDD:SetPoint("TOPLEFT", hint, "BOTTOMLEFT", -12, -24)
    orientDD:SetValue(ns.config.Orientation or 1)

    local orientLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    orientLabel:SetPoint("LEFT", orientDD, "RIGHT", 8, 2)
    orientLabel:SetText(L.ORIENTATION)

    local shapeDD = CreateDropdown(panel, 160, SHAPE_LABELS, function(val)
        ns.config.shape = (val == 2) and 2 or 1
        SaveAndRefresh()
    end)
    shapeDD:SetPoint("TOPLEFT", orientDD, "BOTTOMLEFT", 0, -16)
    shapeDD:SetValue((ns.config.shape == 2) and 2 or 1)

    local shapeLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    shapeLabel:SetPoint("LEFT", shapeDD, "RIGHT", 8, 2)
    shapeLabel:SetText(L.SHAPE)

    local size = CreateFrame("Slider", "EZChatBarBlizSizeSlider", panel, "OptionsSliderTemplate")
    size:SetPoint("TOPLEFT", shapeDD, "BOTTOMLEFT", 20, -28)
    size:SetMinMaxValues(8, 40)
    size:SetValueStep(1)
    size:SetObeyStepOnDrag(true)
    size:SetWidth(240)
    size:SetValue(ns.config.size_btn or 14)
    size:SetScript("OnValueChanged", function(_, v)
        ns.config.size_btn = math.floor(v + 0.5)
        SaveAndRefresh()
    end)
    _G.EZChatBarBlizSizeSliderText:SetText(L.SIZE)

    local gap = CreateFrame("Slider", "EZChatBarBlizGapSlider", panel, "OptionsSliderTemplate")
    gap:SetPoint("TOPLEFT", size, "BOTTOMLEFT", 0, -28)
    gap:SetMinMaxValues(0, 20)
    gap:SetValueStep(1)
    gap:SetObeyStepOnDrag(true)
    gap:SetWidth(240)
    gap:SetValue(ns.config.interval_btn or 4)
    gap:SetScript("OnValueChanged", function(_, v)
        ns.config.interval_btn = math.floor(v + 0.5)
        SaveAndRefresh()
    end)
    _G.EZChatBarBlizGapSliderText:SetText(L.INTERVAL)

    local labels = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    labels:SetPoint("TOPLEFT", gap, "BOTTOMLEFT", -20, -20)
    labels:SetChecked(ns.config.button_label)
    labels:SetScript("OnClick", function(self)
        ns.config.button_label = self:GetChecked() and true or false
        SaveAndRefresh()
    end)
    local labelsText = labels:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    labelsText:SetPoint("LEFT", labels, "RIGHT", 4, 0)
    labelsText:SetText(L.LABELS)

    local reset = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    reset:SetSize(200, 26)
    reset:SetPoint("LEFT", labelsText, "RIGHT", 24, 0)
    reset:SetText(L.RESET_POS)
    reset:SetScript("OnClick", function()
        if ns.ResetAnchorPosition then
            ns:ResetAnchorPosition()
        end
    end)

    local openBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    openBtn:SetSize(260, 28)
    openBtn:SetPoint("TOPLEFT", labels, "BOTTOMLEFT", 0, -20)
    openBtn:SetText(L.OPEN_CONFIG)
    openBtn:SetScript("OnClick", function()
        if SettingsPanel and SettingsPanel.Close then
            HideUIPanel(SettingsPanel)
        elseif SettingsPanel then
            SettingsPanel:Hide()
        end
        ns:ShowConfig()
    end)

    panel:SetScript("OnShow", function()
        ns:EnsureConfig()
        orientDD:SetValue(ns.config.Orientation or 1)
        shapeDD:SetValue((ns.config.shape == 2) and 2 or 1)
        size:SetValue(ns.config.size_btn or 14)
        gap:SetValue(ns.config.interval_btn or 4)
        labels:SetChecked(ns.config.button_label)
    end)

    local category = Settings.RegisterCanvasLayoutCategory(panel, "EZChatBar")
    category.ID = "EZChatBar"
    Settings.RegisterAddOnCategory(category)

    self.settingsPanel = panel
    self.settingsCategory = category
end

function ns:OpenBlizzardOptions()
    self:RegisterBlizzardOptions()
    if not self.settingsCategory then
        self:ShowConfig()
        return
    end

    local categoryID = self.settingsCategory.ID or "EZChatBar"
    if Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(categoryID)
    elseif C_SettingsUtil and C_SettingsUtil.OpenSettingsPanel then
        C_SettingsUtil.OpenSettingsPanel(categoryID)
    else
        self:ShowConfig()
    end
end
