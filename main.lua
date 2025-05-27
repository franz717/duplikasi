local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib(Slider)')))()

local Window = OrionLib:MakeWindow({
    Name = "Grow A Garden",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GrowAGardenUI",
    IntroEnabled = true,
    IntroText = "Grow A Garden 🌱",
    IntroIcon = "rbxassetid://7733964640", -- Optional custom icon
    Icon = "rbxassetid://7733964640"
})

-- TAB: Spawn Seed
local TabSeed = Window:MakeTab({
    Name = "Spawn Seed",
    Icon = "rbxassetid://7734053491",
    PremiumOnly = false
})

TabSeed:AddSection({Name = "Pilih Seed"})

local seedDropdown = TabSeed:AddDropdown({
    Name = "Jenis Seed",
    Default = "BeanStalk",
    Options = {"BeanStalk", "Candy Blossom", "Cherry Blossom", "Moon Blossom"},
    Callback = function(Value)
        print("Seed dipilih:", Value)
    end
})

TabSeed:AddTextbox({
    Name = "Atau Ketik Nama Seed",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        print("Seed diketik:", Value)
        seedDropdown:Set(Value)
    end
})

TabSeed:AddToggle({
    Name = "Spawn Seed",
    Default = false,
    Callback = function(Value)
        if Value then
            print("Menyspawn seed:", OrionLib.Flags["jenisSeed"].Value or "Tidak ada")
            -- Tambahkan animasi spawn jika perlu
        else
            print("Spawn seed dimatikan")
        end
    end,
    Flag = "spawnSeedToggle",
    Save = true
})

-- TAB: Spawn Hewan
local TabHewan = Window:MakeTab({
    Name = "Spawn Hewan",
    Icon = "rbxassetid://7734057493",
    PremiumOnly = false
})

TabHewan:AddSection({Name = "Pilih Hewan"})

local animalDropdown = TabHewan:AddDropdown({
    Name = "Jenis Hewan",
    Default = "Polar Bear",
    Options = {"Polar Bear", "DragonFly", "Racoon", "RedFox"},
    Callback = function(Value)
        print("Hewan dipilih:", Value)
    end
})

TabHewan:AddTextbox({
    Name = "Atau Ketik Nama Hewan",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        print("Hewan diketik:", Value)
        animalDropdown:Set(Value)
    end
})

TabHewan:AddToggle({
    Name = "Spawn Hewan",
    Default = false,
    Callback = function(Value)
        if Value then
            print("Menyspawn hewan:", OrionLib.Flags["jenisHewan"].Value or "Tidak ada")
            -- Tambahkan animasi spawn jika perlu
        else
            print("Spawn hewan dimatikan")
        end
    end,
    Flag = "spawnAnimalToggle",
    Save = true
})

-- OPTIONAL: Tombol tutup UI
TabHewan:AddButton({
    Name = "Tutup UI",
    Callback = function()
        OrionLib:Destroy()
        print("UI ditutup")
    end
})

OrionLib:Init()
