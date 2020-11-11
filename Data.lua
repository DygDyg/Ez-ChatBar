function BaseFrameAddons()
    local BaseFrame = DygDyg_Addons
    local BaseFrameName = "DygDyg_Addons"
    if BaseFrame == nil then
        BaseFrame = CreateFrame("FRAME", BaseFrameName, UIParent, BackdropTemplateMixin and "BackdropTemplate");
    end
    return BaseFrame, BaseFrameName;
end



function Dyg_Button_Panel(name, title, tex, parent, point)
    --local r, g, b, a = ChatFrame1TabText:GetTextColor();
    local r = 189/255
    local g = 116/255
    local b = 8/255
    local a = 200/255
    local Dyg_Button = CreateFrame("Button", name, parent, BackdropTemplateMixin and "BackdropTemplate");
    local ColorSa = 40;

    Dyg_Button:SetWidth(15);
    Dyg_Button:SetHeight(15);
    Dyg_Button:SetPoint(point[1], point[2], point[3], point[4], point[5], point[6]);
    Dyg_Button:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\"..tex, insets = { left = 1, right = 1, top = 1, bottom = 1}});
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



