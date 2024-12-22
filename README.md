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
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
   Title = "Injection complete",
   Content = "NightFall gui",
   Duration = 4.5,
   Image = nil,
})

local Button = MainTab:CreateButton({
   Name = "Infinite jump",
   Callback = function()
      print("Infinite jump button pressed")  -- Debug print to track if button is working

      -- Toggles the infinite jump between on or off on every script run
      G.infinjump = not G.infinjump
      print("Infinite jump toggled:", G.infinjump)  -- Debug print to check toggle state

      if G.infinJumpStarted == nil then
         -- Ensures this only runs once to save resources
         G.infinJumpStarted = true
         -- Notifies readiness
         game.StarterGui:SetCore("SendNotification", {
            Title = "Youtube Hub", 
            Text = "Infinite Jump Activated!", 
            Duration = 5
         })
         
         -- Actual infinite jump logic
         local plr = game:GetService('Players').LocalPlayer
         local m = plr:GetMouse()

         -- Connect the event to detect key presses
         m.KeyDown:Connect(function(k) -- Corrected connect to Connect
            print("Key pressed:", k)  -- Debug print to track which key was pressed
            if G.infinjump then
               if k:byte() == 32 then -- Space bar key
                  print("Space key pressed, jumping")  -- Debug print when space is pressed
                  local humanoid = plr.Character:FindFirstChildOfClass('Humanoid')
                  if humanoid then
                     humanoid:ChangeState('Jumping')
                     wait() -- brief wait
                     humanoid:ChangeState('Seated')
                  end
               end
            end
         end)
      else
         print("Infinite Jump already started")  -- Debug print when the jump is already started
      end
   end,
})
