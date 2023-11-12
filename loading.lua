local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")

f:SetScript("OnEvent", function(self, event, AddonName, isReload)
    if(AddonName == "EzChatBar")then
        --C_Timer.After(5, function()
            EZ_default_settings()
            DygSettings["VerWOWClient"] = select(4, GetBuildInfo());

            --Настройки
            --EzChatBar2SettingsMenu()
            --ChatBarSettings()

            EZ_old_settings()

            Settings_local = DygSettings;
            
            -- MesPanelStart();
            -- Start_Option();
            -- MesButtonPanel();
            -- MesButton();
            -- Start_Settings();
            -- Favorit();

            -- EZTabButtonStart() --Табы отключеный

            EZ_old_settings2()

            --Панель с шариками
            if(DygSettings["ChatBar2_enabled"]) then 
                ChatBar2Load() 
            end

            --FIX LUA ERROR FRAME
            ScriptErrorsFrame:SetWidth(400);
            ScriptErrorsFrame.ScrollFrame:SetWidth(360);
            ScriptErrorsFrame.ScrollFrame.Text:SetWidth(360);
            --FIX LUA ERROR FRAME
            -- DygSettings["CheckVersion"] = 1

        --end)
    end
end
)



function EZ_default_settings()

    if(DygSettings==nil)then
        DygSettings={}
    end

    if(DygSettings["CheckVersion"]==nil)then
        DygSettings["CheckVersion"] = 0
    end

    if(DygSettings["ChatBar2_enabled"]==nil)then
        DygSettings["ChatBar2_enabled"] = true;
    end

    if(DygSettings["SoundMesFile"] == nil or DygSettings["SoundMesFile"] == "") then
        DygSettings["SoundMesFile"] = "message.mp3";
    end

    if(DygSettings["skins"]==nil or DygSettings["skins"] == "")then
        DygSettings["skins"] = "bubble1";
    end

    if(DygSettings["mirror_flip"]==nil)then
        DygSettings["mirror_flip"] =  false;
    end

    if(DygSettings["DisableBLUAError"]==nil) then
        DygSettings["DisableBLUAError"] = true;
    end

    if(DygSettings["FixBarCombat"]==nil) then
        DygSettings["FixBarCombat"] = false;
    end

    if(DygSettings["FixBar"]==nil) then
        DygSettings["FixBar"] = false;
    end

    if(DygSettings["Color1"] == nil) then
        DygSettings["Color1"] = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 0.5};
    end

    if(DygSettings["scrollframe_Height"]==nil) then
        DygSettings["scrollframe_Height"] = ChatFrame1:GetHeight();
    end

    if(DygSettings["LogChat"]==nil) then
        DygSettings["LogChat"] = false;
    end

    if(DygSettings["PanelHorizontal"]==nil)then
        DygSettings["PanelHorizontal"] = false;
    end

    if(DygSettings["OffsetPanel"] == nil) then
        DygSettings["OffsetPanel"] = 2;
    end

    if(DygSettings["DefaultPanel"] == nil) then
        DygSettings["DefaultPanel"] = true;
    end

    if(DygSettings["MyPanel"] == nil) then
        DygSettings["MyPanel"] = true;
    end

    if(DygSettings["SoundMes"] == nil) then
        DygSettings["SoundMes"] = true;
    end
end