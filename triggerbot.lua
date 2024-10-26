-- Cargar Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Configuración de Triggerbot
local triggerbotEnabled = false
local targetBodyPart = "HumanoidRootPart"  -- Opciones: "Head", "UpperTorso", "HumanoidRootPart", etc.
local allPlayersTarget = false  -- Cambia a `true` para atacar a todos los jugadores
local minDelay = 10  -- Delay mínimo entre clics en ms
local maxDelay = 30  -- Delay máximo entre clics en ms

-- Activa el Triggerbot con el botón derecho del mouse
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        triggerbotEnabled = true
    end
end)

-- Desactiva el Triggerbot cuando se suelta el botón derecho del mouse
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        triggerbotEnabled = false
    end
end)

-- Función para simular clic humano con variación
local function simulateClick()
    local delay = math.random(minDelay, maxDelay) / 1000  -- Delay entre 10ms y 30ms
    mouse1press()
    wait(delay)
    mouse1release()
end

-- Bypass básico de anticheat (variaciones de delay y detección)
local function antiCheatBypass()
    local randomWait = math.random(1, 5) / 10  -- Variación aleatoria de espera entre 100ms y 500ms
    wait(randomWait)
end

-- Función del Triggerbot con verificación de vida y bypass de anticheat
game:GetService("RunService").RenderStepped:Connect(function()
    if triggerbotEnabled then
        local mouse = game.Players.LocalPlayer:GetMouse()
        local target = mouse.Target

        if target and target.Parent:FindFirstChild("Humanoid") then
            local humanoid = target.Parent:FindFirstChild("Humanoid")
            local targetPlayer = game.Players:GetPlayerFromCharacter(target.Parent)

            -- Verifica si el objetivo es un jugador enemigo o todos los jugadores según configuración
            if (allPlayersTarget or (targetPlayer and targetPlayer.Team ~= game.Players.LocalPlayer.Team)) and humanoid.Health > 0 then
                local bodyPart = target.Parent:FindFirstChild(targetBodyPart)

                -- Si se encuentra la parte del cuerpo especificada, dispara
                if bodyPart then
                    simulateClick()  -- Ejecuta el clic con variación
                    antiCheatBypass()  -- Añade un delay variable para bypass de anticheat
                    wait(math.random(minDelay, maxDelay) / 100)  -- Variación entre disparos
                end
            end
        end
    end
end)

-- Configuración adicional del menú
print("Triggerbot activado. Opciones:")
print("- Presiona botón derecho del mouse para activar")
print("- Cambia `targetBodyPart` para seleccionar cabeza, torso o cualquier otra parte")
print("- Cambia `allPlayersTarget` a `true` para atacar a todos")

            end
        end
    end
end)
