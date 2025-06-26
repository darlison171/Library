local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ShaddowScripts/Main/main/Library"))()

local window = library:CreateWindow("Nexus Test")

local mainTab = window:CreateTab("Main")

mainTab:CreateToggle("Auto Farm", false, function(state)
	print("Auto Farm:", state)
end)

mainTab:CreateToggle("Auto PowerUp", false, function(state)
	print("Auto PowerUp:", state)
end)

mainTab:CreateToggle("Hitbox 50", false, function(state)
	print("Hitbox:", state)
end)

mainTab:CreateButton("Créditos", function()
	print("Feito por Darlison :)")
end)