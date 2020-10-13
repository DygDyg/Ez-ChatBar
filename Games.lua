local s = 1



local Event1 = CreateFrame("Frame");
Event1:RegisterEvent("CHAT_MSG_ADDON");

Event1:SetScript("OnEvent", function(...)
    --local aa = {...}
    --Log("===================================")
    --for i=1, #aa do
    --    Log(aa[i])
    --    if(aa[3] == "Dyg") then
    --        Log(aa[i])
    --    end
    --end
end)

local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 20);

	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end

	self:SetVerticalScroll(newValue);
end

local function sss()
        test111 = CreateFrame("FRAME", "TEST111", UIParent, BackdropTemplateMixin and "BackdropTemplate");
        test111:Hide();
        test111:SetWidth(150);
        test111:SetHeight(150);
        --test111:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\34480",});
        test111:SetPoint("CENTER");

        test111.ScrollFrame = CreateFrame("ScrollFrame", nil, test111, "UIPanelScrollFrameTemplate");
        test111.ScrollFrame:SetPoint("TOPLEFT", test111, "TOPLEFT", 0, 0);
        test111.ScrollFrame:SetPoint("BOTTOMRIGHT", test111, "BOTTOMRIGHT", 0, 0);
        test111.ScrollFrame:SetClipsChildren(true);
        test111.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);

        test111.ScrollFrame.frame = CreateFrame("FRAME", "TEST111", test111.ScrollFrame, BackdropTemplateMixin and "BackdropTemplate");
        test111.ScrollFrame.frame:SetWidth(150);
        test111.ScrollFrame.frame:SetHeight(350);
        test111.ScrollFrame.frame:SetBackdrop({bgFile = "Interface\\AddOns\\DygDyg_Addons\\image\\34480",});
        test111.ScrollFrame.frame:SetPoint("CENTER");
        test111.ScrollFrame:SetScrollChild(test111.ScrollFrame.frame);

        test111.ScrollFrame.frame.b = CreateFrame("Button", nil, test111.ScrollFrame.frame, "GameMenuButtonTemplate");
        test111.ScrollFrame.frame.b:SetWidth(115);
        test111.ScrollFrame.frame.b:SetHeight(17);
        --test111.ScrollFrame.frame.b.Text:SetParent(test111.ScrollFrame.frame);
        test111.ScrollFrame.frame.b:SetPoint("CENTER", 0, -100);

end
sss()
