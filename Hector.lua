-- StarterPlayer > StarterPlayerScripts > LocalScript

-- IDs de animaciones SUBIDAS por ti (propias), formato rbxassetid://ID
local EMOTES = {
    {name = "Rizz", id = "rbxassetid://12345678901"},
    {name = "Skibidi", id = "rbxassetid://12345678902"},
    {name = "Ohio", id = "rbxassetid://12345678903"},
}

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- UI simple
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "EmoteWheel"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 10 + #EMOTES*36)
frame.Position = UDim2.new(0, 20, 0.5, -frame.Size.Y.Offset/2)
frame.BackgroundTransparency = 0.2
frame.Parent = gui

local uiList = Instance.new("UIListLayout", frame)
uiList.Padding = UDim.new(0, 6)
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiList.VerticalAlignment = Enum.VerticalAlignment.Top

local currentTrack

local function playEmote(animId)
    if currentTrack then
        currentTrack:Stop()
        currentTrack:Destroy()
        currentTrack = nil
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    currentTrack = humanoid:LoadAnimation(anim)
    currentTrack.Priority = Enum.AnimationPriority.Action
    currentTrack:Play()
end

for _, emote in ipairs(EMOTES) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Text = "▶ " .. emote.name
    btn.Parent = frame
    btn.MouseButton1Click:Connect(function()
        playEmote(emote.id)
    end)
end

-- Tecla para parar la animación actual
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.X then
        if currentTrack then currentTrack:Stop() end
    end
