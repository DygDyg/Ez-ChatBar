--DygDyg_frames = CreateFrame("Frame")
--DygDyg_frames:RegisterEvent("CHAT_MSG_SAY")
--DygDyg_frames:SetScript("OnEvent", function(...)
--
--    local args = {...};

    --for i = 1, #args do
    --    print(args[i]);
    --end

--
--    local p = 3;
--    if(args[p] == "test") then
--        print(args[p]);
--
--        Button_captor = CreateFrame("Frame", "test_button", nil, "BasicFrameTemplateWithInset");
--        Button_captor:SetSize(300, 360);
--        Button_captor:SetPoint("CENTER", UIParent, "CENTER");
--        Button_captor:SetScript("OnHide", function()
--            print("OnHide");
--        end)
--    end
--end)
--local Positions = CreateFrame("Frame")
--Positions:RegisterEvent("VARIABLES_LOADED")
--Positions:SetScript("OnEvent", function(...)
--    if(Position == nil) then
--        Position = 1
--        print("Старт позиции: "..Position)
--    else
--        Position = Position + 1
--        print("Позиция равна: "..Position)
--    end
--end)
--

--if(WorldMapFrame) then
--    WorldMapFrame:SetMovable(true)
--
--    WorldMapFrame:SetScript("OnMouseDown", function(self, button)
--    if button == "LeftButton" then
--                WorldMapFrame:StartMoving()
--            end
--    end)
--
--    WorldMapFrame:SetScript("OnMouseUp", function(self, button)
--    if button == "LeftButton" then
--                WorldMapFrame:StopMovingOrSizing()
--            end
--    end)
--end





--SoundtrackControlFrame:SetScript("OnMouseUp", function(self, button)
--if button == "LeftButton" then
--            SoundtrackControlFrame:StartMoving()
--        end
--end)
--
--SoundtrackControlFrame:SetScript("OnMouseUp", function(self, button)
--if button == "LeftButton" then
--            SoundtrackControlFrame:StopMovingOrSizing()
--        end
--end)

--DygDyg_frames1 = CreateFrame("Frame")
--DygDyg_frames1:RegisterEvent("CHAT_MSG_SYSTEM")
--DygDyg_frames1:SetScript("OnEvent", function(...)
--
--    local args = {...};
--    --local args1 = args[1];
--    print("________________")
--    for i = 1, #args do
--        print(args[i]);
--    end
--    print("________________")
--end)


local NUM_BUTTONS = 8
local BUTTON_HEIGHT = 20

local list = {"a","b","f"} -- put contents of the scroll frame here, for example item names
local buttons = {"a","b","f"}

local function update(self)
    local numItems = #list
    FauxScrollFrame_Update(self, numItems, NUM_BUTTONS, BUTTON_HEIGHT)
    local offset = FauxScrollFrame_GetOffset(self)
    for line = 1, NUM_BUTTONS do
        local lineplusoffset = line + offset
        local button = buttons[line]
        if lineplusoffset > numItems then
            button:Hide()
        else
            button:SetText(list[lineplusoffset])
            button:Show()
        end
    end
end

local scrollFrame = CreateFrame("ScrollFrame", "MyFirstNotReallyScrollFrame", nil, "FauxScrollFrameTemplate")
scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, update)
end)

for i = 1, NUM_BUTTONS do
    local button = CreateFrame("Button", nil, scrollFrame:GetParent())
    if i == 1 then
        button:SetPoint("TOP", scrollFrame)
    else
        button:SetPoint("TOP", buttons[i - 1], "BOTTOM")
    end
    button:SetSize(96, BUTTON_HEIGHT)
    buttons[i] = button
end


