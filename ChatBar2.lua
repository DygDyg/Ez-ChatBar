

    --Создание фона


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

function GetBubbles()
    if(Dygbubbles==nil)then
        Dygbubbles = {}

        Dygbubbles[1]={
            cmd="/SAY",
            perm = "ALL",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_SAY,
            r=255/255,
            g=255/255,
            b=255/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/EMOTE",
            perm = "ALL",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_EMOTE,
            r=255/255,
            g=140/255,
            b=69/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/YELL",
            perm = "ALL",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_YELL,
            r=255/255,
            g=69/255,
            b=69/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/PARTY",
            perm = "PARTY",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_PARTY,
            r=186/255,
            g=186/255,
            b=255/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/RAID",
            perm = "RAID",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_RAID,
            r=255/255,
            g=138/255,
            b=0/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/RAID_WARNING",
            perm = "RAID_WARNING",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_RAID_WARNING,
            r=255/255,
            g=78/255,
            b=0/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/GUILD",
            perm = "GUILD",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_GUILD,
            r=69/255,
            g=255/255,
            b=69/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/OFFICER",
            perm = "OFFICER",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_OFFICER,
            r=69/255,
            g=150/255,
            b=69/255,
        }

        Dygbubbles[#Dygbubbles+1]={
            cmd="/INSTANCE_CHAT",
            perm = "INSTANCE_CHAT",
            title=EZCHATBAR_CHATBARCOLOR_TITLE_INSTANCE_CHAT,
            r=255/255,
            g=78/255,
            b=9/255,
        }
    end
end

