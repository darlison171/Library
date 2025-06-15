-- Carregar WindUI (base da UI moderna)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/WindUI.lua"))()

-- Criar janela principal
local Window = WindUI:CreateWindow("🌌 Nexus Hub", Color3.fromRGB(135, 0, 255))

-- Criar abas
local AutoTab = Window:CreateTab("🌱 Auto")
local ToolsTab = Window:CreateTab("🛠️ Ferramentas")
local ConfigTab = Window:CreateTab("⚙️ Config")

-- Definir URL do script externo
local ScriptURL = "https://pastebin.com/raw/PaDr9Evs"
loadstring(game:HttpGet(ScriptURL))() -- Carrega o script

-- Auto: funções principais
AutoTab:AddToggle("Auto Plant", false, function(state)
    getgenv().AutoPlant = state
end)

AutoTab:AddToggle("Auto Harvest", false, function(state)
    getgenv().AutoHarvest = state
end)

AutoTab:AddToggle("Auto Water", false, function(state)
    getgenv().AutoWater = state
end)

AutoTab:AddToggle("Auto Sell", false, function(state)
    getgenv().AutoSell = state
end)

-- Ferramentas adicionais
ToolsTab:AddButton("🔄 Recarregar Script", function()
    loadstring(game:HttpGet(ScriptURL))()
end)

ToolsTab:AddToggle("Mostrar Nome dos Mobs", false, function(state)
    getgenv().ShowMobs = state
end)

-- Configuração e controle da UI
ConfigTab:AddButton("🔽 Minimizar", function()
    Window:Toggle()
end)

ConfigTab:AddButton("❌ Fechar", function()
    Window:Close()
end)

-- Criar botão flutuante para reabrir a UI
local FloatingButton = Instance.new("TextButton")
FloatingButton.Text = "🧩"
FloatingButton.Size = UDim2.new(0, 40, 0, 40)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -20)
FloatingButton.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
FloatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingButton.TextScaled = true
FloatingButton.Draggable = true
FloatingButton.Active = true
FloatingButton.BorderSizePixel = 0
FloatingButton.Parent = game:GetService("CoreGui")

FloatingButton.MouseButton1Click:Connect(function()
    Window:Toggle()
end)