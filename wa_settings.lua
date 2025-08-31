local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, addonName)
    if (string.lower(addonName) == string.lower("EzChatBar")) then
        _G.EzChatBar.config = EZ_ChatBar_Bubble.config or {
            bubbles = {
                {
                    cmd = "/SAY #text#",
                    perm = 1,
                    color = { 1, 1, 1 }
                },
                {
                    cmd = "/EMOTE #text#",
                    perm = 1,
                    color = { 255 / 255, 140 / 255, 69 / 255 }
                },
                {
                    cmd = "/YELL #text#",
                    perm = 1,
                    color = { 255 / 255, 69 / 255, 69 / 255 }
                },
                {
                    cmd = "/PARTY #text#",
                    perm = 2,
                    color = { 186 / 255, 186 / 255, 255 / 255 }
                },
                {
                    cmd = "/RAID #text#",
                    perm = 3,
                    color = { 255 / 255, 138 / 255, 0 / 255 }
                },
                {
                    cmd = "/RAID_WARNING #text#",
                    perm = 4,
                    color = { 255 / 255, 78 / 255, 0 / 255 }
                },
                {
                    cmd = "/GUILD #text#",
                    perm = 5,
                    color = { 69 / 255, 255 / 255, 69 / 255 }
                },
                {
                    cmd = "/OFFICER #text#",
                    perm = 6,
                    color = { 69 / 255, 150 / 255, 69 / 255 }
                },
                {
                    cmd = "/INSTANCE_CHAT #text#",
                    perm = 7,
                    color = { 255 / 255, 78 / 255, 9 / 255 }
                },
                {
                    cmd = "#text##key#",
                    perm = 1,
                    color = { 0 / 255, 175 / 255, 255 / 255 }
                },
                {
                    cmd = "/PARTY What's the key?",
                    perm = 2,
                    color = { 255 / 255, 190 / 255, 229 / 255 }
                },
            },
            shape = 1,
            Orientation = 1,
            size_btn = 14,
            interval_btn = 4
        };

        local perms_name = {
            "ALL",
            "PARTY",
            "RAID",
            "RAID_WARNING",
            "GUILD",
            "OFFICER",
            "INSTANCE_CHAT",
        }

        local shape_values = {
            [1] = "cube",
            [2] = "circle",
            [3] = "spiral",
            [4] = "wow",
        }

        local orientation_values = {
            [1] = "vertical",
            [2] = "horizontal",
        }

        function _G.EzChatBar:SetupOptions()
            local options = {
                name = "EzChatBar ",
                handler = _G.EzChatBar,
                type = "group",
                args = {
                    size_slider = {
                        name = _G.EzChatBar.lang.name_button_size,
                        desc = _G.EzChatBar.lang.name_button_desc,
                        type = "range",
                        min = 1,
                        max = 100,
                        step = 1,
                        get = function() return _G.EzChatBar.config.size_btn end,
                        set = function(_, value)
                            _G.EzChatBar.config.size_btn = value
                            _G.EzChatBar.update_btn(_G.EzChatBar)
                            EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                        end,
                        order = 1
                    },
                    interval_slider = {
                        name = _G.EzChatBar.lang.name_button_interval,
                        desc = _G.EzChatBar.lang.desc_button_interval,
                        type = "range",
                        min = 1,
                        max = 20,
                        step = 1,
                        get = function() return _G.EzChatBar.config.interval_btn end,
                        set = function(_, value)
                            _G.EzChatBar.config.interval_btn = value
                            _G.EzChatBar.update_btn(_G.EzChatBar)
                            EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                        end,
                        order = 2
                    },
                    shape_select = {
                        name = _G.EzChatBar.lang.name_button_shape,
                        desc = _G.EzChatBar.lang.desc_button_shape,
                        type = "select",
                        values = shape_values,
                        get = function() return _G.EzChatBar.config.shape end,
                        set = function(_, value)
                            _G.EzChatBar.config.shape = value
                            _G.EzChatBar.update_btn(_G.EzChatBar)
                            EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                        end,
                        order = 3
                    },
                    reset_position = {
                        name = _G.EzChatBar.lang.name_reset_pos,
                        desc = _G.EzChatBar.lang.desc_reset_pos,
                        type = "execute",
                        func = function()
                            print(_G.EzChatBar.lang.name_reset_pos)
                            _G.EzChatBar.region:ClearAllPoints();
                            _G.EzChatBar.region:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
                        end,
                        order = 0
                    },
                    orientation_select = {
                        name = _G.EzChatBar.lang.name_button_shape,
                        desc = _G.EzChatBar.lang.desc_button_shape,
                        type = "select",
                        values = orientation_values,
                        get = function() return _G.EzChatBar.config.Orientation end,
                        set = function(_, value)
                            _G.EzChatBar.config.Orientation = value
                            _G.EzChatBar.update_btn(_G.EzChatBar)
                            EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                        end,
                        order = 4
                    },
                    bubbles_group = {
                        name = _G.EzChatBar.lang.name_bubbles_group,
                        type = "group",
                        order = 5,
                        args = {
                            add_bubble = {
                                name = _G.EzChatBar.lang.name_add_bubble,
                                desc = _G.EzChatBar.lang.desc_add_bubble,
                                type = "execute",
                                func = function()
                                    table.insert(_G.EzChatBar.config.bubbles, {
                                        cmd = "/SAY #text#",
                                        perm = 1,
                                        color = { 1, 1, 1 }
                                    })
                                    LibStub("AceConfigRegistry-3.0"):NotifyChange("EzChatBar")
                                    _G.EzChatBar:SetupOptions()
                                    _G.EzChatBar.update_btn(_G.EzChatBar)
                                    EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                                end,
                                order = 0
                            }
                        }
                    }
                }
            }


            -- Динамически добавляем настройки для каждого пузырька
            for i, bubble in ipairs(_G.EzChatBar.config.bubbles) do
                options.args.bubbles_group.args["bubble_" .. i] = {
                    name = _G.EzChatBar.lang.name_bubbles_tag .. i,
                    type = "group",
                    order = i,
                    args = {
                        cmd = {
                            name = _G.EzChatBar.lang.name_cmd,
                            desc = _G.EzChatBar.lang.desc_cmd,
                            type = "input",
                            get = function() return _G.EzChatBar.config.bubbles[i].cmd end,
                            set = function(_, value)
                                _G.EzChatBar.config.bubbles[i].cmd = value
                                _G.EzChatBar.update_btn(_G.EzChatBar)
                                EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                                -- _G.EzChatBar:ApplySettings()
                                
                            end,
                            order = 1
                        },
                        perm = {
                            name = _G.EzChatBar.lang.name_perm,
                            desc = _G.EzChatBar.lang.desc_perm,
                            type = "select",
                            values = perms_name,
                            get = function() return _G.EzChatBar.config.bubbles[i].perm end,
                            set = function(_, value)
                                _G.EzChatBar.config.bubbles[i].perm = value
                                _G.EzChatBar.update_btn(_G.EzChatBar)
                                EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                                -- _G.EzChatBar:ApplySettings()
                            end,
                            order = 2
                        },
                        color = {
                            name = _G.EzChatBar.lang.name_color,
                            desc = _G.EzChatBar.lang.desc_color,
                            type = "color",
                            hasAlpha = false,
                            get = function()
                                local color = _G.EzChatBar.config.bubbles[i].color
                                return color[1], color[2], color[3]
                            end,
                            set = function(_, r, g, b)
                                _G.EzChatBar.config.bubbles[i].color = { r, g, b }
                                _G.EzChatBar.update_btn(_G.EzChatBar)
                                EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                                -- _G.EzChatBar:ApplySettings()
                            end,
                            order = 3
                        },
                        delete = {
                            name = _G.EzChatBar.lang.name_delete,
                            desc = _G.EzChatBar.lang.desc_delete,
                            type = "execute",
                            func = function()
                                table.remove(_G.EzChatBar.config.bubbles, i)
                                -- Обновляем настройки для удаления пузырька из интерфейса
                                _G.EzChatBar:SetupOptions()
                                _G.EzChatBar.update_btn(_G.EzChatBar)
                                EZ_ChatBar_Bubble.config = _G.EzChatBar.config
                                -- _G.EzChatBar:ApplySettings()
                            end,
                            order = 4
                        }
                    }
                }
            end

            -- Регистрируем опции в Ace3
            LibStub("AceConfig-3.0"):RegisterOptionsTable("EzChatBar", options)
        end

        -- Инициализация базы данных профиля
        function _G.EzChatBar:OnInitialize()
            -- Инициализируем базу данных с копией конфигурации
            self.db = LibStub("AceDB-3.0"):New("EzChatBarDB", {
                profile = {
                    size_btn = _G.EzChatBar.config.size_btn,
                    interval_btn = _G.EzChatBar.config.interval_btn,
                    bubbles = _G.EzChatBar.config.bubbles
                }
            })
            self:SetupOptions()
            LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EzChatBar", "EzChatBar")
        end

        _G.EzChatBar:OnInitialize()
        _G.EzChatBar.update_btn(_G.EzChatBar)
    end
end)
