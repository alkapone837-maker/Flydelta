--// RAIDER Hub | Clean UI Only
--// Solo menú, sin opciones

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI principal
local Gui = Instance.new("ScreenGui")
Gui.Name = "RaiderHub"
Gui.ResetOnSpawn = false
Gui.Parent = game.CoreGui

-- Frame principal
local Main = Instance.new("Frame")
Main.Parent = Gui
Main.Size = UDim2.new(0, 360, 0, 180)
Main.Position = UDim2.new(0.5, -180, 0.5, -90)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Visible = true
Main.Active = true
Main.Draggable = true

-- Bordes redondeados
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 18)
Corner.Parent = Main

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, -20, 0, 60)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "RAIDER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center

-- Subtexto minimal
local Sub = Instance.new("TextLabel")
Sub.Parent = Main
Sub.Size = UDim2.new(1, -20, 0, 40)
Sub.Position = UDim2.new(0, 10, 0, 80)
Sub.BackgroundTransparency = 1
Sub.Text = "minimal • clean • black"
Sub.TextColor3 = Color3.fromRGB(160, 160, 160)
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 14
Sub.TextXAlignment = Enum.TextXAlignment.Center

-- Botón Toggle flotante
local Toggle = Instance.new("TextButton")
Toggle.Parent = Gui
Toggle.Size = UDim2.new(0, 52, 0, 52)
Toggle.Position = UDim2.new(0.05, 0, 0.5, 0)
Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BorderSizePixel = 0
Toggle.Text = "R"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 20
Toggle.Active = true
Toggle.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = Toggle

-- Función abrir / cerrar menú
Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)
