-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib(Slider)"))()

-- Buat window utama
local Window = OrionLib:MakeWindow({
    Name = "Grow a Garden",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "GrowGardenConfigs",
    IntroEnabled = true,
    IntroText = "Welcome to Grow a Garden!",
    IntroIcon = "rbxassetid://7733960981", -- bisa ganti sesuai selera
    Icon = "rbxassetid://7733960981",
    CloseCallback = function()
        print("Window closed")
    end
})

-- Tab Spawn Seed
local TabSeed = Window:MakeTab({
    Name = "Spawn Seed",
    Icon = "rbxassetid://7734057495",
    PremiumOnly = false
})

local SeedOptions = {
    "BeanStalk",
    "Candy Blossom",
    "Cherry Blossom",
    "Moon Blossom"
}

TabSeed:AddToggle({
    Name = "Spawn Seed",
    Default = false,
    Callback = function(value)
        if value then
            for _, seed in ipairs(SeedOptions) do
                local part = Instance.new("Part", workspace)
                part.Name = seed
                part.Size = Vector3.new(2, 2, 2)
                part.Position = Vector3.new(math.random(-10, 10), 5, math.random(-10, 10))
                part.BrickColor = BrickColor.Random()
                part.Anchored = true
                part.Transparency = 1
                part.CanCollide = false

                local tweenService = game:GetService("TweenService")
                local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                local goal = {Transparency = 0, Position = part.Position + Vector3.new(0, 2, 0)}
                local tween = tweenService:Create(part, info, goal)
                tween:Play()
            end
        else
            for _, seed in ipairs(SeedOptions) do
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj.Name == seed then
                        local tweenService = game:GetService("TweenService")
                        local info = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                        local tween = tweenService:Create(obj, info, {Transparency = 1})
                        tween:Play()
                        tween.Completed:Connect(function()
                            obj:Destroy()
                        end)
                    end
                end
            end
        end
    end
})

-- Tab Spawn Hewan
local TabHewan = Window:MakeTab({
    Name = "Spawn Hewan",
    Icon = "rbxassetid://7734068325",
    PremiumOnly = false
})

local AnimalOptions = {
    "Polar Bear",
    "DragonFly",
    "Racoon",
    "RedFox"
}

TabHewan:AddToggle({
    Name = "Spawn Hewan",
    Default = false,
    Callback = function(value)
        if value then
            for _, animal in ipairs(AnimalOptions) do
                local model = Instance.new("Model", workspace)
                model.Name = animal

                local part = Instance.new("Part", model)
                part.Size = Vector3.new(3, 2, 3)
                part.Position = Vector3.new(math.random(-15, 15), 6, math.random(-15, 15))
                part.BrickColor = BrickColor.Random()
                part.Anchored = true
                part.Transparency = 1
                part.Name = "Body"

                local tweenService = game:GetService("TweenService")
                local info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local goal = {Transparency = 0, Position = part.Position + Vector3.new(0, 2, 0)}
                local tween = tweenService:Create(part, info, goal)
                tween:Play()
            end
        else
            for _, animal in ipairs(AnimalOptions) do
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj:IsA("Model") and obj.Name == animal then
                        local body = obj:FindFirstChild("Body")
                        if body then
                            local tweenService = game:GetService("TweenService")
                            local info = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                            local tween = tweenService:Create(body, info, {Transparency = 1})
                            tween:Play()
                            tween.Completed:Connect(function()
                                obj:Destroy()
                            end)
                        end
                    end
                end
            end
        end
    end
})

-- Inisialisasi UI
OrionLib:Init()
