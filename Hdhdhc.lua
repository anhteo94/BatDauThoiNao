local gui = Instance.new("ScreenGui")
gui.Name = "TestNghia"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local label = Instance.new("TextLabel", frame)
label.Text = "PHẠM NGHĨA TEST"
label.Size = UDim2.new(1, 0, 1, 0)
label.TextScaled = true
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1
