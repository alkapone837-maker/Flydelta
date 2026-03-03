--// Rider Spammer
--// Clean Toggle Menu Base
--// Black UI | No Options

-------------------------
-- CLEANUP
-------------------------
if game.CoreGui:FindFirstChild("RiderSpammerUI") then
	game.CoreGui.RiderSpammerUI:Destroy()
end

-------------------------
-- GUI
-------------------------
local Gui = Instance.new("ScreenGui")
Gui.Name = "RiderSpammerUI"
Gui.Parent = game.CoreGui

-------------------------
-- MAIN MENU
-------------------------
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,320,0,180)
Main.Position = UDim2.new(0.5,-160,0.5,-90)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.BorderSizePixel = 0
Main.Visible = true
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

-------------------------
-- TITLE
-------------------------
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,60)
Title.BackgroundTransparency = 1
Title.Text = "Rider Spammer"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)

-------------------------
-- SUB LINE (DECORATIVE)
-------------------------
local Line = Instance.new("Frame", Main)
Line.Size = UDim2.new(0.8,0,0,1)
Line.Position = UDim2.new(0.1,0,0,65)
Line.BackgroundColor3 = Color3.fromRGB(40,40,40)
Line.BorderSizePixel = 0

-------------------------
-- EMPTY BODY (FOR FUTURE OPTIONS)
-------------------------
local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1,0,1,-80)
Body.Position = UDim2.new(0,0,0,80)
Body.BackgroundTransparency = 1

-------------------------
-- TOGGLE BUTTON
-------------------------
local Toggle = Instance.new("TextButton", Gui)
Toggle.Size = UDim2.new(0,50,0,50)
Toggle.Position = UDim2.new(0.05,0,0.5,0)
Toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
Toggle.Text = "RS"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 16
Toggle.TextColor3 = Color3.fromRGB(255,255,255)
Toggle.BorderSizePixel = 0
Toggle.Active = true
Toggle.Draggable = true

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

-------------------------
-- TOGGLE FUNCTION
-------------------------
Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)
