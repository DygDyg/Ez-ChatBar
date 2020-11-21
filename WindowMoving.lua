WindowMovingDetecting = true;


local window = {
    WorldMapFrame,
    AzeriteEmpoweredItemUI,
    PVEFrame,
    CharacterFrame,
    SpellBookFrame,
    PlayerTalentFrame,
    AchievementFrame,
    WorldMapFrame,
    CommunitiesFrame,
    CollectionsJournal,
    EncounterJournal,
    GameMenuFrame,
    FriendsFrame,
    VideoOptionsFrame,
    InterfaceOptionsFrame,
    AddonList,
    MacroFrame,
    --StaticPopup1,
    KeyBindingFrame,
}


function WindowMoving(Mov, pickup, SaveName)
WindowPosition = WindowPosition or {};
local Uid = UnitGUID("player");
WindowPosition[Uid] = WindowPosition[Uid] or {}

if(SaveName ~= nil)then
    if(WindowPosition[Uid][SaveName]~=nil)then
        if(WindowPosition[Uid][SaveName][1] ~=nil)then
            Mov:ClearAllPoints();
            Mov:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", WindowPosition[Uid][SaveName][1], WindowPosition[Uid][SaveName][2]);
            --Mov:SetSize(WindowPosition[Uid][SaveName][3], WindowPosition[Uid][SaveName][4])
        end
    end
end

WindowPosition = WindowPosition or {};
    if(Mov) then
        Mov:SetMovable(true)
        Mov:SetUserPlaced(true)
        Mov:StartMoving()
        Mov:StopMovingOrSizing()
        Mov:SetScript("OnMouseDown", function(self, button)
            if (button == "LeftButton" ) then
                if(pickup ~= true or DygSettings["FixBar"] == false) then
                    Mov:StartMoving()
                end
            end
        end)

        Mov:SetScript("OnMouseUp", function(self, button)
            if (button == "LeftButton") then
                Mov:StopMovingOrSizing();
                if(SaveName~=nil)then
                    WindowPosition[Uid][SaveName] = {self:GetRect()}
                end
            end
        end)
    end
end

for i = 1, #window do
    WindowMoving(window[i])
end

local frame1 = CreateFrame("Frame")
frame1:RegisterEvent("AUCTION_HOUSE_SHOW")
frame1:SetScript("OnEvent", function(...)
WindowMoving(AuctionHouseFrame)
end)
