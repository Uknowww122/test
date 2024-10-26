-- Cargar Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Configuración del triggerbot
local triggerbotEnabled = false
local aimPart = "Head"
local teamMode = true
local minDelay = 10
local maxDelay = 30
local lifeCheck = true

-- Crear ventana de menú
local Window = Library.CreateLib("Triggerbot Menu", "DarkTheme")

-- Pestaña para Triggerbot
local Tab = Window:NewTab("Triggerbot")

-- Sección para activar/desactivar
local Section = Tab:NewSection("Activar Triggerbot")
Section:NewToggle("Habilitar Triggerbot", "Activa o desactiva el triggerbot", function(state)
    triggerbotEnabled = state
end)

-- Selección de parte del cuerpo
Section:NewDropdown("Parte del Cuerpo", "Elige entre cabeza o torso", {"Head", "Torso"}, function(currentOption)
    aimPart = currentOption
end)

-- Modo de Equipos o Todos contra Todos
Section:NewToggle("Modo de Equipos", "Activa para solo atacar a enemigos de otros equipos", function(state)
    teamMode = state
end)

-- Configuración de Delay
Section:NewSlider("Min Delay (ms)", "Configura el delay mínimo", 5, 50, function(value)
    minDelay = value
end)
Section:NewSlider("Max Delay (ms)", "Configura el delay máximo", 10, 100, function(value)
    maxDelay = value
end)

-- Verificación de vida del objetivo
Section:NewToggle("Verificación de Vida", "Solo dispara si el objetivo está vivo", function(state)
    lifeCheck = state
end)

-- Función que simula un clic humano con variación
local function simulateClick()
    local delay = math.random(minDelay, maxDelay) / 1000  -- Variación de delay
    mouse1press()
    wait(delay)
    mouse1release()
end

-- Función del Triggerbot
game:GetService("RunService").RenderStepped:Connect(function()
    if triggerbotEnabled then
        local mouse = game.Players.LocalPlayer:GetMouse()
        local target = mouse.Target

        if target and target.Parent:FindFirstChild("Humanoid") then
            local humanoid = target.Parent:FindFirstChild("Humanoid")
            local targetPlayer = game.Players:GetPlayerFromCharacter(target.Parent)

            -- Verifica el equipo, la vida y la parte del cuerpo objetivo
            if (not teamMode or (targetPlayer and targetPlayer.Team ~= game.Players.LocalPlayer.Team)) 
                and humanoid.Health > 0 and target.Name == aimPart then
                simulateClick()
                wait(math.random(minDelay, maxDelay) / 100)  -- Delay variable entre clics
            end
        end
    end
end)
