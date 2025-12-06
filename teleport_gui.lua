-- Teleport GUI di Kiri Layar dengan Drag Manual (Kompatibel Android & PC)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

-- GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "TeleportDropdownGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0, 20, 0.4, 0) -- Kiri tengah layar
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true

-- Drag manual (kompatibel Android & PC)
local dragging, dragInput, dragStart, startPos
local function updateInput(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Judul
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Pilih Lokasi Teleport"
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- Tombol dropdown
local dropdown = Instance.new("TextButton", frame)
dropdown.Size = UDim2.new(1, -20, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 40)
dropdown.Text = "Pilih Lokasi"
dropdown.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
dropdown.TextColor3 = Color3.new(1, 1, 1)
dropdown.Font = Enum.Font.SourceSans
dropdown.TextSize = 16

-- Daftar lokasi
local dropdownList = Instance.new("Frame", frame)
dropdownList.Size = UDim2.new(1, -20, 0, 60)
dropdownList.Position = UDim2.new(0, 10, 0, 70)
dropdownList.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
dropdownList.Visible = false

local locations = {
    ["Castaway Cliff"] = Vector3.new(690, 135, -1693),
    ["Carrot Garden"] = Vector3.new(2672, 131, -652)
}

local function teleportTo(pos)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

for name, pos in pairs(locations) do
    local btn = Instance.new("TextButton", dropdownList)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (#dropdownList:GetChildren() - 1) * 30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(function()
        dropdown.Text = name
        dropdownList.Visible = false
        teleportTo(pos)
    end)
end

dropdown.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
end)