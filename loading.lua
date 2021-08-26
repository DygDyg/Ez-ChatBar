local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")

f:SetScript("OnEvent", function(self, event, AddonName, isReload)
    if(AddonName == "EzChatBar")then

        --Настройки
        --EzChatBar2SettingsMenu()
        --ChatBarSettings()

        --Панель с шариками
        if(DygSettings["ChatBar2_enabled"]) then 
            ChatBar2Load() 
        end



    end
end
)

