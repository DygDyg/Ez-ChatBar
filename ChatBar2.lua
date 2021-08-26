

    --Создание фона
    maxlinedata = 0;
    mirror_flip = false;

    Dyg_skins_buble_list = {
        "bubble1",
        "square1"
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

local function ScrollFrame_OnMouseWheel(self, delta)
    local newValue = self:GetVerticalScroll() - (delta * 20);

	if (newValue < 0) then
        newValue = 0;

	elseif newValue > self:GetVerticalScrollRange() then
		newValue = self:GetVerticalScrollRange();
	end
        --print(HideButtonColl)
        --print(self:GetVerticalScrollRange())
	self:SetVerticalScroll(newValue);
    --print(newValue)
end

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

    --if(DygSettings["skins"]==nil)then
        DygSettings["skins"] = DygSettings["skins"] or "bubble1";
        DygSettings["mirror_flip"] = DygSettings["mirror_flip"] or false;

    --end
    if(DygSettings["mirror_flip"] == true) then
        mirror_flip = -1;
    else
        mirror_flip = 1;
    end

    if(DygSettings["ChatBar2_enabled"]==false)then
        if(ChatBar2Frame) then
            ChatBar2Frame:Hide()
        end
    else

    if(DygSettings["PanelHorizontal"]==nil)then
        DygSettings["PanelHorizontal"] = DygSettings["PanelHorizontal"] or false;
    end

    local EZChatBar = BaseFrameAddons();
    
    if(ChatBar2Frame==nil) then
        ChatBar2Frame = CreateFrame("FRAME", "ChatBarPanel2", EZChatBar, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame:SetWidth(21);
        ChatBar2Frame:SetHeight(21);
        ------------------------
        --ChatBarSettings();
        ------------------------
    end

    if(ChatBar2Frame.bg==nil) then
        ChatBar2Frame.bg = CreateFrame("FRAME", "bg", ChatBar2Frame, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame.bg:ClearAllPoints();


        --ChatBar2Frame.bg:Lower();
        --ChatBar2Frame.bg:Raise();
        --ChatBar2Frame.bg:SetHeight(24);
    end
    if(DygSettings["PanelHorizontal"]==false)then
        ChatBar2Frame.bg:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background2_"..mirror_flip,});
        ChatBar2Frame.bg:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);

        ChatBar2Frame.bg:SetPoint("TOP", ChatBar2Frame,"TOP", 0, 2);
        ChatBar2Frame.bg:SetWidth(21);
    else
        ChatBar2Frame.bg:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background2_"..mirror_flip.."_90",});
        ChatBar2Frame.bg:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);

        if(mirror_flip<0)then
            ChatBar2Frame.bg:SetPoint("BOTTOMLEFT", ChatBar2Frame,"BOTTOMLEFT", 14, 0);
        else
            ChatBar2Frame.bg:SetPoint("BOTTOMLEFT", ChatBar2Frame,"BOTTOMLEFT", 2, 0);
        end
        
        ChatBar2Frame.bg:SetHeight(21);
    end

    ChatBar2Frame.bg:Lower();
    ChatBar2Frame.bg:SetFrameStrata("BACKGROUND");

    if(ChatBar2Frame.anchor==nil) then
        ChatBar2Frame.anchor = CreateFrame("FRAME", "ChatBarPanel_anchor", ChatBar2Frame, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame.anchor:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        ChatBar2Frame.anchor:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
        ChatBar2Frame.anchor:ClearAllPoints();
        ChatBar2Frame.anchor:Lower();

        if(DygSettings["PanelHorizontal"]==false)then
            ChatBar2Frame.anchor:SetPoint("BOTTOM", EZChatBar, "TOP");
            ChatBar2Frame.anchor:SetWidth(21);
            ChatBar2Frame.anchor:SetHeight(9);
            ChatBar2Frame:ClearAllPoints();

            if(mirror_flip<0)then
                ChatBar2Frame:SetPoint("TOP", ChatBar2Frame.anchor, "CENTER", 0, -6*mirror_flip);
            else
                ChatBar2Frame:SetPoint("TOP", ChatBar2Frame.anchor, "CENTER", 0, -9*mirror_flip);
            end
        else
            ChatBar2Frame.anchor:SetPoint("BOTTOMLEFT", EZChatBar, "TOPLEFT");
            ChatBar2Frame.anchor:SetWidth(9);
            ChatBar2Frame.anchor:SetHeight(21);
            ChatBar2Frame:ClearAllPoints();

            if(mirror_flip<0)then
                ChatBar2Frame:SetPoint("CENTER", ChatBar2Frame.anchor, "CENTER", -10, 0);
            else
                ChatBar2Frame:SetPoint("LEFT", ChatBar2Frame.anchor, "RIGHT", 0, 0);
            end
        end

        WindowMoving(ChatBar2Frame.anchor, true);

        ChatBar2Frame.anchor:HookScript("OnMouseDown", function(self, button)

            if(button == "RightButton") then
                --ChatBarSettings();
                EzChatBar2SettingsMenu();
            end
        end)
    end



    Ball();
    ChatBar2Frame.bg:Lower();

    for i=1, #Dygbubbles do
        --print(Dygbubbles[i]["perm"]);
        if(perms[Dygbubbles[i]["perm"]]()==true)then
            Ball(Dygbubbles[i]);
        end
    end
    --Ball();
    end

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
            
            --ChatBar2Frame.ball[i]:SetScript("OnEnter", function(self)
            --    print(data["title"]);
            --end)
            
            ChatBar2Frame.ball[i]:HookScript("OnEnter", function(self)

            end)

            ChatBar2Frame.ball[i]:HookScript("OnLeave", function(self)
                ChatBar2Frame.ball[i].glow:Hide();
                DygMesTab.TextPanel:Hide();
            end)
        end

        ChatBar2Frame.ball[i]:SetScript("OnEnter", function(self)
            DygMesTab.TextPanel.Text:SetText(data["title"]);
            ChatBar2Frame.ball[i].glow:Show();
            DygMesTab.TextPanel:Show();

        end)

        ChatBar2Frame.ball[i]:Show();
        ChatBar2Frame.ball[i]:SetWidth(buble_size);
        ChatBar2Frame.ball[i]:SetHeight(buble_size-1);
        ChatBar2Frame.ball[i]:ClearAllPoints();

        if(DygSettings["PanelHorizontal"]==false)then
            
            if(mirror_flip<0)then
                ChatBar2Frame.ball[i]:SetPoint("BOTTOM", ChatBar2Frame, "TOP", 0, (0 - i*(buble_size+2)+(buble_size-5))*mirror_flip);
            else
                ChatBar2Frame.ball[i]:SetPoint("BOTTOM", ChatBar2Frame, "TOP", 0, 0 - i*(buble_size+2)*mirror_flip);
            end

        else
            ChatBar2Frame.ball[i]:SetPoint("LEFT", ChatBar2Frame, "LEFT", (0 + i*(buble_size+2)-(buble_size)+5)*mirror_flip, 0);
        end

        ChatBar2Frame.ball[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\skins\\"..DygSettings["skins"].."\\bubble",});
        ChatBar2Frame.ball[i]:SetBackdropColor(data["r"], data["g"], data["b"]);
        --ChatBar2Frame.ball[i]:Raise();

        ChatBar2Frame.ball[i].glow = ChatBar2Frame.ball[i].glow or CreateFrame("FRAME", "glow", ChatBar2Frame.ball[i], BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Frame.ball[i].glow:Hide();
        ChatBar2Frame.ball[i].glow:SetWidth(buble_size);
        ChatBar2Frame.ball[i].glow:SetHeight(buble_size-1);
        ChatBar2Frame.ball[i].glow:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\skins\\"..DygSettings["skins"].."\\glow",});
        ChatBar2Frame.ball[i].glow:SetPoint("CENTER", ChatBar2Frame.ball[i], "CENTER");
        ChatBar2Frame.ball[i].glow:SetBackdropColor(1, 1, 1, 0.7);
        --ChatBar2Frame.ball[i].glow:Raise();



        ChatBar2Frame.ball[i]:SetScript("OnMouseDown", function(self, button)

            if(button == "LeftButton") then
                local str = Dyg_Variables(data["cmd"]);
                ChatFrame_OpenChat(str, chatFrame);
            end
        end)
        
    else
        for i=1, ChatBar2Frame.ball.i do
            ChatBar2Frame.ball[i]:Hide();
        end
        if(DygSettings["PanelHorizontal"]==false)then
            ChatBar2Frame.bg:SetHeight((buble_size*ChatBar2Frame.ball.i + 24)*mirror_flip);
        else
            ChatBar2Frame.bg:SetWidth((buble_size*ChatBar2Frame.ball.i + 24)*mirror_flip);
        end

        ChatBar2Frame.ball.i = 0;
    end
end


function Dyg_Variables(str)

    if(string.match(str, "#keystone#"))then
        local locate, _, _, steps  = C_Scenario.GetInfo();
        if(locate==nil) then
            return string.gsub(str, "#keystone#", "я не в подземелье")
        end

        local targets, _, _, prochents, final_value, _, _, quantity = C_Scenario.GetCriteriaInfo(steps);
        local keylvl = C_ChallengeMode.GetActiveKeystoneInfo(); 
        keylvl = keylvl or "nil"

        return string.gsub(str, "#keystone#", 'Я сейчас в "'..locate..' ('..keylvl..')", выполняю цель №'..steps..' "'..targets..'"');
        --return 'Я сейчас в "'..locate..' ('..keylvl..')", выполняю цель №'..steps..' "'..targets..'"';
    end

    return str;
end


function ChatBarSettings()
    if(ChatBar2Settings==nil) then
        ChatBar2Settings = EzChatBar2SettingsMenu();
    end

    --if(ChatBar2Settings==nil) then
    --    ChatBar2Settings = CreateFrame("FRAME", "ChatBar2Settings", EZChatBar, BackdropTemplateMixin and "BackdropTemplate");
    --    ChatBar2Settings:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    --    ChatBar2Settings:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
    --    ChatBar2Settings:ClearAllPoints();
    --    ChatBar2Settings:SetPoint("CENTER", EZChatBar,"CENTER", 0, 0);
    --    ChatBar2Settings:SetWidth(600);
    --    ChatBar2Settings:SetHeight(410);
    --    ChatBar2Settings:SetFrameStrata("DIALOG");
    --end

    --if(ChatBar2Settings.ancor==nil) then
    --    ChatBar2Settings.ancor = CreateFrame("FRAME", "ancor", ChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
    --    ChatBar2Settings.ancor:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    --    ChatBar2Settings.ancor:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
    --    ChatBar2Settings.ancor:ClearAllPoints();
    --    ChatBar2Settings.ancor:SetPoint("CENTER", EZChatBar,"CENTER", 0, 200);
    --    ChatBar2Settings.ancor:SetWidth(600);
    --    ChatBar2Settings.ancor:SetHeight(24);
    --    --ChatBar2Settings.ancor:SetFrameStrata("DIALOG");
    --    ChatBar2Settings:ClearAllPoints();
    --    ChatBar2Settings:SetPoint("TOP", ChatBar2Settings.ancor,"BOTTOM", 0, -2);
    --    --ChatBar2Settings.ancor:Raise();
    --    
    --end
    --WindowMoving(ChatBar2Settings.ancor);
    if(ChatBar2Settings.main==nil) then
        ChatBar2Settings.main = CreateFrame("FRAME", nil, ChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
        --ChatBar2Settings.main:SetPoint("CENTER", ChatBar2Settings,"CENTER", 0, 0);
        --ChatBar2Settings.main:SetWidth(1);
        --ChatBar2Settings.main:SetHeight(1);
    end

    if(ChatBar2Settings.core==nil) then
        ChatBar2Settings.core = CreateFrame("FRAME", "ChatBar2Settings", ChatBar2Settings, BackdropTemplateMixin and "BackdropTemplate");
        --ChatBar2Settings.core:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
        --ChatBar2Settings.core:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
        ChatBar2Settings.core:ClearAllPoints();
        ChatBar2Settings.core:SetPoint("CENTER", ChatBar2Settings,"CENTER", 0, 0);
        ChatBar2Settings.core:SetWidth(1);
        ChatBar2Settings.core:SetHeight(1);
        
        --ChatBar2Settings.core:SetFrameStrata("DIALOG");
    end

    if(ChatBar2Settings.scroll==nil) then
        ChatBar2Settings.scroll = CreateFrame("ScrollFrame", "ChatBar2Scroll", ChatBar2Settings.main, BackdropTemplateMixin and "BackdropTemplate");
        --ChatBar2Settings.scroll:SetWidth(ChatBar2Settings:GetWidth());
        
        --ChatBar2Settings.scroll:SetHeight(ChatBar2Settings:GetHeight());
        --ChatBar2Settings.scroll:SetPoint("CENTER", ChatBar2Settings, "CENTER", 0, 0);

        ChatBar2Settings.scroll:SetPoint("TOPLEFT", ChatBar2Settings, "TOPLEFT", 0, -25);
        ChatBar2Settings.scroll:SetPoint("BOTTOMRIGHT", ChatBar2Settings, "BOTTOMRIGHT", 0, 0);
        ChatBar2Settings.scroll:SetScrollChild(ChatBar2Settings.core);

        --ChatBar2Settings.scroll:SetScript("OnVerticalScroll", function(self, offset)
            --print(offset)
            --FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, update)
        --end)

        ChatBar2Settings.scroll:SetScript("OnMouseWheel", function(self, offset)
            ScrollFrame_OnMouseWheel(self, offset)
        end);

    end


    ChatBar2Settings:Show();

    --if(ChatBar2Settings.exit==nil) then
    --    ChatBar2Settings.exit = CreateFrame("FRAME", "Exit", ChatBar2Settings.ancor, BackdropTemplateMixin and "BackdropTemplate");
    --    ChatBar2Settings.exit:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
    --    ChatBar2Settings.exit:SetBackdropColor(255/255, 0/255, 0/255, 0.8);
    --    ChatBar2Settings.exit:ClearAllPoints();
    --    ChatBar2Settings.exit:SetPoint("TOPRIGHT", ChatBar2Settings.ancor,"TOPRIGHT", -4, -4);
    --    ChatBar2Settings.exit:SetWidth(16);
    --    ChatBar2Settings.exit:SetHeight(16);
--
    --    ChatBar2Settings.exit.x = CreateFrame("FRAME", "Exit", ChatBar2Settings.exit, BackdropTemplateMixin and "BackdropTemplate");
    --    ChatBar2Settings.exit.x:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Close",});
    --    ChatBar2Settings.exit.x:SetBackdropColor(1, 1, 1, 1);
    --    ChatBar2Settings.exit.x:ClearAllPoints();
    --    ChatBar2Settings.exit.x:SetPoint("CENTER", ChatBar2Settings.exit,"CENTER", 0, 0);
    --    ChatBar2Settings.exit.x:SetWidth(12);
    --    ChatBar2Settings.exit.x:SetHeight(12);
--
    --    ChatBar2Settings.exit:SetScript("OnMouseDown", function(self, button)
--
    --        if(button == "LeftButton") then
    --            ChatBar2Settings:Hide();
    --        end
    --    end)
--
    --    --ChatBar2Settings.exit:SetFrameStrata("DIALOG");
    --end

    
    if(ChatBar2Settings.add==nil) then
        ChatBar2Settings.add = CreateFrame("FRAME", "add", ChatBar2Settings.main, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Settings.add:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\skins\\"..DygSettings["skins"].."\\bubble",});
        --ChatBar2Settings.add:SetBackdropColor(255/255, 0/255, 0/255, 0.8);
        ChatBar2Settings.add:ClearAllPoints();
        ChatBar2Settings.add:SetPoint("TOPLEFT", ChatBar2Settings,"TOPLEFT", 4, -4);
        ChatBar2Settings.add:SetWidth(16);
        ChatBar2Settings.add:SetHeight(16);
        ChatBar2Settings.add:SetScript("OnMouseDown", function(self, button)

            if(button == "LeftButton") then
                Dygbubbles[#Dygbubbles+1]={
                    cmd="/",
                    perm = "ALL",
                    title="new bubble "..#Dygbubbles+1,
                    r=math.random(),
                    g=math.random(),
                    b=math.random(),
                }
                ChatBar2();
                ChatBarSettings();
            end
        end)

        if(ChatBar2Settings.add.glow==nil) then
            ChatBar2Settings.add.glow = CreateFrame("FRAME", "glow", ChatBar2Settings.add, BackdropTemplateMixin and "BackdropTemplate");
        end

        ChatBar2Settings.add.glow:Hide();
        ChatBar2Settings.add.glow:SetWidth(16);
        ChatBar2Settings.add.glow:SetHeight(16);
        ChatBar2Settings.add.glow:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\skins\\"..DygSettings["skins"].."\\glow",});
        ChatBar2Settings.add.glow:SetPoint("CENTER", ChatBar2Settings.add, "CENTER");
        ChatBar2Settings.add.glow:SetBackdropColor(1, 1, 1, 0.7);

        ChatBar2Settings.add:SetScript("OnLeave", function(self)
            ChatBar2Settings.add.glow:Hide();
        end)
    
        ChatBar2Settings.add:SetScript("OnEnter", function(self)
            ChatBar2Settings.add.glow:Show();
        end)

        if(ChatBar2Settings.add.plus==nil)then
            ChatBar2Settings.add.plus = CreateFrame("EditBox", "plus", ChatBar2Settings.add, BackdropTemplateMixin and "BackdropTemplate");
            ChatBar2Settings.add.plus:ClearAllPoints();
            ChatBar2Settings.add.plus:SetPoint("CENTER", ChatBar2Settings.add,"CENTER");
            ChatBar2Settings.add.plus:SetWidth(25);
            ChatBar2Settings.add.plus:SetHeight(25);
            ChatBar2Settings.add.plus:SetTextInsets(8, 8, 0, 0);
            ChatBar2Settings.add.plus:SetFontObject('ChatFontNormal');
            ChatBar2Settings.add.plus:SetBackdropColor(0, 0, 0, 1);
            ChatBar2Settings.add.plus:SetBackdropBorderColor(1, 1, 1, 0.8);
            ChatBar2Settings.add.plus:SetText("+");
            --ChatBar2Settings.edit[i].title:ClearFocus();
            ChatBar2Settings.add.plus:Disable();
            ChatBar2Settings.add.plus:Hide();
        end

        --ChatBar2Settings.exit:SetFrameStrata("DIALOG");
    end

    if(ChatBar2Settings.label1==nil)then
        ChatBar2Settings.label1 = CreateFrame("EditBox", "label1", ChatBar2Settings.add, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Settings.label1:ClearAllPoints();
        ChatBar2Settings.label1:SetPoint("LEFT", ChatBar2Settings.add,"RIGHT", 10, 0);
        ChatBar2Settings.label1:SetWidth(150);
        ChatBar2Settings.label1:SetHeight(32);
        ChatBar2Settings.label1:SetTextInsets(8, 8, 0, 0);
        ChatBar2Settings.label1:SetFontObject('ChatFontNormal');
        ChatBar2Settings.label1:SetBackdropColor(0, 0, 0, 0.8);
        ChatBar2Settings.label1:SetBackdropBorderColor(1, 1, 1, 0.8);
        ChatBar2Settings.label1:SetText(EZCHATBAR_CHATBAR2_SETTINGS_label1);
        --ChatBar2Settings.edit[i].title:ClearFocus();
        ChatBar2Settings.label1:Disable();
    end

    if(ChatBar2Settings.label2==nil)then
        ChatBar2Settings.label2 = CreateFrame("EditBox", "label2", ChatBar2Settings.label1, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Settings.label2:ClearAllPoints();
        ChatBar2Settings.label2:SetPoint("LEFT", ChatBar2Settings.label1,"RIGHT", 10, 0);
        ChatBar2Settings.label2:SetWidth(200);
        ChatBar2Settings.label2:SetHeight(32);
        ChatBar2Settings.label2:SetTextInsets(8, 8, 0, 0);
        ChatBar2Settings.label2:SetFontObject('ChatFontNormal');
        ChatBar2Settings.label2:SetBackdropColor(0, 0, 0, 0.8);
        ChatBar2Settings.label2:SetBackdropBorderColor(1, 1, 1, 0.8);
        ChatBar2Settings.label2:SetText(EZCHATBAR_CHATBAR2_SETTINGS_label2);
        --ChatBar2Settings.edit[i].title:ClearFocus();
        ChatBar2Settings.label2:Disable();
    end

    if(ChatBar2Settings.label3==nil)then
        ChatBar2Settings.label3 = CreateFrame("EditBox", "label3", ChatBar2Settings.label2, BackdropTemplateMixin and "BackdropTemplate");
        ChatBar2Settings.label3:ClearAllPoints();
        ChatBar2Settings.label3:SetPoint("LEFT", ChatBar2Settings.label2,"RIGHT", 10, 0);
        ChatBar2Settings.label3:SetWidth(100);
        ChatBar2Settings.label3:SetHeight(32);
        ChatBar2Settings.label3:SetTextInsets(8, 8, 0, 0);
        ChatBar2Settings.label3:SetFontObject('ChatFontNormal');
        ChatBar2Settings.label3:SetBackdropColor(0, 0, 0, 0.8);
        ChatBar2Settings.label3:SetBackdropBorderColor(1, 1, 1, 0.8);
        ChatBar2Settings.label3:SetText(EZCHATBAR_CHATBAR2_SETTINGS_label3);
        --ChatBar2Settings.edit[i].title:ClearFocus();
        ChatBar2Settings.label3:Disable();
    end



    function ChatBarSettingsLine(i)
        --local i = 1;
        if(maxlinedata<i)then
            maxlinedata = i
        end

        ChatBar2Settings.edit = ChatBar2Settings.edit or {};
        ChatBar2Settings.edit[i] = ChatBar2Settings.edit[i] or {};




        -------------------------------------
        if(ChatBar2Settings.edit[i].title==nil)then
            ChatBar2Settings.edit[i].title = CreateFrame("EditBox", "SearchFrame", ChatBar2Settings.core, BackdropTemplateMixin and "BackdropTemplate");
            --ChatBar2Settings.scroll:SetScrollChild(ChatBar2Settings.edit[i].title);
            
            ChatBar2Settings.edit[i].title:SetScript("OnMouseDown", function(self)
                ChatBar2Settings.edit[i].title:Enable();
            end)

            ChatBar2Settings.edit[i].title:SetScript("OnEditFocusLost", function(self)
                Dygbubbles[i]["title"] = ChatBar2Settings.edit[i].title:GetText()
                ChatBar2Settings.edit[i].title:Disable();
            end)

            ChatBar2Settings.edit[i].title:SetScript("OnEnterPressed", function(self)
                Dygbubbles[i]["title"] = ChatBar2Settings.edit[i].title:GetText()
                ChatBar2Settings.edit[i].title:Disable();
                ChatBar2();
            end)

        end
        ChatBar2Settings.edit[i].title:Show();
        ChatBar2Settings.edit[i].title:SetBackdrop({
            edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
            bgFile = 'Interface/ChatFrame/ChatFrameBackground',
            insets = {left = 2, right = 2, top = 2, bottom = 2},
            tile = true,
            tileSize = 16,
            edgeSize = 16,
        });

        ChatBar2Settings.edit[i].title:ClearAllPoints();
        ChatBar2Settings.edit[i].title:SetPoint("TOPLEFT", ChatBar2Settings.core,"TOPLEFT", 10, -40*(i-1));
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
            ChatBar2Settings.edit[i].cmd = CreateFrame("EditBox", "SearchFrame", ChatBar2Settings.edit[i].title, BackdropTemplateMixin and "BackdropTemplate");

            ChatBar2Settings.edit[i].cmd:SetScript("OnMouseDown", function(self)
                ChatBar2Settings.edit[i].cmd:Enable();
            end)

            ChatBar2Settings.edit[i].cmd:SetScript("OnEditFocusLost", function(self)
                Dygbubbles[i]["cmd"] = ChatBar2Settings.edit[i].cmd:GetText();
                ChatBar2Settings.edit[i].cmd:Disable();
                ChatBar2();
            end)

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
        --ChatBar2Settings.edit[i].cmd:ClearFocus();
        ChatBar2Settings.edit[i].cmd:Disable();
        ------------------------------------------

        if(ChatBar2Settings.edit[i].perm==nil)then
            ChatBar2Settings.edit[i].perm = CreateFrame("EditBox", "SearchFrame", ChatBar2Settings.edit[i].cmd, BackdropTemplateMixin and "BackdropTemplate");

            ChatBar2Settings.edit[i].perm:SetScript("OnMouseDown", function(self)
                --ChatBar2Settings.edit[i].perm:Enable();

                local menu = {
                    --{ text = "Select an Option", isTitle = true},
                    { text = "ALL", func = function() Dygbubbles[i]["perm"] = "ALL"; ChatBar2Settings.edit[i].perm:SetText("ALL"); ChatBar2(); end },
                    { text = "PARTY", func = function() Dygbubbles[i]["perm"] = "PARTY"; ChatBar2Settings.edit[i].perm:SetText("PARTY"); ChatBar2(); end },
                    { text = "RAID", func = function() Dygbubbles[i]["perm"] = "RAID"; ChatBar2Settings.edit[i].perm:SetText("RAID"); ChatBar2(); end },
                    { text = "RAID_WARNING", func = function() Dygbubbles[i]["perm"] = "RAID_WARNING"; ChatBar2Settings.edit[i].perm:SetText("RAID_WARNING"); ChatBar2(); end },
                    { text = "GUILD", func = function() Dygbubbles[i]["perm"] = "GUILD"; ChatBar2Settings.edit[i].perm:SetText("GUILD"); ChatBar2(); end },
                    { text = "OFFICER", func = function() Dygbubbles[i]["perm"] = "OFFICER"; ChatBar2Settings.edit[i].perm:SetText("OFFICER"); ChatBar2(); end },
                    { text = "INSTANCE_CHAT", func = function() Dygbubbles[i]["perm"] = "INSTANCE_CHAT"; ChatBar2Settings.edit[i].perm:SetText("INSTANCE_CHAT"); ChatBar2(); end },
                    
                }

                EasyMenu(menu, DropBoxFrame, ChatBar2Settings.edit[i].perm, 0 , 0, "MENU");
            end)
        end

        ChatBar2Settings.edit[i].perm:SetBackdrop({
            edgeFile = 'Interface/Tooltips/UI-Tooltip-Border',
            bgFile = 'Interface/ChatFrame/ChatFrameBackground',
            insets = {left = 2, right = 2, top = 2, bottom = 2},
            tile = true,
            tileSize = 16,
            edgeSize = 16,
        });

        ChatBar2Settings.edit[i].perm:ClearAllPoints();
        ChatBar2Settings.edit[i].perm:SetPoint("TOPLEFT", ChatBar2Settings.edit[i].cmd,"TOPRIGHT", 10, 0);
        ChatBar2Settings.edit[i].perm:SetWidth(100);
        ChatBar2Settings.edit[i].perm:SetHeight(32);
        ChatBar2Settings.edit[i].perm:SetTextInsets(8, 8, 0, 0);
        ChatBar2Settings.edit[i].perm:SetFontObject('ChatFontNormal');
        ChatBar2Settings.edit[i].perm:SetBackdropColor(0, 0, 0, 0.8);
        ChatBar2Settings.edit[i].perm:SetBackdropBorderColor(1, 1, 1, 0.8);
        ChatBar2Settings.edit[i].perm:SetText(Dygbubbles[i]["perm"]);
        --ChatBar2Settings.edit[i].perm:ClearFocus();
        ChatBar2Settings.edit[i].perm:Disable();

        -------------------------------------------

        if(ChatBar2Settings.edit[i].GetColor==nil) then
            ChatBar2Settings.edit[i].GetColor = CreateFrame("FRAME", "GetColor", ChatBar2Settings.edit[i].perm, BackdropTemplateMixin and "BackdropTemplate");
        end

        ChatBar2Settings.edit[i].GetColor:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\skins\\"..DygSettings["skins"].."\\bubble",});
        ChatBar2Settings.edit[i].GetColor:SetBackdropColor(Dygbubbles[i]["r"], Dygbubbles[i]["g"], Dygbubbles[i]["b"]);
        ChatBar2Settings.edit[i].GetColor:ClearAllPoints();
        ChatBar2Settings.edit[i].GetColor:SetPoint("LEFT", ChatBar2Settings.edit[i].perm,"RIGHT", 10, 0);
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

            if(ChatBar2Settings.edit[i].GetColor.glow==nil) then
                ChatBar2Settings.edit[i].GetColor.glow = CreateFrame("FRAME", "glow", ChatBar2Settings.edit[i].GetColor, BackdropTemplateMixin and "BackdropTemplate");
            end
    
            ChatBar2Settings.edit[i].GetColor.glow:Hide();
            ChatBar2Settings.edit[i].GetColor.glow:SetWidth(25);
            ChatBar2Settings.edit[i].GetColor.glow:SetHeight(25);
            ChatBar2Settings.edit[i].GetColor.glow:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\skins\\"..DygSettings["skins"].."\\glow",});
            ChatBar2Settings.edit[i].GetColor.glow:SetPoint("CENTER", ChatBar2Settings.edit[i].GetColor, "CENTER");
            ChatBar2Settings.edit[i].GetColor.glow:SetBackdropColor(1, 1, 1, 0.7);
    
            ChatBar2Settings.edit[i].GetColor:SetScript("OnLeave", function(self)
                ChatBar2Settings.edit[i].GetColor.glow:Hide();
            end)
        
            ChatBar2Settings.edit[i].GetColor:SetScript("OnEnter", function(self)
                ChatBar2Settings.edit[i].GetColor.glow:Show();
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
            

--------------------------------------------------------------------

            if(ChatBar2Settings.edit[i].remove == nil) then
                ChatBar2Settings.edit[i].remove = CreateFrame("FRAME", "remove", ChatBar2Settings.edit[i].GetColor, BackdropTemplateMixin and "BackdropTemplate");
            end
        
            ChatBar2Settings.edit[i].remove:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Close",});
            ChatBar2Settings.edit[i].remove:SetBackdropColor(1, 0, 0);
            ChatBar2Settings.edit[i].remove:ClearAllPoints();
            ChatBar2Settings.edit[i].remove:SetPoint("LEFT", ChatBar2Settings.edit[i].GetColor,"RIGHT", 10, 0);
            ChatBar2Settings.edit[i].remove:SetWidth(20);
            ChatBar2Settings.edit[i].remove:SetHeight(20);
            ChatBar2Settings.edit[i].remove:SetScript("OnMouseDown", function(self, button)
                StaticPopup_Show ("removeBall"..i)
        
                end)
--------------------------------------------------------------------

            if(ChatBar2Settings.edit[i].up==nil)then
                ChatBar2Settings.edit[i].up = CreateFrame("FRAME", "ChatBar2Settings", ChatBar2Settings.edit[i].remove, BackdropTemplateMixin and "BackdropTemplate");

                --ChatBar2Settings.edit[i].up.texture =  ChatBar2Settings.edit[i].up:CreateTexture(nil, ChatBar2Settings.edit[i].remove);
                --ChatBar2Settings.edit[i].up.texture:SetAllPoints();
                --ChatBar2Settings.edit[i].up.texture:SetTexture("Interface\\AddOns\\EzChatBar\\image\\tree", false);
                --ChatBar2Settings.edit[i].up.texture:SetRotation(0);

                --ChatBar2Settings.edit[i].up.texture:SetRotation(3.2);
                --ChatBar2Settings.edit[i].up.texture:SetColorTexture(1, 1, 1, 0.8);
                ChatBar2Settings.edit[i].up:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\tree",});
                --ChatBar2Settings.edit[i].up:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
                ChatBar2Settings.edit[i].up:SetBackdropColor(1, 1, 1, 0.8);
                ChatBar2Settings.edit[i].up:ClearAllPoints();
                ChatBar2Settings.edit[i].up:SetPoint("TOPLEFT", ChatBar2Settings.edit[i].remove,"TOPRIGHT", 10, 0);
                ChatBar2Settings.edit[i].up:SetWidth(20);
                ChatBar2Settings.edit[i].up:SetHeight(9);
            end

            ChatBar2Settings.edit[i].up:SetScript("OnMouseDown", function(self, button)
                --StaticPopup_Show ("removeBall"..i)
                Dyg_Buble_offset(-1, i);
            end)

---------------------------------------------------------------------


            if(ChatBar2Settings.edit[i].down==nil)then
                ChatBar2Settings.edit[i].down = CreateFrame("FRAME", "ChatBar2Settings", ChatBar2Settings.edit[i].up, BackdropTemplateMixin and "BackdropTemplate");

                --ChatBar2Settings.edit[i].down.texture =  ChatBar2Settings.edit[i].down:CreateTexture(nil, ChatBar2Settings.edit[i].down);
                --ChatBar2Settings.edit[i].down.texture:SetAllPoints();
                --ChatBar2Settings.edit[i].down.texture:SetTexture("Interface\\AddOns\\EzChatBar\\image\\tree", false);
                --ChatBar2Settings.edit[i].down.texture:SetRotation(3.15);

                ChatBar2Settings.edit[i].down:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\tree2",});
                --ChatBar2Settings.edit[i].down:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], 0.8);
                ChatBar2Settings.edit[i].down:SetBackdropColor(1, 1, 1, 0.8);

                ChatBar2Settings.edit[i].down:ClearAllPoints();
                ChatBar2Settings.edit[i].down:SetPoint("TOP", ChatBar2Settings.edit[i].up,"BOTTOM", 0, -2);
                ChatBar2Settings.edit[i].down:SetWidth(20);
                ChatBar2Settings.edit[i].down:SetHeight(9);
            end

            ChatBar2Settings.edit[i].down:SetScript("OnMouseDown", function(self, button)
                --StaticPopup_Show ("removeBall"..i)
                Dyg_Buble_offset(1, i);
        
            end)

            function Dyg_Buble_offset(offset, i)
                offset = i + offset;

                

                if(offset > #Dygbubbles) then
                    offset = 1;
                elseif(offset<1 ) then
                    offset = #Dygbubbles;
                end
                
                local temp = Dygbubbles[offset];
                Dygbubbles[offset] = Dygbubbles[i];
                Dygbubbles[i] = temp;


                ChatBar2();
                ChatBarSettings();
            end

---------------------------------------------------------------------

                StaticPopupDialogs["removeBall"..i] = {
                    text = EZCHATBAR_CHATBAR2_removeBall_TITLE..i..") " ..Dygbubbles[i]["title"].."?" ,
                    button1 = EZCHATBAR_GENERALTAB_BUTTON_YES,
                    button2 = EZCHATBAR_GENERALTAB_BUTTON_NO,
                    OnAccept = function()
                        table.remove(Dygbubbles, i)
                        ChatBar2();
                        ChatBarSettings();
                        
                    end,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = true,
                    preferredIndex = 3, 
                }

    
            --ChatBar2Settings.exit:SetFrameStrata("DIALOG");
        

    end

    for i = 1, maxlinedata do
        ChatBar2Settings.edit[i].title:Hide();
    end

    for i = 1, #Dygbubbles do
        ChatBarSettingsLine(i);
    end

    


    --ChatBar2Settings.edit[1].title:ClearFocus();
end



function ChatBar2Load()
    GetBubbles();
    local f = CreateFrame("Frame");
	f:RegisterEvent("UPDATE_CHAT_COLOR");
	f:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	f:RegisterEvent("GROUP_ROSTER_UPDATE");
	f:RegisterEvent("PLAYER_GUILD_UPDATE");
    f:RegisterEvent("VARIABLES_LOADED");

    f:SetScript("OnEvent", function(...)
        --GetBubbles();
        --DygSettings["ChatBar2_enabled"] = DygSettings["ChatBar2_enabled"] or true;
        if(DygSettings["ChatBar2_enabled"]==nil)then
            DygSettings["ChatBar2_enabled"] = false;
        end
        
        if(DygSettings["ChatBar2_enabled"])then
            --GetBubbles();
            ChatBar2();
            --ChatBarSettings()
        end
    end)

    local data = {
        ["name"] = "Изменить Bubbles", ["func"] = function() ChatBarSettings() end,
    }

    EzChatBar2SettingsMenuList(data);
end
