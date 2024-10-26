local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Prueba Orion Library",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TestConfig"
})

Window:MakeTab({
    Name = "Tab de Prueba",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

OrionLib:Init()
