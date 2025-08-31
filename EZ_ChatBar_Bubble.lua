local LCG = LibStub("LibCustomGlow-1.0")
local editBox = ChatEdit_ChooseBoxForSend();
local chatFrame = editBox.chatFrame;
local messageTypeList = editBox.chatFrame.messageTypeList;
local channelList = editBox.chatFrame.channelList;
local text = editBox:GetText()

-- if(aura_env==nil) then
local aura_env = aura_env or _G.EzChatBar;
-- end

local bubl_it = 1

local perms_name = {
    "ALL",
    "PARTY",
    "RAID",
    "RAID_WARNING",
    "GUILD",
    "OFFICER",
    "INSTANCE_CHAT",
}


local perms =
{
    ["ALL"] = function() return true end,
    ["PARTY"] = function() return UnitExists("party1") end,
    ["RAID"] = function() return IsInRaid() end,
    ["RAID_WARNING"] = function() return IsInRaid() and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) end,
    ["GUILD"] = function() return IsInGuild() end,
    ["OFFICER"] = function() return C_GuildInfo.CanEditOfficerNote() end,
    ["INSTANCE_CHAT"] = function() return IsInInstance() end,
}


--[[     cmd = "#key#",
    perm = "ALL",
    -- title=EZCHATBAR_CHATBARCOLOR_TITLE_KEY,
    r = 255 / 255,
    g = 0 / 255,
    b = 255 / 255, ]]


-- local editBox, chatFrame, messageTypeList, channelList = CBCPanelUpdate()

function aura_env.Dyg_Variables(str)
    
    if(string.match(str, "#key#"))then
        for b = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
            for s = 1, C_Container.GetContainerNumSlots(b) do
                
                local a = C_Container.GetContainerItemLink(b, s)
                if a then
                    if(string.find(a, "keystone")) then
                        str = string.gsub(str, "#key#", a)
                    end
                end
            end
        end
        str = string.gsub(str, "#key#", "0")
    end
    if(string.match(str, "#text#")) then
        str = string.gsub(str, "#text#", editBox:GetText())
    end
    
    return str;
end

