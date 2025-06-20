local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Criar GUI
local Gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
Gui.Name = "DARLhubUI"
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame", Gui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 300)
Main.Position = UDim2.new(0.25, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0, 0)

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Título
local Top = Instance.new("Frame", Main)
Top.Name = "Top"
Top.Size = UDim2.new(1, 0, 0, 35)
Top.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -35, 1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "⚔️ DARLhub - Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Center

-- BOTÃO DE MINIMIZAR
local MinimizeBtn = Instance.new("TextButton", Top)
MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 8)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	for _, child in pairs(Main:GetChildren()) do
		if child ~= Top then
			child.Visible = not isMinimized
		end
	end
end)

-- Aba Lateral
local Tabs = Instance.new("Frame", Main)
Tabs.Name = "Tabs"
Tabs.Position = UDim2.new(0, 0, 0, 35)
Tabs.Size = UDim2.new(0, 120, 1, -35)
Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 8)

-- Painel de conteúdo
local Panel = Instance.new("Frame", Main)
Panel.Name = "Panel"
Panel.Position = UDim2.new(0, 120, 0, 35)
Panel.Size = UDim2.new(1, -120, 1, -35)
Panel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- Drag
local dragging, dragInput, dragStart, startPos
Top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
Top.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Sistema de abas
local currentTab = nil
function CreateTab(name, callback)
	local btn = Instance.new("TextButton", Tabs)
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(200, 100, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		callback()
	end)
end

function CreatePage()
	for _, v in ipairs(Panel:GetChildren()) do
		if v:IsA("Frame") then v:Destroy() end
	end
	local Page = Instance.new("Frame", Panel)
	Page.Size = UDim2.new(1, 0, 1, 0)
	Page.BackgroundTransparency = 1
	currentTab = Page
	return Page
end

function CreateToggle(parent, name, callback)
	local Toggle = Instance.new("TextButton", parent)
	Toggle.Size = UDim2.new(0, 200, 0, 30)
	Toggle.Position = UDim2.new(0, 20, 0, #parent:GetChildren() * 35)
	Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Toggle.TextColor3 = Color3.fromRGB(200, 100, 255)
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 14
	Toggle.Text = name .. ": OFF"

	local state = false
	Toggle.MouseButton1Click:Connect(function()
		state = not state
		Toggle.Text = name .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

-- ABA: Auto Farm
CreateTab("🌾 Farm", function()
	local page = CreatePage()
	CreateToggle(page, "Auto Farm", function(state)
		_G.AutoFarm = state
		while _G.AutoFarm do
			task.wait()
			-- código do farm
		end
	end)
end)

-- ABA: Teleporte
CreateTab("🧭 Teleporte", function()
	local page = CreatePage()
	CreateToggle(page, "Ir para Ilha 1", function(state)
		if state then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 20, -50)
		end
	end)
end)

-- ABA: Extras
CreateTab("⚙️ Extras", function()
	local page = CreatePage()
	CreateToggle(page, "Anti Kick", function(state)
		if state then
			local vu = game:GetService("VirtualUser")
			game:GetService("Players").LocalPlayer.Idled:Connect(function()
				vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
				task.wait(1)
				vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			end)
		end
	end)
end)