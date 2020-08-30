local cor = -17;
local a1 = 2;

    if(C_CVar.GetCVar("whisperMode") == "inline") then
        print("-------------------------------------------")
        C_CVar.SetCVar("whisperMode", "popout");
        print("Настройка "..InterfaceOptionsSocialPanelWhisperModeLabel:GetText().." изменена")
    end

--menu = {
--    { text = "Select an Option", isTitle = true},
--    { text = "Option 1", func = function() print("You've chosen option 1"); end },
--    { text = "Option 2", func = function() print("You've chosen option 2"); end },
--    { text = "More Options", hasArrow = true,
--        menuList = {
--            { text = "Option 3", func = function() print("You've chosen option 3"); end }
--        }
--    }
--}
--



--EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");

--EasyMenu(menu, menuFrame, menuFrame, 0 , 0, "MENU");




function MesButtonPanel()

    if(DygMesTab==nil) then
        DygMesTab = CreateFrame("FRAME", "DygMesTab1", UIParent);
        DygMesTab:SetWidth(115);
        DygMesTab:SetHeight(15);
        DygMesTab:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",});
        DygMesTab:SetPoint("RIGHT", ChatFrame1.ScrollBar, "TOP", 150, 0);
        WindowMoving(DygMesTab, "DygMesTab");
        DygMesTab:SetUserPlaced(true);
    end
end

function Start_Settings()
    if(Settings["DefaultPanel"] == true) then
        GeneralDockManager:Show();
    else
        GeneralDockManager:Hide();
    end

        if(Settings["MyPanel"] == true) then
        DygMesTab:Show();
    else
        DygMesTab:Hide();
    end

end

MesButtonPanel()

