WindowMovingDetecting = true;

local window = {
    -- EZ_BUBBLE
}


function WindowMoving(Mov, pickup)
    if(Mov~=nil)then
        local SaveName = Mov:GetName();

        WindowPosition = WindowPosition or {};
        local Uid = UnitGUID("player");
        WindowPosition[Uid] = WindowPosition[Uid] or {}
        -- local name, realm = UnitFullName("player")
        -- print(name)
        -- print(realm)
        -- WindowPosition[Uid]["username"] = WindowPosition[Uid]["username"] or name.."-"..realm

        if(SaveName ~= nil)then
            
            if(WindowPosition[Uid][SaveName]~=nil)then
                if(WindowPosition[Uid][SaveName][1] ~=nil)then
                    Mov:ClearAllPoints();
                    Mov:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", WindowPosition[Uid][SaveName][1]/UIParent:GetScale(), WindowPosition[Uid][SaveName][2]/UIParent:GetScale());
                end
            end
        end

WindowPosition = WindowPosition or {};
    if(Mov) then
        Mov:SetMovable(true)
        Mov:SetUserPlaced(true)
        --Mov:StartMoving()
        --Mov:StopMovingOrSizing()
        
        Mov:SetScript("OnMouseDown", function(self, button)
            if (button == "LeftButton" ) then
                if(UnitAffectingCombat("player") ~= true or DygSettings["FixBarCombat"] ~= true) then
                    if(pickup ~= true or DygSettings["FixBar"] ~= true) then
                        --print(Mov:GetName())
                        Mov:StartMoving()
                    end
                end
            end
        end)

        Mov:SetScript("OnMouseUp", function(self, button)
            WindowPosition[Uid] = WindowPosition[Uid] or {}
            if (button == "LeftButton") then
                Mov:StopMovingOrSizing();
                if(SaveName~=nil)then
                    WindowPosition[Uid][SaveName] = {self:GetScaledRect()}
                end
            end
        end)
        Mov.ShowScript1 = Mov:GetScript("OnShow");

        Mov.ShowScript2 = function(self)
            if(SaveName ~= nil)then
                if(WindowPosition[Uid][SaveName]~=nil)then
                    if(WindowPosition[Uid][SaveName][1] ~=nil)then
                        self:ClearAllPoints();
                        self:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", WindowPosition[Uid][SaveName][1]/UIParent:GetScale(), WindowPosition[Uid][SaveName][2]/UIParent:GetScale());
                    end
                end
            end
        end

        --Mov:SetScript("OnShow", function(self)
        --    --Mov.ShowScript1();
        --    if(Mov.ShowScript1)then
        --        Mov.ShowScript1(self);
        --    end

        --    if(Mov.ShowScript2)then
        --        Mov.ShowScript2(self);
        --    end
        --end
        --)

    --Mov.Scripts = function(self) print("2") end
    end
end
end

for i = 1, #window do
    WindowMoving(window[i])
end

local frame1 = CreateFrame("Frame")
frame1:RegisterEvent("AUCTION_HOUSE_SHOW")
frame1:SetScript("OnEvent", function(...)
end)
    WindowMoving(ExtraAbilityContainer, true);

