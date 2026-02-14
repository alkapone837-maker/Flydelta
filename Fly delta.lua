
--========================================
-- ZL HUB v5 | UI Refresh
-- KEY: victoriateamo
-- ESP + TP (lista)
-- SIN Fly / SIN Noclip
--========================================

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Cleanup previo
if _G.ZL_V5_CLEAN then pcall(_G.ZL_V5_CLEAN) end
local connections = {}
_G.ZL_V5_CLEAN = function()
	for _,c in ipairs(connections) do pcall(function() c:Disconnect() end) end
	if CoreGui:FindFirstChild("ZLHubV5") then CoreGui.ZLHubV5:Destroy() end
end

-- GUI Root
local gui = Instance.new("ScreenGui")
gui.Name = "ZLHubV5"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

--========================
-- Helpers
--========================
local function corner(obj, r)
	local c = Instance.new("UICorner", obj)
	c.CornerRadius = UDim.new(0, r or 14)
	return c
end

local function stroke(obj, t)
	local s = Instance.new("UIStroke", obj)
	s.Thickness = t or 1
	s.Color = Color3.fromRGB(90,90,110)
	return s
end

--========================
-- KEY SYSTEM
--========================
local KEY = "victoriateamo"

local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.fromScale(0.32,0.30)
keyFrame.Position = UDim2.fromScale(0.34,0.35)
keyFrame.BackgroundColor3 = Color3.fromRGB(22,22,28)
keyFrame.Active, keyFrame.Draggable = true, true
corner(keyFrame,18); stroke(keyFrame,1)

local kt = Instance.new("TextLabel", keyFrame)
kt.Size = UDim2.fromScale(1,0.22)
kt.BackgroundTransparency = 1
kt.Text = "ZL HUB v5"
kt.Font = Enum.Font.GothamBold
kt.TextScaled = true
kt.TextColor3 = Color3.fromRGB(255,170,220)

local kb = Instance.new("TextBox", keyFrame)
kb.Size = UDim2.fromScale(0.82,0.22)
kb.Position = UDim2.fromScale(0.09,0.32)
kb.PlaceholderText = "Ingresa la key"
kb.BackgroundColor3 = Color3.fromRGB(35,35,45)
kb.TextColor3 = Color3.new(1,1,1)
kb.ClearTextOnFocus = false
corner(kb,12)

local hint = Instance.new("TextLabel", keyFrame)
hint.Size = UDim2.fromScale(1,0.14)
hint.Position = UDim2.fromScale(0,0.56)
hint.BackgroundTransparency = 1
hint.Text = "contraseña en mi discord"
hint.Font = Enum.Font.Gotham
hint.TextScaled = true
hint.TextColor3 = Color3.fromRGB(180,180,200)

local kbtn = Instance.new("TextButton", keyFrame)
kbtn.Size = UDim2.fromScale(0.6,0.2)
kbtn.Position = UDim2.fromScale(0.2,0.74)
kbtn.Text = "DESBLOQUEAR"
kbtn.Font = Enum.Font.GothamBold
kbtn.TextScaled = true
kbtn.TextColor3 = Color3.new(0,0,0)
kbtn.BackgroundColor3 = Color3.fromRGB(255,150,210)
corner(kbtn,14)

--========================
-- MAIN HUB
--========================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.40,0.50)
main.Position = UDim2.fromScale(0.30,0.25)
main.BackgroundColor3 = Color3.fromRGB(18,18,24)
main.Visible = false
main.Active, main.Draggable = true, true
corner(main,20); stroke(main,1)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.12)
title.BackgroundTransparency = 1
title.Text = "victoria mi único amor"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,160,220)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromScale(1,0.88)
content.Position = UDim2.fromScale(0,0.12)
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function mkBtn(txt)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromScale(0.9,0.12)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(40,40,55)
	corner(b,14); stroke(b,1)
	b.Parent = content
	return b
end