function MesButton(args)
    local DygMesTabLocal = {
        [1] = ChatFrame1Tab,
        [2] = ChatFrame2Tab,
        [3] = ChatFrame3Tab,
        [4] = ChatFrame4Tab,
        [5] = ChatFrame5Tab,
        [6] = ChatFrame6Tab,
        [7] = ChatFrame7Tab,
        [8] = ChatFrame8Tab,
        [9] = ChatFrame9Tab,
        [10] = ChatFrame10Tab,
        [11] = ChatFrame11Tab,
        [12] = ChatFrame12Tab,
        [13] = ChatFrame13Tab,
        [14] = ChatFrame14Tab,
        [15] = ChatFrame15Tab,
        [16] = ChatFrame16Tab,
        [17] = ChatFrame17Tab,
        [18] = ChatFrame18Tab,
        [19] = ChatFrame19Tab,
        [20] = ChatFrame20Tab,
        [21] = ChatFrame21Tab,
        [22] = ChatFrame22Tab,
        [23] = ChatFrame23Tab,
        [24] = ChatFrame24Tab,
        [25] = ChatFrame25Tab,
        [26] = ChatFrame26Tab,
        [27] = ChatFrame27Tab,
        [28] = ChatFrame28Tab,
        [29] = ChatFrame29Tab,
        [30] = ChatFrame30Tab,
        [31] = ChatFrame31Tab,
        [32] = ChatFrame32Tab,
        [33] = ChatFrame33Tab,
        [34] = ChatFrame34Tab,
        [35] = ChatFrame35Tab,
        [36] = ChatFrame36Tab,
        [37] = ChatFrame37Tab,
        [38] = ChatFrame38Tab,
        [39] = ChatFrame39Tab,
    }


    local name = {}

    local r, g, b, a = DygMesTabLocal[1].Text:GetTextColor()
    local ColorSa = 40;

    if(DygMesTab.TextPanel == nil) then
        DygMesTab.TextPanel = CreateFrame("FRAME", "TextPanel", DygMesTab);
        DygMesTab.TextPanel:SetWidth(115);
        DygMesTab.TextPanel:SetHeight(15);
        DygMesTab.TextPanel:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",});
        DygMesTab.TextPanel:SetPoint("BOTTOM", DygMesTab, "TOP", 0, 0);
        DygMesTab.TextPanel.Text = CreateFrame("EditBox", "Text", DygMesTab.TextPanel);
        DygMesTab.TextPanel.Text:SetWidth(115);
        DygMesTab.TextPanel.Text:SetHeight(15);
        DygMesTab.TextPanel.Text:SetFontObject(GameFontNormal);
        DygMesTab.TextPanel.Text:Disable();
        DygMesTab.TextPanel.Text:SetText("Text Info");
        DygMesTab.TextPanel.Text:SetPoint("CENTER");
        DygMesTab.TextPanel:Hide();

    end

    if(DygMesTab.GeberalTab == nil) then
        DygMesTab.GeberalTab = CreateFrame("FRAME", "GeberalTab", DygMesTab);
        DygMesTab.GeberalTab:SetWidth(15);
        DygMesTab.GeberalTab:SetHeight(15);
        DygMesTab.GeberalTab:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\general", insets = { left = 1, right = 1, top = 1, bottom = 1}});
        DygMesTab.GeberalTab:SetBackdropColor(r, g, b, a);
        DygMesTab.GeberalTab:SetPoint("LEFT", DygMesTab, "LEFT", 0, 0);

        DygMesTab.GeberalTab:SetScript("OnEnter", function(self)
            DygMesTab.GeberalTab:SetBackdropColor(r+(ColorSa/255), g+(ColorSa/255), b+(ColorSa/255), a);
            DygMesTab.TextPanel:Show();
            DygMesTab.TextPanel.Text:SetText("Общий чат");
        end)

        DygMesTab.GeberalTab:SetScript("OnLeave", function(self)
            DygMesTab.GeberalTab:SetBackdropColor(r, g, b, a);
            DygMesTab.TextPanel:Hide();
        end)

        DygMesTab.GeberalTab:SetScript("OnMouseDown", function(self, button)
            self:SetBackdropColor(1, 1, 1, 1);
            DygMesTabLocal[1]:Click(button);
                if(button == "RightButton") then
                    if(IsControlKeyDown() == true)then
                        Debug("Contrl");
                    end
                    local x, y = GetCursorPosition();
                    local scale = UIParent:GetEffectiveScale();
                    DropDownList1:SetPoint("TOPLEFT", DygMesTab, "TOPRIGHT", 0, 0);
                elseif(button == "LeftButton") then
                    OpenTabHide();
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);

        DygMesTab.GeberalTab:SetScript("OnMouseUp", function(self, button)
            self:SetBackdropColor(r, g, b, a);
        end)
    end

    if(DygMesTab.CombatLog == nil) then
        DygMesTab.CombatLog = CreateFrame("FRAME", "GeberalTab", DygMesTab);
        DygMesTab.CombatLog:SetWidth(15);
        DygMesTab.CombatLog:SetHeight(15);
        DygMesTab.CombatLog:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\CombatLog", insets = { left = 1, right = 1, top = 1, bottom = 1}});
        DygMesTab.CombatLog:SetBackdropColor(r, g, b, a);
        DygMesTab.CombatLog:SetPoint("LEFT", DygMesTab.GeberalTab, "RIGHT", 0, 0);

        DygMesTab.CombatLog:SetScript("OnEnter", function(self)
            self:SetBackdropColor(r+(ColorSa/255), g+(ColorSa/255), b+(ColorSa/255), a);
            DygMesTab.TextPanel:Show();
            DygMesTab.TextPanel.Text:SetText("Журнал боя");
        end)

        DygMesTab.CombatLog:SetScript("OnLeave", function(self)
            self:SetBackdropColor(r, g, b, a);
            DygMesTab.TextPanel:Hide();
        end)

        DygMesTab.CombatLog:SetScript("OnMouseDown", function(self, button)
                if(button == "RightButton") then
                    if(IsControlKeyDown() == true)then
                        Debug("Contrl");
                        --local menu = {
                        --        {
                        --            { text = "Select an Option", isTitle = true},
                        --            { text = "Option 1", func = function() print("You've chosen option 1"); end },
                        --            { text = "Option 2", func = function() print("You've chosen option 2"); end },
                        --            { text = "More Options", hasArrow = true,
                        --                menuList = {
                        --                    { text = "Option 3", func = function() print("You've chosen option 3"); end }
                        --                }
                        --            }
                        --        }
                        --    }
                        --EasyMenu(menu, ExampleMenuFrame, DygMesTab, 0 , 0, "MENU");
                    else
                        DygMesTabLocal[2]:Click(button);
                        local x, y = GetCursorPosition();
                        local scale = UIParent:GetEffectiveScale();
                        DropDownList1:SetPoint("TOPLEFT", DygMesTab, "TOPRIGHT", 0, 0);
                    end
                elseif(button == "LeftButton") then
                    DygMesTabLocal[2]:Click(button);
                    OpenTabHide();
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
                self:SetBackdropColor(1, 1, 1, 1);
            end);

        DygMesTab.CombatLog:SetScript("OnMouseUp", function(self, button)
            self:SetBackdropColor(r, g, b, a);
        end)
    end

    if(DygMesTab.Settings == nil) then
        DygMesTab.Settings = CreateFrame("FRAME", "SettingsButton", DygMesTab);
        DygMesTab.Settings:SetWidth(15);
        DygMesTab.Settings:SetHeight(15);
        DygMesTab.Settings:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\Settings", insets = { left = 1, right = 1, top = 1, bottom = 1}});
        DygMesTab.Settings:SetBackdropColor(r, g, b, a);
        DygMesTab.Settings:SetPoint("RIGHT", DygMesTab, "RIGHT", 0, 0);

        DygMesTab.Settings:SetScript("OnEnter", function(self)
            self:SetBackdropColor(r+(ColorSa/255), g+(ColorSa/255), b+(ColorSa/255), a);
            DygMesTab.TextPanel:Show();
            DygMesTab.TextPanel.Text:SetText("Настройки");
        end)

        DygMesTab.Settings:SetScript("OnLeave", function(self)
            self:SetBackdropColor(r, g, b, a);
            DygMesTab.TextPanel:Hide();
        end)

        DygMesTab.Settings:SetScript("OnMouseDown", function(self, button)
            self:SetBackdropColor(1, 1, 1, 1);
                if(button == "RightButton") then
                    if(IsControlKeyDown() == true)then

                    end
                elseif(button == "LeftButton") then
                    InterfaceOptionsFrame_OpenToCategory(SettingsMyAddon.panel);
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);

        DygMesTab.Settings:SetScript("OnMouseUp", function(self, button)
            self:SetBackdropColor(r, g, b, a);
        end)
    end

    if(DygMesTab.Close == nil) then
        DygMesTab.Close = CreateFrame("FRAME", "CloseButton", DygMesTab);
        DygMesTab.Close:SetWidth(15);
        DygMesTab.Close:SetHeight(15);
        DygMesTab.Close:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\Close", insets = { left = 1, right = 1, top = 1, bottom = 1}});
        DygMesTab.Close:SetBackdropColor(r, g, b, a);
        DygMesTab.Close:SetPoint("RIGHT", DygMesTab.Settings, "LEFT", 0, 0);

        DygMesTab.Close:SetScript("OnEnter", function(self)
            self:SetBackdropColor(r+(ColorSa/255), g+(ColorSa/255), b+(ColorSa/255), a);
            DygMesTab.TextPanel:Show();
            DygMesTab.TextPanel.Text:SetText("Закрыть всё");
        end)

        DygMesTab.Close:SetScript("OnLeave", function(self)
            self:SetBackdropColor(r, g, b, a);
            DygMesTab.TextPanel:Hide();
        end)

        DygMesTab.Close:SetScript("OnMouseDown", function(self, button)
            self:SetBackdropColor(1, 1, 1, 1);
                if(button == "RightButton") then
                    if(IsControlKeyDown() == true)then

                    end
                elseif(button == "LeftButton") then
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);

        DygMesTab.Close:SetScript("OnMouseUp", function(self, button)
            self:SetBackdropColor(r, g, b, a);
        end)
    end

    if(Settings["OffsetPanel"] == nil) then
        Settings["OffsetPanel"] = 2;
    end

    for i = 1, #DygMesTabLocal do
        if(DygMesTab[i] == nil) then
                        --DygMesTab:SetHeight(DygMesTab:GetHeight() + 20);
            DygMesTab[i] = CreateFrame("Button", "button"..i, DygMesTab, "GameMenuButtonTemplate");
            DygMesTab[i]:SetWidth(120);
            DygMesTab[i]:SetHeight(20);
            DygMesTab[i]:SetPoint("TOP", 0, cor);
            DygMesTab[i].NewMes = CreateFrame("Frame", "NewMesTexture", DygMesTab[i]);
            DygMesTab[i].NewMes:SetHeight(10);
            DygMesTab[i].NewMes:SetWidth(10);
            DygMesTab[i].NewMes:SetPoint("RIGHT", DygMesTab[i], "RIGHT", -5, 0);
            DygMesTab[i].NewMes:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\glow",});
            DygMesTab[i].NewMes:Hide();
            DygMesTab[i].OpenTab = CreateFrame("Frame", "OpenTabTexture", DygMesTab[i]);
            DygMesTab[i].OpenTab:SetWidth(DygMesTab[i]:GetWidth());
            DygMesTab[i].OpenTab:SetHeight(DygMesTab[i]:GetHeight());
            DygMesTab[i].OpenTab:SetPoint("CENTER");
            DygMesTab[i].OpenTab:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\ButtonGlowBlue", insets = { left = 0, right = 0, top = -30, bottom = -30}});
            DygMesTab[i].OpenTab:Hide();

            cor = cor - 20;
        end
    end

    function OpenTabHide()
        for i = 1, #DygMesTab do
            DygMesTab[i].OpenTab:Hide();
        end
    end

    local num1 = 1
    for i = 1, #DygMesTabLocal do
        if(DygMesTab[i] ~= nil) then
            DygMesTab[i]:Hide();
        end
        if(DygMesTabLocal[i]~=nil and DygMesTabLocal[i]:IsShown() == true and i > Settings["OffsetPanel"]) then
            if(DygMesTab[i] == nil) then

            end
            DygMesTab[num1]:Show();
            DygMesTab[num1].Text:SetTextColor(DygMesTabLocal[i].Text:GetTextColor());
            DygMesTab[num1]:SetScript("OnMouseDown", function(self, button)
            DygMesTabLocal[i]:Click(button);
                if(button == "RightButton") then

                    if(IsControlKeyDown() == true)then
                        Debug("Contrl");
                    end
                    local x, y = GetCursorPosition();
                    local scale = UIParent:GetEffectiveScale();
                    DropDownList1:SetPoint("TOPLEFT", DygMesTab, "TOPRIGHT", 0, 0);
                elseif(button == "MiddleButton") then
                    MesButton()
                elseif(button == "LeftButton") then
                    self.NewMes:Hide();
                    OpenTabHide();
                    self.OpenTab:Show();

                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);
            name[1], name[2] = strsplit("-", (DygMesTabLocal[i]:GetText()))
            if(name[1] == nil) then
                name[1] = DygMesTabLocal[i]:GetText();
                name[2] = "?";
            end
            DygMesTab[num1]:SetText(name[1]);

            if(args~=nil)then
                if("CHAT_MSG_BN_WHISPER"==args[2] or "CHAT_MSG_WHISPER"==args[2])then
                    if(args[4]==DygMesTabLocal[i]:GetText() and DygMesTabLocal[i].mouseOverAlpha<1) then
                        DygMesTab[num1].NewMes:Show();
                    end
                end
            end

            num1 = num1 + 1;
        end
    end
