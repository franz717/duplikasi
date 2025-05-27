local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib"))()

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

local player = game.Players.LocalPlayer

-- Daftar valid item untuk spawn (no visual)
local validEggs = {
    ["Bug Egg"] = true,
    ["Mythical Egg"] = true,
    ["Legendary Egg"] = true,
}

local validAnimals = {
    ["Racoon"] = true,
    ["Red Fox"] = true,
}

local validSeeds = {
    ["Candy Blossom"] = true,
    ["Moon Blossom"] = true,
    ["Cherry Blossom"] = true,
}

-- Fungsi spawn item tanpa UI, non-visual
local function spawnItem(category, itemName, amount)
    amount = amount or 1

    if category == "egg" and not validEggs[itemName] then
        warn("Egg tidak valid: "..tostring(itemName))
        return
    elseif category == "hewan" and not validAnimals[itemName] then
        warn("Hewan tidak valid: "..tostring(itemName))
        return
    elseif category == "seed" and not validSeeds[itemName] then
        warn("Seed tidak valid: "..tostring(itemName))
        return
    elseif category == "tanaman" then
        warn("Kategori 'tanaman' tidak didukung.")
        return
    elseif category ~= "egg" and category ~= "hewan" and category ~= "seed" then
        warn("Kategori spawn tidak dikenali: "..tostring(category))
        return
    end

    -- Cari container yang sesuai, atau fallback ke Backpack
    local container
    if category == "egg" then
        container = player.Backpack:FindFirstChild("Eggs") or player.Backpack
    elseif category == "hewan" then
        container = player.Backpack:FindFirstChild("Pets") or player.Backpack
    elseif category == "seed" then
        container = player.Backpack:FindFirstChild("Seeds") or player.Backpack
    end

    if not container then
        warn("Container untuk kategori "..category.." tidak ditemukan.")
        return
    end

    -- Cari item di container
    local item = container:FindFirstChild(itemName)
    if not item then
        warn("Item '"..itemName.."' tidak ditemukan di "..category)
        return
    end

    -- Spawn clone sebanyak amount
    for i = 1, amount do
        local clone = item:Clone()
        clone.Parent = container
    end

    print("Spawned "..amount.." "..itemName.." ("..category..") tanpa visual")
end

-- Fungsi ambil item Backpack untuk dropdown
local function getBackpackItems()
    local items = {}
    for _, item in ipairs(player.Backpack:GetChildren()) do
        table.insert(items, item.Name)
    end
    return items
end

-- Toggle aktifasi duplikasi
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

-- Dropdown pilih item dari Backpack
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

-- **Catatan penggunaan spawnItem di console atau script:**
-- Contoh:
-- spawnItem("egg", "Bug Egg", 2)
-- spawnItem("hewan", "Racoon", 1)
-- spawnItem("seed", "Candy Blossom", 3)
-- spawnItem("tanaman", "Anything", 1) -- Tidak akan jalan karena tanaman ditiadakan

