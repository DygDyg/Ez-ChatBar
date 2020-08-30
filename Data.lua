function Dyg_Button(name, title, tex, parent, point)
    local r, g, b, a = ChatFrame1TabText:GetTextColor();
    local Dyg_Button = CreateFrame("Button", name, parent);
    local ColorSa = 40;
    Dyg_Button:SetWidth(15);
    Dyg_Button:SetHeight(15);
    Dyg_Button:SetPoint(point[1], point[2], point[3], point[4], point[5], point[6]);
    Dyg_Button:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\"..tex, insets = { left = 1, right = 1, top = 1, bottom = 1}});
    Dyg_Button:SetBackdropColor(r, g, b, a);

    Dyg_Button:SetScript("PreClick", function(self, button)

    end)

    Dyg_Button:SetScript("OnEnter", function(self)
        Dyg_Button:SetBackdropColor(r+(ColorSa/255), g+(ColorSa/255), b+(ColorSa/255), a);
        DygMesTab.TextPanel:Show();
        DygMesTab.TextPanel.Text:SetText(title);
    end)

    Dyg_Button:SetScript("OnLeave", function(self)
        Dyg_Button:SetBackdropColor(r, g, b, a);
        DygMesTab.TextPanel:Hide();
    end)

    return Dyg_Button
end

        --DygMesTab.Close = CreateFrame("FRAME", "CloseButton", DygMesTab);
        --DygMesTab.Close:SetWidth(15);
        --DygMesTab.Close:SetHeight(15);
        --DygMesTab.Close:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\Close", insets = { left = 1, right = 1, top = 1, bottom = 1}});
        --DygMesTab.Close:SetBackdropColor(r, g, b, a);
        --DygMesTab.Close:SetPoint("RIGHT", DygMesTab.Settings, "LEFT", 0, 0);