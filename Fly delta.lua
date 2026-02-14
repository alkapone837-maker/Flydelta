--==================================================
-- ZL HUB V5 | FULL REWRITE
-- Prison Life Compatible
-- Fly / Noclip / ESP / TP / God / Auto Escape
--==================================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- CHARACTER SAFE
local function GetChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- CLEAN OLD GUI
pcall(function()
    game.CoreGui.ZLHubV5:Destroy()
end)

--==================================================
-- UI
--==================================================
local GUI = Instance.new("ScreenGui", game.CoreGui)
GUI.Name = "ZLHubV5"

local Main = Instance.new("Frame", GUI)
Main.Size = UDim2.fromScale(0.38, 0.5)
Main.Position = UDim2.fromScale(0.31, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active = true
Main.Draggable = true
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0,14)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🔥 ZL HUB V5 – Prison Life"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

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

        RunService:BindToRenderStep("ZLFly", 1, function()
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

-- NOCLIP REAL
local Noclip = false
Button("🚪 Noclip REAL", function()
    Noclip = not Noclip
end)

RunService.Stepped:Connect(function()
    if Noclip then
        for _,v in pairs(GetChar():GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

Button("⚡ Speed Boost", function()
    GetChar().Humanoid.WalkSpeed = 65
end)

Button("🌀 Infinite Jump", function()
    UIS.JumpRequest:Connect(function()
        GetChar().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
end)

--==================================================
-- COMBAT
--==================================================
Button("🛡 God Mode", function()
    local hum = GetChar().Humanoid
    hum.MaxHealth = math.huge
    hum.Health = math.huge
end)

--==================================================
-- ESP
--==================================================
Button("👁 ESP BOX (Police / Prisoner)", function()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if not plr.Character:FindFirstChild("ZLESP") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ZLESP"
                box.Adornee = plr.Character
                box.Size = plr.Character:GetExtentsSize()
                box.AlwaysOnTop = true
                box.Transparency = 0.6
                box.ZIndex = 10
                box.Color3 = (plr.Team and plr.Team.Name == "Police") 
                    and Color3.fromRGB(0,150,255) 
                    or Color3.fromRGB(255,80,80)
                box.Parent = plr.Character
            end
        end
    end
end)

--==================================================
-- TELEPORT
--==================================================
Button("🧲 TP a jugador (random)", function()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            GetChar().HumanoidRootPart.CFrame =
                p.Character.HumanoidRootPart.CFrame
            break
        end
    end
end)

--==================================================
-- PRISON LIFE
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