--========================
-- Toggle flotante
--========================
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.fromOffset(56,56)
toggle.Position = UDim2.fromScale(0.05,0.5)
toggle.Text = "ZL"
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 18
toggle.TextColor3 = Color3.new(0,0,0)
toggle.BackgroundColor3 = Color3.fromRGB(255,150,210)
toggle.Active, toggle.Draggable = true, true
corner(toggle,28)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

--========================
-- ESP (Box)
--========================
local espOn = false
local espItems = {}

local function clearESP()
	for _,v in ipairs(espItems) do pcall(function() v:Destroy() end) end
	espItems = {}
end

local function addESP(plr)
	if plr == LocalPlayer then return end
	local box = Instance.new("BoxHandleAdornment")
	box.Size = Vector3.new(4,6,2)
	box.Color3 = Color3.fromRGB(255,80,80)
	box.Transparency = 0.5
	box.AlwaysOnTop = true
	box.ZIndex = 10
	box.Parent = gui
	table.insert(espItems, box)

	local rs = RunService.RenderStepped:Connect(function()
		if not espOn then box.Adornee = nil return end
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			box.Adornee = plr.Character.HumanoidRootPart
		else
			box.Adornee = nil
		end
	end)
	table.insert(connections, rs)
end

local function refreshESP()
	clearESP()
	if not espOn then return end
	for _,p in ipairs(Players:GetPlayers()) do addESP(p) end
end

--========================
-- TP con lista
--========================
local tpFrame = Instance.new("Frame", gui)
tpFrame.Size = UDim2.fromScale(0.28,0.44)
tpFrame.Position = UDim2.fromScale(0.05,0.28)
tpFrame.BackgroundColor3 = Color3.fromRGB(22,22,28)
tpFrame.Visible = false
tpFrame.Active, tpFrame.Draggable = true, true
corner(tpFrame,18); stroke(tpFrame,1)

local tpt = Instance.new("TextLabel", tpFrame)
tpt.Size = UDim2.fromScale(1,0.14)
tpt.BackgroundTransparency = 1
tpt.Text = "TP A JUGADORES"
tpt.Font = Enum.Font.GothamBold
tpt.TextScaled = true
tpt.TextColor3 = Color3.fromRGB(200,200,220)

local tpl = Instance.new("UIListLayout", tpFrame)
tpl.Padding = UDim.new(0,8)

local function refreshTP()
	for _,c in ipairs(tpFrame:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local b = Instance.new("TextButton")
			b.Size = UDim2.fromScale(0.9,0.1)
			b.Text = p.Name
			b.Font = Enum.Font.Gotham
			b.TextScaled = true
			b.TextColor3 = Color3.new(1,1,1)
			b.BackgroundColor3 = Color3.fromRGB(45,45,60)
			corner(b,12)
			b.Parent = tpFrame
			b.MouseButton1Click:Connect(function()
				if LocalPlayer.Character and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character:PivotTo(p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3))
				end
			end)
		end
	end
end

--========================
-- Botones del Hub
--========================
local espBtn = mkBtn("ESP : OFF")
local tpBtn  = mkBtn("TP PLAYERS")
local closeBtn = mkBtn("CERRAR")

espBtn.MouseButton1Click:Connect(function()
	espOn = not espOn
	espBtn.Text = "ESP : "..(espOn and "ON" or "OFF")
	refreshESP()
end)

tpBtn.MouseButton1Click:Connect(function()
	tpFrame.Visible = not tpFrame.Visible
	if tpFrame.Visible then refreshTP() end
end)

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
end)

--========================
-- Respawn safe
--========================
local cr = LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	if espOn then refreshESP() end
end)
table.insert(connections, cr)

--========================
-- Key check
--========================
kbtn.MouseButton1Click:Connect(function()
	if kb.Text == KEY then
		keyFrame.Visible = false
		main.Visible = true
	else
		kb.Text = "KEY INCORRECTA"
	end
end)

print("ZL HUB v5 UI refreshed loaded")