end

local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
Event1:RegisterEvent("CHAT_MSG_WHISPER");
Event1:RegisterEvent("CHAT_MSG_BN_WHISPER");
Event1:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM");
Event1:SetScript("OnEvent", function(...)
    local args = {...};
    DygTestData = args;
    MesButton(args)
    if(Settings["SoundMes"] == true) then
        if("CHAT_MSG_BN_WHISPER"==args[2] or "CHAT_MSG_WHISPER"==args[2]) then



            if(Settings["SoundMesFile"] == nil) then
                Settings["SoundMesFile"] = "message.mp3";
            end
            PlaySoundFile("Interface\\AddOns\\DygDyg_Addons\\sound\\"..Settings["SoundMesFile"], "SFX");
        end
    end
end)

local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("PLAYER_ENTERING_WORLD");
Event1:SetScript("OnEvent", function(...)
    MesButton()
end)

function OffsetPanel(msg)
    msg = tonumber(msg);

    if(msg~=nil) then
        Settings["OffsetPanel"] = msg;
        MesButton()
    end
end
function DygMesSoundFile(file)
    if(file ~= "") then
        Settings["SoundMesFile"] = file;
        print("Звук сообщений "..file.." установлен")
    else
        print("Текущий звук сообщений "..Settings["SoundMesFile"])
        print("Для смены звука пропишите команду:")
        print(" /DygMesSoundFile <название файла>.mp3")
        print("Предварительно закинув файл звука в")
        print("  ..\\Interface\\AddOns\\DygDyg_Addons\\sound")
    end
end


SlashCmdList["OffsetPanel"] = OffsetPanel;
SLASH_OffsetPanel1 = "/DygOffsetPanel"

SlashCmdList["DygMesSoundFile"] = DygMesSoundFile;
SLASH_DygMesSoundFile1 = "/DygMesSoundFile"
