-- Nexus Hub UI Esqueleto (Mobile Friendly)

local NexusHub = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Criar ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "NexusHub"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- UI Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Text = "Nexus Hub"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.TextScaled = true
title.Parent = mainFrame

-- Aba de botões
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 100, 1, -40)
tabFrame.Position = UDim2.new(0, 0, 0, 40)
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

-- Conteúdo
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, -40)
contentFrame.Position = UDim2.new(0, 100, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- UIGrid para abas
local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Vertical
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabFrame

-- Exemplo de abas
local tabs = {
    "Auto Farm",
    "Player",
    "Teleports",
    "Itens",
    "ESP",
    "Config"
}

local currentTab = nil

local function switchTab(tabName)
    for _, child in pairs(contentFrame:GetChildren()) do
        if child:IsA("Frame") then
            child.Visible = false
        end
    end
    if contentFrame:FindFirstChild(tabName) then
        contentFrame[tabName].Visible = true
    end
end

for _, tabName in pairs(tabs) do
    -- Criar botão da aba
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 30)
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Text = tabName
    tabButton.Parent = tabFrame

    -- Criar conteúdo da aba
    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = contentFrame

    -- Exemplo de Toggle
    local exampleToggle = Instance.new("TextButton")
    exampleToggle.Size = UDim2.new(0, 200, 0, 30)
    exampleToggle.Position = UDim2.new(0, 10, 0, 10)
    exampleToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    exampleToggle.Text = "Toggle de Exemplo (OFF)"
    exampleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    exampleToggle.Parent = tabContent

    local toggled = false
    exampleToggle.MouseButton1Click:Connect(function()
        toggled = not toggled
        exampleToggle.Text = "Toggle de Exemplo (" .. (toggled and "ON" or "OFF") .. ")"
    end)

    tabButton.MouseButton1Click:Connect(function()
        switchTab(tabName)
    end)
end

-- Ativar primeira aba
switchTab(tabs[1])
