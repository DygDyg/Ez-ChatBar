
--Создание фона
function ChatBar()
    --if(DebugCheck == true) then
        if(DygChatBarFrame==nil) then
            DygChatBarFrameCore = DygChatBarFrameCore or CreateFrame("FRAME", "ChatBarPanel", BaseFrameAddons(), BackdropTemplateMixin and "BackdropTemplate");
            DygChatBarFrame = DygChatBarFrame or CreateFrame("FRAME", "ChatBar", DygChatBarFrameCore, BackdropTemplateMixin and "BackdropTemplate");
            DygChatBarFrame:ClearAllPoints();
            DygChatBarFrameCore:ClearAllPoints();
            DygChatBarFrameCore:SetPoint("RIGHT", ChatFrame1.ScrollBar, "TOP", 150, 0);
            DygChatBarFrameCore:SetWidth(21);
            DygChatBarFrameCore:SetHeight(21);
            DygChatBarFrameCore:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
            DygChatBarFrameCore:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
            DygChatBarFrame:SetPoint("TOP", DygChatBarFrameCore, "BOTTOM", 0, -2);
            DygSettings["PanelHorizontal"] = DygSettings["PanelHorizontal"] or false
            WindowMoving(DygChatBarFrameCore, true, "DygChatBarFrame_Core");
        end
        ChatBarButton()
    --end
end

--Создание кнопок
function ChatBarButton()
    local editBox, chatFrame, messageTypeList, channelList = CBCPanelUpdate();

    DygChatBarFrameCore:SetWidth(21);
    DygChatBarFrameCore:SetHeight(21);
    DygChatBarFrameCore:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    DygChatBarFrameCore:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
    DygChatBarFrame:ClearAllPoints();
    DygChatBarFrame:SetPoint("TOP", DygChatBarFrameCore, "BOTTOM", 0, -2);

    if(DygSettings["PanelHorizontal"] == true)then
        DygChatBarFrame:SetWidth(8);
        DygChatBarFrame:SetHeight(21);
        DygChatBarFrameCore:SetWidth(9);
        DygChatBarFrame:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background2_90",});
        DygChatBarFrame:ClearAllPoints();
        DygChatBarFrame:SetPoint("TOPLEFT", DygChatBarFrameCore, "TOPRIGHT", 2, 0);
    else
        DygChatBarFrame:SetWidth(21);
        DygChatBarFrame:SetHeight(8);
        DygChatBarFrameCore:SetHeight(9);
        DygChatBarFrame:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background2",});
        DygChatBarFrame:ClearAllPoints();
        DygChatBarFrame:SetPoint("TOP", DygChatBarFrameCore, "BOTTOM", 0, -2);
    end
    DygChatBarFrame:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);

    if(DygChatBarFrame.button==nil) then
        DygChatBarFrame.button = {}
    end
    local buttonframechatbar = DygChatBarFrame;
    local numerx = 4;
    local numery = -4;
    local num1 = #messageTypeList;
    local ColorChat = nil;

    for i = 1, 100 do
        if(DygChatBarFrame.button[i]~=nil) then
            DygChatBarFrame.button[i]:Hide();
        end
        if(DygSettings["PanelHorizontal"] == true)then
            DygChatBarFrame:SetWidth(4);
        else
            DygChatBarFrame:SetHeight(4);
        end
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

            if(DygSettings["PanelHorizontal"] == true)then

            else

            end
            DygChatBarFrame.button[i]:SetPoint("TOPLEFT", buttonframechatbar, "TOPLEFT", numerx, numery);
            DygChatBarFrame.button[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\ButtonChatBar2",});
            --ButtonChatBar2
            DygChatBarFrame.button[i]:SetBackdropColor(color_r/255, color_g/255, color_b/255, 200/255);
            if(DygSettings["PanelHorizontal"] == true)then
                DygChatBarFrame:SetWidth(DygChatBarFrame:GetWidth()+19);
            else
                DygChatBarFrame:SetHeight(DygChatBarFrame:GetHeight()+19);
            end
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
            if(DygSettings["PanelHorizontal"] == true)then
                numerx = 19;
                numery = 0;
            else
                numerx = 0;
                numery = -19;
            end
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
        title = EZCHATBAR_CHATBARCOLOR_TITLE_SAY;
        cmd = "SAY"
    end

    if(messageType == "EMOTE") then
        color_r = 255;
        color_g = 140;
        color_b = 69;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_EMOTE;
        cmd = "EMOTE"
    end

    if(messageType == "YELL") then
        color_r = 255;
        color_g = 69;
        color_b = 69;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_YELL;
        cmd = "YELL"
    end

    if(messageType == "PARTY" and UnitExists("party1")) then
        color_r = 186;
        color_g = 186;
        color_b = 255;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_PARTY;
        cmd = "PARTY"
    end

    if(messageType == "RAID"and IsInRaid()) then
        color_r = 255;
        color_g = 138;
        color_b = 0;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_RAID;
        cmd = "RAID"
    end

    if(messageType == "RAID_WARNING" and IsInRaid() and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))) then
        color_r = 255;
        color_g = 78;
        color_b = 0;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_RAID_WARNING;
        cmd = "RW"
    end

    if(messageType == "GUILD" and IsInGuild()) then
        color_r = 69;
        color_g = 255;
        color_b = 69;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_GUILD;
        cmd = "GUILD"
    end

    if(messageType == "OFFICER" and C_GuildInfo.CanEditOfficerNote()) then
        color_r = 69;
        color_g = 150;
        color_b = 69;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_OFFICER;
        cmd = "OFFICER"
    end

    if(messageType == "INSTANCE_CHAT" and IsInInstance()) then
        color_r = 255;
        color_g = 78;
        color_b = 9;
        act = true;
        title = EZCHATBAR_CHATBARCOLOR_TITLE_INSTANCE_CHAT;
        cmd = "INSTANCE_CHAT"
    end



    return act, color_r, color_g, color_b, title, cmd;
end
    local f = CreateFrame("Frame");
	f:RegisterEvent("UPDATE_CHAT_COLOR");
	f:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	f:RegisterEvent("GROUP_ROSTER_UPDATE");
	f:RegisterEvent("PLAYER_GUILD_UPDATE");
    f:RegisterEvent("VARIABLES_LOADED");

    f:SetScript("OnEvent", function(...)
        ChatBar()
    end)