function ChatBar2()
    local EZChatBar = BaseFrameAddons();
    
    if(ChatBar2Frame==nil) then
        ChatBar2Frame = CreateFrame("FRAME", "ChatBarPanel2", EZChatBar, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame:SetWidth(1);
        ChatBar2Frame:SetHeight(1);
        ------------------------
        --ChatBarSettings();
        ------------------------
    end

    if(ChatBar2Frame.bg==nil) then
        ChatBar2Frame.bg = CreateFrame("FRAME", "bg", ChatBar2Frame, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame.bg:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background2",});
        ChatBar2Frame.bg:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
        ChatBar2Frame.bg:ClearAllPoints();
        ChatBar2Frame.bg:SetPoint("TOP", ChatBar2Frame,"TOP", 0, 2);
        ChatBar2Frame.bg:SetWidth(21);
        --ChatBar2Frame.bg:Lower();
        --ChatBar2Frame.bg:Raise();
        --ChatBar2Frame.bg:SetHeight(24);
    end

    if(ChatBar2Frame.anchor==nil) then
        ChatBar2Frame.anchor = CreateFrame("FRAME", "ChatBarPanel_anchor", ChatBar2Frame, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame.anchor:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        ChatBar2Frame.anchor:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
        ChatBar2Frame.anchor:ClearAllPoints();
        ChatBar2Frame.anchor:SetPoint("BOTTOM", EZChatBar, "TOP");
        ChatBar2Frame.anchor:SetWidth(21);
        ChatBar2Frame.anchor:SetHeight(8);
        ChatBar2Frame.anchor:Lower();
        ChatBar2Frame:ClearAllPoints();
        ChatBar2Frame:SetPoint("TOP", ChatBar2Frame.anchor, "BOTTOM", 0, -3);
        WindowMoving(ChatBar2Frame.anchor, true);

        ChatBar2Frame.anchor:HookScript("OnMouseDown", function(self, button)

            if(button == "RightButton") then
                ChatBarSettings();
            end
        end)
    end

    Ball();

    for i=1, #Dygbubbles do
        --print(Dygbubbles[i]["perm"]);
        if(perms[Dygbubbles[i]["perm"]]()==true)then
            Ball(Dygbubbles[i]);
        end
    end
    --Ball();
end


function Ball(data)
    local buble_size = 16;
    local editBox, chatFrame, messageTypeList, channelList = CBCPanelUpdate();
    ChatBar2Frame.ball = ChatBar2Frame.ball or {};
    ChatBar2Frame.ball.i = ChatBar2Frame.ball.i or 0;

    if(data)then
        ChatBar2Frame.ball.i=ChatBar2Frame.ball.i+1;
        local i = ChatBar2Frame.ball.i;
        if(ChatBar2Frame.ball[i]==nil)then
            ChatBar2Frame.ball[i] = ChatBar2Frame.ball[i] or CreateFrame("FRAME", "ball", ChatBar2Frame, BackdropTemplateMixin and "BackdropTemplate");
            ChatBar2Frame.ball[i]:HookScript("OnEnter", function(self)
                ChatBar2Frame.ball[i].glow:Show();
                DygMesTab.TextPanel:Show();
                DygMesTab.TextPanel.Text:SetText(data["title"]);
                --DygChatBarFrame.button[i]:SetBackdropColor((color_r+100)/255, (color_g+100)/255, (color_b+100)/255, 255/255);
            end)

            ChatBar2Frame.ball[i]:HookScript("OnLeave", function(self)
                ChatBar2Frame.ball[i].glow:Hide();
                DygMesTab.TextPanel:Hide();
                --DygChatBarFrame.button[i]:SetBackdropColor(color_r/255, color_g/255, color_b/255, 255/255);

            end)

        end

        ChatBar2Frame.ball[i]:Show();
        ChatBar2Frame.ball[i]:SetWidth(buble_size);
        ChatBar2Frame.ball[i]:SetHeight(buble_size-1);
        ChatBar2Frame.ball[i]:ClearAllPoints();
        ChatBar2Frame.ball[i]:SetPoint("BOTTOM", ChatBar2Frame, "TOP", 0, 0 - i*(buble_size+2));
        ChatBar2Frame.ball[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\ButtonChatBar2",});
        ChatBar2Frame.ball[i]:SetBackdropColor(data["r"], data["g"], data["b"]);
        --ChatBar2Frame.ball[i]:Raise();

        ChatBar2Frame.ball[i].glow = ChatBar2Frame.ball[i].glow or CreateFrame("FRAME", "glow", ChatBar2Frame.ball[i], BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame.ball[i].glow:Hide();
        ChatBar2Frame.ball[i].glow:SetWidth(buble_size);
        ChatBar2Frame.ball[i].glow:SetHeight(buble_size-1);
        ChatBar2Frame.ball[i].glow:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\glow3",});
        ChatBar2Frame.ball[i].glow:SetPoint("CENTER", ChatBar2Frame.ball[i], "CENTER");
        ChatBar2Frame.ball[i].glow:SetBackdropColor(1, 1, 1, 0.7);
        --ChatBar2Frame.ball[i].glow:Raise();



        ChatBar2Frame.ball[i]:SetScript("OnMouseDown", function(self, button)

            if(button == "LeftButton") then
                ChatFrame_OpenChat(data["cmd"], chatFrame);
            end
        end)
        
    else
        for i=1, ChatBar2Frame.ball.i do
            ChatBar2Frame.ball[i]:Hide();
        end
        ChatBar2Frame.bg:SetHeight(buble_size*ChatBar2Frame.ball.i + 24);
        ChatBar2Frame.ball.i = 0;
    end
end

function ChatBarSettings()
    if(ChatBar2Settings==nil) then
        ChatBar2Settings = CreateFrame("FRAME", "ChatBar2Settings", EZChatBar, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Settings:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        ChatBar2Settings:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
        ChatBar2Settings:ClearAllPoints();
        ChatBar2Settings:SetPoint("CENTER", EZChatBar,"CENTER", 0, 0);
        ChatBar2Settings:SetWidth(600);
        ChatBar2Settings:SetHeight(400);
        ChatBar2Settings:SetFrameStrata("DIALOG");
    end
    ChatBar2Settings:Show();

    if(ChatBar2Settings.exit==nil) then
        ChatBar2Settings.exit = CreateFrame("FRAME", "Exit", ChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Settings.exit:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        ChatBar2Settings.exit:SetBackdropColor(255/255, 0/255, 0/255, 0.8);
        ChatBar2Settings.exit:ClearAllPoints();
        ChatBar2Settings.exit:SetPoint("TOPRIGHT", ChatBar2Settings,"TOPRIGHT", -4, -4);
        ChatBar2Settings.exit:SetWidth(16);
        ChatBar2Settings.exit:SetHeight(16);
        ChatBar2Settings.exit:SetScript("OnMouseDown", function(self, button)

            if(button == "LeftButton") then
                ChatBar2Settings:Hide();
            end
        end)

        --ChatBar2Settings.exit:SetFrameStrata("DIALOG");
    end

    function ChatBarSettingsLine(i)
        --local i = 1;
        ChatBar2Settings.edit = ChatBar2Settings.edit or {};
        ChatBar2Settings.edit[i] = ChatBar2Settings.edit[i] or {};

        -------------------------------------
        if(ChatBar2Settings.edit[i].title==nil)then
            ChatBar2Settings.edit[i].title = CreateFrame("EditBox", "SearchFrame", ChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
            
            ChatBar2Settings.edit[i].title:SetScript("OnMouseDown", function(self)
                ChatBar2Settings.edit[i].title:Enable();
            end)
            --ChatBar2Settings:HookScript("OnLeave", function(self)
            --    ChatBar2Settings.edit[i].title:Disable();
            --end)

            ChatBar2Settings.edit[i].title:SetScript("OnEnterPressed", function(self)
                Dygbubbles[i]["title"] = ChatBar2Settings.edit[i].title:GetText()
                ChatBar2Settings.edit[i].title:Disable();
                ChatBar2();
            end)

        end
        
        ChatBar2Settings.edit[i].title:SetBackdrop({
            edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
            bgFile = 'Interface/ChatFrame/ChatFrameBackground',
            insets = {left = 2, right = 2, top = 2, bottom = 2},
            tile = true,
            tileSize = 16,
            edgeSize = 16,
        });

        ChatBar2Settings.edit[i].title:ClearAllPoints();
        ChatBar2Settings.edit[i].title:SetPoint("TOPLEFT", ChatBar2Settings,"TOPLEFT", 10, -40*i);
        ChatBar2Settings.edit[i].title:SetWidth(150);
        ChatBar2Settings.edit[i].title:SetHeight(32);
        ChatBar2Settings.edit[i].title:SetTextInsets(8, 8, 0, 0);
        ChatBar2Settings.edit[i].title:SetFontObject('ChatFontNormal');
        ChatBar2Settings.edit[i].title:SetBackdropColor(0, 0, 0, 0.8);
        ChatBar2Settings.edit[i].title:SetBackdropBorderColor(1, 1, 1, 0.8);
        ChatBar2Settings.edit[i].title:SetText(Dygbubbles[i]["title"]);
        --ChatBar2Settings.edit[i].title:ClearFocus();
        ChatBar2Settings.edit[i].title:Disable();





        -------------------------------------
        if(ChatBar2Settings.edit[i].cmd==nil)then
            ChatBar2Settings.edit[i].cmd = CreateFrame("EditBox", "SearchFrame", ChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");

            ChatBar2Settings.edit[i].cmd:SetScript("OnMouseDown", function(self)
                ChatBar2Settings.edit[i].cmd:Enable();
            end)
            --ChatBar2Settings:HookScript("OnLeave", function(self)
            --    ChatBar2Settings.edit[i].cmd:Disable();
            --end)
            ChatBar2Settings.edit[i].cmd:SetScript("OnEnterPressed", function(self)
                Dygbubbles[i]["cmd"] = ChatBar2Settings.edit[i].cmd:GetText();
                ChatBar2Settings.edit[i].cmd:Disable();
                ChatBar2();
            end)
        end

        ChatBar2Settings.edit[i].cmd:SetBackdrop({
            edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
            bgFile = 'Interface/ChatFrame/ChatFrameBackground',
            insets = {left = 2, right = 2, top = 2, bottom = 2},
            tile = true,
            tileSize = 16,
            edgeSize = 16,
        });
        ChatBar2Settings.edit[i].cmd:ClearAllPoints();
        ChatBar2Settings.edit[i].cmd:SetPoint("TOPLEFT", ChatBar2Settings.edit[i].title,"TOPRIGHT", 10, 0);
        ChatBar2Settings.edit[i].cmd:SetWidth(200);
        ChatBar2Settings.edit[i].cmd:SetHeight(32);
        ChatBar2Settings.edit[i].cmd:SetTextInsets(8, 8, 0, 0);
        ChatBar2Settings.edit[i].cmd:SetFontObject('ChatFontNormal');
        ChatBar2Settings.edit[i].cmd:SetBackdropColor(0, 0, 0, 0.8);
        ChatBar2Settings.edit[i].cmd:SetBackdropBorderColor(1, 1, 1, 0.8);
        ChatBar2Settings.edit[i].cmd:SetText(Dygbubbles[i]["cmd"]);
        ChatBar2Settings.edit[i].cmd:ClearFocus();
        ------------------------------------------

        if(ChatBar2Settings.edit[i].GetColor==nil) then
            ChatBar2Settings.edit[i].GetColor = CreateFrame("FRAME", "GetColor", ChatBar2Settings.edit[i].cmd, BackdropTemplateMixin and "BackdropTemplate");
        end

        ChatBar2Settings.edit[i].GetColor:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\ButtonChatBar2",});
        ChatBar2Settings.edit[i].GetColor:SetBackdropColor(Dygbubbles[i]["r"], Dygbubbles[i]["g"], Dygbubbles[i]["b"]);
        ChatBar2Settings.edit[i].GetColor:ClearAllPoints();
        ChatBar2Settings.edit[i].GetColor:SetPoint("LEFT", ChatBar2Settings.edit[i].cmd,"RIGHT", 10, 0);
        ChatBar2Settings.edit[i].GetColor:SetWidth(25);
        ChatBar2Settings.edit[i].GetColor:SetHeight(25);
        ChatBar2Settings.edit[i].GetColor:SetScript("OnMouseDown", function(self, button)
    
                if(button == "LeftButton") then
                    
                    --ColorPickerFrame.func = PickerGetColor(i);
                    --ColorPickerFrame.cancelFunc = PickerCancelColor;
                    ColorPickerFrame.previousValues  = {Dygbubbles[i]["r"], Dygbubbles[i]["g"], Dygbubbles[i]["b"]};
                    ColorPickerFrame.i = i;
                    ColorPickerFrame:SetColorRGB(Dygbubbles[i]["r"], Dygbubbles[i]["g"], Dygbubbles[i]["b"]); 
                    ColorPickerFrame:Show();
                end
            end)

            ColorPickerFrame.func = function()
                local i = ColorPickerFrame.i;
                ChatBar2Settings.edit[i].GetColor:SetBackdropColor(ColorPickerFrame:GetColorRGB());
                Dygbubbles[i]["r"], Dygbubbles[i]["g"], Dygbubbles[i]["b"] = ColorPickerFrame:GetColorRGB();
                ChatBar2();

            end

            ColorPickerFrame.cancelFunc = function()
                local i = ColorPickerFrame.i;
                ChatBar2Settings.edit[i].GetColor:SetBackdropColor(ColorPickerFrame.previousValues[1], ColorPickerFrame.previousValues[2], ColorPickerFrame.previousValues[3]);
                Dygbubbles[i]["r"], Dygbubbles[i]["g"], Dygbubbles[i]["b"] = ColorPickerFrame.previousValues[1], ColorPickerFrame.previousValues[2], ColorPickerFrame.previousValues[3];
                ChatBar2();
            end

            function PickerGetColor(i,a)
                print(i);
                print(a);
            end

            
            function PickerCancelColor(i)
                print(i);
            end

    
            --ChatBar2Settings.exit:SetFrameStrata("DIALOG");
        

    end

    for i = 1, #Dygbubbles do
        ChatBarSettingsLine(i);
    end


    --ChatBar2Settings.edit[1].title:ClearFocus();
end


    local f = CreateFrame("Frame");
	f:RegisterEvent("UPDATE_CHAT_COLOR");
	f:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	f:RegisterEvent("GROUP_ROSTER_UPDATE");
	f:RegisterEvent("PLAYER_GUILD_UPDATE");
    f:RegisterEvent("VARIABLES_LOADED");

    f:SetScript("OnEvent", function(...)
        GetBubbles();
        --DygSettings["ChatBar2_enabled"] = DygSettings["ChatBar2_enabled"] or true;
        if(DygSettings["ChatBar2_enabled"]==nil)then
            DygSettings["ChatBar2_enabled"] = false;
        end
        
        if(DygSettings["ChatBar2_enabled"])then
            GetBubbles();
            ChatBar2();

        end
        

    end)
