-- GUI pequena com Toggle estilo “Chilli Float”

local player = game.Players.LocalPlayer

-- Cria a ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NexScriptsGUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 40)
Frame.Position = UDim2.new(0.5, -90, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0)
Frame.Parent = ScreenGui

-- Bordas arredondadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

-- Ícone
local Icon = Instance.new("ImageLabel")
Icon.Size = UDim2.new(0, 24, 0, 24)
Icon.Position = UDim2.new(0, 8, 0.5, -12)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://10168905532" -- 🔥 exemplo de ícone
Icon.Parent = Frame

-- Label
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(0, 100, 0, 40)
Label.Position = UDim2.new(0, 40, 0, 0)
Label.BackgroundTransparency = 1
Label.Text = "Nex Scripts"
Label.TextColor3 = Color3.fromRGB(255,255,255)
Label.Font = Enum.Font.SourceSansBold
Label.TextSize = 16
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Parent = Frame

-- Toggle
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0, 36, 0, 20)
Toggle.Position = UDim2.new(1, -46, 0.5, -10)
Toggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
Toggle.Text = ""
Toggle.AutoButtonColor = false
Toggle.Parent = Frame

local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(0, 10)
ToggleUICorner.Parent = Toggle

-- Pequeno círculo interno
local Circle = Instance.new("Frame")
Circle.Size = UDim2.new(0, 16, 0, 16)
Circle.Position = UDim2.new(0, 2, 0, 2)
Circle.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
Circle.Parent = Toggle
local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(0, 8)
CircleCorner.Parent = Circle

-- Estado do Toggle
local toggled = false
local blocoFlutuar = nil
local blocoConn = nil

-- Função para ativar/desativar flutuar
local function setFlutuar(enabled)
    if enabled then
        -- Cria bloco se não existir
        if blocoFlutuar then blocoFlutuar:Destroy() end
        blocoFlutuar = Instance.new("Part")
        blocoFlutuar.Name = "BlocoFlutuar_"..player.Name
        blocoFlutuar.Size = Vector3.new(6, 1, 6)
        blocoFlutuar.Anchored = true
        blocoFlutuar.CanCollide = true
        blocoFlutuar.Color = Color3.fromRGB(100, 200, 255)
        blocoFlutuar.Material = Enum.Material.Neon
        blocoFlutuar.Parent = workspace

        -- Loop para manter bloco embaixo
        blocoConn = game:GetService("RunService").Heartbeat:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                blocoFlutuar.Position = hrp.Position - Vector3.new(0, hrp.Size.Y/2 + 2, 0)
            end
        end)
    else
        if blocoConn then blocoConn:Disconnect() blocoConn = nil end
        if blocoFlutuar then blocoFlutuar:Destroy() blocoFlutuar = nil end
    end
end

local function updateToggleState()
    if toggled then
        Circle.Position = UDim2.new(0, 18, 0, 2)
        Toggle.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
        setFlutuar(true)
    else
        Circle.Position = UDim2.new(0, 2, 0, 2)
        Toggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        setFlutuar(false)
    end
end

Toggle.MouseButton1Click:Connect(function()
    toggled = not toggled
    updateToggleState()
end)

-- Bind da tecla F
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.F and not gameProcessedEvent then
        toggled = not toggled
        updateToggleState()
    end
end)

-- Inicializa o estado do toggle
updateToggleState()

