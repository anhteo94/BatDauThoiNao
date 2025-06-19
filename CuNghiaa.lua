-- GUI cho iPhone - Phạm Nghĩa
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BloxFruitMobileUI"
ScreenGui.ResetOnSpawn = false

-- Nút mở menu
local OpenButton = Instance.new("ImageButton", ScreenGui)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Position = UDim2.new(0, 10, 0.5, -25)
OpenButton.Image = "rbxassetid://77865014424955"
OpenButton.BackgroundTransparency = 1

-- Frame chính
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 360)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Nút đóng menu
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)

-- Danh sách tab
local tabs = {
    "AutoFarmLevel",
    "AutoFarmBoss",
    "AutoChest",
    "AutoBounty",
    "ESP",
    "Aimbot",
    "AutoRaid",
    "AutoFruit",
    "Misc",
    "Settings"
}

for i, name in ipairs(tabs) do
    _G[name] = false

    local tabFrame = Instance.new("Frame", MainFrame)
    tabFrame.Size = UDim2.new(1, -20, 0, 30)
    tabFrame.Position = UDim2.new(0, 10, 0, (i - 1) * 32 + 40)
    tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local label = Instance.new("TextLabel", tabFrame)
    label.Text = name
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton", tabFrame)
    toggle.Text = "OFF"
    toggle.Size = UDim2.new(0.4, -10, 0.8, 0)
    toggle.Position = UDim2.new(0.6, 5, 0.1, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggle.TextColor3 = Color3.new(1, 1, 1)

    toggle.MouseButton1Click:Connect(function()
        _G[name] = not _G[name]
        toggle.Text = _G[name] and "ON" or "OFF"
        toggle.BackgroundColor3 = _G[name] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
    end)
end

-- Mở / Đóng menu
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

-- Tự động chạy chức năng
spawn(function()
    while true do
        wait(0.3)

        if _G.AutoFarmLevel then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character or plr.CharacterAdded:Wait()
                local target = nil

                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        target = v
                        break
                    end
                end

                if target then
                    char:PivotTo(target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                end
            end)
        end

        if _G.AutoFarmBoss then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                local bosses = {"The Gorilla King", "Magma Admiral", "Ice Admiral", "Don Swan"}

                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if table.find(bosses, v.Name) and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        char:PivotTo(v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                        break
                    end
                end
            end)
        end

        if _G.AutoChest then
            pcall(function()
                for _, chest in pairs(workspace:GetDescendants()) do
                    if chest:IsA("Part") and string.find(chest.Name:lower(), "chest") and chest.Transparency < 1 then
                        game.Players.LocalPlayer.Character:PivotTo(chest.CFrame + Vector3.new(0, 3, 0))
                        wait(0.2)
                    end
                end
            end)
        end

        if _G.ESP then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character and not plr.Character:FindFirstChild("ESP") then
                    local esp = Instance.new("BillboardGui", plr.Character)
                    esp.Name = "ESP"
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.AlwaysOnTop = true
                    esp.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")

                    local txt = Instance.new("TextLabel", esp)
                    txt.Text = plr.Name
                    txt.TextColor3 = Color3.new(1, 0, 0)
                    txt.BackgroundTransparency = 1
                    txt.Size = UDim2.new(1, 0, 1, 0)
                end
            end
        end

        if _G.AutoFruit then
            pcall(function()
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Tool") and string.find(obj.Name:lower(), "fruit") then
                        game.Players.LocalPlayer.Character:PivotTo(obj.Handle.CFrame)
                        wait(0.3)
                    end
                end
            end)
        end
    end
end)
