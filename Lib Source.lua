-- Carregar a Luna UI Library
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua"))()

-- Criar a janela
local Window = Luna:CreateWindow("Nexus Hub", Vector2.new(500, 400), Enum.KeyCode.RightControl)

-- Criar as abas
local MainTab = Window:CreateTab("Main")
local FarmTab = Window:CreateTab("Auto Farm")
local PlayerTab = Window:CreateTab("Player")
local VisualTab = Window:CreateTab("Visual")
local TeleportTab = Window:CreateTab("Teleport")
local ConfigTab = Window:CreateTab("Config")

-- Adicionar Toggles e Botões de Exemplo
MainTab:AddLabel("Bem-vindo ao Nexus Hub!")
MainTab:AddButton("Exemplo de Botão", function()
    print("Botão clicado!")
end)

FarmTab:AddToggle("Auto Farm Ativado", false, function(value)
    print("Auto Farm:", value)
end)

PlayerTab:AddSlider("Velocidade do Jogador", 16, 100, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

VisualTab:AddToggle("ESP Ativado", false, function(value)
    print("ESP:", value)
end)

TeleportTab:AddButton("Ir para o Spawn", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
end)

ConfigTab:AddKeybind("Abrir/Fechar UI", Enum.KeyCode.RightControl, function()
    Window:Toggle()
end)

-- UI ativada
print("Nexus Hub carregado com sucesso!")
