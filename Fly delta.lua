
-- ZL HUB v5 | Fresh Edition
-- Full rebuild - Stable - Clean

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------
-- CONFIG
--------------------------------------------------
local KEY = "victoriateamo"

--------------------------------------------------
-- RAINBOW TEXT
--------------------------------------------------
local function Rainbow(label)
	task.spawn(function()
		local h = 0
		while label and label.Parent do
			h = (h + 1) % 360
			label.TextColor3 = Color3.fromHSV(h/360,1,1)
			task.wait(0.03)
		end
	end)
end

--------------------------------------------------
-- GUI
--------------------------------------------------
local GUI = Instance.new("ScreenGui", game.CoreGui)
GUI.ResetOnSpawn = false

--------------------------------------------------
-- KEY UI
--------------------------------------------------
local KeyFrame = Instance.new("Frame", GUI)
KeyFrame.Size = UDim2.fromScale(0.32,0.32)
KeyFrame.Position = UDim2.fromScale(0.34,0.34)
KeyFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)
KeyFrame.Active, KeyFrame.Draggable = true, true
Instance.new("UICorner",KeyFrame).CornerRadius = UDim.new(0,20)

local KT = Instance.new("TextLabel",KeyFrame)
KT.Size = UDim2.new(1,0,0.25,0)
KT.BackgroundTransparency = 1
KT.Text = "ZL HUB v5"
KT.Font = Enum.Font.GothamBold
KT.TextScaled = true
Rainbow(KT)

local KB = Instance.new("TextBox",KeyFrame)
KB.Size = UDim2.new(0.8,0,0.2,0)
KB.Position = UDim2.new(0.1,0,0.4,0)
KB.PlaceholderText = "Enter Key"
KB.Text = ""
KB.TextScaled = true
KB.BackgroundColor3 = Color3.fromRGB(35,35,35)
KB.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",KB).CornerRadius = UDim.new(0,12)

local KI = Instance.new("TextLabel",KeyFrame)
KI.Size = UDim2.new(1,0,0.15,0)
KI.Position = UDim2.new(0,0,0.62,0)
KI.BackgroundTransparency = 1
KI.Text = "contraseña en mi discord"
KI.Font = Enum.Font.Gotham
KI.TextScaled = true
KI.TextColor3 = Color3.fromRGB(180,180,180)

local KBTN = Instance.new("TextButton",KeyFrame)
KBTN.Size = UDim2.new(0.5,0,0.18,0)
KBTN.Position = UDim2.new(0.25,0,0.78,0)
KBTN.Text = "UNLOCK"
KBTN.Font = Enum.Font.GothamBold
KBTN.TextScaled = true
KBTN.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner",KBTN).CornerRadius = UDim.new(0,14)

--------------------------------------------------
-- MAIN HUB
--------------------------------------------------
local Main = Instance.new("Frame",GUI)
Main.Size = UDim2.fromScale(0.38,0.5)
Main.Position = UDim2.fromScale(0.05,0.25)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Visible = false
Main.Active, Main.Draggable = true, true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,22)

local Title = Instance.new("TextLabel",Main)
Title.Size = UDim2.new(1,0,0.12,0)
Title.BackgroundTransparency = 1
Title.Text = "ZL HUB v5"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Rainbow(Title)

--------------------------------------------------
-- TOGGLE
--------------------------------------------------
local open = true
UIS.InputBegan:Connect(function(i,g)
	if not g and i.KeyCode == Enum.KeyCode.RightControl then
		open = not open
		Main.Visible = open
	end
end)

--------------------------------------------------
-- BUTTON CREATOR
--------------------------------------------------
local function Button(txt,y,cb)
	local b = Instance.new("TextButton",Main)
	b.Size = UDim2.new(0.8,0,0.085,0)
	b.Position = UDim2.new(0.1,0,y,0)
	b.Text = txt
	b.Font = Enum.Font.Gotham
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,14)
	b.MouseButton1Click:Connect(cb)
end

--------------------------------------------------
-- FEATURES
--------------------------------------------------
local hum
local function Char()
	return LP.Character or LP.CharacterAdded:Wait()
end

LP.CharacterAdded:Connect(function()
	hum = Char():WaitForChild("Humanoid")
end)
hum = Char():WaitForChild("Humanoid")

-- Infinite Jump
local IJ = false
UIS.JumpRequest:Connect(function()
	if IJ then hum:ChangeState("Jumping") end
end)

-- ESP
local ESPon = false
local ESPobjs = {}

local function ClearESP()
	for _,v in pairs(ESPobjs) do v:Destroy() end
	ESPobjs = {}
end

local function ESP()
	ClearESP()
	if not ESPon then return end
	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local box = Instance.new("BoxHandleAdornment")
			box.Adornee = p.Character
			box.Size = Vector3.new(4,6,4)
			box.AlwaysOnTop = true
			box.Color3 = Color3.fromRGB(255,0,0)
			box.Transparency = 0.5
			box.Parent = p.Character
			table.insert(ESPobjs,box)
		end
	end
end

-- TP LIST
local function TPMenu()
	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
			break
		end
	end
end

--------------------------------------------------
-- BUTTONS
--------------------------------------------------
Button("Infinite Jump",0.16,function() IJ = not IJ end)
Button("Speed Boost",0.26,function() hum.WalkSpeed = 32 end)
Button("Jump Boost",0.36,function() hum.JumpPower = 80 end)
Button("ESP Toggle",0.46,function() ESPon = not ESPon ESP() end)
Button("TP Player (List)",0.56,TPMenu)
Button("FPS Boost",0.66,function()
	for _,v in pairs(Lighting:GetChildren()) do
		if v:IsA("PostEffect") then v.Enabled = false end
	end
end)

--------------------------------------------------
-- KEY CHECK
--------------------------------------------------
KBTN.MouseButton1Click:Connect(function()
	if KB.Text == KEY then
		KeyFrame.Visible = false
		Main.Visible = true
	else
		KB.Text = "WRONG KEY"
	end
end)
