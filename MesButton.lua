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
        DygMesTab.GeberalTab = Dyg_Button_Panel("GeberalTab", "Общий чат", "general", DygMesTab, {"LEFT", DygMesTab, "LEFT", 0, 0})

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
        DygMesTab.CombatLog = Dyg_Button_Panel("CombatLog", "Журнал боя", "CombatLog", DygMesTab, {"LEFT", DygMesTab.GeberalTab, "RIGHT", 0, 0})
        DygMesTab.CombatLog:SetScript("OnMouseDown", function(self, button)
                if(button == "RightButton") then
                    if(IsControlKeyDown() == true)then
                        Debug("Contrl");
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
        DygMesTab.Settings = Dyg_Button_Panel("SettingsButton", "Настройки", "Settings", DygMesTab, {"RIGHT", DygMesTab, "RIGHT", 0, 0})

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
        DygMesTab.Close = Dyg_Button_Panel("CloseButton", "Закрыть всё", "Close", DygMesTab, {"RIGHT", DygMesTab.Settings, "LEFT", 0, 0});

        DygMesTab.Close:SetScript("OnMouseDown", function(self, button)
            self:SetBackdropColor(1, 1, 1, 1);
                if(button == "RightButton") then
                    if(IsControlKeyDown() == true)then

                    end
                elseif(button == "LeftButton") then
                    if(IsControlKeyDown() == true)then
                        Debug("Contrl");
                        CloseAllTab();
                    else
                        StaticPopupDialogs["DygCloseAllTab"] = {
                            text = "Закрыть все вкладки?",
                            button1 = "Да",
                            button2 = "Нет",
                            OnAccept = function()
                                CloseAllTab();
                            end,
                            timeout = 0,
                            whileDead = true,
                            hideOnEscape = true,
                            preferredIndex = 3,
                        }
                        StaticPopup_Show("DygCloseAllTab");
                    end
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);
    end

    if(Settings["OffsetPanel"] == nil) then
        Settings["OffsetPanel"] = 2;
    end

    for i = 1, #DygMesTabLocal do
        if(DygMesTab[i] == nil) then
                        --DygMesTab:SetHeight(DygMesTab:GetHeight() + 20);
            DygMesTab[i] = CreateFrame("Button", "button"..i, DygMesTab);

            DygMesTab[i].b = CreateFrame("Button", nil, DygMesTab[i], "GameMenuButtonTemplate");
            DygMesTab[i].b:SetWidth(115);
            DygMesTab[i].b:SetHeight(17);
            DygMesTab[i].b.Text:SetParent(DygMesTab[i])
            DygMesTab[i].b.Text:SetPoint("CENTER");
            DygMesTab[i].b.Text:SetWidth(115);
            DygMesTab[i].b.Text:SetHeight(17);
            DygMesTab[i].b:Hide()
            DygMesTab[i]:SetText("ttt")


            DygMesTab[i]:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",  insets = { left = 0, right = 0, top = 0, bottom = 0}});
            DygMesTab[i]:SetBackdropColor(0, 0, 0, 1);
            DygMesTab[i]:SetWidth(115);
            DygMesTab[i]:SetHeight(17);
            DygMesTab[i]:SetPoint("TOP", 0, cor);


            --DygMesTab[i].Text = CreateFrame("FontString", nil, DygMesTab[i]);
            --DygMesTab[i].Text:Disable();
            --DygMesTab[i].Text:SetFontObject(GameFontNormal);
            --DygMesTab[i].Text:SetWidth(115);
            --DygMesTab[i].Text:SetHeight(15);
            --DygMesTab[i].Text:SetPoint("CENTER");
            --DygMesTab[i].Text:SetText("кнопка "..i);

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
            DygMesTab[i].OpenTab:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\ButtonGlowBlue", insets = { left = -2, right = -2, top = -31, bottom = -30}});
            DygMesTab[i].OpenTab:Hide();

            cor = cor - 19;
        end
    end

function CloseAllTab()
    for i = 1, #DygMesTabLocal do
        local r, g, b, a = DygMesTabLocal[i].Text:GetTextColor();
        if(tostring(g) == "0.50195968151093" or tostring(g) == "0.99999779462814") then
            DygMesTabLocal[i]:Click("MiddleButton");
            --Log(DygMesTabLocal[i].Text:GetText());
            MesButton()
        end
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
            --DygMesTab[num1].TextColor =
            DygMesTab[num1].b.Text:SetTextColor(DygMesTabLocal[i].Text:GetTextColor());

            --DygMesTab[num1].b.Text:SetHighlightTextColor(r, g, b, a);

            DygMesTab[num1]:SetScript("OnMouseDown", function(self, button)
                DygMesTabLocal[i]:Click(button);
                if(button == "RightButton") then                                                           --Правая кнопка
                    if(IsControlKeyDown() == true)then
                        Debug("Contrl");
                    end
                    local x, y = GetCursorPosition();
                    local scale = UIParent:GetEffectiveScale();
                    DropDownList1:SetPoint("TOPLEFT", DygMesTab, "TOPRIGHT", 0, 0);

                    if(DropDownList1Button4.value == "Закрыть окно личных сообщений") then
                        --Log("Закрыть окно личных сообщений")
                        DropDownList1Button4:SetScript("OnClick", function(self, button)
                                DygMesTabLocal[i]:Click("MiddleButton");
                                MesButton()
                        end)
                    end

                    if(DropDownList1Button5.value == "Закрыть окно чата") then
                        --Log("Закрыть окно личных сообщений")
                        DropDownList1Button5:SetScript("OnClick", function(self, button)
                                DygMesTabLocal[i]:Click("MiddleButton");
                                MesButton()
                        end)
                    end

                elseif(button == "MiddleButton") then                                                      --Колёсико
                    MesButton()
                elseif(button == "LeftButton") then                                                        --Левая кнопка
                    self.NewMes:Hide();
                    OpenTabHide();
                    self.OpenTab:Show();
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);

            DygMesTab[num1].UserName, DygMesTab[num1].ServerName = strsplit("-", (DygMesTabLocal[i]:GetText()))

            --DygMesTab[num1].ServerName = name[2];

            if(DygMesTab[num1].UserName == nil) then
                DygMesTab[num1].UserName = DygMesTabLocal[i]:GetText();
                DygMesTab[num1].ServerName = "?";
            end


            DygMesTab[num1]:SetScript("OnEnter", function(self)
                local r, g, b, a = DygMesTabLocal[i].Text:GetTextColor()
                self.b.Text:SetTextColor(r*1.5, g*1.5, b*1.5, a);
                if(self.ServerName ~= nil) then
                    DygMesTab.TextPanel:Show();
                    DygMesTab.TextPanel.Text:SetText(tostring(self.ServerName));
                end
            end)

            DygMesTab[num1]:SetScript("OnLeave", function(self)
                --local r, g, b, a = DygMesTabLocal[i].Text:GetTextColor()
                self.b.Text:SetTextColor(DygMesTabLocal[i].Text:GetTextColor());
                DygMesTab.TextPanel:Hide();
            end)

            DygMesTab[num1].b.Text:SetText(DygMesTab[num1].UserName);

            if(args~=nil)then
                if("CHAT_MSG_BN_WHISPER"==args[2] or "CHAT_MSG_WHISPER"==args[2])then
                    if(args[4]==DygMesTabLocal[i]:GetText() and DygMesTabLocal[i].mouseOverAlpha < 1) then
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
            PlaySoundFile("Interface\\AddOns\\DygDyg_Addons\\sound\\"..Settings["SoundMesFile"], "master");
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


local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("CHAT_MSG_ADDON");

Event1:SetScript("OnEvent", function(...)
    local aa = {...}
    --for i=1, #aa do
    --    print(aa[i])
    --end

end)