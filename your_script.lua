local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "NightFall Hub",
    Icon = 0,
    LoadingTitle = "NightFall",
    LoadingSubtitle = "by MHC201",
    Theme = "Custom",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = true,
        Invite = "NauJg2aT",
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "Booga | Key",
        Subtitle = "Key in Discord server",
        Note = "Join server",
        FileName = "NIGHTFALL_KEY",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/wZS2224n"}
    },

    CustomTheme = {
        Background = Color3.fromRGB(20, 20, 20),
        Topbar = Color3.fromRGB(30, 30, 30),
        TextColor = Color3.fromRGB(200, 100, 255),
        AccentColor = Color3.fromRGB(128, 0, 255),
        ButtonBackground = Color3.fromRGB(40, 40, 40),
        ButtonTextColor = Color3.fromRGB(200, 100, 255),
    }
})

-- Create Tabs and Sections
local MainTab = Window:CreateTab("\ud83c\udfe0Home", nil)
local MainSection = MainTab:CreateSection("Main")

-- Add a new tab for player management
local PlayerTab = Window:CreateTab("\ud83e\uddd1Players", nil)
local PlayerSection = PlayerTab:CreateSection("Player List")

-- Store selected player
local selectedPlayer = nil

-- Dropdown for selecting a player
local playerList = PlayerSection:CreateDropdown({
    Name = "Select a Player",
    Options = {}, -- Dynamically populated
    Callback = function(selected)
        selectedPlayer = game.Players:FindFirstChild(selected)
        if selectedPlayer then
            Rayfield:Notify({
                Title = "Player Selected",
                Content = "You selected: " .. selectedPlayer.Name,
                Duration = 2.5,
                Image = nil,
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Player not found or may have left the game.",
                Duration = 2.5,
                Image = nil,
            })
        end
    end
})

-- Button to kick selected player
PlayerSection:CreateButton({
    Name = "Kick Selected Player",
    Callback = function()
        if selectedPlayer then
            pcall(function()
                selectedPlayer:Kick("Your account has been flagged for suspicious activity.")
            end)
            Rayfield:Notify({
                Title = "Player Kicked",
                Content = selectedPlayer.Name .. " has been kicked.",
                Duration = 2.5,
                Image = nil,
            })
        else
            Rayfield:Notify({
                Title = "No Player Selected",
                Content = "Please select a valid player to kick.",
                Duration = 2.5,
                Image = nil,
            })
        end
    end
})

-- Function to update the player list dynamically
local function updatePlayerList()
    local players = game.Players:GetPlayers()
    local playerNames = {}

    for _, player in pairs(players) do
        if player and player:IsDescendantOf(game) then
            table.insert(playerNames, player.Name)
        end
    end

    pcall(function()
        playerList:SetOptions(playerNames)
    end)
end

-- Update player list when players join or leave
game.Players.PlayerAdded:Connect(function()
    wait(0.5) -- Delay to ensure data is loaded
    updatePlayerList()
end)

game.Players.PlayerRemoving:Connect(function()
    wait(0.5) -- Avoid race conditions
    updatePlayerList()
end)

-- Initial update
updatePlayerList()

-- Speed and Jump Boost Toggle
MainSection:CreateButton("Toggle Speed Boost", function()
    local speedToggle = not speedToggle
    if speedToggle then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16  -- Default speed
    end
end)

MainSection:CreateButton("Toggle Jump Boost", function()
    local jumpToggle = not jumpToggle
    if jumpToggle then
        game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 50  -- Default height
    end
end)

-- Noclip Toggle
MainSection:CreateButton("Toggle Noclip", function()
    local noclipToggle = not noclipToggle
    local character = game.Players.LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if noclipToggle then
        humanoid.PlatformStand = true
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        humanoid.PlatformStand = false
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- ESP (Extrasensory Perception)
MainSection:CreateButton("Toggle ESP", function()
    local espToggle = not espToggle
    if espToggle then
        local function createESP(target)
            local espBox = Instance.new("BoxHandleAdornment")
            espBox.Adornee = target
            espBox.AlwaysOnTop = true
            espBox.ZIndex = 10
            espBox.Size = target.Size + Vector3.new(1, 1, 1)
            espBox.Color3 = Color3.fromRGB(255, 0, 0)
            espBox.Parent = game.CoreGui
        end

        -- Create ESP for all players
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                createESP(player.Character.HumanoidRootPart)
            end
        end
    else
        -- Destroy all ESP boxes when toggled off
        for _, box in pairs(game.CoreGui:GetChildren()) do
            if box:IsA("BoxHandleAdornment") then
                box:Destroy()
            end
        end
    end
end)

-- Notify User
Rayfield:Notify({
   Title = "Injection Complete",
   Content = "NightFall GUI",
   Duration = 4.5,
   Image = nil,
})
