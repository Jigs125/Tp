-- GUI Teleport dengan Dropdown dan Fitur Float (Draggable)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Buat GUI utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportDropdownGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame utama
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0.5, -110, 0.75, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Ini yang membuat frame bisa digeser
frame.Parent = screenGui

-- Label judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Pilih Lokasi Teleport"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- Dropdown Button
local dropdown = Instance.new("TextButton")
dropdown.Size = UDim2.new(1, -20, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 40)
dropdown.Text = "Pilih Lokasi"
dropdown.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
dropdown.TextColor3 = Color3.new(1, 1, 1)
dropdown.Font = Enum.Font.SourceSans
dropdown.TextSize = 16
dropdown.Parent = frame

-- Dropdown List
local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(1, -20, 0, 60)
dropdownList.Position = UDim2.new(0, 10, 0, 70)
dropdownList.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
dropdownList.Visible = false
dropdownList.Parent = frame

-- Lokasi-lokasi
local locations = {
    ["Castaway Cliff"] = Vector3.new(690, 135, -1693),
    ["Carrot Garden"] = Vector3.new(2672, 131, -652)
}

-- Fungsi teleportasi
local function teleportTo(position)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    else
        warn("Karakter tidak ditemukan atau belum siap.")
    end
end

-- Tambahkan tombol untuk setiap lokasi
for name, pos in pairs(locations) do
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 30)
    option.Position = UDim2.new(0, 0, 0, (#dropdownList:GetChildren() - 1) * 30)
    option.Text = name
    option.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    option.TextColor3 = Color3.new(1, 1, 1)
    option.Font = Enum.Font.SourceSans
    option.TextSize = 16
    option.Parent = dropdownList

    option.MouseButton1Click:Connect(function()
        dropdown.Text = name
        dropdownList.Visible = false
        teleportTo(pos)
    end)
end

-- Toggle dropdown
dropdown.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
end)