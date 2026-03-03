--========================================
--        RIDER SPAMMER HUB
--========================================

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- POSICIONES SEMI-TP (NO TOCADAS)
local pos1 = Vector3.new(-359, -7, 89)
local pos2 = Vector3.new(-370, -7, 36)

-- ESTADO
local menuOpen = true
local semiTPEnabled = false
local minuteDouble = true

--========================================
--                GUI
--========================================

local gui = Instance.new("ScreenGui")
gui.Name = "RiderSpammerGUI"
gui.Parent = game:GetService("CoreGui")
gui.ResetOnSpawn = false

-- Toggle button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 120, 0, 35)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -18)
toggleBtn.Text = "RIDER"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = gui

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 230)
frame.Position = UDim2.new(0.5, -160, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "Rider Spammer"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

-- Divider
local line = Instance.new("Frame")
line.Size = UDim2.new(1, -20, 0, 1)
line.Position = UDim2.new(0, 10, 0, 45)
line.BackgroundColor3 = Color3.fromRGB(40,40,40)
line.BorderSizePixel = 0
line.Parent = frame

-- Semi-TP Button
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, -40, 0, 45)
tpBtn.Position = UDim2.new(0, 20, 0, 70)
tpBtn.Text = "Semi-TP : OFF"
tpBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
tpBtn.Font = Enum.Font.Gotham
tpBtn.TextSize = 16
tpBtn.BorderSizePixel = 0
tpBtn.Parent = frame

-- Minute Double label
local minuteLabel = Instance.new("TextLabel")
minuteLabel.Size = UDim2.new(1, -40, 0, 40)
minuteLabel.Position = UDim2.new(0, 20, 0, 135)
minuteLabel.BackgroundTransparency = 1
minuteLabel.Text = "Minute Double : ON"
minuteLabel.Font = Enum.Font.Gotham
minuteLabel.TextSize = 14
minuteLabel.TextColor3 = Color3.fromRGB(200,200,200)
minuteLabel.Parent = frame

--========================================
--           INTERACCIONES
--========================================

toggleBtn.MouseButton1Click:Connect(function()
	menuOpen = not menuOpen
	frame.Visible = menuOpen
end)

tpBtn.MouseButton1Click:Connect(function()
	semiTPEnabled = not semiTPEnabled
	tpBtn.Text = semiTPEnabled and "Semi-TP : ON" or "Semi-TP : OFF"
end)

--========================================
--        SEMI-TP (SIN CAMBIOS)
--========================================

ProximityPromptService.PromptHoldEnded:Connect(function(prompt, plr)
	if not semiTPEnabled then return end
	if plr ~= player then return end

	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	local atual = root.Position
	local d1 = (atual - pos1).Magnitude
	local d2 = (atual - pos2).Magnitude

	if d1 < d2 then
		root.CFrame = CFrame.new(pos1)
	else
		root.CFrame = CFrame.new(pos2)
	end
end)

--========================================
--            MINUTE DOUBLE
--========================================

task.spawn(function()
	while minuteDouble do
		task.wait(60)
	end
end)
