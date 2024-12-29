-- Attempt to load Rayfield GUI
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

-- Check if the loading was successful
if not success then
    warn("Failed to load Rayfield GUI: " .. Rayfield)
else
    -- Create the main window
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
            Invite = "NauJg2aT",  -- Correct Discord Invite
            RememberJoins = true
        },
        KeySystem = true,
        KeySettings = {
            Title = "Booga | key",
            Subtitle = "Key in discord server",
            Note = "Join server",
            FileName = "NIGHTFALL_KEY",
            SaveKey = true,
            GrabKeyFromSite = true,
            Key = {"https://pastebin.com/raw/wZS2224n"}  -- Correct Key URL
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
    local MainTab = Window:CreateTab("🏠Home", nil)
    local MainSection = MainTab:CreateSection("Main")

    -- Add a simple test button to see if it works
    MainSection:CreateButton("Test Button", function()
        print("Test Button clicked!")
    end)

    -- Add a new tab for player management
    local PlayerTab = Window:CreateTab("🧑Players", nil)
    local PlayerSection = PlayerTab:CreateSection("Player List")

    -- Store selected player
    local selectedPlayer = nil

    -- Add a scrollable container to list players
    local playerList = PlayerSection:CreateDropdown({
        Name = "Select a Player",
        Options = {}, -- Options will be dynamically populated
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

    -- Update player list whenever players join or leave
    game.Players.PlayerAdded:Connect(function()
        wait(0.5) -- Slight delay to ensure player data is loaded
        updatePlayerList()
    end)

    game.Players.PlayerRemoving:Connect(function()
        wait(0.5) -- Slight delay to avoid race conditions
        updatePlayerList()
    end)

    -- Initial update
    updatePlayerList()

    -- Speed Boost Button
    local speed = 50
    local speedToggle = false

    local speedButton = MainSection:CreateButton("Toggle Speed Boost", function()
        speedToggle = not speedToggle
        if speedToggle then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16  -- Default speed
        end
    end)

    -- Jump Boost Button
    local jump = 50
    local jumpToggle = false

    local jumpButton = MainSection:CreateButton("Toggle Jump Boost", function()
        jumpToggle = not jumpToggle
        if jumpToggle then
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = jump
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 50  -- Default jump height
        end
    end)

    -- Noclip Button
    local noclipToggle = false
    local noclipButton = MainSection:CreateButton("Toggle Noclip", function()
        noclipToggle = not noclipToggle
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

    -- ESP Button
    local espToggle = false
    local espButton = MainSection:CreateButton("Toggle ESP", function()
        espToggle = not espToggle
        if espToggle then
            -- Function to create ESP with some basic obfuscation
            local function createESP(target)
                local espBox = Instance.new("BoxHandleAdornment")
                espBox.Adornee = target
                espBox.AlwaysOnTop = true
                espBox.ZIndex = 10
                espBox.Size = target.Size + Vector3.new(1, 1, 1)
                espBox.Color3 = Color3.fromRGB(255, 0, 0)
                espBox.Parent = game.CoreGui
                -- Obfuscate part destruction by using a decoy event
                local decoyEvent = target.AncestryChanged:Connect(function()
                    if not target.Parent then
                        espBox:Destroy()
                        decoyEvent:Disconnect()  -- Cleanup to prevent memory leaks
                    end
                end)
            end

            -- Scan for all players and create ESP
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

    -- Notify User that the GUI is loaded
    Rayfield:Notify({
        Title = "Injection complete",
        Content = "NightFall GUI",
        Duration = 4.5,
        Image = nil,
    })
end
