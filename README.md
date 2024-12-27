local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NightFall Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "NightFall",
   LoadingSubtitle = "by MHC201",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "https://discord.gg/NauJg2aT", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Booga | key",
      Subtitle = "Key in discord server",
      Note = "Join server", -- Use this to tell the user how to get a key
      FileName = "NIGHTFALL KEY", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/wZS2224n"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠Home", nil) -- Title, Image
local MainSection = MainTabTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Injection complete",
   Content = "NightFall gui",
   Duration = 4.5,
   Image = nil,
})

-- Infinite Jump Toggle Button
local Button = MainTab:CreateButton({
    Name = "Infinite Jump Toggle",
    Callback = function()
        -- Toggles the infinite jump between on or off on every script run
        _G.infinjump = not _G.infinjump

   if _G.infinjump and _G.infinJumpStarted == nil then
            -- Ensures this only runs once to save resources
            _G.infinJumpStarted = true
            
   -- Notifies readiness
            game.StarterGui:SetCore("SendNotification", {
                Title = "Youtube Hub", 
                Text = "Infinite Jump Activated!", 
                Duration = 5
            })

   -- The actual infinite jump
            local plr = game:GetService('Players').LocalPlayer
            local UIS = game:GetService("UserInputService")  -- Using UserInputService for better key handling
            local humanoid = plr.Character:WaitForChild('Humanoid')

 -- KeyDown Event Handling
            UIS.InputBegan:Connect(function(input, gameProcessedEvent)
                if gameProcessedEvent then return end
                if _G.infinjump and input.KeyCode == Enum.KeyCode.Space then
                    humanoid:ChangeState('Jumping')
                    wait()
                    humanoid:ChangeState('Seated')
                end
            end)
        end
    end,
})

-- WalkSpeed Slider
local WalkSpeedSlider = MainTab:CreateSlider({
    Name = "WalkSpeed Slider",
    Range = {1, 350},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "sliderws",
    Callback = function(Value)
        local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = Value
    end,
})

-- JumpPower Slider
local JumpPowerSlider = MainTab:CreateSlider({
    Name = "JumpPower Slider",
    Range = {1, 350},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = 16,
    Flag = "sliderjp",
    Callback = function(Value)
        local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.JumpPower = Value
    end,
})

-- WalkSpeed Input
local WalkSpeedInput = MainTab:CreateInput({
    Name = "Walkspeed",
    PlaceholderText = "1-500",
    RemoveTextAfterFocusLost = true,
    Callback = function(Text)
        local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = tonumber(Text) or 16  -- Default to 16 if invalid input
    end,
})

-- Auto Farm Toggle
local Toggle = MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        print("FARMING")
    end,
})

-- Teleports Tab
local TPTab = Window:CreateTab("🏝 Teleports", nil)

local Button1 = TPTab:CreateButton({
    Name = "Starter Island",
    Callback = function()
        -- Example teleportation
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.StarterIsland.CFrame
    end,
})

local Button2 = TPTab:CreateButton({
    Name = "Pirate Island",
    Callback = function()
        -- Example teleportation
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.PirateIsland.CFrame
    end,
})

local Button3 = TPTab:CreateButton({
    Name = "Pineapple Paradise",
    Callback = function()
        -- Example teleportation
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.PineappleParadise.CFrame
    end,
})

-- Miscellaneous Tab
local MiscTab = Window:CreateTab("🎲 Misc", nil)
