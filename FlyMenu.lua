-- Fly + Noclip Menu | Delta | Mobile Compatible

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local flying = false
local noclip = false
local speed = 60
local bv, bg

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FlyNoclipMenu"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,180)
frame.Position = UDim2.new(0,20,0,200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "FLY HUB"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(1,-20,0,40)
flyBtn.Position = UDim2.new(0,10,0,40)
flyBtn.Text = "FLY : OFF"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)

local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Size = UDim2.new(1,-20,0,40)
noclipBtn.Position = UDim2.new(0,10,0,90)
noclipBtn.Text = "NOCLIP : OFF"
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)

local mobileBtn = Instance.new("TextButton", gui)
mobileBtn.Size = UDim2.new(0,60,0,60)
mobileBtn.Position = UDim2.new(0.85,0,0.7,0)
mobileBtn.Text = "MENU"
mobileBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
mobileBtn.TextColor3 = Color3.new(1,1,1)
mobileBtn.Visible = UIS.TouchEnabled

mobileBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	flyBtn.Text = flying and "FLY : ON" or "FLY : OFF"

	if flying then
		bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(9e9,9e9,9e9)

		bg = Instance.new("BodyGyro", hrp)
		bg.MaxTorque = Vector3.new(9e9,9e9,9e9)

		hum.PlatformStand = true
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		hum.PlatformStand = false
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NOCLIP : ON" or "NOCLIP : OFF"
end)

RunService.Stepped:Connect(function()
	if noclip then
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if flying and bv and bg then
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += cam.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= cam.CFrame.UpVector end

		bv.Velocity = dir * speed
		bg.CFrame = cam.CFrame
	end
end)
