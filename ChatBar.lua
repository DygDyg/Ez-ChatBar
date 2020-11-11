
--Создание фона
function ChatBar()
    if(DebugCheck == true) then
        if(ChatBarFrame==nil) then
            ChatBarFrame = CreateFrame("FRAME", "ChatBar", DygMesTab1.frame, BackdropTemplateMixin and "BackdropTemplate");
            ChatBarFrame:SetWidth(21);
            ChatBarFrame:SetHeight(8);
            ChatBarFrame:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\Background",});
            --ChatBarFrame:SetBackdropColor(0, 0, 0, 1);
            ChatBarFrame:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
            ChatBarFrame:SetPoint("TOPRIGHT", DygMesTab1, "LEFT", -2, 7);
        end
        ChatBarButton()
    end
end

--Создание кнопок
function ChatBarButton()
    local editBox, chatFrame, messageTypeList, channelList = CBCPanelUpdate();

    if(ChatBarFrame.button==nil) then
        ChatBarFrame.button = {}
    end
    local buttonframechatbar = ChatBarFrame;
    local numerx = 4;
    local numery = -4;
    local num1 = #messageTypeList;
    local ColorChat = nil;


    for i = 1, #ChatBarFrame.button do
        if(ChatBarFrame.button[i]~=nil) then
            ChatBarFrame.button[i]:Hide();
            ChatBarFrame:SetHeight(4);
        end
    end

    for i = 1, num1 do
        local act, color_r, color_g, color_b, title, cmd = ChatBarColor(messageTypeList[i]);
        if(act == true) then
            if(ChatBarFrame.button[i]==nil) then
                ChatBarFrame.button[i] = CreateFrame("FRAME", "ChatBarButton"..i, ChatBarFrame, BackdropTemplateMixin and "BackdropTemplate");
                ChatBarFrame.button[i]:Hide();
            end


            ChatBarFrame.button[i]:SetWidth(15);
            ChatBarFrame.button[i]:SetHeight(15);
            ChatBarFrame.button[i]:SetPoint("TOPLEFT", buttonframechatbar, "TOPLEFT", numerx, numery);
            ChatBarFrame.button[i]:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\ButtonChatBar1",});
            ChatBarFrame.button[i]:SetBackdropColor(color_r/255, color_g/255, color_b/255, 255/255);
            ChatBarFrame:SetHeight(ChatBarFrame:GetHeight()+19);
            ChatBarFrame.button[i]:Show();

            --ChatBarFrame.button[i]:SetScript("OnMouseDown", function(self, button) ChatBarButton() end);

            ChatBarFrame.button[i]:SetScript("OnMouseDown", function(self, button)
                ChatFrame_OpenChat("/"..cmd, chatFrame);
            end);

            ChatBarFrame.button[i]:SetScript("OnEnter", function(self)
                DygMesTab.TextPanel:Show();
                DygMesTab.TextPanel.Text:SetText(title);
            end)

            ChatBarFrame.button[i]:SetScript("OnLeave", function(self)
                DygMesTab.TextPanel:Hide();
            end)


            buttonframechatbar = ChatBarFrame.button[i];
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
        title = "Речь"
        cmd = "SAY"
    end

    if(messageType == "EMOTE") then
        color_r = 255;
        color_g = 140;
        color_b = 69;
        act = true;
        title = "Эмоции"
        cmd = "EMOTE"
    end

    if(messageType == "YELL") then
        color_r = 255;
        color_g = 69;
        color_b = 69;
        act = true;
        title = "Крикнуть"
        cmd = "YELL"
    end

    if(messageType == "PARTY") then
        color_r = 186;
        color_g = 186;
        color_b = 255;
        act = true;
        title = "Группа"
        cmd = "PARTY"
    end

    if(messageType == "RAID") then
        color_r = 255;
        color_g = 138;
        color_b = 0;
        act = true;
        title = "Рейд"
        cmd = "RAID"
    end

    if(messageType == "RAID_WARNING") then
        color_r = 255;
        color_g = 78;
        color_b = 0;
        act = true;
        title = "Сообщение рейда"
        cmd = "RW"
    end

    if(messageType == "GUILD") then
        color_r = 69;
        color_g = 255;
        color_b = 69;
        act = true;
        title = "Гильдия"
        cmd = "GUILD"
    end

    if(messageType == "OFFICER") then
        color_r = 69;
        color_g = 210;
        color_b = 69;
        act = true;
        title = "Офицер"
        cmd = "OFFICER"
    end

    return act, color_r, color_g, color_b, title, cmd;
end