local _, ns = ...

WindowPosition = WindowPosition or {}

local function GetPlayerUID()
    return UnitGUID("player") or "UNKNOWN"
end

function ns:EnableMoving(frame, pickupOnly)
    if not frame or not frame.GetName then
        return
    end

    local saveName = frame:GetName()
    if not saveName then
        return
    end

    local uid = GetPlayerUID()
    WindowPosition[uid] = WindowPosition[uid] or {}

    local pos = WindowPosition[uid][saveName]
    if pos and pos.point and pos.x and pos.y then
        local scale = UIParent:GetEffectiveScale()
        frame:ClearAllPoints()
        frame:SetPoint(
            pos.point,
            UIParent,
            pos.relativePoint or pos.point,
            pos.x / scale,
            pos.y / scale
        )
    end

    frame:SetMovable(true)
    frame:SetUserPlaced(false)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)

    frame:SetScript("OnDragStart", function(self)
        if pickupOnly then
            return
        end
        if InCombatLockdown and InCombatLockdown() then
            return
        end
        self:StartMoving()
    end)

    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relativePoint, x, y = self:GetPoint()
        local scale = UIParent:GetEffectiveScale()
        WindowPosition[uid][saveName] = {
            point = point,
            relativePoint = relativePoint,
            x = x * scale,
            y = y * scale,
        }
    end)
end

function ns:ResetAnchorPosition()
    local uid = GetPlayerUID()
    if WindowPosition[uid] then
        WindowPosition[uid].EZ_BUBBLE = nil
    end
    if self.anchor then
        self.anchor:ClearAllPoints()
        self.anchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    end
end
