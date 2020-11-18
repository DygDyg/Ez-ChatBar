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

function WindowMoving(Mov, pickup)

    if(Mov) then
        Mov:SetMovable(true)
        Mov:SetScript("OnMouseDown", function(self, button)
            if (button == "LeftButton" ) then
                if(pickup ~= true or DygSettings["FixBar"] == false) then
                    Mov:StartMoving()
                    Mov:SetUserPlaced(true)
                end
            end
        end)

        Mov:SetScript("OnMouseUp", function(self, button)
            if (button == "LeftButton") then
                if(pickup ~= true or DygSettings["FixBar"] == false) then
                Mov:StopMovingOrSizing();
                end
            end
        end)
    else
        print(Mov)
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
