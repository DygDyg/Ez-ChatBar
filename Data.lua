function BaseFrameAddons()
    local BaseFrame = EZChatBar
    local BaseFrameName = "EZChatBar"
    if BaseFrame == nil then
        BaseFrame = CreateFrame("FRAME", BaseFrameName, UIParent);
        BaseFrame:SetPoint("CENTER", UIParent);
        BaseFrame:SetWidth(1);
        BaseFrame:SetHeight(1);
    end
    return BaseFrame, BaseFrameName;
end

local A = 0;
local color = {};

local function ScrollFrame_OnMouseWheel(self, delta)
    local newValue = self:GetVerticalScroll() - delta*10;

    if (newValue < 0) then
        newValue = 0;

    elseif (newValue > self:GetVerticalScrollRange()) then
        newValue = self:GetVerticalScrollRange();
    end

    self:SetVerticalScroll(newValue);
end

Dyg_CopyChatFrame = Dyg_CopyChatFrame or CreateFrame("FRAME", "Dyg_CopyChatFrame", UIParent, "BasicFrameTemplateWithInset");

WindowMoving(Dyg_CopyChatFrame, nil, "CopyChatFrame");

Dyg_CopyChatFrame:Hide();

Dyg_CopyChatFrame:SetWidth(ChatFrame1.FontStringContainer:GetWidth());
Dyg_CopyChatFrame:SetHeight(500);
Dyg_CopyChatFrame:SetPoint("CENTER", UIParent);
Dyg_CopyChatFrame.TitleText:SetText(EZCHATBAR_GENERALTAB_BUTTON_COPY);

Dyg_CopyChatFrame.ScrollFrame = Dyg_CopyChatFrame.ScrollFrame or CreateFrame("ScrollFrame", nil, Dyg_CopyChatFrame, "UIPanelScrollFrameTemplate");

Dyg_CopyChatFrame.ScrollFrame:SetPoint("CENTER", Dyg_CopyChatFrame, -5, -11);
Dyg_CopyChatFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", Dyg_CopyChatFrame, "BOTTOMRIGHT", -26, 10);
Dyg_CopyChatFrame.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
Dyg_CopyChatFrame.ScrollFrame.ScrollBar:ClearAllPoints();
Dyg_CopyChatFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", Dyg_CopyChatFrame.ScrollFrame, "TOPRIGHT", 30, -10);
Dyg_CopyChatFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", Dyg_CopyChatFrame.ScrollFrame, "BOTTOMRIGHT", -7, 18);

Dyg_CopyChatFrame.TextEditor = Dyg_CopyChatFrame.TextEditor or CreateFrame("EditBox", nil, Dyg_CopyChatFrame.ScrollFrame);
Dyg_CopyChatFrame.TextEditor:SetWidth(Dyg_CopyChatFrame.ScrollFrame:GetWidth());
Dyg_CopyChatFrame.TextEditor:SetMultiLine(true);
Dyg_CopyChatFrame.TextEditor:SetFontObject(GameFontNormal);
Dyg_CopyChatFrame.TextEditor:SetPoint("TOP",Dyg_CopyChatFrame,0,-30);
Dyg_CopyChatFrame.ScrollFrame:SetScrollChild(Dyg_CopyChatFrame.TextEditor);
Dyg_CopyChatFrame.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);

function OpenCopyChatFrame(button)


    Dyg_CopyChatFrame:Show();
    local editBox, chatFrame, messageTypeList, channelList = CBCPanelUpdate();
    local text = nil;
print(button)
    if(IsControlKeyDown() == false and (button == "LeftButton" or button=="MiddleButton"))then
        text = chatFrame["visibleLines"];
        Dyg_CopyChatFrame.TextEditor:SetText("");

        A = #text;
        while A > 0 do
            if(text[A]["messageInfo"]~=nil)then
                if(text[A]["messageInfo"]["r"]~=nil)then
                    color = {
                        math.ceil(text[A]["messageInfo"]["r"]*255),
                        math.ceil(text[A]["messageInfo"]["g"]*255),
                        math.ceil(text[A]["messageInfo"]["b"]*255),
                    }
                    Dyg_CopyChatFrame.TextEditor:Insert("|cff"..format("%02X%02X%02X",color[1],color[2],color[3]).." ")
                end
                Dyg_CopyChatFrame.TextEditor:Insert(text[A]["messageInfo"]["message"].."|r\n")
            end
            A = A - 1;
        end
    end



    if(IsControlKeyDown() == true or button == "RightButton")then
        text = chatFrame["historyBuffer"]["elements"];
        Dyg_CopyChatFrame.TextEditor:SetText("");
        A = 1;

        while A < #text+1 do
            if(text[A]["message"]~=nil)then
                if(text[A]["r"]~=nil)then
                    color = {
                        math.ceil(text[A]["r"]*255),
                        math.ceil(text[A]["g"]*255),
                        math.ceil(text[A]["b"]*255),
                    }
                    Dyg_CopyChatFrame.TextEditor:Insert("|cff"..format("%02X%02X%02X",color[1],color[2],color[3]).." ")
                end
                Dyg_CopyChatFrame.TextEditor:Insert(text[A]["message"].."|r\n")
            end
            A = A + 1;
        end
        C_Timer.After(0.5, function() Dyg_CopyChatFrame.ScrollFrame:SetVerticalScroll(Dyg_CopyChatFrame.ScrollFrame:GetVerticalScrollRange()) end);
    end
end


function Dyg_Button_Panel(name, title, tex, parent, point)
    local r = 189/255
    local g = 116/255
    local b = 8/255
    local a = 200/255
    local Dyg_Button = CreateFrame("Button", name, parent, BackdropTemplateMixin and "BackdropTemplate");
    local ColorSa = 40;

    Dyg_Button:SetWidth(15);
    Dyg_Button:SetHeight(15);
    Dyg_Button:SetPoint(point[1], point[2], point[3], point[4], point[5], point[6]);
    Dyg_Button:SetBackdrop({bgFile = "Interface\\AddOns\\EzChatBar\\image\\"..tex, insets = { left = 1, right = 1, top = 1, bottom = 1}});
    Dyg_Button:SetBackdropColor(r, g, b, a);

    Dyg_Button:SetScript("PreClick", function(self, button)

    end)

    Dyg_Button:SetScript("OnEnter", function(self)
        Dyg_Button:SetBackdropColor(r+(ColorSa/255), g+(ColorSa/255), b+(ColorSa/255), a);
        DygMesTab.TextPanel:Show();
        DygMesTab.TextPanel.Text:SetText(title);
    end)

    Dyg_Button:SetScript("OnLeave", function(self)
        Dyg_Button:SetBackdropColor(r, g, b, a);
        DygMesTab.TextPanel:Hide();
    end)

    return Dyg_Button
end

function DygScaleAnim(self, time)
    self.fps = self.fps or 60;
    self.OldScale  = self.OldScale or self:GetScale();
    self.del = self.del or self.OldScale / ((time * 1000)/self.fps);
    local time = time or 1;
    if(self.enables==nil)then
        self.enables = true;
    end

    if(self.enables ~= false) then
        if(self:GetScale()-self.del > 0) then
            self:SetScale(self:GetScale()-self.del);
            C_Timer.After(self.del, function() DygScaleAnim(self, time) end);
        else
            self:Hide();
            self.enables = false;
        end
    elseif(self.enables == false) then
        self:Show();
        if(self:GetScale() < self.OldScale) then
            self:SetScale(self:GetScale()+self.del);
            C_Timer.After(self.del, function() DygScaleAnim(self, time) end);
        else
            self.enables = true;
        end
    end
end