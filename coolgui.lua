-- HAMMER (standalone GUI)
-- Paste into a NEW tab in Solara

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	rootPart = newChar:WaitForChild("HumanoidRootPart")
end)

------------------------------------------------------------
-- STANDALONE GUI
------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HammerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0, 20, 0.5, -40)
frame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Thickness = 2
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
title.BorderSizePixel = 0
title.Text = "Hammer"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6)
titleCorner.Parent = title

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 32)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "Hammer: OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 4)
toggleCorner.Parent = toggleBtn

------------------------------------------------------------
-- HAMMER LOGIC
------------------------------------------------------------
local hammerActive = false
local hammerParts = {}
local hammerFolder = nil
local hammerConnection = nil
local hammerClickConn = nil
local hammerSlam = false
local hammerSlamOffset = 0

local function buildHammer()
	if hammerFolder then hammerFolder:Destroy() end
	hammerFolder = Instance.new("Folder")
	hammerFolder.Name = "CoolKidHammer"
	hammerFolder.Parent = workspace

	hammerParts = {}

	local handle = Instance.new("Part")
	handle.Size = Vector3.new(1, 5, 1)
	handle.Color = Color3.fromRGB(120, 80, 40)
	handle.Material = Enum.Material.Wood
	handle.Anchored = false
	handle.CanCollide = false
	handle.CanQuery = false
	handle.CanTouch = false
	handle.Parent = hammerFolder
	table.insert(hammerParts, handle)

	local head = Instance.new("Part")
	head.Size = Vector3.new(5, 1.5, 1.5)
	head.Color = Color3.fromRGB(200, 0, 0)
	head.Material = Enum.Material.Neon
	head.Anchored = false
	head.CanCollide = false
	head.CanQuery = false
	head.CanTouch = false
	head.Parent = hammerFolder
	table.insert(hammerParts, head)

	local light = Instance.new("PointLight")
	light.Color = Color3.fromRGB(255, 0, 0)
	light.Brightness = 5
	light.Range = 12
	light.Parent = head
end

local function startHammer()
	if hammerActive then return end
	hammerActive = true
	buildHammer()

	hammerConnection = RunService.RenderStepped:Connect(function(dt)
		if not hammerActive or not rootPart or not hammerParts[1] then return end

		local cam = workspace.CurrentCamera

		if hammerSlam then
			hammerSlamOffset = hammerSlamOffset + dt * 50
			if hammerSlamOffset > 8 then hammerSlamOffset = 8 end
		else
			hammerSlamOffset = math.max(0, hammerSlamOffset - dt * 30)
		end

		local basePos = rootPart.Position
			+ cam.CFrame.LookVector * 5
			+ cam.CFrame.UpVector * (5 - hammerSlamOffset)

		local baseCF = CFrame.new(basePos, basePos + cam.CFrame.LookVector)

		local handleCF = baseCF
		local headCF = baseCF * CFrame.new(0, 3, 0) * CFrame.Angles(0, 0, math.rad(90))

		hammerParts[1].CFrame = handleCF
		hammerParts[1].AssemblyLinearVelocity = Vector3.zero
		hammerParts[1].AssemblyAngularVelocity = Vector3.zero

		hammerParts[2].CFrame = headCF
		hammerParts[2].AssemblyLinearVelocity = Vector3.zero
		hammerParts[2].AssemblyAngularVelocity = Vector3.zero

		if hammerSlam and hammerSlamOffset >= 7 then
			hammerSlam = false

			local mouse = player:GetMouse()
			local target = mouse.Target
			if target then
				local model = target:FindFirstAncestorOfClass("Model")
				if model then
					local targetPlayer = Players:GetPlayerFromCharacter(model)
					if targetPlayer and targetPlayer ~= player then
						local tRoot = model:FindFirstChild("HumanoidRootPart")
						if tRoot then
							for i = 1, 12 do
								local block = Instance.new("Part")
								block.Size = Vector3.new(1.5, 1.5, 1.5)
								block.Color = Color3.fromRGB(255, math.random(0, 80), 0)
								block.Material = Enum.Material.Neon
								block.Anchored = false
								block.CanCollide = false
								block.Position = tRoot.Position
								block.Parent = workspace

								local bv = Instance.new("BodyVelocity")
								bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
								bv.Velocity = Vector3.new(math.random(-150,150), math.random(100,250), math.random(-150,150))
								bv.Parent = block
								Debris:AddItem(bv, 0.5)
								Debris:AddItem(block, 3)
							end

							local flingBV = Instance.new("BodyVelocity")
							flingBV.MaxForce = Vector3.new(1e6, 1e6, 1e6)
							flingBV.Velocity = Vector3.new(math.random(-100,100), 250, math.random(-100,100))
							flingBV.Parent = tRoot
							Debris:AddItem(flingBV, 0.5)

							local spin = Instance.new("BodyAngularVelocity")
							spin.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
							spin.AngularVelocity = Vector3.new(200, 200, 200)
							spin.Parent = tRoot
							Debris:AddItem(spin, 1)
						end
					end
				end
			end
		end
	end)

	hammerClickConn = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and hammerActive then
			hammerSlam = true
			hammerSlamOffset = 0
		end
	end)
end

local function stopHammer()
	hammerActive = false
	if hammerConnection then hammerConnection:Disconnect() hammerConnection = nil end
	if hammerClickConn then hammerClickConn:Disconnect() hammerClickConn = nil end
	if hammerFolder then hammerFolder:Destroy() hammerFolder = nil end
	hammerParts = {}
end

player.CharacterAdded:Connect(function()
	if hammerActive then stopHammer() end
end)

------------------------------------------------------------
-- TOGGLE BUTTON
------------------------------------------------------------
toggleBtn.MouseButton1Click:Connect(function()
	if hammerActive then
		stopHammer()
		toggleBtn.Text = "Hammer: OFF"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	else
		startHammer()
		toggleBtn.Text = "Hammer: ON"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
	end
end)
