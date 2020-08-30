local menuFrame = CreateFrame("Frame", "ExampleMenuFrame", UIParent, "UIDropDownMenuTemplate")
menuFrame:SetPoint("Center", UIParent, "Center")
menuFrame:Hide()


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
        print("Сейчс установлено:");
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
SettingsMyAddon.myCheckButtons = {};

SettingsMyAddon.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent );
SettingsMyAddon.panel.name = "DygDyg Addons";
SettingsMyAddon.panel.okay = function (self) Settings = Settings_local; Start_Settings(); end;
SettingsMyAddon.panel.cancel = function (self) Settings = Settings_local; Start_Settings(); end;
InterfaceOptions_AddCategory(SettingsMyAddon.panel);

SettingsMyAddon.childpanelChat = CreateFrame( "Frame", "MyAddonPanel", SettingsMyAddon.panel);
SettingsMyAddon.childpanelChat.name = "Настройки списка диалогов";
SettingsMyAddon.childpanelChat.parent = SettingsMyAddon.panel.name;
InterfaceOptions_AddCategory(SettingsMyAddon.childpanelChat);

SettingsMyAddon.childpanelIstory = CreateFrame( "Frame", "MyAddonPanel", SettingsMyAddon.panel);
SettingsMyAddon.childpanelIstory.name = "Настройки истории чата";
SettingsMyAddon.childpanelIstory.parent = SettingsMyAddon.panel.name;
InterfaceOptions_AddCategory(SettingsMyAddon.childpanelIstory);




    function Dyg_OPT_Create_Button(i, My_text, My_toltip, default, My_Name, panel)

        pos2342355 = -20 * i;

        if(panel.myCheckButtons == nil) then
            panel.myCheckButtons = {}
        end

        if(panel.myCheckButtons[i] == nil) then
            panel.myCheckButtons[i] = CreateFrame("CheckButton", nil, panel, "ChatConfigCheckButtonTemplate");
            panel.myCheckButtons[i]:SetID(i);
            panel.myCheckButtons[i]:SetWidth(27);
            panel.myCheckButtons[i]:SetHeight(27);
            panel.myCheckButtons[i]:SetChecked(default);
            panel.myCheckButtons[i]:SetPoint("TOPLEFT", 20, pos2342355);
            --pos2342355 = pos2342355 - 20;
            panel.myCheckButtons[i].Text:SetText(My_text);
            panel.myCheckButtons[i].tooltip = My_toltip;
        end
            if(Settings[My_Name]~=nil) then
                panel.myCheckButtons[i]:SetChecked(Settings_local[My_Name]);
            else
                Settings_local[My_Name] = panel.myCheckButtons[i]:GetChecked();

            end

        panel.myCheckButtons[i]:SetScript("OnClick",
        function(self, button, down)
            Settings_local[My_Name] = self:GetChecked();

        end)
end

function Start_Option()

    local pan = SettingsMyAddon.childpanelChat;
    Dyg_OPT_Create_Button(1, "Стандартная панель", "Включить стандартную панель", false, "DefaultPanel", pan);
    Dyg_OPT_Create_Button(2, "Боковая панель", "Включить боковую панель", true, "MyPanel", pan);
    Dyg_OPT_Create_Button(3, "Звук входящего сообщения", "Уведомление о входящем личном сообщении", true, "SoundMes", pan);

    pan = SettingsMyAddon.childpanelIstory;
    Dyg_OPT_Create_Button(1, "Логирование чата", "Включить сохранение истории личных переписок", false, "LogChat", pan);
--    Dyg_OPT_Create_Button(4, "Звук входящего сообщения гильдии", "Уведомление о входящем сообщении гильдии", true, "SoundMesGuild", pan);
end




local Event2 = CreateFrame("Frame");
Event2:RegisterEvent("ADDON_LOADED");
Event2.test = true;
Event2:SetScript("OnEvent", function(...)

    if(Settings == nil) then
        Settings = {}
    end

    if(Event2.test == true) then
        Settings_local = Settings;
        Start_Option();
        Start_Settings();
        Event2.test = false;
    end
end)

SettingsMyAddon.panel.logo = CreateFrame("Frame", nil, SettingsMyAddon.panel);
SettingsMyAddon.panel.logo:SetWidth(300);
SettingsMyAddon.panel.logo:SetHeight(300);
SettingsMyAddon.panel.logo:SetPoint("CENTER");
SettingsMyAddon.panel.logo:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\logo",});