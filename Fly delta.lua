--// ZL HUB v5 - Universal
--// TP Player List • Fly • Cat Background • Toggle Menu

-- Limpieza
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("ZLHubUI") then
    CoreGui.ZLHubUI:Destroy()
end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ZLHubUI"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local menuOpen = true

-- Frame principal
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 460, 0, 360)
main.Position = UDim2.new(0.5, -230, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- Fondo gato
local bg = Instance.new("ImageLabel", main)
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.Image = "rbxassetid://14754720137" -- gato (puedes cambiarlo)
bg.ImageTransparency = 0.75
bg.ScaleType = Enum.ScaleType.Crop
bg.BackgroundTransparency = 1
Instance.new("UICorner", bg).CornerRadius = UDim.new(0,16)

-- Barra superior
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,44)
top.BackgroundColor3 = Color3.fromRGB(15,15,15)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,16)

-- Título
local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,-60,1,0)
title.Position = UDim2.new(0,15,0,0)
title.BackgroundTransparency = 1
title.Text = "ZL HUB v5"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Left
title.TextColor3 = Color3.new(1,0,0)

-- Botón cerrar
local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,2)
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundTransparency = 1

-- Contenido
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,0,0,54)
content.Size = UDim2.new(1,0,1,-54)
content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0,10)
layout.HorizontalAlignment = Center

-- Crear botón
local function createButton(text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,380,0,42)
    b.BackgroundColor3 = Color3.fromRGB(20,20,20)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 15
    b.TextColor3 = Color3.fromRGB(235,235,235)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    b.Parent = content
    return b
end

-- ======================
-- FLY REAL
-- ======================
local flying = false
local flySpeed = 50
local bodyGyro, bodyVel

local function startFly()
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    bodyGyro = Instance.new("BodyGyro", hrp)
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
    bodyGyro.CFrame = hrp.CFrame

    bodyVel = Instance.new("BodyVelocity", hrp)
    bodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)

    flying = true

    RunService.RenderStepped:Connect(function()
        if not flying then return end
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += workspace.CurrentCamera.CFrame.RightVector end
        bodyVel.Velocity = dir * flySpeed
    end)
end

local function stopFly()
    flying = false
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVel then bodyVel:Destroy() end
end

-- ======================
-- TP LISTA JUGADORES
-- ======================
local function openTPList()
    if gui:FindFirstChild("TPList") then gui.TPList:Destroy() end

    local f = Instance.new("Frame", gui)
    f.Name = "TPList"
    f.Size = UDim2.new(0,260,0,300)
    f.Position = UDim2.new(0.5,-130,0.5,-150)
    f.BackgroundColor3 = Color3.fromRGB(15,15,15)
    f.BorderSizePixel = 0
    f.Active = true
    f.Draggable = true
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,14)

    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0,6)

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local b = Instance.new("TextButton", f)
            b.Size = UDim2.new(1,-10,0,36)
            b.BackgroundColor3 = Color3.fromRGB(25,25,25)
            b.Text = "TP a "..plr.Name
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            b.TextColor3 = Color3.new(1,1,1)
            b.BorderSizePixel = 0
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

            b.MouseButton1Click:Connect(function()
                if LP.Character and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    LP.Character:PivotTo(plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3))
                end
            end)
        end
    end
end

-- Botones
local flyBtn = createButton("🛫 Fly (ON / OFF)")
flyBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
        flyBtn.Text = "🛫 Fly (OFF)"
    else
        startFly()
        flyBtn.Text = "🛫 Fly (ON)"
    end
end)

local tpBtn = createButton("🧲 Teleport a jugador")
tpBtn.MouseButton1Click:Connect(openTPList)

createButton("⚙ Más opciones pronto…")

-- Cerrar menú
close.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    main.Visible = menuOpen
end)

-- Toggle teclado
UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        menuOpen = not menuOpen
        main.Visible = menuOpen
    end
end)

-- Rainbow título
local h = 0
RunService.RenderStepped:Connect(function()
    h = (h + 0.004) % 1
    title.TextColor3 = Color3.fromHSV(h,1,1)
end)
