--// Raider Spammer
--// Clean Toggle Menu | Black UI | Text Only
--// With Discord link + Buy text

-------------------------
-- CLEANUP
-------------------------
if game.CoreGui:FindFirstChild("RaiderSpammerUI") then
	game.CoreGui.RaiderSpammerUI:Destroy()
end

-------------------------
-- GUI
-------------------------
local Gui = Instance.new("ScreenGui")
Gui.Name = "RaiderSpammerUI"
Gui.Parent = game.CoreGui

-------------------------
-- MAIN MENU
-------------------------
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,340,0,230)
Main.Position = UDim2.new(0.5,-170,0.5,-115)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.BorderSizePixel = 0
Main.Visible = true
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,20)

-------------------------
-- TITLE
-------------------------
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,60)
Title.BackgroundTransparency = 1
Title.Text = "Raider Spammer"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)

-------------------------
-- DIVIDER
-------------------------
local Line1 = Instance.new("Frame", Main)
Line1.Size = UDim2.new(0.85,0,0,1)
Line1.Position = UDim2.new(0.075,0,0,65)
Line1.BackgroundColor3 = Color3.fromRGB(40,40,40)
Line1.BorderSizePixel = 0

-------------------------
-- DISCORD TEXT
-------------------------
local DiscordText = Instance.new("TextLabel", Main)
DiscordText.Size = UDim2.new(1,-40,0,50)
DiscordText.Position = UDim2.new(0,20,0,80)
DiscordText.BackgroundTransparency = 1
DiscordText.TextWrapped = true
DiscordText.Text = "Discord:\nhttps://discord.gg/VHTBMZfWX"
DiscordText.Font = Enum.Font.Gotham
DiscordText.TextSize = 14
DiscordText.TextColor3 = Color3.fromRGB(255,255,255)

-------------------------
-- DIVIDER 2
-------------------------
local Line2 = Instance.new("Frame", Main)
Line2.Size = UDim2.new(0.85,0,0,1)
Line2.Position = UDim2.new(0.075,0,0,140)
Line2.BackgroundColor3 = Color3.fromRGB(40,40,40)
Line2.BorderSizePixel = 0

-------------------------
-- BUY TEXT
-------------------------
local BuyText = Instance.new("TextLabel", Main)
BuyText.Size = UDim2.new(1,0,0,30)
BuyText.Position = UDim2.new(0,0,0,150)
BuyText.BackgroundTransparency = 1
BuyText.Text = "Buy Rider"
BuyText.Font = Enum.Font.GothamBold
BuyText.TextSize = 18
BuyText.TextColor3 = Color3.fromRGB(255,255,255)

-------------------------
-- TOGGLE BUTTON
-------------------------
local Toggle = Instance.new("TextButton", Gui)
Toggle.Size = UDim2.new(0,60,0,60)
Toggle.Position = UDim2.new(0.05,0,0.5,-30)
Toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
Toggle.Text = "RS"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 18
Toggle.TextColor3 = Color3.fromRGB(255,255,255)
Toggle.Active = true
Toggle.Draggable = true

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

Toggle.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)
