--// ZL HUB V3 | Universal (UPDATED)
--// Fly + Noclip + Speed + Aura + Key System
--// Key: victoriateamo

--------------------
-- CONFIG
--------------------
local REQUIRED_KEY = "victoriateamo"

--------------------
-- SERVICES
--------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

--------------------
-- RESPAWN FIX
--------------------
player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")
end)

--------------------
-- KEY SYSTEM UI
--------------------
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
KeyGui.Name = "ZL_KeySystem"

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,300,0,150)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,35)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,14)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.Text = "ZL HUB V3 - KEY"
KeyTitle.BackgroundTransparency = 1
KeyTitle.TextColor3 = Color3.fromRGB(255,140,210)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 18

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.PlaceholderText = "Ingresa la key"
KeyBox.Size = UDim2.new(0.85,0,0,35)
KeyBox.Position = UDim2.new(0.075,0,0.4,0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.ClearTextOnFocus = false
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Text = "VALIDAR"
KeyBtn.Size = UDim2.new(0.5,0,0,35)
KeyBtn.Position = UDim2.new(0.25,0,0.7,0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(255,140,210)
KeyBtn.TextColor3 = Color3.new(0,0,0)
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.TextSize = 14
Instance.new("UICorner", KeyBtn)

--------------------
-- MAIN HUB UI
--------------------
local HubGui = Instance.new("ScreenGui", game.CoreGui)
HubGui.Enabled = false
HubGui.Name = "ZLHubV3"

local Main = Instance.new("Frame", HubGui)
Main.Size = UDim2.new(0,380,0,330)
Main.Position = UDim2.new(0.5,-190,0.5,-165)
Main.BackgroundColor3 = Color3.fromRGB(30,30,45)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel", Main)
Title.Text = "victoria mi único amor"
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,160,220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

--------------------
-- FLOAT BUTTON
--------------------
local ToggleBtn = Instance.new("TextButton", HubGui)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0.05,0,0.5,0)
ToggleBtn.Text = "ZL"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16
ToggleBtn.TextColor3 = Color3.new(0,0,0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255,140,210)
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)

ToggleBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--------------------
-- BUTTON FACTORY
--------------------
local function createButton(text, y)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.new(0.85,0,0,40)
	b.Position = UDim2.new(0.075,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(0,0,0)
	b.BackgroundColor3 = Color3.fromRGB(255,180,225)
	Instance.new("UICorner", b)
	return b
end

--------------------
-- SPEED
--------------------
local speedOn = false
local SpeedBtn = createButton("Speed ON / OFF", 60)
SpeedBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	humanoid.WalkSpeed = speedOn and 40 or 16
end)

--------------------
-- FLY (FIXED 100%)
--------------------
local flying = false
local flyConn
local bv, bg
local flySpeed = 60

local FlyBtn = createButton("Fly ON / OFF", 110)

local function enableFly()
	flying = true
	bv = Instance.new("BodyVelocity", root)
	bv.MaxForce = Vector3.new(9e9,9e9,9e9)
	bv.Velocity = Vector3.zero

	bg = Instance.new("BodyGyro", root)
	bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	bg.CFrame = root.CFrame

	flyConn = RunService.RenderStepped:Connect(function()
		if not flying then return end
		local cam = workspace.CurrentCamera
		local dir = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end

		bv.Velocity = dir * flySpeed
		bg.CFrame = cam.CFrame
	end)
end

local function disableFly()
	flying = false
	if flyConn then flyConn:Disconnect() end
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
end

FlyBtn.MouseButton1Click:Connect(function()
	if flying then disableFly() else enableFly() end
end)

--------------------
-- NOCLIP (REAL)
--------------------
local noclip = false
local noclipConn
local NoclipBtn = createButton("Noclip ON / OFF", 160)

local function setCollide(state)
	for _,v in pairs(character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = state
		end
	end
end

local function enableNoclip()
	noclip = true
	noclipConn = RunService.Stepped:Connect(function()
		if noclip then setCollide(false) end
	end)
end

local function disableNoclip()
	noclip = false
	if noclipConn then noclipConn:Disconnect() end
	setCollide(true)
end

NoclipBtn.MouseButton1Click:Connect(function()
	if noclip then disableNoclip() else enableNoclip() end
end)

--------------------
-- AURA (UNIVERSAL)
--------------------
local AuraBtn = createButton("Aura ON", 210)
AuraBtn.MouseButton1Click:Connect(function()
	for _,tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") and tool:FindFirstChild("Handle") and not tool.Handle:FindFirstChild("Aura") then
			local p = Instance.new("ParticleEmitter", tool.Handle)
			p.Name = "Aura"
			p.Texture = "rbxassetid://243660364"
			p.Rate = 35
			p.Lifetime = NumberRange.new(0.5)
			p.Size = NumberSequence.new(0.6)
			p.Color = ColorSequence.new(Color3.fromRGB(255,140,210))
		end
	end
end)

--------------------
-- KEY CHECK
--------------------
KeyBtn.MouseButton1Click:Connect(function()
	if KeyBox.Text == REQUIRED_KEY then
		KeyGui:Destroy()
		HubGui.Enabled = true
	end
end)
