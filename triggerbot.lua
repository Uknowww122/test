-- Cargar la Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Configuración principal del menú
OrionLib:MakeNotification({
    Name = "Triggerbot Loader",
    Content = "Bienvenido al triggerbot. Usa el menú para configuraciones.",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Ventana principal del menú
local Window = OrionLib:MakeWindow({
    Name = "Triggerbot Menu",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TriggerbotConfig"
})

-- Variables de Configuración del Triggerbot
local triggerbotEnabled = false
local targetBodyPart = "HumanoidRootPart"
local allPlayersTarget = false
local minDelay = 10
local maxDelay = 30

-- Función para simular clics con delay variable
local function simulateClick()
    local delay = math.random(minDelay, maxDelay) / 1000
    mouse1press()
    wait(delay)
    mouse1release()
end

-- Bypass básico de anticheat
local function antiCheatBypass()
    local randomWait = math.random(1, 5) / 10
    wait(randomWait)
end

-- Función del Triggerbot con bypass
game:GetService("RunService").RenderStepped:Connect(function()
    if triggerbotEnabled then
        local mouse = game.Players.LocalPlayer:GetMouse()
        local target = mouse.Target

        if target and target.Parent:FindFirstChild("Humanoid") then
            local humanoid = target.Parent:FindFirstChild("Humanoid")
            local targetPlayer = game.Players:GetPlayerFromCharacter(target.Parent)

            if (allPlayersTarget or (targetPlayer and targetPlayer.Team ~= game.Players.LocalPlayer.Team)) and humanoid.Health > 0 then
                local bodyPart = target.Parent:FindFirstChild(targetBodyPart)
                if bodyPart then
                    simulateClick()
                    antiCheatBypass()
                    wait(math.random(minDelay, maxDelay) / 100)
                end
            end
        end
    end
end)

-- Sección del Menú para Configuración del Triggerbot
local TriggerTab = Window:MakeTab({
    Name = "Triggerbot",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TriggerTab:AddToggle({
    Name = "Activar Triggerbot",
    Default = false,
    Callback = function(Value)
        triggerbotEnabled = Value
    end    
})

TriggerTab:AddDropdown({
    Name = "Seleccionar Parte del Cuerpo",
    Default = "HumanoidRootPart",
    Options = {"Head", "UpperTorso", "HumanoidRootPart", "LeftLeg", "RightLeg"},
    Callback = function(Value)
        targetBodyPart = Value
    end    
})

TriggerTab:AddToggle({
    Name = "Atacar a Todos los Jugadores",
    Default = false,
    Callback = function(Value)
        allPlayersTarget = Value
    end    
})

TriggerTab:AddSlider({
    Name = "Delay Mínimo (ms)",
    Min = 5,
    Max = 50,
    Default = 10,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "ms",
    Callback = function(Value)
        minDelay = Value
    end    
})

TriggerTab:AddSlider({
    Name = "Delay Máximo (ms)",
    Min = 10,
    Max = 100,
    Default = 30,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "ms",
    Callback = function(Value)
        maxDelay = Value
    end    
})

-- Notificación de que el menú está listo
OrionLib:Init()
