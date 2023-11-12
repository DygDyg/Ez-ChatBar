function EZTabButtonStart()
    local editBox, chatFrame = CBCPanelUpdate();

    EZTabButton = EZTabButton or CreateFrame("FRAME", "EZTabButton", BaseFrameAddons(), BackdropTemplateMixin and "BackdropTemplate");

    EZTabButton:ClearAllPoints();
    EZTabButton:SetPoint("RIGHT", ChatFrame1.ScrollBar, "TOP", 150, 0);
    WindowMoving(EZTabButton, true, "EZTabButton");

    EZTabButton:SetWidth(115);
    EZTabButton:SetHeight(15);
    EZTabButton:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    EZTabButton:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);


    EZTabButton.ScrollFrame = EZTabButton.ScrollFrame or CreateFrame("ScrollFrame", "TabScrollFrame", EZTabButton, BackdropTemplateMixin and "BackdropTemplate");
    EZTabButton.ScrollFrame:SetWidth(115);
    EZTabButton.ScrollFrame:SetHeight(DygSettings["scrollframe_Height"]);
    EZTabButton.ScrollFrame:ClearAllPoints();
    -- EZTabButton.ScrollFrame:SetPoint("TOPLEFT", EZTabButton.frame, "TOPLEFT", 0, 0);
    -- EZTabButton.ScrollFrame:SetPoint("BOTTOMRIGHT", EZTabButton.frame, "BOTTOMRIGHT", 0, 0);
    EZTabButton.ScrollFrame:SetPoint("TOPLEFT", EZTabButton, "BOTTOMLEFT", 0, -1);
    EZTabButton.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);



    EZTabButton.frame2 = CreateFrame("Frame", "frame2", EZTabButton.ScrollFrame, BackdropTemplateMixin and "BackdropTemplate");
    EZTabButton.frame2:SetWidth(EZTabButton.ScrollFrame:GetWidth());
    EZTabButton.frame2:SetHeight(EZTabButton.ScrollFrame:GetHeight());
    EZTabButton.frame2:SetPoint("TOPLEFT", EZTabButton, "BOTTOMLEFT", 0, 0);
    EZTabButton.ScrollFrame:SetScrollChild(EZTabButton.frame2);


    EZTabButton.frame2:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    EZTabButton.frame2:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
    

    EZTabButton.test = {}
    for i=1, 1 do
        EZTabButtonTest()
    end
    -- EZTabButton.ScrollFrame:MarkDirty();
end

function EZTabButtonTest()
    EZTabButton.test.i = EZTabButton.test.i or 1;
    i = EZTabButton.test.i
    EZTabButton.test[i] = EZTabButton.test[i] or CreateFrame("FRAME", "EZTabButton.test"..i, EZTabButton.frame2, BackdropTemplateMixin and "BackdropTemplate");
    EZTabButton.test[i]:ClearAllPoints();
    EZTabButton.test[i]:SetPoint("TOPLEFT", EZTabButton.frame2, "TOPLEFT", 0, -16*i);
    -- print((17*i)-15)
    EZTabButton.test[i]:SetWidth(115);
    EZTabButton.test[i]:SetHeight(15);
    EZTabButton.test[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    EZTabButton.test[i]:SetBackdropColor(1, 0, 0, 0.8);

    EZTabButton.test.i = EZTabButton.test.i + 1;
    --EZTabButton.frame2:SetHeight((-17*i)+15);
end



------------------------------------------------------------------------------------------------------