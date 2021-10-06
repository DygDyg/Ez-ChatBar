local LDBIcon = LibStub("LibDBIcon-1.0")
local LCG = LibStub("LibCustomGlow-1.0");
--LDBIcon:Register("EzChatBar")

if(SettingList == nil)then
    SettingList = {
      --  {
      --      ["name"] = "Главная", ["func"] = function() SettingsHideAllMenu();  end,
      --  },
        {
            ["name"] = "Модули", ["func"] = function() SettingsHideAllMenu(); end,
        },
    }
end

function EzChatBar2SettingsMenuList(data)


    if (data~=nil and data ~="") then
        SettingList[#SettingList+1] = data
    end

    return SettingList;
end

function EzChatBar2SettingsMenu()

    if(EzChatBar2Settings==nil) then
        EzChatBar2Settings = CreateFrame("FRAME", "EzChatBar2Settings", BaseFrameAddons(), BackdropTemplateMixin and "BackdropTemplate");
        EzChatBar2Settings:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        EzChatBar2Settings:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
        EzChatBar2Settings:ClearAllPoints();
        EzChatBar2Settings:SetPoint("CENTER", BaseFrameAddons(),"CENTER", 0, 0);
        EzChatBar2Settings:SetWidth(600);
        EzChatBar2Settings:SetHeight(410);
        EzChatBar2Settings:SetFrameStrata("DIALOG");
    end

    if(EzChatBar2Settings.menu==nil) then
        EzChatBar2Settings.menu = CreateFrame("FRAME", nil, EzChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
        EzChatBar2Settings.menu:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        EzChatBar2Settings.menu:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
        EzChatBar2Settings.menu:ClearAllPoints();
        EzChatBar2Settings.menu:SetPoint("RIGHT", EzChatBar2Settings,"LEFT", -2, 0);
        EzChatBar2Settings.menu:SetWidth(150);
        EzChatBar2Settings.menu:SetHeight(410);
        EzChatBar2Settings.menu:SetFrameStrata("DIALOG");
    end

    if(EzChatBar2Settings.ancor==nil) then
        EzChatBar2Settings.ancor = CreateFrame("FRAME", nil, EzChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
        EzChatBar2Settings.ancor:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        EzChatBar2Settings.ancor:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
        EzChatBar2Settings.ancor:ClearAllPoints();
        EzChatBar2Settings.ancor:SetPoint("CENTER", BaseFrameAddons(),"CENTER", 0, 200);
        EzChatBar2Settings.ancor:SetWidth(600);
        EzChatBar2Settings.ancor:SetHeight(24);
        --EzChatBar2Settings.ancor:SetFrameStrata("DIALOG");
        EzChatBar2Settings:ClearAllPoints();
        EzChatBar2Settings:SetPoint("TOP", EzChatBar2Settings.ancor,"BOTTOM", 0, -2);
        --EzChatBar2Settings.ancor:Raise();
        
    end
    WindowMoving(EzChatBar2Settings.ancor);

    if(EzChatBar2Settings.exit==nil) then
        EzChatBar2Settings.exit = CreateFrame("FRAME", "Exit", EzChatBar2Settings.ancor, BackdropTemplateMixin and "BackdropTemplate");
        EzChatBar2Settings.exit:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        EzChatBar2Settings.exit:SetBackdropColor(255/255, 0/255, 0/255, 0.8);
        EzChatBar2Settings.exit:ClearAllPoints();
        EzChatBar2Settings.exit:SetPoint("TOPRIGHT", EzChatBar2Settings.ancor,"TOPRIGHT", -4, -4);
        EzChatBar2Settings.exit:SetWidth(16);
        EzChatBar2Settings.exit:SetHeight(16);

        EzChatBar2Settings.exit.x = CreateFrame("FRAME", "Exit", EzChatBar2Settings.exit, BackdropTemplateMixin and "BackdropTemplate");
        EzChatBar2Settings.exit.x:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Close",});
        EzChatBar2Settings.exit.x:SetBackdropColor(1, 1, 1, 1);
        EzChatBar2Settings.exit.x:ClearAllPoints();
        EzChatBar2Settings.exit.x:SetPoint("CENTER", EzChatBar2Settings.exit,"CENTER", 0, 0);
        EzChatBar2Settings.exit.x:SetWidth(12);
        EzChatBar2Settings.exit.x:SetHeight(12);

        EzChatBar2Settings.exit:SetScript("OnMouseDown", function(self, button)

            if(button == "LeftButton") then
                EzChatBar2Settings:Hide();
            end
        end)
    end

    --EzChatBar2SettingsMenuList()

    for i=1, #SettingList do
        EzChatBar2SettingsCreateButton(SettingList, i)
    end

    EzChatBar2Settings:Show();

    return EzChatBar2Settings;
end

function EzChatBar2SettingsCreateButton(SettingList, i)
    if(EzChatBar2Settings.menu.i==nil) then
        --EzChatBar2Settings.menu.i = 1;
    end

    if(i < 16) then
        local i = i;
        local menu = EzChatBar2Settings.menu[i]
        if(menu==nil) then
            menu = CreateFrame("FRAME", i, EzChatBar2Settings.menu, BackdropTemplateMixin and "BackdropTemplate");
            menu:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
            menu:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
            menu:ClearAllPoints();
            menu:SetPoint("TOP", EzChatBar2Settings.menu,"TOP", 0, -(25*i-20));
            menu:SetWidth(150);
            menu:SetHeight(20);
            menu:SetFrameStrata("DIALOG");
            
            --i = EzChatBar2Settings.menu.i + 1;
        end
        
        menu:SetScript("OnMouseDown", SettingList[i]["func"])
        --menu:HookScript("OnMouseDown", function() SettingsHideAllMenu() print("a") end, LE_SCRIPT_BINDING_TYPE_INTRINSIC_PRECALL)

        menu:SetScript("OnEnter", function(self)
            menu.text:SetTextColor(1, 1, 0, 1)
        end)

        menu:SetScript("OnLeave", function(self)
            menu.text:SetTextColor(1, 0.82, 0, 1)
        end)

        if(menu.text==nil)then
            menu.text = menu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            menu.text:SetPoint("CENTER", 0, 0)
            menu.text:SetTextColor(1, 0.82, 0, 1)
        end
        -- print(menu.text:GetTextColor())
        menu.text:SetText(SettingList[i]["name"])
    end
end

function SettingsHideAllMenu()
    for i = 1, #EZCHtBarSettingsFrameList do
        EZCHtBarSettingsFrameList[i]:Hide();
    end

end
function EZButton(target)

    if(target==nil)then
        target = UIParent;
    end

    local button = CreateFrame("Frame", nil, target, BackdropTemplateMixin and "BackdropTemplate");
    button:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    button:SetBackdropColor(0,0,0,0.9);
    button:SetPoint("CENTER", 0, 0)
    button:SetWidth(128);
    button:SetHeight(16);
    button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    button.text:SetPoint("CENTER", 0, 0, "CENTER")
    button.text:SetTextColor(1, 0.82, 0, 1)
    button.text:SetText("test")
    -- LCG.ButtonGlow_Start(button);
    -- LCG.PixelGlow_Start(button);
    -- LCG.AutoCastGlow_Start(button);
    --LCG.ShowOverlayGlow(button);
    
    -- button:SetPoint("CENTER", target, "CENTER", 0, 0);

    return button;
end



function GetEZCheckBox(target, mas, default, settings)
    local m = 1

    for i=1, #mas do 
        if(target[i]==nil)then

        -- target[i] = CreateFrame("FRAME", nil, target.core, BackdropTemplateMixin and "BackdropTemplate");
        if(mas[i][1]=="CheckButton")then
            target[i] = CreateFrame("CheckButton", nil, target.core, "ChatConfigCheckButtonTemplate");
            target[i].tooltip = mas[i][3];
            target[i]:SetCheckedTexture("Interface\\AddOns\\EzChatBar\\image\\glow")
            -- target[i]:SetNormalTexture("Interface\\AddOns\\EzChatBar\\image\\check-box_2")
            -- target[i]:SetPushedTexture("Interface\\AddOns\\EzChatBar\\image\\blank-check-box1")
            target[i]:SetDisabledCheckedTexture("Interface\\AddOns\\EzChatBar\\image\\glow3")

            if(DygSettings[mas[5]])then
                target[i]:SetChecked(DygSettings[mas[i][5]]) 
            else
                target[i]:SetChecked(mas[i][4]) 
            end
            target[i].Text:SetText(mas[i][2]);

            target[i]:SetScript("OnClick", function() 
                --print(target[i]:GetChecked())
                DygSettings[mas[i][5]] = target[i]:GetChecked()
                ChatBar2()
            end)
        end

        if(mas[i][1]=="Button")then
            target[i] = CreateFrame("Frame", nil, target.core, BackdropTemplateMixin and "BackdropTemplate");
            target[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
            target[i]:SetBackdropColor(0,0,0,0.9)
            target[i]:SetWidth(128);
            target[i]:SetHeight(16);

            target[i]:SetScript("OnMouseDown", function() 
                --print(target[i]:GetChecked())
                --DygSettings[mas[i][5]] = target[i]:GetChecked()
                print("a")
                --ChatBar2()
            end)
        end


        
        if (i % 2 ~= 0) then
                target[i]:SetPoint("TOPLEFT", target.core, "TOPLEFT", 10, (-26*m)+26);
                --target[i]:SetChecked(false) 
            else
                target[i]:SetPoint("TOPLEFT", target.core, "TOPLEFT", 600/2, (-26*m)+26);
                --target[i]:SetChecked(true) 
                m = m+1;
            end
            

            -- target[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        end
        -- if(target[i]==nil)then
            -- target[i] = CreateFrame("CheckButton", "target.core", parentFrame, "ChatConfigCheckButtonTemplate");
        -- end
    end

        return EZCheckBox;
end
