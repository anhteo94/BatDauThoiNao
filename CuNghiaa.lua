-- Giao diện GUI giả lập Kavo UI - Phạm Nghĩa Mobile Hub

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PhanNghiaHub"
gui.ResetOnSpawn = false

local openBtn = Instance.new("ImageButton", gui)
openBtn.Image = "rbxassetid://77865014424955"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.5, -25)
openBtn.BackgroundTransparency = 1

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0.5, -250, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = false
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "PHẠM NGHĨA HUB - IPHONE GUI"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)

-- Tabs & Toggles
local tabNames = {
    "AutoFarmLevel", "AutoFarmBoss", "AutoChest", "AutoBounty",
    "ESP", "Aimbot", "AutoRaid", "AutoFruit", "Misc", "Settings"
}

local toggles = {}
local buttons = {}

local side = Instance.new("Frame", frame)
side.Size = UDim2.new(0, 130, 1, -30)
side.Position = UDim2.new(0, 0, 0, 30)
side.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -130, 1, -30)
content.Position = UDim2.new(0, 130, 0, 30)
content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Hiện / ẩn tab
local function showTab(tabName)
    for _, tab in pairs(content:GetChildren()) do
        if tab:IsA("Frame") then
            tab.Visible = (tab.Name == tabName)
        end
    end
end

-- Tạo tab & toggle
for i, name in ipairs(tabNames) do
    _G[name] = false

    local btn = Instance.new("TextButton", side)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 29)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)

    local tab = Instance.new("Frame", content)
    tab.Name = name
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = i == 1

    local toggle = Instance.new("TextButton", tab)
    toggle.Size = UDim2.new(0, 150, 0, 40)
    toggle.Position = UDim2.new(0, 20, 0, 20)
    toggle.Text = "Toggle: OFF"
    toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggle.TextColor3 = Color3.new(1, 1, 1)

    toggle.MouseButton1Click:Connect(function()
        _G[name] = not _G[name]
        toggle.Text = "Toggle: " .. (_G[name] and "ON" or "OFF")
        toggle.BackgroundColor3 = _G[name] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
    end)

    btn.MouseButton1Click:Connect(function()
        showTab(name)
    end)

    toggles[name] = toggle
    buttons[name] = btn
end

-- Mở / Ẩn menu
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)

-- Gắn chức năng
spawn(function()
    while true do
        wait(0.3)

        -- Auto Farm Level
        if _G.AutoFarmLevel then
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        char:PivotTo(v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
                        wait(0.1)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                        wait(0.1)
                        break
                    end
                end
            end)
        end

        -- Auto Chest
        if _G.AutoChest then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") and string.find(v.Name:lower(), "chest") and v.Transparency < 1 then
                    game.Players.LocalPlayer.Character:PivotTo(v.CFrame + Vector3.new(0, 3, 0))
                    wait(0.2)
                end
            end
        end

        -- ESP
        if _G.ESP then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character and not plr.Character:FindFirstChild("ESP") then
                    local esp = Instance.new("BillboardGui", plr.Character)
                    esp.Name = "ESP"
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")
                    esp.AlwaysOnTop = true
                    local text = Instance.new("TextLabel", esp)
                    text.Text = plr.Name
                    text.TextColor3 = Color3.new(1, 0, 0)
                    text.BackgroundTransparency = 1
                    text.Size = UDim2.new(1, 0, 1, 0)
                end
            end
        end

        -- Auto Fruit
        if _G.AutoFruit then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                    game.Players.LocalPlayer.Character:PivotTo(v.Handle.CFrame)
                    wait(0.2)
                end
            end
        end
    end
end)
