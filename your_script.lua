-- Make sure we are using standard Roblox services and functionality
local Window = Instance.new("ScreenGui")
Window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Window.Name = "NightFall Hub"

-- Create a basic frame for the GUI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Parent = Window

-- Create a TextLabel for the title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "NightFall Hub"
title.TextColor3 = Color3.fromRGB(200, 100, 255)
title.Font = Enum.Font.SourceSans
title.TextSize = 30
title.Parent = frame

-- Create a button for "Get Parts"
local getPartsButton = Instance.new("TextButton")
getPartsButton.Size = UDim2.new(0, 200, 0, 50)
getPartsButton.Position = UDim2.new(0.5, -100, 0.3, 0)
getPartsButton.Text = "Get Parts"
getPartsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
getPartsButton.TextColor3 = Color3.fromRGB(200, 100, 255)
getPartsButton.Font = Enum.Font.SourceSans
getPartsButton.TextSize = 20
getPartsButton.Parent = frame

getPartsButton.MouseButton1Click:Connect(function()
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

-- Create a button for "Dex"
local dexButton = Instance.new("TextButton")
dexButton.Size = UDim2.new(0, 200, 0, 50)
dexButton.Position = UDim2.new(0.5, -100, 0.5, 0)
dexButton.Text = "Dex"
dexButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dexButton.TextColor3 = Color3.fromRGB(200, 100, 255)
dexButton.Font = Enum.Font.SourceSans
dexButton.TextSize = 20
dexButton.Parent = frame

dexButton.MouseButton1Click:Connect(function()
    -- Load the Dex script when the button is clicked
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Keyless-mobile-dex-17888"))()
end)

-- Notify User with a simple message
print("NightFall Hub Loaded - Ready for testing!")
