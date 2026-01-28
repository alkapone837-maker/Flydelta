-- Fly + Noclip Menu | MOBILE FIXED | Delta
-- By Alkapone 🐐🔥

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local flying = false
local noclip = false
local speed = 60
local up = false
local down = false
local bv, bg

local function getChar()
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FlyMenu"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 320)
frame.Position = UDim2.new(0.05, 0, 0.25, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 18)

local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(60,0,120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,170,255))
}

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "🪽 FLY MENU"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

local function btn(text,y,color)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(0.85,0,0,40)
	b.Position = UDim2.new(0.075,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = color
	local c = Instance.new("UICorner", b)
	c.CornerRadius = UDim.new(0,12)
	return b
end

local flyBtn = btn("FLY : OFF", 55, Color3.fromRGB(0,200,255))
local noclipBtn = btn("NOCLIP : OFF", 100, Color3.fromRGB(255,80,80))
local upBtn = btn("▲ SUBIR", 145, Color3.fromRGB(120,255,120))
local downBtn = btn("▼ BAJAR", 190, Color3.fromRGB(255,180,120))
local speedBtn = btn("SPEED +", 235, Color3.fromRGB(180,120,255))

-- FLY
local function startFly()
	local hrp = getChar():WaitForChild("HumanoidRootPart")

	bv = Instance.new("BodyVelocity", hrp)
	bv.MaxForce = Vector3.new(1e9,1e9,1e9)

	bg = Instance.new("BodyGyro", hrp)
	bg.MaxTorque = Vector3.new(1e9,1e9,1e9)

	RunService.RenderStepped:Connect(function()
		if flying then
			local dir = Camera.CFrame.LookVector
			if up then dir += Vector3.new(0,1,0) end
			if down then dir -= Vector3.new(0,1,0) end
			bv.Velocity = dir * speed
			bg.CFrame = Camera.CFrame
		end
	end)
end

local function stopFly()
	if bv then bv:Destroy() bv=nil end
	if bg then bg:Destroy() bg=nil end
end

-- NOCLIP
RunService.Stepped:Connect(function()
	if noclip then
		for _,v in pairs(getChar():GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- BUTTONS
flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flyBtn.Text = flying and "FLY : ON" or "FLY : OFF"
	if flying then startFly() else stopFly() end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NOCLIP : ON" or "NOCLIP : OFF"
end)

upBtn.MouseButton1Down:Connect(function() up = true end)
upBtn.MouseButton1Up:Connect(function() up = false end)

downBtn.MouseButton1Down:Connect(function() down = true end)
downBtn.MouseButton1Up:Connect(function() down = false end)

speedBtn.MouseButton1Click:Connect(function()
	speed += 10
end)
