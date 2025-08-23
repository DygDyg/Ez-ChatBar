
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
_G.EzChatBar.region:SetBackdropColor(0, 0, 0, 0)
WindowMoving(_G.EzChatBar.region)

_G.EzChatBar.region:SetScript("OnEnter", function(self)
    _G.EzChatBar.region:SetBackdropColor(0, 0, 0, 0.3)
end)

_G.EzChatBar.region:SetScript("OnLeave", function(self)
    _G.EzChatBar.region:SetBackdropColor(0, 0, 0, 0)
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
        _G.EzChatBar:OnInitialize()
        _G.EzChatBar:ApplySettings()
    end
end)

-- Узнать билд игры
local _, ver = GetBuildInfo()
EZ_ChatBar_Bubble.wow_ver = {GetBuildInfo()}
