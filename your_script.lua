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

-- Add "Get Parts" button
MainSection:CreateButton("Get Parts", function()
    -- Function to log object names with hierarchy
    local function logObjectNames(parent, path)
        for _, child in pairs(parent:GetChildren()) do
            local success, err = pcall(function()
                -- Construct the full path to the current object
                local currentPath = path .. "/" .. child.Name
                -- Log the object path to the output console
                print("[LOG] Object Path: " .. currentPath)
                -- Recursively log child objects
                logObjectNames(child, currentPath)
            end)

            if not success then
                print("[ERROR] Failed to process: " .. tostring(child.Name) .. " - " .. tostring(err))
            end
        end
    end

    -- Start logging with Workspace as the base
    local success, err = pcall(function()
        logObjectNames(game.Workspace, "Workspace")
    end)

    if not success then
        print("[ERROR] Failed to start logging: " .. tostring(err))
    end

    print("===== Logging Complete =====")
end)

-- Notify User
Rayfield:Notify({
   Title = "Injection Complete",
   Content = "NightFall GUI",
   Duration = 4.5,
   Image = nil,
})
