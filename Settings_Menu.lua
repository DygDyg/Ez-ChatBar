
-- /dump GetBuildInfo(); Узнать версию игры



if(DropBoxFrame == nil) then
    DropBoxFrame = CreateFrame("Frame", "ExampleMenuFrame", UIParent, "UIDropDownMenuTemplate")
    DropBoxFrame:SetPoint("Center", UIParent, "Center");
    DropBoxFrame:Hide();
end
function Debug(mes)
    if(DebugCheck == true) then
        print(mes)
    else
        --print("Дебаг не включён");
    end
end

function Log(mes)
    Debug(mes)
end

function DebugEnable(check)

    if (check == "true") then
        DebugCheck = true;
        print("Debug режим включён");
    elseif (check == "false") then
        DebugCheck = false;
        print("Debug режим выключен");
    else
        print("Сейчас установлено:");
        print(DebugCheck);
        print("Для переключения дебага введите:");
        print("/Debug true или /Debug false")
    end

end

SlashCmdList["DebugEnable"] = DebugEnable;
SLASH_DebugEnable1 = "/Debug"




SettingsMyAddon = {};
--if Settings == nil then Settings = {}; end
--pos2342355 = -20;
SettingsMyAddon.myButton = {};

SettingsMyAddon.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent, BackdropTemplateMixin and "BackdropTemplate" );
SettingsMyAddon.panel.name = "EzChatBar";
SettingsMyAddon.panel.okay = function (self) DygSettings = Settings_local; Start_Settings(); end;
SettingsMyAddon.panel.cancel = function (self) DygSettings = Settings_local; Start_Settings(); end;
InterfaceOptions_AddCategory(SettingsMyAddon.panel);

SettingsMyAddon.childpanelChat = CreateFrame( "Frame", "MyAddonPanel", SettingsMyAddon.panel, BackdropTemplateMixin and "BackdropTemplate");
SettingsMyAddon.childpanelChat.name = EZCHATBAR_SETTINGS1_PANELNAME1;
SettingsMyAddon.childpanelChat.parent = SettingsMyAddon.panel.name;
InterfaceOptions_AddCategory(SettingsMyAddon.childpanelChat);

