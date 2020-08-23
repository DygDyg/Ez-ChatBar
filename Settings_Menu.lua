local MyAddon = {};
--if Settings == nil then Settings = {}; end
pos2342355 = -20;
MyAddon.myCheckButtons = {};

MyAddon.panel = CreateFrame( "Frame", "MyAddonPanel", UIParent );
MyAddon.panel.name = "DygDyg Addons";
MyAddon.panel.okay = function (self) Settings = Settings_local; Start_Settings(); end;
MyAddon.panel.cancel = function (self) Settings = Settings_local; Start_Settings(); end;

InterfaceOptions_AddCategory(MyAddon.panel);

    function Dyg_OPT_Create_Button(i, My_text, My_toltip, default, My_Name)

        if(MyAddon.myCheckButtons[i] == nil) then
            MyAddon.myCheckButtons[i] = CreateFrame("CheckButton", nil, MyAddon.panel, "ChatConfigCheckButtonTemplate");
            MyAddon.myCheckButtons[i]:SetID(i);
            MyAddon.myCheckButtons[i]:SetWidth(27);
            MyAddon.myCheckButtons[i]:SetHeight(27);
            MyAddon.myCheckButtons[i]:SetChecked(default);
            MyAddon.myCheckButtons[i]:SetPoint("TOPLEFT", 20, pos2342355);
            pos2342355 = pos2342355 - 20;
            MyAddon.myCheckButtons[i].Text:SetText(My_text);
            MyAddon.myCheckButtons[i].tooltip = My_toltip;
        end
            if(Settings[My_Name]~=nil) then
                MyAddon.myCheckButtons[i]:SetChecked(Settings_local[My_Name]);
            else
                Settings_local[My_Name] = MyAddon.myCheckButtons[i]:GetChecked();

            end

        MyAddon.myCheckButtons[i]:SetScript("OnClick",
        function(self, button, down)
            Settings_local[My_Name] = self:GetChecked();

        end)
end

function Start_Option()
    Dyg_OPT_Create_Button(1, "Стандартная панель", "Включить стандартную панель", true, "DefaultPanel");
    Dyg_OPT_Create_Button(2, "Боковая панель", "Включить боковую панель", true, "MyPanel");
    Dyg_OPT_Create_Button(3, "Логирование чата", "Включить сохранение истории личных переписок", true, "LogChat");
end



-- Make a child panel
--MyAddon.childpanel = CreateFrame( "Frame", "MyAddonChild", MyAddon.panel);
--MyAddon.childpanel.name = "Настройки";
-- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
--MyAddon.childpanel.parent = MyAddon.panel.name;
-- Add the child to the Interface Options
--InterfaceOptions_AddCategory(MyAddon.childpanel);

local Event2 = CreateFrame("Frame");
Event2:RegisterEvent("ADDON_LOADED");
Event2.test = true;
Event2:SetScript("OnEvent", function(...)
    if(Event2.test == true) then
        Settings_local = Settings;
        Start_Option();
        Start_Settings();
        Event2.test = false;
    end
end)