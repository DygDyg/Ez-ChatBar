local s = 1



local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("CHAT_MSG_ADDON");

Event1:SetScript("OnEvent", function(...)
    local aa = {...}
    for i=1, #aa do
        if(aa[3] == "Dyg") then
            print(aa[i])
        end
    end

end)