SettingsMyAddon.childpanelIstory = CreateFrame( "Frame", "MyAddonPanel", SettingsMyAddon.panel, BackdropTemplateMixin and "BackdropTemplate");
SettingsMyAddon.childpanelIstory.name = EZCHATBAR_SETTINGS1_PANELNAME2;
SettingsMyAddon.childpanelIstory.parent = SettingsMyAddon.panel.name;
InterfaceOptions_AddCategory(SettingsMyAddon.childpanelIstory);




    function Dyg_OPT_Create_CheckBox(i, My_text, My_toltip, default, My_Name, panel)

        local pos2342355 = -20 * i;

        if(panel.myButton == nil) then
            panel.myButton = {}
        end

        if(panel.myButton[i] == nil) then
            panel.myButton[i] = CreateFrame("CheckButton", nil, panel, "ChatConfigCheckButtonTemplate");
            panel.myButton[i]:SetID(i);
            panel.myButton[i]:SetWidth(27);
            panel.myButton[i]:SetHeight(27);
            panel.myButton[i]:SetChecked(default);
            panel.myButton[i]:SetPoint("TOPLEFT", 20, pos2342355);
            --pos2342355 = pos2342355 - 20;
            panel.myButton[i].Text:SetText(My_text);
            panel.myButton[i].tooltip = My_toltip;
        end
            if(DygSettings[My_Name]~=nil) then
                panel.myButton[i]:SetChecked(Settings_local[My_Name]);
            else
                Settings_local[My_Name] = panel.myButton[i]:GetChecked();

            end

        panel.myButton[i]:SetScript("OnClick",
        function(self, button, down)
            Settings_local[My_Name] = self:GetChecked();

        end)
    end

    function Dyg_OPT_Create_Button_Color(i, My_text, My_toltip, default, My_Name, panel)

        if(DygSettings == nil) then
            DygSettings = {}
        end

        if(DygSettings["Color1"] == nil) then
            DygSettings["Color1"] = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 0.5};
        end

        local pos2342355 = -20 * i;

        if(panel.myButton == nil) then
            panel.myButton = {}
        end

        if(panel.myButton[i] == nil) then
            panel.myButton[i] = CreateFrame("frame", nil, panel, BackdropTemplateMixin and "BackdropTemplate");
            panel.myButton[i]:SetID(i);
            panel.myButton[i]:SetWidth(25);
            panel.myButton[i]:SetHeight(25);
            --panel.myButton[i]:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});
            --panel.myButton[i]:SetBackdropColor(0, 0, 0, 0.8);
            panel.myButton[i]:SetPoint("TOPLEFT", 20, pos2342355);

            panel.myButton[i].color = CreateFrame("frame", nil, panel.myButton[i], BackdropTemplateMixin and "BackdropTemplate");
            panel.myButton[i].color:SetWidth(panel.myButton[i]:GetWidth());
            panel.myButton[i].color:SetHeight(panel.myButton[i]:GetHeight());
            panel.myButton[i].color:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\Background",});

            panel.myButton[i].color:SetBackdropColor(DygSettings["Color1"]["r"], DygSettings["Color1"]["g"], DygSettings["Color1"]["b"], DygSettings["Color1"]["a"]);
            panel.myButton[i].color:SetScale(0.6)
            panel.myButton[i].color:SetPoint("CENTER");

            panel.myButton[i].Text = CreateFrame("EditBox", "Text", panel.myButton[i], BackdropTemplateMixin and "BackdropTemplate");
            panel.myButton[i].Text:SetWidth(400);
            panel.myButton[i].Text:SetHeight(20);
            panel.myButton[i].Text:SetPoint("LEFT", panel.myButton[i], "RIGHT", 0, 0);
            panel.myButton[i].Text:SetFontObject(GameFontNormal);
            panel.myButton[i].Text:Disable();
            panel.myButton[i].Text:SetMultiLine(true);
            panel.myButton[i].Text:SetText(My_text);
            panel.myButton[i].Text:SetTextColor(1, 1, 1, 1);

            panel.myButton[i].tooltip = My_toltip;
        end

        panel.myButton[i]:SetScript("OnMouseDown",
        function(self, button, down)
            DygColorPanel(panel.myButton[i].color, My_Name)

        end)
    end

    function Dyg_OPT_Create_InputBox(i, My_text, My_toltip, default, My_Name, panel)
        local pos2342355 = -20 * i;
        if(panel.imputBox[i]==nil) then
            panel.imputBox[i] = CreateFrame("EditBox", nil, frame, "InputBoxTemplate");
            panel.imputBox[i]:SetID(i);
            panel.imputBox[i]:SetWidth(27);
            panel.imputBox[i]:SetHeight(27);
            panel.imputBox[i]:SetPoint("TOPLEFT", 20, pos2342355);
        end
    end

    function Dyg_OPT_Create_DropBox(i, text, panel)
        local pos2342355 = -20 * i;
        local menu1 = {}
        for i = 1, #Dyg_Sound_PlayList_Message do
            menu1[i] = { text = Dyg_Sound_PlayList_Message[i], func = function() Dyg_OPT_Sound_edit(Dyg_Sound_PlayList_Message[i]); end }
        end

        if(panel.DropBoxFrame == nil) then
            panel.DropBoxFrame = {};
        end
        if(panel.DropBoxFrame[i] == nil) then
            panel.DropBoxFrame[i] = CreateFrame("Button", nil, panel, "GameMenuButtonTemplate");
            panel.DropBoxFrame[i]:SetID(i);
            panel.DropBoxFrame[i]:SetText(text);
            panel.DropBoxFrame[i]:SetWidth(150);
            panel.DropBoxFrame[i]:SetHeight(22);
            panel.DropBoxFrame[i]:SetPoint("TOPLEFT", 20, pos2342355);
            BuferButtonEdit12342345 = panel.DropBoxFrame[i];
            panel.DropBoxFrame[i]:SetScript("OnMouseDown", function(self, button)
                EasyMenu(menu1, DropBoxFrame, panel.DropBoxFrame[i], 0 , 0, "MENU");
                BuferButtonEdit12342345 = panel.DropBoxFrame[i];
            end)
        end
    end

