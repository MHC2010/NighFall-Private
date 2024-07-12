--SPEED SCRIPT -toggle Q-

-- Da Hood Gui Script
local DaHoodGui = Instance.new("ScreenGui")
-- ... (other GUI elements and functionality)


-- Example: Speed hack (press Q to toggle)
local walkspeedenabled = false
function x_walkspeed(key)
   if key == "q" then
       if walkspeedenabled == false then
           _G.WS = 200
           local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
           Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
               Humanoid.WalkSpeed = _G.WS
           end)
           Humanoid.WalkSpeed = _G.WS
           walkspeedenabled = true
       elseif walkspeedenabled == true then
           _G.WS = 20
           local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
           Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
               Humanoid.WalkSpeed = _G.WS
           end)
           Humanoid.WalkSpeed = _G.WS
           walkspeedenabled = false
       end
   end
end


game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
   if not gameProcessedEvent then
       x_walkspeed(input.KeyCode.Name:lower())
   end
end)
-- Da Hood Gui Script
local DaHoodGui = Instance.new("ScreenGui")
-- ... (other GUI elements and functionality)


-- Example: Speed hack (press Q to toggle)
local walkspeedenabled = false
function x_walkspeed(key)
   if key == "q" then
       if walkspeedenabled == false then
           _G.WS = 200
           local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
           Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
               Humanoid.WalkSpeed = _G.WS
           end)
           Humanoid.WalkSpeed = _G.WS
           walkspeedenabled = true
       elseif walkspeedenabled == true then
           _G.WS = 20
           local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
           Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
               Humanoid.WalkSpeed = _G.WS
           end)
           Humanoid.WalkSpeed = _G.WS
           walkspeedenabled = false
       end
   end
end


game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
   if not gameProcessedEvent then
       x_walkspeed(input.KeyCode.Name:lower())
   end
end)












--FLY SCRIPT -toggle p-

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local localplayer = plr


if workspace:FindFirstChild("Core") then
   workspace.Core:Destroy()
end


local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)


spawn(function()
   Core.Parent = workspace
   local Weld = Instance.new("Weld", Core)
   Weld.Part0 = Core
   Weld.Part1 = localplayer.Character.LowerTorso
   Weld.C0 = CFrame.new(0, 0, 0)
end)


workspace:WaitForChild("Core")


local torso = workspace.Core
local flying = false
local speed = 10
local keys = {a = false, d = false, w = false, s = false}


local function start()
   local pos = Instance.new("BodyPosition", torso)
   local gyro = Instance.new("BodyGyro", torso)
   pos.Name = "EPIXPOS"
   pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
   pos.position = torso.Position
   gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
   gyro.cframe = torso.CFrame


   repeat wait()
       localplayer.Character.Humanoid.PlatformStand = true
       local new = gyro.cframe - gyro.cframe.p + pos.position


       if not keys.w and not keys.s and not keys.a and not keys.d thendss
           speed = 5
       end


       if keys.w then
           new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
       end


       if keys.s then
           new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
       end


       if keys.d then
           new = new * CFrame.new(speed, 0, 0)
       end


       if keys.a then
           new = new * CFrame.new(-speed, 0, 0)
       end


       speed = math.clamp(speed + 0.1, 5, 10)
       pos.position = new.p


       if keys.w or keys.s then
           gyro.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(speed * 0), 0, 0)
       else
           gyro.cframe = workspace.CurrentCamera.CoordinateFrame
       end
   until not flying


   gyro:Destroy()
   pos:Destroy()
   flying = false
   localplayer.Character.Humanoid.PlatformStand = false
end


mouse.KeyDown:connect(function(key)
   if key == "w" then
       keys.w = true
   elseif key == "s" then
       keys.s = true
   elseif key == "a" then
       keys.a = true
   elseif key == "d" then
       keys.d = true
   elseif key == "p" then
       flying = not flying
       if flying then
           start()
       end
   end
end)


mouse.KeyUp:connect(function(key)
   if key == "w" then
       keys.w = false
   elseif key == "s" then
       keys.s = false
   elseif key == "a" then
       keys.a = false
   elseif key == "d" then
       keys.d = false
   end
end)



