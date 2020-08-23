local cor = -16;
local a1 = 2;

function MesButtonPanel()

    if(DygMesTab==nil) then
        DygMesTab = CreateFrame("FRAME", "DygMesTab1", UIParent);
        DygMesTab:SetWidth(125);
        DygMesTab:SetHeight(12);
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

menu = {
    { text = "Select an Option", isTitle = true},
    { text = "Option 1", func = function() print("You've chosen option 1"); end },
    { text = "Option 2", func = function() print("You've chosen option 2"); end },
    { text = "More Options", hasArrow = true,
        menuList = {
            { text = "Option 3", func = function() print("You've chosen option 3"); end }
        }
    }
}
-- Note that this frame must be named for the dropdowns to work.
--menuFrame = CreateFrame("Frame", "ExampleMenuFrame", UIParent, "UIDropDownMenuTemplate")

-- Make the menu appear at the cursor:
--EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
-- Or make the menu appear at the frame:
--menuFrame:SetPoint("Center", UIParent, "Center")

--EasyMenu(menu, menuFrame, menuFrame, 0 , 0, "MENU");


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

function MesButton()
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
                    local x, y = GetCursorPosition();
                    local scale = UIParent:GetEffectiveScale();
                    DropDownList1:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", x/scale, y/scale);
                elseif(button == "MiddleButton") then
                    MesButton()
                    print(button)
                    --DygMesTab:SetHeight(DygMesTab:GetHeight() - 20);
                end
                PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
            end);
            name[1], name[2] = strsplit("-", (DygMesTabLocal[i]:GetText()))
            if(name[1] == nil) then
                name[1] = DygMesTabLocal[i]:GetText();
                name[2] = "?";
            end
            DygMesTab[num1]:SetText(name[1]);
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
    --local args = {...};
    MesButton()
end)

local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("PLAYER_ENTERING_WORLD");
Event1:SetScript("OnEvent", function(...)
    MesButton()
end)

function OffsetPanel(msg)
    msg = tonumber(msg);
    --print(type(t_mes));
    --print(t_mes);

    if(msg~=nil) then
        --print(msg);
        Settings["OffsetPanel"] = msg;
        MesButton()
    end
end

SlashCmdList["OffsetPanel"] = OffsetPanel;
SLASH_OffsetPanel1 = "/DygOffsetPanel"
