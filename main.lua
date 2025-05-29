-- Booting Orion Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib(Slider)')))()

-- Membuat window utama
local Window = OrionLib:MakeWindow({
    Name = "Grow A Garden Inventory",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GrowAGardenConfig"
})

-- Membuat tab untuk stok
local Tab = Window:MakeTab({
    Name = "Inventory",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Label untuk gear, egg, dan seed (update nanti)
local GearLabel = Tab:AddLabel("Gear: Loading...")
local EggLabel = Tab:AddLabel("Egg: Loading...")
local SeedLabel = Tab:AddLabel("Seed: Loading...")

-- Fungsi untuk update stok (ganti sesuai data Grow A Garden)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function UpdateInventory()
    local gearCount = 0
    local eggCount = 0
    local seedCount = 0

    -- Contoh ambil data gear dari Backpack
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        gearCount = #backpack:GetChildren()
    end

    -- Contoh ambil data egg dan seed dari folder Inventory
    local inventory = player:FindFirstChild("Inventory")
    if inventory then
        local eggs = inventory:FindFirstChild("Eggs")
        if eggs then eggCount = #eggs:GetChildren() end
        local seeds = inventory:FindFirstChild("Seeds")
        if seeds then seedCount = #seeds:GetChildren() end
    end

    GearLabel:Set("Gear: " .. tostring(gearCount))
    EggLabel:Set("Egg: " .. tostring(eggCount))
    SeedLabel:Set("Seed: " .. tostring(seedCount))
end

-- Update stok setiap 2 detik
spawn(function()
    while true do
        UpdateInventory()
        wait(2)
    end
end)

-- Inisialisasi UI Orion
OrionLib:Init()