function aura_env.SetBubble(param_, aura_env)
    if(aura_env.addon) then aura_env = _G.EzChatBar end
    if perms[param_["perm"]]() == false then return end
    if not aura_env.region.framedata then
        aura_env.region.framedata = {}
        aura_env.region:RegisterEvent("UPDATE_CHAT_COLOR");
        aura_env.region:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
        aura_env.region:RegisterEvent("GROUP_ROSTER_UPDATE");
        aura_env.region:RegisterEvent("PLAYER_GUILD_UPDATE");
        
        aura_env.region:SetScript("OnEvent", function(...)
                aura_env.update_btn(aura_env)
        end)
    end
    if not aura_env.region.framedata[bubl_it] then
        aura_env.region.framedata[bubl_it] = CreateFrame("Frame", "EZ_BUBBLE_" .. bubl_it, aura_env.region,
        BackdropTemplateMixin and "BackdropTemplate")
        aura_env.region.framedata[bubl_it].mask = CreateFrame("Frame", "EZ_BUBBLE_mask", aura_env.region.framedata[bubl_it],
        BackdropTemplateMixin and "BackdropTemplate")
        aura_env.region.framedata[bubl_it].mask:Hide()

    end
    if not aura_env.region.bg then
        aura_env.region.bg = CreateFrame("Frame", "EZ_BUBBLE_BG", aura_env.region,
        BackdropTemplateMixin and "BackdropTemplate")
    end
    aura_env.region.bg:ClearAllPoints();
    if(aura_env.config["Orientation"]==1) then
        aura_env.region.bg:SetSize(aura_env.config["size_btn"] + 8, (aura_env.config["size_btn"] + aura_env.config["interval_btn"]) * bubl_it + 4)
        aura_env.region.bg:SetPoint("TOP", aura_env.region, "BOTTOM", 0, -1)
    end

    if(aura_env.config["Orientation"]==2) then
        aura_env.region.bg:SetSize((aura_env.config["size_btn"] + aura_env.config["interval_btn"]) * bubl_it + 4, aura_env.config["size_btn"] + 8)
        -- aura_env.region.bg:SetPoint("TOP", aura_env.region, "BOTTOM", 0, 5)
        aura_env.region.bg:SetPoint("LEFT", aura_env.region, "RIGHT", 1, 0)
    end

    aura_env.region.bg:SetFrameStrata("BACKGROUND")
    
    

    
    aura_env.region.bg:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",     -- Одноцветная текстура
            edgeFile = nil,
            tile = false,
            tileSize = 0,
            edgeSize = 0,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    

    
    aura_env.region.bg:SetBackdropColor(0, 0, 0, 0.4)
    
    aura_env.region.bg:Show()
    
    aura_env.region.framedata[bubl_it]:Show()
    aura_env.region.framedata[bubl_it]:SetSize(aura_env.config["size_btn"], aura_env.config["size_btn"])
    
    aura_env.region.framedata[bubl_it]:ClearAllPoints();
    if(aura_env.config["Orientation"]==1) then
        aura_env.region.framedata[bubl_it]:SetPoint("TOP", aura_env.region, "BOTTOM", 0,
            (-aura_env.config["interval_btn"] - aura_env.config["size_btn"]) * bubl_it + aura_env.config["size_btn"])
    end
    if(aura_env.config["Orientation"]==2) then
        aura_env.region.framedata[bubl_it]:SetPoint("LEFT", aura_env.region, "RIGHT", 
            (aura_env.config["interval_btn"] + aura_env.config["size_btn"]) * bubl_it - aura_env.config["size_btn"], 0)
    end

    if(aura_env.config["shape"]==1) then
    -- Добавляем текстуру
        aura_env.region.framedata[bubl_it]:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8x8",
                -- bgFile = "Interface\\Buttons\\WHITE8x8",
                edgeFile = nil,
                tile = false,
                tileSize = 0,
                edgeSize = 0,
                insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
    end
    if(aura_env.config["shape"]==2) then
    -- Добавляем текстуру
        aura_env.region.framedata[bubl_it]:SetBackdrop({
                bgFile = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Smooth",
                -- bgFile = "424570",
                edgeFile = nil,
                tile = false,
                tileSize = 0,
                edgeSize = 0,
                insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        aura_env.region.framedata[bubl_it].mask:SetSize(aura_env.config["size_btn"], aura_env.config["size_btn"])
    
        -- Размещаем под родителем
        aura_env.region.framedata[bubl_it].mask:SetPoint("TOP", aura_env.region.framedata[bubl_it], "TOP", 0, 0)


        aura_env.region.framedata[bubl_it].mask:SetBackdrop({
            bgFile = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_AlphaGradient_In.tga",
            
            edgeFile = nil,
            tile = false,
            tileSize = 0,
            edgeSize = 0,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        
    end
    if(aura_env.config["shape"]==3) then
    -- Добавляем текстуру
        aura_env.region.framedata[bubl_it]:SetBackdrop({
                bgFile = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Squirrel",
                edgeFile = nil,
                tile = false,
                tileSize = 0,
                edgeSize = 0,
                insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        aura_env.region.framedata[bubl_it].mask:SetSize(aura_env.config["size_btn"], aura_env.config["size_btn"])
    
        -- Размещаем под родителем
        aura_env.region.framedata[bubl_it].mask:SetPoint("TOP", aura_env.region.framedata[bubl_it], "TOP", 0, 0)


        aura_env.region.framedata[bubl_it].mask:SetBackdrop({
            -- bgFile = "128-Store-Main",
            bgFile = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_AlphaGradient_In.tga",
            edgeFile = nil,
            tile = false,
            tileSize = 0,
            edgeSize = 0,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        
    end
    if(aura_env.config["shape"]==4) then
    -- Добавляем текстуру
        aura_env.region.framedata[bubl_it]:SetBackdrop({
                bgFile = "424570",
                edgeFile = nil,
                tile = false,
                tileSize = 0,
                edgeSize = 0,
                insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        aura_env.region.framedata[bubl_it].mask:SetSize(aura_env.config["size_btn"], aura_env.config["size_btn"])
    
        -- Размещаем под родителем
        aura_env.region.framedata[bubl_it].mask:SetPoint("TOP", aura_env.region.framedata[bubl_it], "TOP", 0, 0)


        aura_env.region.framedata[bubl_it].mask:SetBackdrop({
            -- bgFile = "128-Store-Main",
            bgFile = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_AlphaGradient_In.tga",
            edgeFile = nil,
            tile = false,
            tileSize = 0,
            edgeSize = 0,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        
    end
    aura_env.region.framedata[bubl_it]:SetBackdropColor(param_["r"], param_["g"], param_["b"], 1)
    aura_env.region.framedata[bubl_it].color = param_["cmd"] ..
    " " .. param_["r"] .. " " .. param_["g"] .. " " .. param_["b"] .. " " .. bubl_it
    aura_env.region.framedata[bubl_it]:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" then
                ChatFrame_OpenChat(aura_env.Dyg_Variables(param_["cmd"]), chatFrame);
            end
    end)
    
    
    aura_env.region.framedata[bubl_it]:SetScript("OnEnter", function(self)
        if(aura_env.config["shape"]==1) then
            LCG.ButtonGlow_Start(self)
        end

        if(aura_env.config["shape"]==2) then
            -- LCG.PixelGlow_Start(self, {0, 0.8, 1, 1}, 6, 0.02, 2, 30, 0, 0, true)
            self.mask:Show()
        end

        if(aura_env.config["shape"]==3) then
            self.mask:Show()
        end

        if(aura_env.config["shape"]==4) then
            self.mask:Show()
        end
    end)
    
    aura_env.region.framedata[bubl_it]:SetScript("OnLeave", function(self)
        if(aura_env.config["shape"]==1) then
            LCG.ButtonGlow_Stop(self)
        end
        if(aura_env.config["shape"]==2) then
            self.mask:Hide()
            -- LCG.PixelGlow_Stop(self)
        end
        if(aura_env.config["shape"]==3) then
            self.mask:Hide()
        end
        if(aura_env.config["shape"]==4) then
            self.mask:Hide()
        end
    end)

    -- Добавление буквы G в центр бабла
    if not aura_env.region.framedata[bubl_it].text then
        aura_env.region.framedata[bubl_it].text = aura_env.region.framedata[bubl_it]:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        aura_env.region.framedata[bubl_it].text:SetPoint("CENTER")
        aura_env.region.framedata[bubl_it].text:SetTextColor(1, 1, 1, 1)  -- Белый цвет для текста (светлый на тёмной теме)
        aura_env.region.framedata[bubl_it].text:SetFont("Fonts\\FRIZQT__.TTF", aura_env.config["size_btn"] / 1.1, "OUTLINE")  -- Размер шрифта адаптирован под кнопку
        -- print(string.upper(string.gsub(param_["cmd"], "/", ""):sub(1, 1)))
    end
    aura_env.region.framedata[bubl_it].text:SetText(string.upper(string.gsub(param_["cmd"], "/", ""):sub(1, 1)))

    bubl_it = bubl_it + 1
end

function aura_env.update_btn(aura_env)
    bubl_it = 1
    if(aura_env.addon) then aura_env = _G.EzChatBar end
    if aura_env.region then
        for _, child in ipairs({ aura_env.region:GetChildren() }) do
            local name = child:GetName()
            if name and name:find("^EZ_BUBBLE_") then
                child:Hide()
            end
        end
    end
    for key, value in pairs(aura_env.config["bubbles"]) do
        aura_env.SetBubble({
                cmd = value["cmd"],
                perm = perms_name[value["perm"]],
                r = value["color"][1],
                g = value["color"][2],
                b = value["color"][3],
                
        }, aura_env)
    end
end
if(not aura_env.addon) then
    aura_env.update_btn(aura_env)
end