function Dyg_OPT_Sound_edit(file)
    --print(file);
    PlaySoundFile("Interface\\AddOns\\EzChatBar\\sound\\"..file, "master");
    DygSettings["SoundMesFile"] = file;
    BuferButtonEdit12342345:SetText(file);
end


function Start_Option()

    local pan = SettingsMyAddon.childpanelChat;
    local num = 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX1, EZCHATBAR_SETTINGS1_CHECKBOX1_TITLE, true, "DefaultPanel", pan); num = num + 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX2, EZCHATBAR_SETTINGS1_CHECKBOX2_TITLE, true, "MyPanel", pan); num = num + 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX_CHATBAR, EZCHATBAR_SETTINGS1_CHECKBOX_CHATBAR_TITLE, true, "ChatBarEnable", pan); num = num + 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX3, EZCHATBAR_SETTINGS1_CHECKBOX3_TITLE, true, "SoundMes", pan); num = num + 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX4, EZCHATBAR_SETTINGS1_CHECKBOX4_TITLE, false, "FixBar", pan); num = num + 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX6, EZCHATBAR_SETTINGS1_CHECKBOX6_TITLE, false, "FixBarCombat", pan); num = num + 1;
    Dyg_OPT_Create_CheckBox(num, EZCHATBAR_SETTINGS1_CHECKBOX5, EZCHATBAR_SETTINGS1_CHECKBOX5_TITLE, false, "PanelHorizontal", pan); num = num + 1;
    Dyg_OPT_Create_Button_Color(num, EZCHATBAR_SETTINGS1_COLOR1, EZCHATBAR_SETTINGS1_COLOR1_TITLE, true, 1, pan); num = num + 1;
    Dyg_OPT_Create_DropBox(num, DygSettings["SoundMesFile"], pan); num = num + 1;
    --Dyg_OPT_Create_Button_Color(5, "Цвет Значков", "Уведомление о входящем личном сообщении", true, 2, pan); num = num + 1;

    num = 1;
    pan = SettingsMyAddon.childpanelIstory;
    Dyg_OPT_Create_CheckBox(1, EZCHATBAR_SETTINGS2_CHECKBOX1, EZCHATBAR_SETTINGS2_CHECKBOX1_TITLE, false, "LogChat", pan); num = num + 1;
--  Dyg_OPT_Create_CheckBox(4, "Звук входящего сообщения гильдии", "Уведомление о входящем сообщении гильдии", true, "SoundMesGuild", pan); num = num + 1;
end




local Event = CreateFrame("Frame");
Event:RegisterEvent("ADDON_LOADED");
Event.start = false;
Event:SetScript("OnEvent", function(...)

    if(DygSettings == nil) then
        DygSettings = {}
    end

    if(Event.start == true) then
        Settings_local = DygSettings;
        Start_Option();
        MesButtonPanel();
        MesButton();
        Start_Settings();
        Favorit();
        Event.start = false;
    end
end)


--Событие при старте игры, чтоб прогрузились сохранённые данные
local Event = CreateFrame("Frame");
Event:RegisterEvent("PLAYER_ENTERING_WORLD");
Event.start = true;
Event:SetScript("OnEvent", function(...)

    if(DygSettings == nil) then
        DygSettings = {}
    end

    if(Event.start == true) then
        Settings_local = DygSettings;
        Start_Option();
        MesButtonPanel();
        MesButton();
        Start_Settings();

        Event.start = false;
    end

end)



local Event2 = CreateFrame("Frame");
Event2:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
Event2:SetScript("OnEvent", function(...)
    MesButton();
end)


SettingsMyAddon.panel.logo = CreateFrame("Frame", nil, SettingsMyAddon.panel, BackdropTemplateMixin and "BackdropTemplate");
SettingsMyAddon.panel.logo:SetWidth(300);
SettingsMyAddon.panel.logo:SetHeight(300);
SettingsMyAddon.panel.logo:SetPoint("CENTER");
SettingsMyAddon.panel.logo:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\logo",});
