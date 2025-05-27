local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib(Slider)')))()

local Window = OrionLib:MakeWindow({
    Name = "Main Hack",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MainHackConfig"
})

local MainTab = Window:MakeTab({
    Name = "Main Hack",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Fungsi duplikasi item
local function duplicateItem()
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    local originalItem = backpack:FindFirstChild("ItemNameHere") -- Ganti dengan nama item sebenarnya

    if originalItem then
        local clonedItem = originalItem:Clone()
        clonedItem.Parent = backpack
        print("Item duplicated successfully!")
    else
        print("Item not found.")
    end
end

-- Toggle untuk mengaktifkan duplikasi
MainTab:AddToggle({
    Name = "DuplicationItem",
    Default = false,
    Callback = function(Value)
        if Value then
            duplicateItem()
        end
    end
})

-- Slider (opsional, untuk mengatur berapa kali duplikasi dilakukan)
MainTab:AddSlider({
    Name = "DuplicationItem",
    Min = 1,
    Max = 10,
    Default = 1,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "times",
    Callback = function(value)
        -- Fungsi yang bisa kamu gunakan nanti, misalnya:
        for i = 1, value do
            duplicateItem()
        end
    end
})

OrionLib:Init()
