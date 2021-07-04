
function EzChatBar2SettingsMenuList(data)
    if(SettingList == nil)then
        SettingList = {
            {
                ["name"] = "Главная", ["func"] = function()  end,
            },
            {
                ["name"] = "Модули", ["func"] = function()  end,
            }
        }
    end

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
        --print(menu.text:GetTextColor())
        menu.text:SetText(SettingList[i]["name"])
    end
end
