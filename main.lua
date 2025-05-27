local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib(Slider)"))()

local Window = OrionLib:MakeWindow({
    Name = "Main Hack",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "DuplicationConfig"
})

local Tab = Window:MakeTab({
    Name = "Main Hack",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Bagian utama toggle dan slider
local duplicationEnabled = false
local duplicationAmount = 1
local selectedItem = nil

-- Ambil semua item dari Backpack
local player = game.Players.LocalPlayer
local function getBackpackItems()
    local items = {}
    for _, item in ipairs(player.Backpack:GetChildren()) do
        table.insert(items, item.Name)
    end
    return items
end

-- Toggle aktifasi
Tab:AddToggle({
    Name = "Aktifkan Duplikasi",
    Default = false,
    Callback = function(Value)
        duplicationEnabled = Value
    end
})

-- Slider jumlah duplikat
Tab:AddSlider({
    Name = "Jumlah Duplikat",
    Min = 1,
    Max = 10,
    Default = 1,
    Increment = 1,
    ValueName = "kali",
    Callback = function(Value)
        duplicationAmount = Value
    end
})

-- Dropdown pilih item
local itemDropdown = Tab:AddDropdown({
    Name = "Pilih Item dari Backpack",
    Default = "",
    Options = getBackpackItems(),
    Callback = function(Value)
        selectedItem = Value
    end
})

-- Tombol update dropdown jika ada item baru
Tab:AddButton({
    Name = "⟳ Perbarui Daftar Item",
    Callback = function()
        itemDropdown:Refresh(getBackpackItems(), true)
    end
})

-- Tombol untuk menduplikasi
Tab:AddButton({
    Name = "🔁 Duplicate Now",
    Callback = function()
        if duplicationEnabled and selectedItem then
            local item = player.Backpack:FindFirstChild(selectedItem)
            if item then
                for i = 1, duplicationAmount do
                    local clone = item:Clone()
                    clone.Parent = player.Backpack
                end
                OrionLib:MakeNotification({
                    Name = "Berhasil",
                    Content = "Item berhasil diduplikasi x" .. duplicationAmount,
                    Time = 5
                })
            else
                OrionLib:MakeNotification({
                    Name = "Gagal",
                    Content = "Item tidak ditemukan di Backpack!",
                    Time = 5
                })
            end
        else
            OrionLib:MakeNotification({
                Name = "Gagal",
                Content = "Aktifkan toggle dan pilih item dulu!",
                Time = 5
            })
        end
    end
})

OrionLib:Init()
