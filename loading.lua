local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")

f:SetScript("OnEvent", function(self, event, AddonName, isReload)
    if(AddonName == "EzChatBar")then
        if(DygSettings["CheckVersion"]==nil)then
            DygSettings["CheckVersion"] = 0
        end
        --Настройки
        --EzChatBar2SettingsMenu()
        --ChatBarSettings()

        --Панель с шариками
        if(DygSettings["ChatBar2_enabled"]) then 
            ChatBar2Load() 
        end

    --FIX LUA ERROR FRAME
    ScriptErrorsFrame:SetWidth(400);
    ScriptErrorsFrame.ScrollFrame:SetWidth(360);
    ScriptErrorsFrame.ScrollFrame.Text:SetWidth(360);
    --FIX LUA ERROR FRAME
    DygSettings["CheckVersion"] = 1
    end
end
)

