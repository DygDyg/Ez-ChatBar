Dyg_st_temp = 1;
Dyg_UTC_plus = 3600 * 4;
Dyg_UTC_Minus = 3600 * 0;

---------------------------------------------------------------------------

function messeng(args)

        if(type(Message)~="table") then
            Message = {}
            print("Dyg-Mes: ГОТОВО")
        end

    local MesD = {
        ["type"] = args[2],
        ["text"] = args[3],
        ["name"] = args[4],
        ["id"] = args[14],
        ["UNIX"] = C_DateAndTime.GetServerTimeLocal(),
        ["date"] = date("%m.%d.%y"),
        ["time"] = date("%H:%M:%S"),
    }

    Message[#Message+1] = MesD
end

----------------------------------------------------------------------------

local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
Event1:RegisterEvent("CHAT_MSG_WHISPER");
--Event1:RegisterEvent("CHAT_MSG_BN_WHISPER");
--Event1:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM");
Event1:SetScript("OnEvent", function(...)
    if(Settings["Логирование чата"] == true) then
        local args = {...};
        messeng(args)
    end
end)

-----

local Event2 = CreateFrame("Frame");
Event2:RegisterEvent("ADDON_LOADED");
Event2:SetScript("OnEvent", function(...)
Dyg_pars(Message);
end)

-----------------------------------------------------------------------------

local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 20);

	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end

	self:SetVerticalScroll(newValue);
end

------------------------------------------------------------------------------
function Dyg_Frame()

    Dyg = {}
    Dyg.myframes = CreateFrame("Frame","My_Mes_Frame",UIParent, "BasicFrameTemplateWithInset");
    WindowMoving(Dyg.myframes, "DygMes");
    Dyg.myframes:Hide();
    Dyg.myframes:SetWidth(460);
    Dyg.myframes:SetHeight(500);
    Dyg.myframes:SetPoint("CENTER");
    Dyg.myframes.TitleText:SetText("*Username*");

    Dyg.myframes2 = CreateFrame("FRAME","My_Mes_Frame_Control",My_Mes_Frame);
    Dyg.myframes2:SetWidth(230);
    Dyg.myframes2:SetHeight(Dyg.myframes:GetHeight());
    Dyg.myframes2:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",});
    Dyg.myframes2:SetPoint("LEFT",Dyg.myframes,-230,0);

    Dyg.myframes.ScrollFrame = CreateFrame("ScrollFrame", nil, Dyg.myframes, "UIPanelScrollFrameTemplate");
    Dyg.myframes.ScrollFrame:SetPoint("TOPLEFT", Dyg.myframes, "TOPLEFT", 4, -21);
    Dyg.myframes.ScrollFrame:SetPoint("BOTTOMRIGHT", Dyg.myframes, "BOTTOMRIGHT", -3, 10);
    Dyg.myframes.ScrollFrame:SetClipsChildren(true);
    Dyg.myframes.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
    Dyg.myframes.ScrollFrame.ScrollBar:ClearAllPoints();
    Dyg.myframes.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", Dyg.myframes.ScrollFrame, "TOPRIGHT", -18, -32);
    Dyg.myframes.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", Dyg.myframes.ScrollFrame, "BOTTOMRIGHT", -7, 18);

    Dyg.myframes.TextEditor = CreateFrame("EditBox", nil, Dyg.myframes.ScrollFrame);
    Dyg.myframes.TextEditor:Disable();
    Dyg.myframes.TextEditor:SetWidth(430);
    Dyg.myframes.TextEditor:SetFontObject(GameFontNormal);
    Dyg.myframes.TextEditor:SetBackdropColor(0, 0, 0, 0.8);
    Dyg.myframes.TextEditor:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
    Dyg.myframes.TextEditor:SetPoint("TOP",Dyg.myframes,0,-30);
    Dyg.myframes.TextEditor:SetMultiLine(true);

    Dyg.myframes.ScrollFrame:SetScrollChild(Dyg.myframes.TextEditor);

end

Dyg_Frame()

-----------------------------------------------------------------------------


function Dyg_pars(Messages)
    local Dyg_Mes_type;
        if(Dyg_st_temp == 1) then
            local i = 1;
            local Dyg_tex = "";
            local Dyg_Data_Letr = "";
            local a = nil;
            while i < #Messages do
                if(Messages[i]["name"] == "Дугдуг-Дракономор") then

                    if(a == nil) then
                        --Dyg.myframes.TextEditor:Insert("|cff7b68ee =========={"..Messages[i]["name"].."}==========|r".."\n");
                        Dyg.myframes.TitleText:SetText(Messages[i]["name"]);
                        a = 1;
                    end

                    local Dyg_tim = date("!*t", Messages[i]["UNIX"]);
                    local DygDyg_t = Messages[i]["time"] or "??:??:??";
                    local Dyg_time = Dyg_tim.year.."."..Dyg_tim.month.."."..Dyg_tim.day;
                    Dyg_Data_New = Dyg_time;
                    if(Dyg_Data_Letr ~= Dyg_Data_New) then
                        Dyg.myframes.TextEditor:Insert("                           |cffff8000==========["..Dyg_Data_New.."]==========|r".."\n")
                        Dyg_Data_Letr = Dyg_Data_New;
                    end

                    Dyg_Mes_type = "|CFF85c2ff Вам|r"
                    if(Messages[i]["type"] == "CHAT_MSG_WHISPER_INFORM") then
                        Dyg_Mes_type = "|CFFbdffbd Вы|r";
                    end

                    Dyg.myframes.TextEditor:Insert("|CFFe0ffff["..DygDyg_t.."]|r"..Dyg_Mes_type..": "..Messages[i]["text"].."\n");
                    --print(Messages[Dyg_A]["name"]);
                    Dyg_tim = nil;
                end
                --print(i)
                i = i + 1;
            end;
            Dyg_st_temp = 0;
        end
    --Dyg.myframes.TextEditor:SetText(Dyg_tex);
end;

function OpenMsgFrame(msg) Dyg.myframes:Show(); end

SlashCmdList["OpenMsgFrame"] = OpenMsgFrame;
SLASH_OpenMsgFrame1 = "/DygMSGOpen"



function DygClearMsg()
    StaticPopupDialogs["DygClearMsg"] = {
    text = "Удалить всю историю переписки? Это будет необратимо. Саавсем необратимо. Точно-точно необратимо!",
    button1 = "Да",
    button2 = "Нет",

    OnAccept = function()
        print("Я усё удалиль, честно - честно :)")
        Message = {}
    end,

    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}
StaticPopup_Show ("DygClearMsg")
end

SlashCmdList["DygClearMsg"] = DygClearMsg;
SLASH_DygClearMsg1 = "/DygClearMsg"

--local seconds_since_epoch  = 1379094015
--datetime = date("!*t",seconds_since_epoch)
--print(tostring(datetime.year))
-----------------------------------------------------------------------------