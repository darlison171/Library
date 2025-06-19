local Player = game.Players.LocalPlayer
local Gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
Gui.Name = "DARLhubUI"
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local Main = Instance.new("Frame", Gui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 600, 0, 350)
Main.Position = UDim2.new(0.5, -300, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0.5, 0.5)

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

-- Title Bar
local Top = Instance.new("Frame", Main)
Top.Name = "Top"
Top.Size = UDim2.new(1, 0, 0, 35)
Top.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "⚔️ DARLhub - Blox Fruits"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- Tabs (Lateral)
local Tabs = Instance.new("Frame", Main)
Tabs.Name = "Tabs"
Tabs.Position = UDim2.new(0, 0, 0, 35)
Tabs.Size = UDim2.new(0, 120, 1, -35)
Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 8)

-- Main Panel
local Panel = Instance.new("Frame", Main)
Panel.Name = "Panel"
Panel.Position = UDim2.new(0, 120, 0, 35)
Panel.Size = UDim2.new(1, -120, 1, -35)
Panel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

-- Função de criação de botão de aba
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

-- Função para criar uma página de conteúdo
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

-- Função de toggle
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
CreateTab("🌾 Auto Farm", function()
	local page = CreatePage()
	CreateToggle(page, "Auto Farm", function(state)
		_G.AutoFarm = state
		while _G.AutoFarm do
			task.wait()
			-- auto farm code
		end
	end)
	CreateToggle(page, "Farm Mastery", function(state)
		_G.FarmMastery = state
	end)
end)

-- ABA: Teleporte
CreateTab("🧭 Teleporte", function()
	local page = CreatePage()
	CreateToggle(page, "Teleport Ilha 1", function(state)
		if state then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 20, -50)
		end
	end)
	CreateToggle(page, "Teleport Ilha 2", function(state)
		if state then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(500, 50, 600)
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
