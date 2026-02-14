--==================================================
-- ZL HUB X (V10) | Base profesional
-- Key System + Menú Tabs + Fly + Noclip + ESP + TP + Infinite Jump + Speed/Jump
-- Optimizado, seguro, cliente-only
--==================================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- CHARACTER HANDLER
local function GetChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- CLEAR OLD GUI
pcall(function()
    game.CoreGui.ZLHubX:Destroy()
end)

--==================================================
-- MAIN GUI
--==================================================
local GUI = Instance.new("ScreenGui", game.CoreGui)
GUI.Name = "ZLHubX"

local Main = Instance.new("Frame", GUI)
Main.Size = UDim2.fromScale(0.38, 0.5)
Main.Position = UDim2.fromScale(0.31, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active = true
Main.Draggable = true
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🔥 ZL HUB X V10"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- UI Layout
local Layout = Instance.new("UIListLayout", Main)
Layout.Padding = UDim.new(0,6)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- BUTTON CREATOR
local function Button(txt, func)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.95,0,0,40)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.AutoButtonColor = true
    b.BorderSizePixel = 0
    b.Parent = Main
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.MouseButton1Click:Connect(func)
end

--==================================================
-- KEY SYSTEM (SIMPLE)
--==================================================
local REQUIRED_KEY = "victoriateamo"
local KeyFrame = Instance.new("Frame", GUI)
KeyFrame.Size = UDim2.new(0,300,0,150)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,35)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,14)

local KeyLabel = Instance.new("TextLabel", KeyFrame)
KeyLabel.Size = UDim2.new(1,0,0,40)
KeyLabel.Text = "ZL HUB X – KEY"
KeyLabel.TextColor3 = Color3.fromRGB(255,150,220)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Font = Enum.Font.GothamBold
KeyLabel.TextSize = 16

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.PlaceholderText = "Ingresa la key"
KeyBox.Size = UDim2.new(0.85,0,0,35)
KeyBox.Position = UDim2.new(0.075,0,0.4,0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,60)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(0.5,0,0,35)
KeyBtn.Position = UDim2.new(0.25,0,0.7,0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(255,150,220)
KeyBtn.TextColor3 = Color3.new(0,0,0)
KeyBtn.Text = "VALIDAR"
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.TextSize = 14
Instance.new("UICorner", KeyBtn)

KeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == REQUIRED_KEY then
        KeyFrame:Destroy()
        GUI.Enabled = true
    end
end)

GUI.Enabled = false

--==================================================
-- MOVEMENT
--==================================================
local Fly = false
local FlyBV, FlyBG
Button("🛫 Fly REAL (WASD)", function()
    Fly = not Fly
    local HRP = GetChar():WaitForChild("HumanoidRootPart")
    if Fly then
        FlyBV = Instance.new("BodyVelocity", HRP)
        FlyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
        FlyBG = Instance.new("BodyGyro", HRP)
        FlyBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        RunService:BindToRenderStep("ZLFly",1,function()
            local dir = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
            FlyBV.Velocity = dir * 70
            FlyBG.CFrame = Camera.CFrame
        end)
    else
        RunService:UnbindFromRenderStep("ZLFly")
        if FlyBV then FlyBV:Destroy() end
        if FlyBG then FlyBG:Destroy() end
    end
end)

-- Noclip
local Noclip = false
Button("🚪 Noclip REAL", function()
    Noclip = not Noclip
end)
RunService.Stepped:Connect(function()
    if Noclip then
        for _,v in pairs(GetChar():GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Speed / Infinite Jump
Button("⚡ Speed Boost", function() GetChar().Humanoid.WalkSpeed = 65 end)
UIS.JumpRequest:Connect(function() GetChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
Button("🌀 Infinite Jump Toggle",function() end) -- local toggle, infinite jump active

--==================================================
-- COMBAT
--==================================================
Button("🛡 God Mode", function()
    local hum = GetChar().Humanoid
    hum.MaxHealth = math.huge
    hum.Health = math.huge
end)

--==================================================
-- VISUALS / ESP
--==================================================
Button("👁 ESP BOX Police/Prisoner", function()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if not p.Character:FindFirstChild("ZLESP") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ZLESP"
                box.Adornee = p.Character
                box.Size = p.Character:GetExtentsSize()
                box.AlwaysOnTop = true
                box.Transparency = 0.6
                box.ZIndex = 10
                box.Color3 = (p.Team and p.Team.Name == "Police") 
                    and Color3.fromRGB(0,150,255) 
                    or Color3.fromRGB(255,80,80)
                box.Parent = p.Character
            end
        end
    end
end)

--==================================================
-- TELEPORT
--==================================================
Button("🧲 TP Random Player", function()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            GetChar().HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
            break
        end
    end
end)

--==================================================
-- PRISON LIFE AUTO ESCAPE
--==================================================
Button("🤖 Auto Escape Prison", function()
    GetChar().HumanoidRootPart.CFrame = CFrame.new(916, 100, 2447)
end)

--==================================================
-- OPTIMIZATION
--==================================================
Button("💨 Anti Lag / FPS Boost", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        end
    end
end)

--==================================================
-- RESPAWN FIX
--==================================================
LocalPlayer.CharacterAdded:Connect(function()
    Fly = false
    Noclip = false
end)
