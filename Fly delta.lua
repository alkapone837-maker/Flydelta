
--// ZL HUB V4 | Universal
--// FULL FEATURES | Stable | Optimized
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

--------------------
-- VARIABLES
--------------------
local character, humanoid, root
local fly = false
local noclip = false
local speedOn = false
local infJump = false
local espEnabled = false
local flyBV, flyBG

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
-- KEY SYSTEM UI
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
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Text = "VALIDAR"
KeyBtn.Size = UDim2.new(0.5,0,0,35)
KeyBtn.Position = UDim2.new(0.25,0,0.7,0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(255,120,200)
KeyBtn.TextColor3 = Color3.new(0,0,0)
KeyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", KeyBtn)

--------------------
-- MAIN HUB UI
--------------------
local HubGui = Instance.new("ScreenGui", game.CoreGui)
HubGui.Enabled = false

local Main = Instance.new("Frame", HubGui)
Main.Size = UDim2.new(0,380,0,420)
Main.Position = UDim2.new(0.5,-190,0.5,-210)
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
-- BUTTON CREATOR
--------------------
local function btn(text,y)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.new(0.85,0,0,40)
	b.Position = UDim2.new(0.075,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = Color3.new(0,0,0)
	b.BackgroundColor3 = Color3.fromRGB(255,170,220)
	Instance.new("UICorner", b)
	return b
end

--------------------
-- SPEED
--------------------
btn("Speed ON / OFF", 60).MouseButton1Click:Connect(function()
	speedOn = not speedOn
	humanoid.WalkSpeed = speedOn and 40 or 16
end)

--------------------
-- JUMP
--------------------
btn("Jump Boost", 110).MouseButton1Click:Connect(function()
	humanoid.JumpPower = humanoid.JumpPower == 50 and 100 or 50
end)

--------------------
-- INFINITE JUMP
--------------------
btn("Infinite Jump", 160).MouseButton1Click:Connect(function()
	infJump = not infJump
end)

UIS.JumpRequest:Connect(function()
	if infJump then humanoid:ChangeState("Jumping") end
end)

--------------------
-- FLY REAL
--------------------
btn("Fly ON / OFF", 210).MouseButton1Click:Connect(function()
	fly = not fly
	if fly then
		flyBV = Instance.new("BodyVelocity", root)
		flyBV.MaxForce = Vector3.new(1e9,1e9,1e9)
		flyBG = Instance.new("BodyGyro", root)
		flyBG.MaxTorque = Vector3.new(1e9,1e9,1e9)

		RunService.RenderStepped:Connect(function()
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
-- NOCLIP REAL
--------------------
btn("Noclip ON / OFF", 260).MouseButton1Click:Connect(function()
	noclip = not noclip
end)

RunService.Stepped:Connect(function()
	if noclip and character then
		for _,v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)

--------------------
-- ESP SIMPLE
--------------------
btn("ESP ON / OFF", 310).MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
			local h = plr.Character.Head
			local e = h:FindFirstChild("ZLESP")
			if e then e:Destroy() end
			if espEnabled then
				local g = Instance.new("BillboardGui", h)
				g.Name = "ZLESP"
				g.Size = UDim2.new(0,120,0,30)
				g.AlwaysOnTop = true
				local t = Instance.new("TextLabel", g)
				t.Size = UDim2.new(1,0,1,0)
				t.BackgroundTransparency = 1
				t.Text = plr.Name
				t.TextColor3 = Color3.fromRGB(255,120,200)
				t.TextStrokeTransparency = 0
			end
		end
	end
end)

--------------------
-- TP TOOL
--------------------
btn("TP Tool", 360).MouseButton1Click:Connect(function()
	local m = player:GetMouse()
	if m and m.Hit then
		root.CFrame = m.Hit + Vector3.new(0,3,0)
	end
end)

--------------------
-- KEY CHECK
--------------------
KeyBtn.MouseButton1Click:Connect(function()
	if KeyBox.Text == REQUIRED_KEY then
		KeyGui:Destroy()
		HubGui.Enabled = true

			--------------------
-- PRISON LIFE ESP BOX (ROLES)
--------------------
local espPL = false
local ESPPLBtn = createButton("Prison Life ESP (Roles)", 410)

local function getRole(plr)
	if not plr.Team then return "Unknown" end
	local name = plr.Team.Name:lower()
	if name:find("police") then
		return "Police", Color3.fromRGB(80,150,255)
	elseif name:find("criminal") then
		return "Criminal", Color3.fromRGB(255,80,80)
	else
		return "Prisoner", Color3.fromRGB(80,255,120)
	end
end

local function clearPLBoxes()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr.Character then
			local h = plr.Character:FindFirstChild("HumanoidRootPart")
			if h then
				local box = h:FindFirstChild("ZL_PL_BOX")
				if box then box:Destroy() end
			end
		end
	end
end

local function applyPLBoxes()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
			local hum = plr.Character:FindFirstChild("Humanoid")
			if hrp and hum and not hrp:FindFirstChild("ZL_PL_BOX") then
				local role, color = getRole(plr)

				local box = Instance.new("BoxHandleAdornment")
				box.Name = "ZL_PL_BOX"
				box.Adornee = hrp
				box.Size = Vector3.new(4,6,2)
				box.AlwaysOnTop = true
				box.ZIndex = 5
				box.Transparency = 0.5
				box.Color3 = color
				box.Parent = hrp
			end
		end
	end
end

ESPPLBtn.MouseButton1Click:Connect(function()
	espPL = not espPL
	clearPLBoxes()
	if espPL then
		applyPLBoxes()
	end
end)

Players.PlayerAdded:Connect(function()
	task.wait(1)
	if espPL then applyPLBoxes() end
end)
	end
		--------------------
-- GOD MODE
--------------------
local godMode = false
local GodBtn = createButton("God Mode ON / OFF", 460)

local function applyGod()
	if humanoid then
		humanoid.MaxHealth = math.huge
		humanoid.Health = math.huge
	end
end

GodBtn.MouseButton1Click:Connect(function()
	godMode = not godMode
	if godMode then
		applyGod()
	else
		if humanoid then
			humanoid.MaxHealth = 100
			humanoid.Health = 100
		end
	end
end)

-- mantener god al respawn
player.CharacterAdded:Connect(function(char)
	task.wait(1)
	humanoid = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")
	if godMode then
		applyGod()
	end
end)
end)
