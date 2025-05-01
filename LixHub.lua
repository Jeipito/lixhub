--[[  
   Lix Hub v1.0  
   Auto Miner (Ultimate Mining Tycoon)  
   Use: loadstring(game:HttpGet("https://raw.githubusercontent.com/Jeipito/lixhub/main/LixHub.lua"))()  
]]

return function()
    local Players        = game:GetService("Players")
    local RunService     = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer

    -- Criar GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "LixHubUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 120)
    frame.Position = UDim2.new(0, 20, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Text = "🪓 Lix Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -20, 0, 50)
    toggle.Position = UDim2.new(0, 10, 0, 40)
    toggle.Text = "Ativar Auto Minerar"
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 18
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
    toggle.BorderSizePixel = 0
    toggle.Parent = frame

    -- Estado
    local mining = false
    toggle.MouseButton1Click:Connect(function()
        mining = not mining
        if mining then
            toggle.Text = "Desativar Auto Minerar"
            toggle.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
        else
            toggle.Text = "Ativar Auto Minerar"
            toggle.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
        end
    end)

    -- Loop de mineração
    RunService.RenderStepped:Connect(function()
        if not mining then return end
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        local rocks = workspace:FindFirstChild("Rocks")
        local remote = ReplicatedStorage:FindFirstChild("MineEvent")
        if not rocks or not remote then return end

        for _, rock in ipairs(rocks:GetChildren()) do
            if rock:IsA("BasePart") then
                local dist = (rock.Position - char.HumanoidRootPart.Position).Magnitude
                if dist <= 15 then
                    -- dispara o RemoteEvent de mineração
                    pcall(function()
                        remote:FireServer(rock)
                    end)
                    break
                end
            end
        end
    end)
end
