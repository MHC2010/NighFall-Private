local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the Rayfield Window
local Window = Rayfield:CreateWindow({
    Name = "NightFall Hub",
    Icon = 0, -- No icon in the topbar
    LoadingTitle = "NightFall",
    LoadingSubtitle = "by MHC201",
    Theme = "Default", -- Default theme for the window

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevent version mismatch warnings

    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- Custom folder name for saving the configuration
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = true, -- Prompt user to join the Discord server
        Invite = "NauJg2aT", -- Discord invite code
        RememberJoins = true -- Remember the user's Discord join status
    },

    KeySystem = true, -- Enable key system for access control
    KeySettings = {
        Title = "Booga | key",
        Subtitle = "Key in discord server",
        Note = "Join server", -- Instructions for how to obtain a key
        FileName = "NIGHTFALL KEY", -- Unique file name for key saving
        SaveKey = true, -- Save the user's key
        GrabKeyFromSite = true, -- Fetch the key from the specified link
        Key = {"https://pastebin.com/raw/wZS2224n"} -- Link to the raw key file (or simple key strings)
    }
})

-- Create the Home Tab
local MainTab = Window:CreateTab("🏠Home", nil)

-- Create a section within the Home tab
local MainSection = MainTab:CreateSection("Main")

-- Infinite Jump logic
local canJump = false
local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")

local function toggleJump()
    canJump = not canJump
    if canJump then
        print("Infinite Jump ON")
    else
        print("Infinite Jump OFF")
    end
end

local function onJumpRequest()
    if canJump and humanoid:GetState() == Enum.HumanoidStateType.Physics then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        humanoid:Move(Vector3.new(0, 50, 0))  -- This will give the jump force
    end
end

-- Add Infinite Jump Button
MainTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        toggleJump()
    end
})

-- Fly logic
local flying = false
local bodyVelocity

local function toggleFly()
    flying = not flying
    local character = game.Players.LocalPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if flying then
        -- Start flying
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)  -- Initial upward force
        bodyVelocity.Parent = humanoidRootPart

        -- Enable controls for movement
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Space then
                    bodyVelocity.Velocity = Vector3.new(0, 50, 0)  -- Moving upwards
                elseif input.KeyCode == Enum.KeyCode.W then
                    bodyVelocity.Velocity = Vector3.new(0, 50, -50)  -- Forward
                elseif input.KeyCode == Enum.KeyCode.S then
                    bodyVelocity.Velocity = Vector3.new(0, 50, 50)  -- Backward
                elseif input.KeyCode == Enum.KeyCode.A then
                    bodyVelocity.Velocity = Vector3.new(-50, 50, 0)  -- Left
                elseif input.KeyCode == Enum.KeyCode.D then
                    bodyVelocity.Velocity = Vector3.new(50, 50, 0)  -- Right
                end
            end
        end)
        print("Flying ON")
    else
        -- Stop flying
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
        print("Flying OFF")
    end
end

-- Add Fly Button
MainTab:CreateButton({
    Name = "Fly",
    Callback = function()
        toggleFly()
    end
})

-- Speed Slider
local speedSlider = MainTab:CreateSlider({
    Name = "Set Speed",
    Range = {16, 200}, -- Range of speed values (default walk speed is 16)
    Increment = 1, -- Step increment
    Default = 16, -- Default speed
    Callback = function(value)
        humanoid.WalkSpeed = value
    end
})

-- Kick Player Feature
MainTab:CreateSection("Admin Features")

local playerTextbox = MainTab:CreateTextBox({
    Name = "Enter Username to Kick",
    Text = "",
    PlaceholderText = "Username",
    Callback = function(username)
        -- Kick player with the specified username
        local targetPlayer = game.Players:FindFirstChild(username)
        if targetPlayer then
            targetPlayer:Kick("Kicked by admin")
            print("Player " .. username .. " has been kicked.")
        else
            print("Player not found.")
        end
    end
})

-- Add Kick Button to execute kick
MainTab:CreateButton({
    Name = "Kick Player",
    Callback = function()
        local username = playerTextbox.Text
        local targetPlayer = game.Players:FindFirstChild(username)
        if targetPlayer then
            targetPlayer:Kick("Kicked by admin")
            print("Player " .. username .. " has been kicked.")
        else
            print("Player not found.")
        end
    end
})

-- Notify the user once the GUI has been loaded
Rayfield:Notify({
    Title = "Injection complete",
    Content = "NightFall GUI",
    Duration = 4.5, -- Notification duration in seconds
    Image = nil, -- No image in the notification
})

-- Connect the JumpRequest event to trigger infinite jump
game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jumping:Connect(onJumpRequest)
