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

            if(DygSettings["PanelHorizontal"]==nil)then
                DygSettings["PanelHorizontal"] = DygSettings["PanelHorizontal"] or false;
            end

            WindowMoving(DygChatBarFrameCore, true, "DygChatBarFrame_Core");

            if(DygSettings["ChatBarEnable"] == nil) then
                DygSettings["ChatBarEnable"] = true;
            end

            if(DygSettings["ChatBarEnable"]==true)then
                DygChatBarFrameCore:Show();
            else

                DygChatBarFrameCore:Hide();
            end

        end
        --ChatBarButton()
    --end
end


function ChatBarButton()

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