-- GHI CHÚ: Thay placeholder URL loadstring nếu cần
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits Enhanced", "Serpent") -- chọn theme

-- Mỗi tab + các toggle
local tabs = {
    {name = "Auto Farm Level",     func = function(bool) _G.AutoFarmLevel = bool; end},
    {name = "Auto Farm Boss",      func = function(bool) _G.AutoFarmBoss = bool; end},
    {name = "Auto Chest",          func = function(bool) _G.AutoChest = bool; end},
    {name = "Auto Bounty",         func = function(bool) _G.AutoBounty = bool; end},
    {name = "ESP",                 func = function(bool) _G.ESP = bool; end},
    {name = "Aimbot",             func = function(bool) _G.Aimbot = bool; end},
    {name = "Auto Raid",          func = function(bool) _G.AutoRaid = bool; end},
    {name = "Auto Fruit",         func = function(bool) _G.AutoFruit = bool; end},
    {name = "Misc",               func = function(bool) _G.Misc = bool; end},
    {name = "Settings",           func = function(bool) _G.Settings = bool; end},
}

for _, tabData in ipairs(tabs) do
    local Tab = Window:NewTab(tabData.name)
    local Section = Tab:NewSection(tabData.name .. " Section")
    Section:NewToggle("Enable " .. tabData.name, "Toggle " .. tabData.name, function(state)
        tabData.func(state)
        if state then
            print(tabData.name .. " bật")
            -- Chèn code chức năng ON tại đây
        else
            print(tabData.name .. " tắt")
            -- Chèn code STOP chức năng OFF ở đây
        end
    end)
end

-- Kéo thả GUI đã có sẵn trong Kavo UI

-- Ví dụ: auto-farm đơn giản
spawn(function()
    while true do
        wait(0.5)
        if _G.AutoFarmLevel then
            -- CODE auto farm level
        end
        if _G.AutoFarmBoss then
            -- CODE auto farm boss
        end
        -- và các chức năng khác...
    end
end)
