local cor = -17;
local a1 = 2;

function MesButtonPanel()

    if(DygMesTab==nil) then
        DygMesTab = CreateFrame("FRAME", "DygMesTab1", UIParent);
        DygMesTab:SetWidth(115);
        DygMesTab:SetHeight(15);
        DygMesTab:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",});--  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",});
        --DygMesTab:SetBackdrop({bgFile = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Smooth_Border2.tga",})
        --DygMesTab:SetBackdrop({bgFile = "Interface\\CHATFRAME\\ChatFrameBorder",})

        --DygMesTab:SetBackdropColor(48/255,48/255,48/255,0.5);
        --DygMesTab:SetPoint("CENTER");
        DygMesTab:SetPoint("RIGHT", ChatFrame1.ScrollBar, "TOP", 150, 0);
        WindowMoving(DygMesTab, "DygMesTab");
        DygMesTab:SetUserPlaced(true);
        --GeneralDockManagerScrollFrameChild:Hide();
    end
end

function Start_Settings()
    if(Settings["DefaultPanel"] == true) then
        GeneralDockManagerScrollFrameChild:Show();
    else
        GeneralDockManagerScrollFrameChild:Hide();
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
            cor = cor - 20;
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
                    DropDownList1:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", x/scale, y/scale);
                elseif(button == "MiddleButton") then
                    MesButton()
                elseif(button == "LeftButton") then
                    self.NewMes:Hide();

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
                if(args[4]==DygMesTabLocal[i]:GetText()) then
                    DygMesTab[num1].NewMes:Show();
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
