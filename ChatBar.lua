
--Создание фона
function ChatBar()
    --if(DebugCheck == true) then
        if(DygChatBarFrame==nil) then
            DygChatBarFrame = CreateFrame("FRAME", "ChatBar", DygMesTab1.frame, BackdropTemplateMixin and "BackdropTemplate");
            DygChatBarFrame:SetWidth(21);
            DygChatBarFrame:SetHeight(8);
            DygChatBarFrame:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background2",});
            --DygChatBarFrame:SetBackdropColor(0, 0, 0, 1);
            DygChatBarFrame:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
            DygChatBarFrame:SetPoint("TOPRIGHT", DygMesTab1, "LEFT", -2, 7);
        end
        ChatBarButton()
    --end
end

--Создание кнопок
function ChatBarButton()
    local editBox, chatFrame, messageTypeList, channelList = CBCPanelUpdate();

    if(DygChatBarFrame.button==nil) then
        DygChatBarFrame.button = {}
    end
    local buttonframechatbar = DygChatBarFrame;
    local numerx = 4;
    local numery = -4;
    local num1 = #messageTypeList;
    local ColorChat = nil;

    --print(#DygChatBarFrame.button)
    for i = 1, 100 do
        if(DygChatBarFrame.button[i]~=nil) then
            DygChatBarFrame.button[i]:Hide();
        end
        DygChatBarFrame:SetHeight(4);
    end

    for i = 1, num1 do
        local act, color_r, color_g, color_b, title, cmd = ChatBarColor(messageTypeList[i]);
        if(act == true) then
            if(DygChatBarFrame.button[i]==nil) then
                DygChatBarFrame.button[i] = CreateFrame("FRAME", "ChatBarButton"..i, DygChatBarFrame, BackdropTemplateMixin and "BackdropTemplate");
                --DygChatBarFrame.button[i]:Hide();

                DygChatBarFrame.button[i].glow = CreateFrame("FRAME", "glow", DygChatBarFrame.button[i], BackdropTemplateMixin and "BackdropTemplate");
                DygChatBarFrame.button[i].glow:Hide();
                DygChatBarFrame.button[i].glow:SetWidth(14);
                DygChatBarFrame.button[i].glow:SetHeight(14);
                DygChatBarFrame.button[i].glow:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\glow3",});
                DygChatBarFrame.button[i].glow:SetPoint("CENTER", DygChatBarFrame.button[i], "CENTER");
                DygChatBarFrame.button[i].glow:SetBackdropColor(1, 1, 1, 0.7);

                DygChatBarFrame.button[i].text = CreateFrame("EditBox", "Text", DygChatBarFrame.button[i], BackdropTemplateMixin and "BackdropTemplate");
                DygChatBarFrame.button[i].text:SetWidth(15);
                DygChatBarFrame.button[i].text:SetHeight(15);
                DygChatBarFrame.button[i].text:SetPoint("CENTER");
                DygChatBarFrame.button[i].text:SetFontObject(GameFontNormal);
                DygChatBarFrame.button[i].text:Disable();
                DygChatBarFrame.button[i].text:SetText("B");
                DygChatBarFrame.button[i].text:Hide();
            end



            DygChatBarFrame.button[i]:SetWidth(15);
            DygChatBarFrame.button[i]:SetHeight(15);
            DygChatBarFrame.button[i]:SetPoint("TOPLEFT", buttonframechatbar, "TOPLEFT", numerx, numery);
            DygChatBarFrame.button[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\ButtonChatBar2",});
            DygChatBarFrame.button[i]:SetBackdropColor(color_r/255, color_g/255, color_b/255, 200/255);
            DygChatBarFrame:SetHeight(DygChatBarFrame:GetHeight()+19);
            DygChatBarFrame.button[i]:Show();

            --DygChatBarFrame.button[i]:SetScript("OnMouseDown", function(self, button) ChatBarButton() end);

            DygChatBarFrame.button[i]:SetScript("OnMouseDown", function(self, button)
                ChatFrame_OpenChat("/"..cmd, chatFrame);
            end);

            DygChatBarFrame.button[i]:SetScript("OnEnter", function(self)
                DygMesTab.TextPanel:Show();
                DygChatBarFrame.button[i].glow:Show();
                DygMesTab.TextPanel.Text:SetText(title);
                DygChatBarFrame.button[i]:SetBackdropColor((color_r+100)/255, (color_g+100)/255, (color_b+100)/255, 255/255);
            end)

            DygChatBarFrame.button[i]:SetScript("OnLeave", function(self)
                DygMesTab.TextPanel:Hide();
                DygChatBarFrame.button[i]:SetBackdropColor(color_r/255, color_g/255, color_b/255, 255/255);
                DygChatBarFrame.button[i].glow:Hide();
            end)


            buttonframechatbar = DygChatBarFrame.button[i];
            numerx = 0;
            numery = -19;
        end
    end
    --C_Timer.After(3, ChatBar)
end


function ChatBarColor(messageType)
    local color_r, color_g, color_b = nil;
    local act = false;
    local title = nil;
    local cmd = nil;

    if(messageType == "SAY") then
        color_r = 255;
        color_g = 255;
        color_b = 255;
        act = true;
        title = EzChatBar_ChatBarColor_title_SAY;
        cmd = "SAY"
    end

    if(messageType == "EMOTE") then
        color_r = 255;
        color_g = 140;
        color_b = 69;
        act = true;
        title = EzChatBar_ChatBarColor_title_EMOTE;
        cmd = "EMOTE"
    end

    if(messageType == "YELL") then
        color_r = 255;
        color_g = 69;
        color_b = 69;
        act = true;
        title = EzChatBar_ChatBarColor_title_YELL;
        cmd = "YELL"
    end

    if(messageType == "PARTY") then
        color_r = 186;
        color_g = 186;
        color_b = 255;
        act = true;
        title = EzChatBar_ChatBarColor_title_PARTY;
        cmd = "PARTY"
    end

    if(messageType == "RAID") then
        color_r = 255;
        color_g = 138;
        color_b = 0;
        act = true;
        title = EzChatBar_ChatBarColor_title_RAID;
        cmd = "RAID"
    end

    if(messageType == "RAID_WARNING") then
        color_r = 255;
        color_g = 78;
        color_b = 0;
        act = true;
        title = EzChatBar_ChatBarColor_title_RAID_WARNING;
        cmd = "RW"
    end

    if(messageType == "GUILD") then
        color_r = 69;
        color_g = 255;
        color_b = 69;
        act = true;
        title = EzChatBar_ChatBarColor_title_GUILD;
        cmd = "GUILD"
    end

    if(messageType == "OFFICER") then
        color_r = 69;
        color_g = 150;
        color_b = 69;
        act = true;
        title = EzChatBar_ChatBarColor_title_OFFICER;
        cmd = "OFFICER"
    end

    if(messageType == "INSTANCE_CHAT") then
        color_r = 255;
        color_g = 78;
        color_b = 9;
        act = true;
        title = EzChatBar_ChatBarColor_title_INSTANCE_CHAT;
        cmd = "INSTANCE_CHAT"
    end



    return act, color_r, color_g, color_b, title, cmd;
end



--menuFrame45645 = CreateFrame("Frame", "ExampleMenuFrame11", UIParent, "UIDropDownMenuTemplate");
--menuFrame45645:Show();
-- Or make the menu appear at the frame:
--menuFrame45645:SetPoint("Center", UIParent, "Center");
--EasyMenu(menu1, menuFrame45645, menuFrame45645, 0 , 0, "MENU");




--menuFrame:Hide()
--EasyMenu(menu1, ExampleMenuFrame, ExampleMenuFrame, 0 , 0);
--/script EasyMenu(menu1, menuFrame, menuFrame, 0 , 0);
--/script EasyMenu(menu1, menuFrame45645, menuFrame45645, 0 , 0, "MENU"); menuFrame45645:Show();
--/script EasyMenu(menu1, menuFrame45645, "cursor", 0 , 0, "MENU");