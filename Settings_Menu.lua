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




local MyAddon = {};
--if Settings == nil then Settings = {}; end
--pos2342355 = -20;
MyAddon.myCheckButtons = {};

MyAddon.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent );
MyAddon.panel.name = "DygDyg Addons";
MyAddon.panel.okay = function (self) Settings = Settings_local; Start_Settings(); end;
MyAddon.panel.cancel = function (self) Settings = Settings_local; Start_Settings(); end;
InterfaceOptions_AddCategory(MyAddon.panel);

MyAddon.childpanelChat = CreateFrame( "Frame", "MyAddonPanel", MyAddon.panel);
MyAddon.childpanelChat.name = "Настройки списка диалогов";
MyAddon.childpanelChat.parent = MyAddon.panel.name;
InterfaceOptions_AddCategory(MyAddon.childpanelChat);

MyAddon.childpanelIstory = CreateFrame( "Frame", "MyAddonPanel", MyAddon.panel);
MyAddon.childpanelIstory.name = "Настройки истории чата";
MyAddon.childpanelIstory.parent = MyAddon.panel.name;
InterfaceOptions_AddCategory(MyAddon.childpanelIstory);




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

    local pan = MyAddon.childpanelChat;
    Dyg_OPT_Create_Button(1, "Стандартная панель", "Включить стандартную панель", true, "DefaultPanel", pan);
    Dyg_OPT_Create_Button(2, "Боковая панель", "Включить боковую панель", true, "MyPanel", pan);
    Dyg_OPT_Create_Button(3, "Звук входящего сообщения", "Уведомление о входящем личном сообщении", true, "SoundMes", pan);

    pan = MyAddon.childpanelIstory;
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

MyAddon.panel.logo = CreateFrame("Frame", nil, MyAddon.panel);
MyAddon.panel.logo:SetWidth(300);
MyAddon.panel.logo:SetHeight(300);
MyAddon.panel.logo:SetPoint("CENTER");
MyAddon.panel.logo:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\icon",});