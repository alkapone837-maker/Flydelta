--// ZL HUB V4 | Prison Life Edition
--// Key: victoriateamo
--// Full | Stable | Optimized

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

--------------------
-- VARIABLES
--------------------
local character, humanoid, root
local fly, noclip, speedOn, infJump = false,false,false,false
local espPL, godMode = false,false
local flyBV, flyBG
local connections = {}

--------------------
-- CHARACTER LOAD
--------------------
local function loadChar()
	character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")
	root = character:WaitForChild("HumanoidRootPart")
end
loadChar()
player.CharacterAdded:Connect(loadChar)

--------------------
-- CLEAN CONNECTIONS (ANTI LAG)
--------------------
local function connect(sig, func)
	local c = sig:Connect(func)
	table.insert(connections, c)
	return c
end

--------------------
-- KEY SYSTEM
--------------------
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,300,0,150)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,35)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,14)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.Text = "ZL HUB V4 - KEY"
KeyTitle.TextColor3 = Color3.fromRGB(255,120,200)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 18

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.PlaceholderText = "Ingresa la key"
KeyBox.Size = UDim2.new(0.85,0,0,35)
KeyBox.Position = UDim2.new(0.075,0,0.4,0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Text = "VALIDAR"
KeyBtn.Size = UDim2.new(0.5,0,0,35)
KeyBtn.Position = UDim2.new(0.25,0,0.7,0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(255,120,200)
KeyBtn.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", KeyBtn)

--------------------
-- MAIN UI
--------------------
local HubGui = Instance.new("ScreenGui", game.CoreGui)
HubGui.Enabled = false

local Main = Instance.new("Frame", HubGui)
Main.Size = UDim2.new(0,400,0,560)
Main.Position = UDim2.new(0.5,-200,0.5,-280)
Main.BackgroundColor3 = Color3.fromRGB(30,30,45)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel", Main)
Title.Text = "victoria mi único amor"
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,150,220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

--------------------
-- FLOAT BUTTON
--------------------
local ToggleBtn = Instance.new("TextButton", HubGui)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0.05,0,0.5,0)
ToggleBtn.Text = "ZL"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255,120,200)
ToggleBtn.TextColor3 = Color3.new(0,0,0)
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
ToggleBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--------------------
-- BUTTON MAKER
--------------------
local function btn(text,y)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.new(0.85,0,0,38)
	b.Position = UDim2.new(0.075,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = Color3.new(0,0,0)
	b.BackgroundColor3 = Color3.fromRGB(255,170,220)
	Instance.new("UICorner", b)
	return b
end

--------------------
-- SPEED / JUMP
--------------------
btn("Speed ON / OFF",60).MouseButton1Click:Connect(function()
	speedOn = not speedOn
	humanoid.WalkSpeed = speedOn and 40 or 16
end)

btn("Jump Boost",100).MouseButton1Click:Connect(function()
	humanoid.JumpPower = humanoid.JumpPower == 50 and 100 or 50
end)

--------------------
-- INFINITE JUMP
--------------------
btn("Infinite Jump",140).MouseButton1Click:Connect(function()
	infJump = not infJump
end)

connect(UIS.JumpRequest,function()
	if infJump then humanoid:ChangeState("Jumping") end
end)

--------------------
-- FLY REAL
--------------------
btn("Fly ON / OFF",180).MouseButton1Click:Connect(function()
	fly = not fly
	if fly then
		flyBV = Instance.new("BodyVelocity", root)
		flyBV.MaxForce = Vector3.new(1e9,1e9,1e9)
		flyBG = Instance.new("BodyGyro", root)
		flyBG.MaxTorque = Vector3.new(1e9,1e9,1e9)

		connect(RunService.RenderStepped,function()
			if not fly then return end
			local cam = workspace.CurrentCamera
			local dir = Vector3.zero
			if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
			flyBV.Velocity = dir * 60
			flyBG.CFrame = cam.CFrame
		end)
	else
		if flyBV then flyBV:Destroy() end
		if flyBG then flyBG:Destroy() end
	end
end)

--------------------
-- NOCLIP
--------------------
btn("Noclip ON / OFF",220).MouseButton1Click:Connect(function()
	noclip = not noclip
end)

connect(RunService.Stepped,function()
	if noclip and character then
		for _,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)

--------------------
-- ESP BOX PRISON LIFE (ROLES)
--------------------
btn("ESP BOX (Police/Criminal)",260).MouseButton1Click:Connect(function()
	espPL = not espPL
	for _,plr in pairs(Players:GetPlayers()) do
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = plr.Character.HumanoidRootPart
			local old = hrp:FindFirstChild("ZL_BOX")
			if old then old:Destroy() end
			if espPL and plr ~= player then
				local color = Color3.fromRGB(80,255,120)
				if plr.Team and plr.Team.Name:lower():find("police") then
					color = Color3.fromRGB(80,150,255)
				elseif plr.Team and plr.Team.Name:lower():find("criminal") then
					color = Color3.fromRGB(255,80,80)
				end
				local box = Instance.new("BoxHandleAdornment", hrp)
				box.Name = "ZL_BOX"
				box.Adornee = hrp
				box.Size = Vector3.new(4,6,2)
				box.AlwaysOnTop = true
				box.Transparency = 0.5
				box.Color3 = color
			end
		end
	end
end)

--------------------
-- TP AL MOUSE
--------------------
btn("TP Mouse",300).MouseButton1Click:Connect(function()
	local m = player:GetMouse()
	if m and m.Hit then
		root.CFrame = m.Hit + Vector3.new(0,3,0)
	end
end)

--------------------
-- TP A JUGADOR (MAS CERCANO)
--------------------
btn("TP Player (Closest)",340).MouseButton1Click:Connect(function()
	local closest,dist
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local d = (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude
			if not dist or d < dist then
				dist = d
				closest = plr
			end
		end
	end
	if closest then
		root.CFrame = closest.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
	end
end)

--------------------
-- GOD MODE (ANTI DAMAGE)
--------------------
btn("God Mode ON / OFF",380).MouseButton1Click:Connect(function()
	godMode = not godMode
	if godMode then
		humanoid.MaxHealth = math.huge
		humanoid.Health = math.huge
	else
		humanoid.MaxHealth = 100
		humanoid.Health = 100
	end
end)

--------------------
-- PRISON LIFE AUTO ESCAPE
--------------------
btn("Auto Escape Prison",420).MouseButton1Click:Connect(function()
	if workspace:FindFirstChild("Criminals Spawn") then
		root.CFrame = workspace["Criminals Spawn"].CFrame + Vector3.new(0,5,0)
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
