-- Carregar a Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- Criar a janela principal
local Janela = Rayfield:CreateWindow({
    Name = "💪 Muscle Legends - Teste de UI",
    LoadingTitle = "Iniciando UI...",
    LoadingSubtitle = "Aguarde...",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- Criar uma aba
local Aba = Janela:CreateTab("Principal", 4483362458)

-- Criar uma seção e botão de teste
Aba:CreateSection("Teste de Botão")

Aba:CreateButton({
    Name = "Clique para testar",
    Callback = function()
        Rayfield:Notify({
            Title = "Sucesso!",
            Content = "A UI está funcionando perfeitamente!",
            Duration = 4,
            Image = 4483362458
        })
    end
})