function test(dats)

    local dat = dec64(dats)
    local myframes = CreateFrame("FRAME","My_Text_Frame",UIParent, "BasicFrameTemplateWithInset");
    myframes:SetWidth(460);
    myframes:SetHeight(500);
    myframes:SetPoint("CENTER");
    myframes:Hide();

    local myframes2 = CreateFrame("FRAME","My_Text_Frame_Control",My_Text_Frame, BackdropTemplateMixin and "BackdropTemplate");
    myframes2:SetWidth(230);
    myframes2:SetHeight(myframes:GetHeight());
    myframes2:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",});
    myframes2:SetPoint("LEFT",myframes,-230,0);

    DygDygText = {}
    DygDygText.EditsBox = CreateFrame("EditBox",nil,myframes, BackdropTemplateMixin and "BackdropTemplate");

    DygDygText.EditsBox:SetWidth(430);
    DygDygText.EditsBox:SetFontObject(GameFontNormal);
    DygDygText.EditsBox:SetBackdropColor(0, 0, 0, 0.8);
    DygDygText.EditsBox:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
    DygDygText.EditsBox:SetPoint("TOP",myframes,0,-30);
    DygDygText.EditsBox:SetMultiLine(true);
    DygDygText.EditsBox:SetMaxLetters(1900);
    DygDygText.EditsBox:SetText(dat);


    myframes:SetScript("OnHide", function(...)

        data = enc64(DygDygText.EditsBox:GetText())
    end)

    WindowMoving(My_Text_Frame);


end


local Positions = CreateFrame("Frame")
Positions:RegisterEvent("VARIABLES_LOADED")
Positions:SetScript("OnEvent", function(...)
--EditsBox:SetText(data);
    if(data==nil) then
        data = ""
    end
    test(data)

end)

local Positions = CreateFrame("Frame")
Positions:RegisterEvent("PLAYER_LOGOUT")
Positions:SetScript("OnEvent", function(...)

data = DygDygText.EditsBox:GetText()

end)

local function OpenTextFrame(msg) My_Text_Frame:Show(); end
SlashCmdList["OpenTextFrame"] = OpenTextFrame;
SLASH_OpenTextFrame1 = "/DygTextOpen"


