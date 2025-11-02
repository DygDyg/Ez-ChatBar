
local LCG = LibStub("LibCustomGlow-1.0")
EZ_ChatBar_Bubble = EZ_ChatBar_Bubble or{}
_G.EzChatBar = {};
_G.EzChatBar.addon = true;
_G.EzChatBar.region = CreateFrame("Frame", "EZ_BUBBLE", UIParent, BackdropTemplateMixin and "BackdropTemplate")
_G.EzChatBar.region:SetSize(19, 19)
_G.EzChatBar.region:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
_G.EzChatBar.region:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",     -- Одноцветная текстура
    edgeFile = nil,
    tile = false,
    tileSize = 0,
    edgeSize = 0,
    insets = { left = 0, right = 0, top = 0, bottom = 0 }
})
_G.EzChatBar.region:SetBackdropColor(0, 0, 0, 0.3)
WindowMoving(_G.EzChatBar.region)

_G.EzChatBar.region:SetScript("OnEnter", function(self)
    _G.EzChatBar.region:SetBackdropColor(0, 0, 0, 0.5)
    LCG.ButtonGlow_Start(self)
end)

_G.EzChatBar.region:SetScript("OnLeave", function(self)
    _G.EzChatBar.region:SetBackdropColor(0, 0, 0, 0.3)
    LCG.ButtonGlow_Stop(self)
end)


--- Открытие настрокек по ПКМ
_G.EzChatBar.region:SetScript("OnMouseDown", function(self, button)
    if button == "RightButton" then
        -- Проверяем, зарегистрированы ли опции
        if LibStub and LibStub("AceConfigDialog-3.0") then
            LibStub("AceConfigDialog-3.0"):Open("EzChatBar")
        else
            print("⚙️ Настройки EzChatBar не найдены или не инициализированы.")
        end
    end
end)
-- Функция инициализации
function _G.EzChatBar:OnInitialize()
    -- Загружаем базу данных
    self.db = LibStub("AceDB-3.0"):New("EzChatBarDB", self.defaults, true)
    
    -- Регистрируем опции
    self:SetupOptions()
end


-- Регистрируем события
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "EzChatBar" then
        --_G.EzChatBar:ApplySettings() -- Оставляем только ApplySettings, если он нужен
    end
end)

-- Узнать билд игры
local _, ver = GetBuildInfo()
EZ_ChatBar_Bubble.wow_ver = {GetBuildInfo()}
