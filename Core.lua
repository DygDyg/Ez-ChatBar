local ADDON_NAME, ns = ...

ns.ADDON_NAME = ADDON_NAME

local LCG = LibStub and LibStub("LibCustomGlow-1.0", true)
if not LCG then
    LCG = {
        ButtonGlow_Start = function() end,
        ButtonGlow_Stop = function() end,
    }
end
ns.LCG = LCG

local DEFAULT_BUBBLES = {
    { cmd = "/SAY #text#",           perm = 1, color = { 1, 1, 1 } },
    { cmd = "/EMOTE #text#",         perm = 1, color = { 1, 0.55, 0.27 } },
    { cmd = "/YELL #text#",          perm = 1, color = { 1, 0.27, 0.27 } },
    { cmd = "/PARTY #text#",         perm = 2, color = { 0.73, 0.73, 1 } },
    { cmd = "/RAID #text#",          perm = 3, color = { 1, 0.54, 0 } },
    { cmd = "/RAID_WARNING #text#",  perm = 4, color = { 1, 0.31, 0 } },
    { cmd = "/GUILD #text#",         perm = 5, color = { 0.27, 1, 0.27 } },
    { cmd = "/OFFICER #text#",       perm = 6, color = { 0.27, 0.59, 0.27 } },
    { cmd = "/INSTANCE_CHAT #text#", perm = 7, color = { 1, 0.31, 0.04 } },
}

ns.DEFAULTS = {
    bubbles = DEFAULT_BUBBLES,
    shape = 1,
    Orientation = 1, -- 1 vertical, 2 horizontal
    size_btn = 14,
    interval_btn = 4,
    button_label = false,
}

local function DeepCopy(value)
    if type(value) ~= "table" then
        return value
    end
    local copy = {}
    for k, v in pairs(value) do
        copy[k] = DeepCopy(v)
    end
    return copy
end
ns.DeepCopy = DeepCopy

function ns:EnsureConfig()
    EZ_ChatBar_Bubble = EZ_ChatBar_Bubble or {}
    local cfg = EZ_ChatBar_Bubble.config
    if type(cfg) ~= "table" then
        cfg = DeepCopy(ns.DEFAULTS)
        EZ_ChatBar_Bubble.config = cfg
    end

    for key, value in pairs(ns.DEFAULTS) do
        if cfg[key] == nil then
            cfg[key] = DeepCopy(value)
        end
    end

    -- Only square (1) and circle (2) are supported.
    if cfg.shape ~= 1 and cfg.shape ~= 2 then
        cfg.shape = 1
    end

    if type(cfg.bubbles) ~= "table" or #cfg.bubbles == 0 then
        cfg.bubbles = DeepCopy(ns.DEFAULTS.bubbles)
    end

    self.config = cfg
    EZ_ChatBar_Bubble.config = cfg
    return cfg
end

function ns:CreateAnchor()
    if self.anchor then
        return self.anchor
    end

    local frame = CreateFrame("Frame", "EZ_BUBBLE", UIParent, "BackdropTemplate")
    frame:SetSize(19, 19)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = nil,
        tile = false,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    frame:SetBackdropColor(0, 0, 0, 0.35)
    frame:EnableMouse(true)
    frame:SetFrameStrata("MEDIUM")

    frame:HookScript("OnEnter", function(selfFrame)
        selfFrame:SetBackdropColor(0, 0, 0, 0.55)
        ns.LCG.ButtonGlow_Start(selfFrame)
    end)

    frame:HookScript("OnLeave", function(selfFrame)
        selfFrame:SetBackdropColor(0, 0, 0, 0.35)
        ns.LCG.ButtonGlow_Stop(selfFrame)
    end)

    frame:HookScript("OnMouseDown", function(_, button)
        if button == "RightButton" and ns.ToggleConfig then
            ns:ToggleConfig()
        end
    end)

    self.anchor = frame
    return frame
end

function ns:Refresh()
    if self.UpdateBubbles then
        self:UpdateBubbles()
    end
end

local pendingRefresh = false

local function RequestRefresh()
    if InCombatLockdown() then
        pendingRefresh = true
        return
    end
    pendingRefresh = false
    if ns.config then
        ns:Refresh()
    end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:RegisterEvent("PLAYER_LOGIN")
loader:RegisterEvent("GROUP_ROSTER_UPDATE")
loader:RegisterEvent("PLAYER_GUILD_UPDATE")
loader:RegisterEvent("PLAYER_ENTERING_WORLD")
loader:RegisterEvent("PLAYER_REGEN_ENABLED")
loader:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= ADDON_NAME then
            return
        end
        ns:EnsureConfig()
        local anchor = ns:CreateAnchor()
        if ns.EnableMoving then
            ns:EnableMoving(anchor, false)
        end
        return
    end

    if event == "PLAYER_LOGIN" then
        ns:EnsureConfig()
        ns:CreateAnchor()
        RequestRefresh()
        if ns.RegisterBlizzardOptions then
            ns:RegisterBlizzardOptions()
        end
        return
    end

    if event == "PLAYER_REGEN_ENABLED" then
        if pendingRefresh then
            RequestRefresh()
        end
        return
    end

    if ns.config then
        RequestRefresh()
    end
end)

SLASH_EZCHATBAR1 = "/ezcb"
SLASH_EZCHATBAR2 = "/ezchatbar"
SlashCmdList.EZCHATBAR = function(msg)
    msg = strtrim(msg or ""):lower()
    if msg == "options" or msg == "config" or msg == "settings" then
        if ns.OpenBlizzardOptions then
            ns:OpenBlizzardOptions()
        elseif ns.ToggleConfig then
            ns:ToggleConfig()
        end
        return
    end
    if ns.ToggleConfig then
        ns:ToggleConfig()
    end
end

_G.EzChatBar = ns
