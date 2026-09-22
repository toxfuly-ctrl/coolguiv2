-- c00lgui Reborn - Complete Edition (All Features + Hands)
-- GitHub: toxfuly-ctrl/coolguiv2
-- Loader: loadstring(game:HttpGet("https://raw.githubusercontent.com/toxfuly-ctrl/coolguiv2/main/script.lua"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")

workspace.FallenPartsDestroyHeight = -100000

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	rootPart = newChar:WaitForChild("HumanoidRootPart")
end)

local BG_DARK = Color3.fromRGB(15, 0, 0)
local BG_PANEL = Color3.fromRGB(25, 0, 0)
local RED_BRIGHT = Color3.fromRGB(200, 0, 0)
local RED_DARK = Color3.fromRGB(90, 0, 0)
local RED_BORDER = Color3.fromRGB(255, 0, 0)
local TEXT_WHITE = Color3.fromRGB(255, 255, 255)

local HAND_TAN = Color3.fromRGB(160, 140, 90)
local HAND_CYAN = Color3.fromRGB(80, 230, 200)
local HAND_CHAIN = Color3.fromRGB(180, 180, 180)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoolKidGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 500)
main.Position = UDim2.new(0.5, -160, 0.5, -250)
main.BackgroundColor3 = BG_DARK
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 6)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = RED_BORDER
mainStroke.Thickness = 2
mainStroke.Parent = main

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = RED_DARK
titleBar.BorderSizePixel = 0
titleBar.Text = "c00lgui Reborn"
titleBar.TextColor3 = TEXT_WHITE
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 14
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6)
titleCorner.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0, 3)
closeBtn.BackgroundColor3 = RED_BRIGHT
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = TEXT_WHITE
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function() main.Visible = false end)

local navBar = Instance.new("Frame")
navBar.Size = UDim2.new(1, -12, 0, 30)
navBar.Position = UDim2.new(0, 6, 0, 34)
navBar.BackgroundColor3 = BG_PANEL
navBar.BorderSizePixel = 0
navBar.Parent = main

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 4)
navCorner.Parent = navBar

local navList = Instance.new("UIListLayout")
navList.FillDirection = Enum.FillDirection.Horizontal
navList.SortOrder = Enum.SortOrder.LayoutOrder
navList.Padding = UDim.new(0, 2)
navList.HorizontalAlignment = Enum.HorizontalAlignment.Center
navList.VerticalAlignment = Enum.VerticalAlignment.Center
navList.Parent = navBar

local navPad = Instance.new("UIPadding")
navPad.PaddingTop = UDim.new(0, 3)
navPad.PaddingLeft = UDim.new(0, 3)
navPad.PaddingRight = UDim.new(0, 3)
navPad.Parent = navBar

local pageContainer = Instance.new("Frame")
pageContainer.Size = UDim2.new(1, -12, 1, -76)
pageContainer.Position = UDim2.new(0, 6, 0, 70)
pageContainer.BackgroundColor3 = BG_PANEL
pageContainer.BorderSizePixel = 0
pageContainer.Parent = main

local pageCorner = Instance.new("UICorner")
pageCorner.CornerRadius = UDim.new(0, 4)
pageCorner.Parent = pageContainer

local pages = {}
local currentPage = nil

local function createPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 4
	page.ScrollBarImageColor3 = RED_BRIGHT
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Visible = false
	page.Parent = pageContainer

	local pageList = Instance.new("UIListLayout")
	pageList.Padding = UDim.new(0, 6)
	pageList.SortOrder = Enum.SortOrder.LayoutOrder
	pageList.Parent = page

	local pagePad = Instance.new("UIPadding")
	pagePad.PaddingTop = UDim.new(0, 8)
	pagePad.PaddingLeft = UDim.new(0, 8)
	pagePad.PaddingRight = UDim.new(0, 8)
	pagePad.PaddingBottom = UDim.new(0, 8)
	pagePad.Parent = page

	local navBtn = Instance.new("TextButton")
	navBtn.Size = UDim2.new(0, 38, 1, -6)
	navBtn.BackgroundColor3 = RED_DARK
	navBtn.BorderSizePixel = 0
	navBtn.Text = name
	navBtn.TextColor3 = TEXT_WHITE
	navBtn.Font = Enum.Font.GothamBold
	navBtn.TextSize = 10
	navBtn.Parent = navBar

	local navBtnCorner = Instance.new("UICorner")
	navBtnCorner.CornerRadius = UDim.new(0, 4)
	navBtnCorner.Parent = navBtn

	pages[name] = { frame = page, navBtn = navBtn, list = pageList }

	navBtn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do
			p.frame.Visible = false
			p.navBtn.BackgroundColor3 = RED_DARK
		end
		page.Visible = true
		navBtn.BackgroundColor3 = RED_BRIGHT
		currentPage = name
	end)

	return page
end

local function makeButton(pageName, text, callback)
	local pageData = pages[pageName]
	if not pageData then return end

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -8, 0, 35)
	btn.BackgroundColor3 = RED_BRIGHT
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = TEXT_WHITE
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.Parent = pageData.frame

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 4)
	c.Parent = btn

	local s = Instance.new("UIStroke")
	s.Color = RED_BORDER
	s.Thickness = 1
	s.Transparency = 0.5
	s.Parent = btn

	btn.MouseButton1Click:Connect(function() callback(btn) end)

	pageData.frame.CanvasSize = UDim2.new(0, 0, 0, pageData.list.AbsoluteContentSize.Y + 16)
	pageData.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		pageData.frame.CanvasSize = UDim2.new(0, 0, 0, pageData.list.AbsoluteContentSize.Y + 16)
	end)

	return btn
end

local function makeSlider(pageName, labelText, minVal, maxVal, defaultVal, onChange)
	local pageData = pages[pageName]
	if not pageData then return end

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, -8, 0, 50)
	holder.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
	holder.BorderSizePixel = 0
	holder.Parent = pageData.frame

	local holderCorner = Instance.new("UICorner")
	holderCorner.CornerRadius = UDim.new(0, 4)
	holderCorner.Parent = holder

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 0, 20)
	label.Position = UDim2.new(0, 5, 0, 2)
	label.BackgroundTransparency = 1
	label.Text = labelText .. ": " .. tostring(defaultVal)
	label.TextColor3 = TEXT_WHITE
	label.Font = Enum.Font.GothamBold
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = holder

	local track = Instance.new("TextButton")
	track.Size = UDim2.new(1, -20, 0, 12)
	track.Position = UDim2.new(0, 10, 0, 28)
	track.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
	track.BorderSizePixel = 0
	track.Text = ""
	track.AutoButtonColor = false
	track.Parent = holder

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
	fill.BackgroundColor3 = RED_BRIGHT
	fill.BorderSizePixel = 0
	fill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local handle = Instance.new("Frame")
	handle.Size = UDim2.new(0, 16, 0, 16)
	handle.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -8, 0.5, -8)
	handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	handle.BorderSizePixel = 0
	handle.Parent = track

	local handleCorner = Instance.new("UICorner")
	handleCorner.CornerRadius = UDim.new(1, 0)
	handleCorner.Parent = handle

	local dragging = false

	local function updateSlider(input)
		local posX = math.clamp(input.Position.X - track.AbsolutePosition.X, 0, track.AbsoluteSize.X)
		local percent = posX / track.AbsoluteSize.X
		local newVal = math.floor(minVal + percent * (maxVal - minVal))
		fill.Size = UDim2.new(percent, 0, 1, 0)
		handle.Position = UDim2.new(percent, -8, 0.5, -8)
		label.Text = labelText .. ": " .. tostring(newVal)
		if onChange then onChange(newVal) end
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			updateSlider(input)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
		or input.UserInputType == Enum.UserInputType.Touch) then
			updateSlider(input)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	pageData.frame.CanvasSize = UDim2.new(0, 0, 0, pageData.list.AbsoluteContentSize.Y + 16)
	pageData.list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		pageData.frame.CanvasSize = UDim2.new(0, 0, 0, pageData.list.AbsoluteContentSize.Y + 16)
	end)
end

createPage("Main")
createPage("TP")
createPage("Fling")
createPage("Visual")
createPage("Fun")
createPage("c00lkidd")
createPage("Nat")
createPage("MM2")
createPage("Music")

pages["Main"].frame.Visible = true
pages["Main"].navBtn.BackgroundColor3 = RED_BRIGHT
currentPage = "Main"

------------------------------------------------------------
-- FLY
------------------------------------------------------------
local flying = false
local flySpeed = 50
local bodyVelocity, bodyGyro, flyConnection

local function startFly()
	if not character or not rootPart then return end
	flying = true
	humanoid.PlatformStand = true

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = rootPart

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	bodyGyro.P = 1000
	bodyGyro.CFrame = rootPart.CFrame
	bodyGyro.Parent = rootPart

	flyConnection = RunService.RenderStepped:Connect(function()
		if not flying or not rootPart then return end
		local camera = workspace.CurrentCamera
		local dir = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += camera.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= camera.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= camera.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += camera.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
		if dir.Magnitude > 0 then dir = dir.Unit end
		bodyVelocity.Velocity = dir * flySpeed
		bodyGyro.CFrame = camera.CFrame
	end)
end

local function stopFly()
	flying = false
	if humanoid then humanoid.PlatformStand = false end
	if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if flyConnection then flyConnection:Disconnect() flyConnection = nil end
end

player.CharacterAdded:Connect(function() if flying then stopFly() end end)

------------------------------------------------------------
-- NOCLIP
------------------------------------------------------------
local noclip = false
local noclipConnection

local function startNoclip()
	noclip = true
	noclipConnection = RunService.Stepped:Connect(function()
		if not noclip or not character then return end
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
		end
	end)
end

local function stopNoclip()
	noclip = false
	if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
	end
end

player.CharacterAdded:Connect(function() if noclip then stopNoclip() end end)

------------------------------------------------------------
-- GOD MODE
------------------------------------------------------------
local godModeActive = false
local godConnection

local function startGodMode()
	godModeActive = true
	godConnection = RunService.Heartbeat:Connect(function()
		if not godModeActive then return end
		if humanoid and humanoid.Parent then
			humanoid.MaxHealth = math.huge
			humanoid.Health = math.huge
		end
	end)
end

local function stopGodMode()
	godModeActive = false
	if godConnection then godConnection:Disconnect() godConnection = nil end
	if humanoid and humanoid.Parent then
		humanoid.MaxHealth = 100
		humanoid.Health = 100
	end
end

player.CharacterAdded:Connect(function()
	if godModeActive then
		task.wait(0.5)
		godConnection = nil
		startGodMode()
	end
end)

------------------------------------------------------------
-- ANTI-FLING
------------------------------------------------------------
local antiFlingActive = false
local antiFlingConnection
local lastSafeCFrame = nil

local function startAntiFling()
	antiFlingActive = true
	antiFlingConnection = RunService.Heartbeat:Connect(function()
		if not antiFlingActive or not rootPart or not rootPart.Parent then return end
		local velocity = rootPart.AssemblyLinearVelocity.Magnitude
		local angular = rootPart.AssemblyAngularVelocity.Magnitude
		if velocity > 250 or angular > 250 then
			rootPart.AssemblyLinearVelocity = Vector3.zero
			rootPart.AssemblyAngularVelocity = Vector3.zero
			if lastSafeCFrame then rootPart.CFrame = lastSafeCFrame end
		else
			lastSafeCFrame = rootPart.CFrame
		end
	end)
end

local function stopAntiFling()
	antiFlingActive = false
	if antiFlingConnection then antiFlingConnection:Disconnect() antiFlingConnection = nil end
end

player.CharacterAdded:Connect(function() if antiFlingActive then stopAntiFling() end end)

------------------------------------------------------------
-- INFINITE JUMP
------------------------------------------------------------
local infJump = false
local infJumpConnection

local function startInfJump()
	infJump = true
	infJumpConnection = UserInputService.JumpRequest:Connect(function()
		if infJump and humanoid and humanoid.Parent then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

local function stopInfJump()
	infJump = false
	if infJumpConnection then infJumpConnection:Disconnect() infJumpConnection = nil end
end

player.CharacterAdded:Connect(function()
	if infJump then
		stopInfJump()
		task.wait(0.5)
		startInfJump()
	end
end)

------------------------------------------------------------
-- GHOST
------------------------------------------------------------
local ghost = false

local function applyGhost()
	if not character then return end
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = 1
			part.LocalTransparencyModifier = 0.5
		elseif part:IsA("Decal") then
			part.Transparency = 1
		end
	end
end

local function removeGhost()
	if not character then return end
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = 0
			part.LocalTransparencyModifier = 0
		elseif part:IsA("Decal") then
			part.Transparency = 0
		end
	end
end

player.CharacterAdded:Connect(function()
	if ghost then
		task.wait(0.5)
		applyGhost()
	end
end)

------------------------------------------------------------
-- RED GLOW
------------------------------------------------------------
local redGlowActive = false
local redLight = nil

local function startRedGlow()
	redGlowActive = true
	if not character or not rootPart then return end
	if not redLight or not redLight.Parent then
		redLight = Instance.new("PointLight")
		redLight.Color = Color3.fromRGB(255, 0, 0)
		redLight.Brightness = 3
		redLight.Range = 15
		redLight.Parent = rootPart
	end
end

local function stopRedGlow()
	redGlowActive = false
	if redLight then redLight:Destroy() redLight = nil end
end

player.CharacterAdded:Connect(function()
	if redGlowActive then
		task.wait(0.5)
		startRedGlow()
	end
end)

------------------------------------------------------------
-- ESP
------------------------------------------------------------
local espActive = false
local espObjects = {}

local function createESPForPlayer(targetPlayer)
	if not targetPlayer or targetPlayer == player then return end
	if espObjects[targetPlayer] then return end

	local espData = {}
	local highlight = Instance.new("Highlight")
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = screenGui
	espData.highlight = highlight

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = screenGui

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 1, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = targetPlayer.Name
	nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	nameLabel.TextStrokeTransparency = 0
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 16
	nameLabel.Parent = billboard

	espData.billboard = billboard
	espObjects[targetPlayer] = espData
end

local function updateESPForPlayer(targetPlayer)
	local data = espObjects[targetPlayer]
	if not data then return end
	local targetChar = targetPlayer.Character
	if not targetChar then
		if data.highlight then data.highlight.Adornee = nil end
		if data.billboard then data.billboard.Adornee = nil end
		return
	end
	local head = targetChar:FindFirstChild("Head")
	if data.highlight then data.highlight.Adornee = targetChar end
	if data.billboard and head then data.billboard.Adornee = head end
end

local function removeESPForPlayer(targetPlayer)
	local data = espObjects[targetPlayer]
	if not data then return end
	if data.highlight then data.highlight:Destroy() end
	if data.billboard then data.billboard:Destroy() end
	espObjects[targetPlayer] = nil
end

local espConnection

local function startESP()
	espActive = true
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then createESPForPlayer(p) end
	end
	espConnection = RunService.RenderStepped:Connect(function()
		if not espActive then return end
		for p, _ in pairs(espObjects) do updateESPForPlayer(p) end
	end)
end

local function stopESP()
	espActive = false
	if espConnection then espConnection:Disconnect() espConnection = nil end
	for p, _ in pairs(espObjects) do removeESPForPlayer(p) end
	espObjects = {}
end

Players.PlayerAdded:Connect(function(p)
	if espActive and p ~= player then task.wait(1) createESPForPlayer(p) end
end)
Players.PlayerRemoving:Connect(function(p) removeESPForPlayer(p) end)

------------------------------------------------------------
-- CHAT
------------------------------------------------------------
local CHAT_MESSAGE = "JOIN TEAM c00lkid TODAY"

local function sayMessage()
	pcall(function()
		local textChatService = game:GetService("TextChatService")
		if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			local channels = textChatService:FindFirstChild("TextChannels")
			if channels then
				local general = channels:FindFirstChild("RBXGeneral")
				if general then general:SendAsync(CHAT_MESSAGE) return end
			end
		end
		StarterGui:SetCore("ChatSendMessage", CHAT_MESSAGE)
	end)
end

local chatSpamActive = false

local function startChatSpam()
	chatSpamActive = true
	task.spawn(function()
		while chatSpamActive do
			sayMessage()
			task.wait(5)
		end
	end)
end

local function stopChatSpam()
	chatSpamActive = false
end

------------------------------------------------------------
-- FLING
------------------------------------------------------------
local flinging = false

local function flingPlayer(targetPlayer)
	if not targetPlayer or targetPlayer == player then return end
	if flinging then return end
	flinging = true

	local myChar = player.Character
	local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
	local myRoot = myHum and myHum.RootPart

	local tChar = targetPlayer.Character
	if not tChar then flinging = false return end
	local tHum = tChar:FindFirstChildOfClass("Humanoid")
	local tRoot = tHum and tHum.RootPart
	local tHead = tChar:FindFirstChild("Head")

	if not (myChar and myHum and myRoot) then flinging = false return end
	if not (tHum and tRoot) then flinging = false return end

	local savedCFrame = myRoot.CFrame
	local savedFPDH = workspace.FallenPartsDestroyHeight
	local savedHealth = myHum.Health

	local savedCollide = {}
	for _, p in ipairs(myChar:GetDescendants()) do
		if p:IsA("BasePart") then
			savedCollide[p] = p.CanCollide
			p.CanCollide = false
		end
	end

	myHum.PlatformStand = true
	if tHead then
		workspace.CurrentCamera.CameraSubject = tHead
	else
		workspace.CurrentCamera.CameraSubject = tHum
	end

	workspace.FallenPartsDestroyHeight = 0 / 0

	local function FPos(BasePart, Pos, Ang)
		myRoot.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
		myChar:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
		myRoot.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
		myRoot.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
	end

	local function SFBasePart(BasePart)
		local TimeToWait = 1
		local Time = tick()
		local Angle = 0
		repeat
			if myRoot and tHum then
				if BasePart.Velocity.Magnitude < 50 then
					Angle = Angle + 100
					FPos(BasePart, CFrame.new(0, 1.5, 0) + tHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(0, -1.5, 0) + tHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + tHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + tHum.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
					task.wait()
				else
					FPos(BasePart, CFrame.new(0, 1.5, tHum.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(0, -1.5, -tHum.WalkSpeed), CFrame.Angles(0, 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(0, 1.5, tHum.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(0, 1.5, tRoot.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
					task.wait()
					FPos(BasePart, CFrame.new(0, -1.5, -tRoot.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
					task.wait()
				end
			else
				break
			end
		until BasePart.Velocity.Magnitude > 500 
			or BasePart.Parent ~= tChar 
			or targetPlayer.Parent ~= Players 
			or targetPlayer.Character ~= tChar 
			or tHum.Sit 
			or myHum.Health <= 0 
			or tick() > Time + TimeToWait
	end

	local BV = Instance.new("BodyVelocity")
	BV.Name = "EpixVel"
	BV.Parent = myRoot
	BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
	BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

	myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

	if tRoot and tHead then
		if (tRoot.CFrame.p - tHead.CFrame.p).Magnitude > 5 then
			SFBasePart(tHead)
		else
			SFBasePart(tRoot)
		end
	elseif tRoot and not tHead then
		SFBasePart(tRoot)
	elseif not tRoot and tHead then
		SFBasePart(tHead)
	end

	task.wait(1)

	if BV then BV:Destroy() end
	pcall(function() myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end)

	if myChar then
		for _, part in ipairs(myChar:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Velocity = Vector3.zero
				part.RotVelocity = Vector3.zero
			end
		end
	end

	if myRoot then myRoot.CFrame = savedCFrame end

	for p, state in pairs(savedCollide) do
		if p and p.Parent then p.CanCollide = state end
	end

	workspace.CurrentCamera.CameraSubject = myHum
	workspace.FallenPartsDestroyHeight = savedFPDH

	task.wait(0.1)

	if myChar then
		for _, part in ipairs(myChar:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Velocity = Vector3.zero
				part.RotVelocity = Vector3.zero
			end
		end
	end

	if myHum and myHum.Parent then
		pcall(function()
			myHum.Health = math.max(myHum.Health, savedHealth, myHum.MaxHealth)
		end)
	end

	if myHum then myHum.PlatformStand = false end
	flinging = false
end

local function findClosestPlayer()
	local closest, closestDist = nil, math.huge
	if not rootPart then return nil end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
			if tRoot then
				local d = (tRoot.Position - rootPart.Position).Magnitude
				if d < closestDist then
					closest = p
					closestDist = d
				end
			end
		end
	end
	return closest
end

------------------------------------------------------------
-- FLING AURA
------------------------------------------------------------
local flingAuraActive = false
local flingAuraConnection
local flingAuraLastTime = 0

local function startFlingAura()
	flingAuraActive = true
	flingAuraConnection = RunService.Heartbeat:Connect(function()
		if not flingAuraActive or flinging or not rootPart then return end
		if tick() - flingAuraLastTime < 0.5 then return end

		local nearest, nearestDist = nil, 15
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
				local tHum = p.Character:FindFirstChildOfClass("Humanoid")
				if tRoot and tHum and tHum.Health > 0 then
					local d = (tRoot.Position - rootPart.Position).Magnitude
					if d < nearestDist then nearest = p nearestDist = d end
				end
			end
		end

		if nearest then
			flingAuraLastTime = tick()
			task.spawn(function() flingPlayer(nearest) end)
		end
	end)
end

local function stopFlingAura()
	flingAuraActive = false
	if flingAuraConnection then flingAuraConnection:Disconnect() flingAuraConnection = nil end
end

player.CharacterAdded:Connect(function() if flingAuraActive then stopFlingAura() end end)

------------------------------------------------------------
-- C00LKIDD PAGE - SUPER RING
------------------------------------------------------------
local SUPER_RING_RADIUS = 12
local SUPER_RING_ORBIT = 8
local SUPER_RING_SPEED = 2
local SUPER_RING_MAX_SIZE = 5
local SUPER_RING_MAX_PARTS = 12

local superRingActive = false
local superRingConnection

local function isCharacterPart(part)
	if not part.Parent then return true end
	local model = part:FindFirstAncestorOfClass("Model")
	if model then
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character == model then return true end
		end
	end
	return false
end

local function startSuperRing()
	if superRingActive then return end
	superRingActive = true

	local angle = 0
	local frameCounter = 0
	local cachedParts = {}

	superRingConnection = RunService.Heartbeat:Connect(function(dt)
		if not superRingActive or not rootPart or not rootPart.Parent then return end

		frameCounter = frameCounter + 1
		local center = rootPart.Position
		angle = angle + dt * SUPER_RING_SPEED * math.pi * 2

		if frameCounter % 15 == 0 then
			cachedParts = {}
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") then
					if not obj.Anchored and obj ~= rootPart and not isCharacterPart(obj) then
						local dist = (obj.Position - center).Magnitude
						if dist < SUPER_RING_RADIUS and dist > 2 then
							local size = obj.Size
							if size.X < SUPER_RING_MAX_SIZE and size.Y < SUPER_RING_MAX_SIZE and size.Z < SUPER_RING_MAX_SIZE then
								table.insert(cachedParts, obj)
							end
						end
					end
				end
			end
			if #cachedParts > SUPER_RING_MAX_PARTS then
				local trimmed = {}
				for i = 1, SUPER_RING_MAX_PARTS do trimmed[i] = cachedParts[i] end
				cachedParts = trimmed
			end
		end

		for i, part in ipairs(cachedParts) do
			if part and part.Parent then
				local partAngle = angle + (i - 1) * (math.pi * 2 / #cachedParts)
				local offset = Vector3.new(
					math.cos(partAngle) * SUPER_RING_ORBIT,
					3 + math.sin(angle * 2 + i) * 2,
					math.sin(partAngle) * SUPER_RING_ORBIT
				)
				local targetPos = center + offset
				part.CFrame = CFrame.new(targetPos) * CFrame.Angles(partAngle, partAngle * 2, 0)
				part.AssemblyLinearVelocity = (targetPos - part.Position) / dt
			end
		end
	end)
end

local function stopSuperRing()
	superRingActive = false
	if superRingConnection then superRingConnection:Disconnect() superRingConnection = nil end
end

player.CharacterAdded:Connect(function() if superRingActive then stopSuperRing() end end)

------------------------------------------------------------
-- TORNADO
------------------------------------------------------------
local tornadoActive = false
local tornadoParts = {}
local tornadoConnection

local function startTornado()
	if tornadoActive then return end
	tornadoActive = true
	tornadoParts = {}

	for i = 1, 30 do
		local part = Instance.new("Part")
		part.Size = Vector3.new(1.5, 1.5, 1.5)
		part.Color = Color3.fromRGB(200, 200, 200)
		part.Anchored = false
		part.CanCollide = false
		part.Parent = workspace
		table.insert(tornadoParts, part)
	end

	local angle = 0
	tornadoConnection = RunService.Heartbeat:Connect(function(dt)
		if not tornadoActive or not rootPart or not rootPart.Parent then return end
		angle = angle + dt * 6
		local center = rootPart.Position

		for i, part in ipairs(tornadoParts) do
			if part and part.Parent then
				local height = i * 0.8
				local radius = 2 + math.sin(i / 5) * 2
				local partAngle = angle + (i * 0.3)
				local offset = Vector3.new(
					math.cos(partAngle) * radius,
					height,
					math.sin(partAngle) * radius
				)
				local targetPos = center + offset
				part.CFrame = CFrame.new(targetPos) * CFrame.Angles(angle, angle, 0)
				part.AssemblyLinearVelocity = (targetPos - part.Position) / dt
			end
		end
	end)
end

local function stopTornado()
	tornadoActive = false
	if tornadoConnection then tornadoConnection:Disconnect() tornadoConnection = nil end
	for _, part in ipairs(tornadoParts) do
		if part and part.Parent then part:Destroy() end
	end
	tornadoParts = {}
end

player.CharacterAdded:Connect(function() if tornadoActive then stopTornado() end end)

------------------------------------------------------------
-- RED PAD
------------------------------------------------------------
local redPadActive = false
local redPadPart
local redPadConnection

local function startRedPad()
	if redPadActive then return end
	redPadActive = true

	redPadPart = Instance.new("Part")
	redPadPart.Size = Vector3.new(8, 0.5, 8)
	redPadPart.Color = Color3.fromRGB(255, 0, 0)
	redPadPart.Material = Enum.Material.Neon
	redPadPart.Anchored = false
	redPadPart.CanCollide = false
	redPadPart.CanQuery = false
	redPadPart.CanTouch = false
	redPadPart.Parent = workspace

	redPadConnection = RunService.Heartbeat:Connect(function()
		if not redPadActive or not redPadPart or not rootPart then return end
		local pos = rootPart.Position - Vector3.new(0, 3, 0)
		redPadPart.CFrame = CFrame.new(pos)
		redPadPart.AssemblyLinearVelocity = Vector3.zero
		redPadPart.AssemblyAngularVelocity = Vector3.zero
	end)
end

local function stopRedPad()
	redPadActive = false
	if redPadConnection then redPadConnection:Disconnect() redPadConnection = nil end
	if redPadPart then redPadPart:Destroy() redPadPart = nil end
end

player.CharacterAdded:Connect(function() if redPadActive then stopRedPad() end end)

------------------------------------------------------------
-- RED SKY
------------------------------------------------------------
local redSkyActive = false
local originalSky = nil
local redSky = nil

local function startRedSky()
	redSkyActive = true
	originalSky = Lighting:FindFirstChildOfClass("Sky")
	if originalSky then originalSky.Parent = nil end

	redSky = Instance.new("Sky")
	redSky.SkyboxBk = "rbxassetid://0"
	redSky.SkyboxDn = "rbxassetid://0"
	redSky.SkyboxFt = "rbxassetid://0"
	redSky.SkyboxLf = "rbxassetid://0"
	redSky.SkyboxRt = "rbxassetid://0"
	redSky.SkyboxUp = "rbxassetid://0"
	redSky.Parent = Lighting

	Lighting.Ambient = Color3.fromRGB(100, 0, 0)
	Lighting.OutdoorAmbient = Color3.fromRGB(120, 0, 0)
	Lighting.Brightness = 1
	Lighting.ClockTime = 0
	Lighting.FogColor = Color3.fromRGB(80, 0, 0)
	Lighting.FogEnd = 1000
end

local function stopRedSky()
	redSkyActive = false
	if redSky then redSky:Destroy() redSky = nil end
	if originalSky then originalSky.Parent = Lighting end
end

------------------------------------------------------------
-- CAGE
------------------------------------------------------------
local cageActive = false
local cageParts = {}

local function startCage()
	if cageActive then return end
	cageActive = true
	cageParts = {}

	local size = 8
	local height = 12
	local offset = size / 2
	local center = rootPart.Position

	local positions = {
		Vector3.new(offset, 0, 0),
		Vector3.new(-offset, 0, 0),
		Vector3.new(0, 0, offset),
		Vector3.new(0, 0, -offset),
	}

	for _, pos in ipairs(positions) do
		for h = 0, height - 1, 4 do
			local wall = Instance.new("Part")
			wall.Size = Vector3.new(size, 4, 0.5)
			wall.Color = Color3.fromRGB(255, 0, 0)
			wall.Material = Enum.Material.Neon
			wall.Anchored = false
			wall.CanCollide = true
			wall.CFrame = CFrame.new(center + pos + Vector3.new(0, h + 2, 0))
			wall.Parent = workspace
			table.insert(cageParts, wall)
		end
	end
end

local function stopCage()
	cageActive = false
	for _, part in ipairs(cageParts) do
		if part and part.Parent then part:Destroy() end
	end
	cageParts = {}
end

------------------------------------------------------------
-- BLOCK STORM
------------------------------------------------------------
local stormActive = false
local stormConnection

local function startStorm()
	if stormActive then return end
	stormActive = true

	stormConnection = RunService.Heartbeat:Connect(function()
		if not stormActive or not rootPart then return end
		for i = 1, 3 do
			local block = Instance.new("Part")
			block.Size = Vector3.new(3, 3, 3)
			block.Color = Color3.fromRGB(255, 0, 0)
			block.Material = Enum.Material.Neon
			block.Anchored = false
			block.CanCollide = true
			block.Position = rootPart.Position + Vector3.new(
				math.random(-20, 20),
				math.random(20, 40),
				math.random(-20, 20)
			)
			block.Parent = workspace
			Debris:AddItem(block, 5)
		end
	end)
end

local function stopStorm()
	stormActive = false
	if stormConnection then stormConnection:Disconnect() stormConnection = nil end
end

------------------------------------------------------------
-- BLACK HOLE
------------------------------------------------------------
local BLACK_HOLE_RANGE = 15
local BLACK_HOLE_FORCE = 100

local holeActive = false
local holePart
local holeConnection
local holeSpawnPos
local holeRingParts = {}
local HOLE_RING_COUNT = 20
local HOLE_RING_RADIUS = 8

local function startBlackHole()
	if holeActive then return end
	holeActive = true

	holeSpawnPos = rootPart.Position

	holePart = Instance.new("Part")
	holePart.Shape = Enum.PartType.Ball
	holePart.Size = Vector3.new(6, 6, 6)
	holePart.Color = Color3.fromRGB(0, 0, 0)
	holePart.Material = Enum.Material.Neon
	holePart.Anchored = true
	holePart.CanCollide = false
	holePart.Parent = workspace

	local light = Instance.new("PointLight")
	light.Color = Color3.fromRGB(255, 0, 0)
	light.Brightness = 5
	light.Range = 25
	light.Parent = holePart

	holeRingParts = {}
	for i = 1, HOLE_RING_COUNT do
		local ringPart = Instance.new("Part")
		ringPart.Size = Vector3.new(1.5, 1.5, 1.5)
		ringPart.Color = Color3.fromRGB(255, 0, 0)
		ringPart.Material = Enum.Material.Neon
		ringPart.Anchored = false
		ringPart.CanCollide = false
		ringPart.CanQuery = false
		ringPart.CanTouch = false
		ringPart.Parent = workspace
		table.insert(holeRingParts, ringPart)
	end

	local frameCounter = 0
	local ringAngle = 0

	holeConnection = RunService.RenderStepped:Connect(function(dt)
		if not holeActive or not holePart then return end

		holePart.CFrame = CFrame.new(holeSpawnPos)
		holePart.AssemblyLinearVelocity = Vector3.zero
		holePart.AssemblyAngularVelocity = Vector3.zero

		ringAngle = ringAngle + dt * 3
		for i, part in ipairs(holeRingParts) do
			if part and part.Parent then
				local partAngle = ringAngle + (i - 1) * (math.pi * 2 / HOLE_RING_COUNT)
				local offset = Vector3.new(
					math.cos(partAngle) * HOLE_RING_RADIUS,
					math.sin(ringAngle * 2 + i) * 2,
					math.sin(partAngle) * HOLE_RING_RADIUS
				)
				local targetPos = holeSpawnPos + offset
				part.CFrame = CFrame.new(targetPos) * CFrame.Angles(ringAngle, ringAngle * 2, 0)
				part.AssemblyLinearVelocity = (targetPos - part.Position) / dt
			end
		end

		frameCounter = frameCounter + 1
		if frameCounter % 10 ~= 0 then return end

		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj.Anchored and obj ~= holePart then
				if not isCharacterPart(obj) then
					local isRingPart = false
					for _, rp in ipairs(holeRingParts) do
						if rp == obj then isRingPart = true break end
					end
					if not isRingPart then
						local dist = (obj.Position - holeSpawnPos).Magnitude
						if dist < BLACK_HOLE_RANGE then
							local dir = (holeSpawnPos - obj.Position).Unit
							obj.AssemblyLinearVelocity = dir * BLACK_HOLE_FORCE
							if dist < 3 then
								obj.AssemblyLinearVelocity = -dir * 500 + Vector3.new(0, 200, 0)
							end
						end
					end
				end
			end
		end

		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
				local tHum = p.Character:FindFirstChildOfClass("Humanoid")
				if tRoot and tHum and tHum.Health > 0 then
					local dist = (tRoot.Position - holeSpawnPos).Magnitude
					if dist < BLACK_HOLE_RANGE then
						local dir = (holeSpawnPos - tRoot.Position).Unit
						tRoot.AssemblyLinearVelocity = dir * BLACK_HOLE_FORCE
						if dist < 4 then
							tRoot.AssemblyLinearVelocity = Vector3.new(0, 500, 0)
							pcall(function()
								tRoot.AssemblyAngularVelocity = Vector3.new(9e8, 9e8, 9e8)
							end)
						end
					end
				end
			end
		end
	end)
end

local function stopBlackHole()
	holeActive = false
	if holeConnection then holeConnection:Disconnect() holeConnection = nil end
	if holePart then holePart:Destroy() holePart = nil end
	for _, part in ipairs(holeRingParts) do
		if part and part.Parent then part:Destroy() end
	end
	holeRingParts = {}
end

player.CharacterAdded:Connect(function() if holeActive then stopBlackHole() end end)

------------------------------------------------------------
-- HAND BUILDER
------------------------------------------------------------
local function makePart(parent, size, cframe, color, material, transparency)
	local p = Instance.new("Part")
	p.Size = size
	p.CFrame = cframe
	p.Color = color
	p.Material = material or Enum.Material.SmoothPlastic
	p.Transparency = transparency or 0
	p.Anchored = false
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.Parent = parent
	return p
end

local function buildHand(folder, baseCFrame, openFingers)
	local parts = {}

	local palm = makePart(folder, Vector3.new(10, 4, 10), baseCFrame, HAND_TAN, Enum.Material.SmoothPlastic, 0)
	table.insert(parts, palm)

	local eye = makePart(folder, Vector3.new(6, 0.5, 6), baseCFrame * CFrame.new(0, 2.3, 0), HAND_CYAN, Enum.Material.Neon, 0)
	table.insert(parts, eye)

	local fingerXs = {-3.5, -1.75, 0, 1.75, 3.5}
	for i, x in ipairs(fingerXs) do
		local seg1 = makePart(folder, Vector3.new(1.6, 3, 1.6), baseCFrame * CFrame.new(x, 3.5, 0), HAND_TAN, Enum.Material.SmoothPlastic, 0)
		table.insert(parts, seg1)

		local joint1 = makePart(folder, Vector3.new(1.2, 0.6, 1.2), baseCFrame * CFrame.new(x, 5.1, 0), HAND_CYAN, Enum.Material.Neon, 0)
		table.insert(parts, joint1)

		local chain1 = makePart(folder, Vector3.new(0.4, 1.5, 0.4), baseCFrame * CFrame.new(x, 5.8, 0), HAND_CHAIN, Enum.Material.Metal, 0)
		table.insert(parts, chain1)

		local seg2Y = openFingers and 7.2 or 6.8
		local seg2 = makePart(folder, Vector3.new(1.4, 2.5, 1.4), baseCFrame * CFrame.new(x, seg2Y, 0), HAND_TAN, Enum.Material.SmoothPlastic, 0)
		table.insert(parts, seg2)

		local joint2 = makePart(folder, Vector3.new(1.2, 0.6, 1.2), baseCFrame * CFrame.new(x, seg2Y + 1.3, 0), HAND_CYAN, Enum.Material.Neon, 0)
		table.insert(parts, joint2)

		local seg3Y = openFingers and seg2Y + 2.5 or seg2Y + 1.8
		local seg3 = makePart(folder, Vector3.new(1.2, 2, 1.2), baseCFrame * CFrame.new(x, seg3Y, 0), HAND_TAN, Enum.Material.SmoothPlastic, 0)
		table.insert(parts, seg3)
	end

	local thumbJoint = makePart(folder, Vector3.new(1.2, 0.6, 1.2), baseCFrame * CFrame.new(-5.5, 0, 0), HAND_CYAN, Enum.Material.Neon, 0)
	table.insert(parts, thumbJoint)

	local thumb = makePart(folder, Vector3.new(2, 3, 1.5), baseCFrame * CFrame.new(-6.8, -1, 0), HAND_TAN, Enum.Material.SmoothPlastic, 0)
	table.insert(parts, thumb)

	local thumbTip = makePart(folder, Vector3.new(1.5, 2, 1.2), baseCFrame * CFrame.new(-7.8, -2.8, 0), HAND_TAN, Enum.Material.SmoothPlastic, 0)
	table.insert(parts, thumbTip)

	return parts
end

------------------------------------------------------------
-- GUN HAND
------------------------------------------------------------
local gunHandActive = false
local gunHandFolder = nil
local gunHandConnection = nil
local gunHandClickConn = nil
local gunHandParts = {}

local function fireGunHand()
	if not gunHandActive or not rootPart then return end
	local cam = workspace.CurrentCamera
	local startPos = gunHandParts[1] and gunHandParts[1].Position or rootPart.Position
	local dir = cam.CFrame.LookVector
	local mouse = player:GetMouse()
	if mouse and mouse.Hit then
		dir = (mouse.Hit.Position - startPos).Unit
	end

	for i = 1, 5 do
		local bullet = Instance.new("Part")
		bullet.Size = Vector3.new(2, 2, 2)
		bullet.Color = HAND_TAN
		bullet.Material = Enum.Material.Neon
		bullet.Anchored = false
		bullet.CanCollide = false
		bullet.CFrame = CFrame.new(startPos + dir * (5 + i))
		bullet.Parent = workspace

		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
		bv.Velocity = dir * 200
		bv.Parent = bullet

		Debris:AddItem(bv, 2)
		Debris:AddItem(bullet, 5)

		task.spawn(function()
			local hit = false
			bullet.Touched:Connect(function(part)
				if hit then return end
				local model = part:FindFirstAncestorOfClass("Model")
				if model then
					local hitPlayer = Players:GetPlayerFromCharacter(model)
					if hitPlayer and hitPlayer ~= player then
						hit = true
						local hRoot = model:FindFirstChild("HumanoidRootPart")
						if hRoot then
							local hbv = Instance.new("BodyVelocity")
							hbv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
							hbv.Velocity = dir * 300 + Vector3.new(0, 200, 0)
							hbv.Parent = hRoot
							Debris:AddItem(hbv, 0.5)
						end
					end
				end
			end)
		end)
	end
end

local function startGunHand()
	if gunHandActive then return end
	gunHandActive = true

	if gunHandFolder then gunHandFolder:Destroy() end
	gunHandFolder = Instance.new("Folder")
	gunHandFolder.Name = "CoolKidGunHand"
	gunHandFolder.Parent = workspace

	local cam = workspace.CurrentCamera
	local basePos = rootPart.Position + cam.CFrame.LookVector * 10 + cam.CFrame.UpVector * 2
	local baseCF = CFrame.new(basePos, basePos + cam.CFrame.LookVector)
	gunHandParts = buildHand(gunHandFolder, baseCF, false)

	gunHandConnection = RunService.RenderStepped:Connect(function(dt)
		if not gunHandActive or not rootPart or not gunHandParts[1] then return end
		local cam = workspace.CurrentCamera
		local offset = Vector3.new(4, 2, 10)
		local basePos = rootPart.Position
			+ cam.CFrame.LookVector * offset.Z
			+ cam.CFrame.RightVector * offset.X
			+ cam.CFrame.UpVector * offset.Y
		local baseCF = CFrame.new(basePos, basePos + cam.CFrame.LookVector)

		local delta = baseCF * gunHandParts[1].CFrame:Inverse()
		for _, p in ipairs(gunHandParts) do
			if p and p.Parent then
				p.CFrame = delta * p.CFrame
				p.AssemblyLinearVelocity = Vector3.zero
				p.AssemblyAngularVelocity = Vector3.zero
			end
		end
	end)

	gunHandClickConn = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			fireGunHand()
		end
	end)
end

local function stopGunHand()
	gunHandActive = false
	if gunHandConnection then gunHandConnection:Disconnect() gunHandConnection = nil end
	if gunHandClickConn then gunHandClickConn:Disconnect() gunHandClickConn = nil end
	if gunHandFolder then gunHandFolder:Destroy() gunHandFolder = nil end
	gunHandParts = {}
end

player.CharacterAdded:Connect(function() if gunHandActive then stopGunHand() end end)

------------------------------------------------------------
-- SQUISH HAND
------------------------------------------------------------
local squishHandActive = false
local squishHandFolder = nil
local squishHandConnection = nil
local squishHandClickConn = nil
local squishHandParts = {}
local squishOffset = 0
local squishSlam = false

local function startSquishHand()
	if squishHandActive then return end
	squishHandActive = true

	if squishHandFolder then squishHandFolder:Destroy() end
	squishHandFolder = Instance.new("Folder")
	squishHandFolder.Name = "CoolKidSquishHand"
	squishHandFolder.Parent = workspace

	local cam = workspace.CurrentCamera
	local basePos = rootPart.Position + cam.CFrame.LookVector * 10 + cam.CFrame.UpVector * 2
	local baseCF = CFrame.new(basePos, basePos + cam.CFrame.LookVector)
	squishHandParts = buildHand(squishHandFolder, baseCF, true)

	squishHandConnection = RunService.RenderStepped:Connect(function(dt)
		if not squishHandActive or not rootPart or not squishHandParts[1] then return end
		local cam = workspace.CurrentCamera

		if squishSlam then
			squishOffset = squishOffset + dt * 80
			if squishOffset > 25 then squishOffset = 25 end
		else
			squishOffset = math.max(0, squishOffset - dt * 60)
		end

		local basePos = rootPart.Position
			+ cam.CFrame.LookVector * (10 + squishOffset)
			+ cam.CFrame.UpVector * 4
		local baseCF = CFrame.new(basePos, basePos + cam.CFrame.LookVector)

		local delta = baseCF * squishHandParts[1].CFrame:Inverse()
		for _, p in ipairs(squishHandParts) do
			if p and p.Parent then
				p.CFrame = delta * p.CFrame
				p.AssemblyLinearVelocity = Vector3.zero
				p.AssemblyAngularVelocity = Vector3.zero
			end
		end

		if squishSlam then
			local palm = squishHandParts[1]
			if palm then
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= player and p.Character then
						local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
						if tRoot and (tRoot.Position - palm.Position).Magnitude < 12 then
							for _, part in ipairs(p.Character:GetDescendants()) do
								if part:IsA("BasePart") and part.Size.Y > 0.3 then
									part.Size = Vector3.new(part.Size.X, part.Size.Y * 0.5, part.Size.Z)
								end
							end
						end
					end
				end
			end
		end

		if squishSlam and squishOffset >= 25 then
			task.delay(0.15, function() squishSlam = false end)
		end
	end)

	squishHandClickConn = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			squishSlam = true
			squishOffset = 0
		end
	end)
end

local function stopSquishHand()
	squishHandActive = false
	if squishHandConnection then squishHandConnection:Disconnect() squishHandConnection = nil end
	if squishHandClickConn then squishHandClickConn:Disconnect() squishHandClickConn = nil end
	if squishHandFolder then squishHandFolder:Destroy() squishHandFolder = nil end
	squishHandParts = {}
end

player.CharacterAdded:Connect(function() if squishHandActive then stopSquishHand() end end)

------------------------------------------------------------
-- CLAP HAND
------------------------------------------------------------
local clapHandActive = false
local clapHandFolder = nil
local clapHandConnection = nil
local clapHandClickConn = nil
local clapParts = {}
local clapSpacing = 15
local clapActive = false

local function startClapHand()
	if clapHandActive then return end
	clapHandActive = true

	if clapHandFolder then clapHandFolder:Destroy() end
	clapHandFolder = Instance.new("Folder")
	clapHandFolder.Name = "CoolKidClapHands"
	clapHandFolder.Parent = workspace

	clapParts = {}

	local cam = workspace.CurrentCamera
	local centerPos = rootPart.Position + cam.CFrame.LookVector * 10
	local baseCF = CFrame.new(centerPos, centerPos + cam.CFrame.LookVector)

	local leftFolder = Instance.new("Folder")
	leftFolder.Name = "LeftHand"
	leftFolder.Parent = clapHandFolder

	local rightFolder = Instance.new("Folder")
	rightFolder.Name = "RightHand"
	rightFolder.Parent = clapHandFolder

	clapParts.left = buildHand(leftFolder, baseCF * CFrame.new(-clapSpacing, 0, 0), true)
	clapParts.right = buildHand(rightFolder, baseCF * CFrame.new(clapSpacing, 0, 0), true)

	clapHandConnection = RunService.RenderStepped:Connect(function(dt)
		if not clapHandActive or not rootPart then return end
		local cam = workspace.CurrentCamera
		local centerPos = rootPart.Position + cam.CFrame.LookVector * 10
		local baseCF = CFrame.new(centerPos, centerPos + cam.CFrame.LookVector)

		local spacing = clapActive and 2 or clapSpacing

		local leftTarget = baseCF * CFrame.new(-spacing, 0, 0)
		local rightTarget = baseCF * CFrame.new(spacing, 0, 0)

		local function moveGroup(parts, target)
			local delta = target * parts[1].CFrame:Inverse()
			for _, p in ipairs(parts) do
				if p and p.Parent then
					p.CFrame = delta * p.CFrame
					p.AssemblyLinearVelocity = Vector3.zero
					p.AssemblyAngularVelocity = Vector3.zero
				end
			end
		end

		moveGroup(clapParts.left, leftTarget)
		moveGroup(clapParts.right, rightTarget)

		if clapActive then
			local leftPalm = clapParts.left[1]
			local rightPalm = clapParts.right[1]
			local midPoint = (leftPalm.Position + rightPalm.Position) / 2
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= player and p.Character then
					local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
					if tRoot and (tRoot.Position - midPoint).Magnitude < 8 then
						local bv = Instance.new("BodyVelocity")
						bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
						bv.Velocity = Vector3.new(0, 300, 0)
						bv.Parent = tRoot
						Debris:AddItem(bv, 0.5)
					end
				end
			end
		end
	end)

	clapHandClickConn = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			clapActive = true
			task.delay(0.2, function() clapActive = false end)
		end
	end)
end

local function stopClapHand()
	clapHandActive = false
	if clapHandConnection then clapHandConnection:Disconnect() clapHandConnection = nil end
	if clapHandClickConn then clapHandClickConn:Disconnect() clapHandClickConn = nil end
	if clapHandFolder then clapHandFolder:Destroy() clapHandFolder = nil end
	clapParts = {}
end

player.CharacterAdded:Connect(function() if clapHandActive then stopClapHand() end end)

------------------------------------------------------------
-- MM2 FUNCTIONS
------------------------------------------------------------
local KILL_AURA_RANGE = 7

local function findMurderer()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Backpack and p.Backpack:FindFirstChild("Knife") then return p end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("Knife") then return p end
	end
	return nil
end

local function findSheriff()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Backpack and p.Backpack:FindFirstChild("Gun") then return p end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("Gun") then return p end
	end
	return nil
end

local function killClosest()
	if not player.Character then return end
	if not player.Character:FindFirstChild("Knife") then
		if player.Backpack and player.Backpack:FindFirstChild("Knife") then
			pcall(function() humanoid:EquipTool(player.Backpack:FindFirstChild("Knife")) end)
			task.wait(0.1)
		else return end
	end
	if not player.Character:FindFirstChild("Knife") or not rootPart then return end

	local nearest, dist = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character then
			local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
			if tRoot then
				local d = (tRoot.Position - rootPart.Position).Magnitude
				if d < dist then nearest = p dist = d end
			end
		end
	end
	if not nearest then return end
	local tRoot = nearest.Character:FindFirstChild("HumanoidRootPart")
	if not tRoot then return end

	pcall(function()
		tRoot.Anchored = true
		tRoot.CFrame = rootPart.CFrame + rootPart.CFrame.LookVector * 2
	end)
	task.wait(0.1)
	pcall(function() player.Character.Knife.Stab:FireServer("Slash") end)
end

local killAuraActive = false
local killAuraConnection

local function startKillAura()
	killAuraActive = true
	killAuraConnection = RunService.Heartbeat:Connect(function()
		if not killAuraActive or not player.Character then return end
		if not player.Character:FindFirstChild("Knife") then
			if player.Backpack and player.Backpack:FindFirstChild("Knife") then
				pcall(function() humanoid:EquipTool(player.Backpack:FindFirstChild("Knife")) end)
			end
			return
		end
		if not rootPart then return end

		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and p.Character then
				local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
				local tHum = p.Character:FindFirstChildOfClass("Humanoid")
				if tRoot and tHum and tHum.Health > 0 then
					if (tRoot.Position - rootPart.Position).Magnitude < KILL_AURA_RANGE then
						pcall(function()
							tRoot.Anchored = true
							tRoot.CFrame = rootPart.CFrame + rootPart.CFrame.LookVector * 2
						end)
						task.wait(0.1)
						pcall(function() player.Character.Knife.Stab:FireServer("Slash") end)
						return
					end
				end
			end
		end
	end)
end

local function stopKillAura()
	killAuraActive = false
	if killAuraConnection then killAuraConnection:Disconnect() killAuraConnection = nil end
end

player.CharacterAdded:Connect(function() if killAuraActive then stopKillAura() end end)

local sheriffAuraActive = false
local sheriffAuraConnection
local sheriffLastShot = 0

local function startSheriffAura()
	sheriffAuraActive = true
	sheriffAuraConnection = RunService.Heartbeat:Connect(function()
		if not sheriffAuraActive or not player.Character or not rootPart then return end
		if tick() - sheriffLastShot < 1 then return end

		local murderer = findMurderer()
		if not murderer or not murderer.Character then return end

		local gun = player.Character:FindFirstChild("Gun")
		if not gun and player.Backpack and player.Backpack:FindFirstChild("Gun") then
			pcall(function() humanoid:EquipTool(player.Backpack:FindFirstChild("Gun")) end)
			gun = player.Character:FindFirstChild("Gun")
		end
		if not gun then return end

		local tRoot = murderer.Character:FindFirstChild("HumanoidRootPart")
		if not tRoot then return end

		local shoot = gun:FindFirstChild("Shoot")
		if shoot then
			sheriffLastShot = tick()
			pcall(function()
				shoot:FireServer(CFrame.new(rootPart.Position), CFrame.new(tRoot.Position))
			end)
		end
	end)
end

local function stopSheriffAura()
	sheriffAuraActive = false
	if sheriffAuraConnection then sheriffAuraConnection:Disconnect() sheriffAuraConnection = nil end
end

player.CharacterAdded:Connect(function() if sheriffAuraActive then stopSheriffAura() end end)

------------------------------------------------------------
-- ROLE ESP
------------------------------------------------------------
local roleESPActive = false
local roleESPObjects = {}

local function addRoleHighlight(targetPlayer, color, labelText)
	if not targetPlayer or not targetPlayer.Character then return end
	if roleESPObjects[targetPlayer] then return end

	local highlight = Instance.new("Highlight")
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.FillTransparency = 0.5
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Adornee = targetPlayer.Character
	highlight.Parent = screenGui

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 4, 0)
	billboard.AlwaysOnTop = true
	billboard.Adornee = targetPlayer.Character:FindFirstChild("Head")
	billboard.Parent = screenGui

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 1, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = labelText .. ": " .. targetPlayer.Name
	nameLabel.TextColor3 = color
	nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	nameLabel.TextStrokeTransparency = 0
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 16
	nameLabel.Parent = billboard

	roleESPObjects[targetPlayer] = {highlight = highlight, billboard = billboard}
end

local function startRoleESP()
	roleESPActive = true
	local updateConn
	updateConn = RunService.Heartbeat:Connect(function()
		if not roleESPActive then updateConn:Disconnect() return end
		local murderer = findMurderer()
		if murderer and not roleESPObjects[murderer] then
			addRoleHighlight(murderer, Color3.fromRGB(255, 0, 0), "MURDERER")
		end
		local sheriff = findSheriff()
		if sheriff and not roleESPObjects[sheriff] then
			addRoleHighlight(sheriff, Color3.fromRGB(0, 100, 255), "SHERIFF")
		end
	end)
end

local function stopRoleESP()
	roleESPActive = false
	for p, data in pairs(roleESPObjects) do
		if data.highlight then data.highlight:Destroy() end
		if data.billboard then data.billboard:Destroy() end
	end
	roleESPObjects = {}
end

------------------------------------------------------------
-- NAT DISASTER PREDICTOR
------------------------------------------------------------
local disasterLabel = Instance.new("TextLabel")
disasterLabel.Size = UDim2.new(0, 350, 0, 50)
disasterLabel.Position = UDim2.new(0.5, -175, 0, 10)
disasterLabel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
disasterLabel.BackgroundTransparency = 0.3
disasterLabel.BorderSizePixel = 0
disasterLabel.Text = "Disaster: Scanning..."
disasterLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
disasterLabel.Font = Enum.Font.Arcade
disasterLabel.TextSize = 24
disasterLabel.Visible = false
disasterLabel.Parent = screenGui

local predictorActive = false
local predictorConnection

local function findDisasterName()
	local playerGui = player:FindFirstChild("PlayerGui")
	if playerGui then
		for _, gui in ipairs(playerGui:GetDescendants()) do
			if gui:IsA("TextLabel") and gui.Visible then
				local t = gui.Text
				if t and #t > 3 then
					local lower = t:lower()
					if lower:find("tornado") or lower:find("tsunami") or lower:find("earthquake")
						or lower:find("meteor") or lower:find("fire") or lower:find("flood")
						or lower:find("blizzard") or lower:find("sandstorm") or lower:find("thunderstorm")
						or lower:find("volcano") or lower:find("acid") or lower:find("avalanche")
						or lower:find("virus") or lower:find("disaster") then
						return t
					end
				end
			end
		end
	end
	local map = workspace:FindFirstChild("Map")
	if map then
		for _, obj in ipairs(map:GetChildren()) do
			local n = obj.Name:lower()
			if n:find("tornado") or n:find("tsunami") or n:find("earthquake")
				or n:find("meteor") or n:find("fire") or n:find("flood")
				or n:find("blizzard") or n:find("sandstorm") or n:find("thunderstorm")
				or n:find("volcano") or n:find("acid") or n:find("avalanche")
				or n:find("virus") then
				return "Disaster: " .. obj.Name
			end
		end
	end
	for _, obj in ipairs(game:GetDescendants()) do
		if obj:IsA("StringValue") then
			local n = obj.Name:lower()
			if n:find("disaster") or n:find("weather") or n:find("currentevent") then
				return "Disaster: " .. tostring(obj.Value)
			end
		end
	end
	return "Disaster: Scanning..."
end

local function startPredictor()
	predictorActive = true
	disasterLabel.Visible = true
	predictorConnection = RunService.Heartbeat:Connect(function()
		if not predictorActive then return end
		local name = findDisasterName()
		if name then disasterLabel.Text = name end
	end)
end

local function stopPredictor()
	predictorActive = false
	disasterLabel.Visible = false
	if predictorConnection then predictorConnection:Disconnect() predictorConnection = nil end
end

------------------------------------------------------------
-- NAT SAFE SPOT ESP
------------------------------------------------------------
local safeSpotActive = false
local safeSpotHighlights = {}

local function startSafeSpot()
	safeSpotActive = true
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") or obj:IsA("BasePart") then
			local n = obj.Name:lower()
			if n:find("building") or n:find("house") or n:find("tower") or n:find("struct") then
				local h = Instance.new("Highlight")
				h.Adornee = obj
				h.FillColor = Color3.fromRGB(0, 255, 0)
				h.OutlineColor = Color3.fromRGB(255, 255, 255)
				h.FillTransparency = 0.7
				h.OutlineTransparency = 0
				h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				h.Parent = screenGui
				table.insert(safeSpotHighlights, h)
			end
		end
	end
end

local function stopSafeSpot()
	safeSpotActive = false
	for _, h in ipairs(safeSpotHighlights) do if h then h:Destroy() end end
	safeSpotHighlights = {}
end

------------------------------------------------------------
-- NAT STRUCTURE ESP
------------------------------------------------------------
local structActive = false
local structHighlights = {}

local function startStruct()
	structActive = true
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Size.Magnitude > 15 then
			local h = Instance.new("Highlight")
			h.Adornee = obj
			h.FillColor = Color3.fromRGB(255, 200, 0)
			h.OutlineColor = Color3.fromRGB(255, 255, 255)
			h.FillTransparency = 0.8
			h.OutlineTransparency = 0.3
			h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			h.Parent = screenGui
			table.insert(structHighlights, h)
		end
	end
end

local function stopStruct()
	structActive = false
	for _, h in ipairs(structHighlights) do if h then h:Destroy() end end
	structHighlights = {}
end

------------------------------------------------------------
-- TP PANEL
------------------------------------------------------------
local tpPanel = Instance.new("Frame")
tpPanel.Size = UDim2.new(0, 200, 0, 300)
tpPanel.Position = UDim2.new(1, -210, 0.5, -150)
tpPanel.BackgroundColor3 = BG_DARK
tpPanel.BorderSizePixel = 0
tpPanel.Visible = false
tpPanel.Parent = screenGui

local tpPC = Instance.new("UICorner")
tpPC.CornerRadius = UDim.new(0, 6)
tpPC.Parent = tpPanel

local tpPS = Instance.new("UIStroke")
tpPS.Color = RED_BORDER
tpPS.Thickness = 2
tpPS.Parent = tpPanel

local tpTitle = Instance.new("TextLabel")
tpTitle.Size = UDim2.new(1, 0, 0, 28)
tpTitle.BackgroundColor3 = RED_DARK
tpTitle.BorderSizePixel = 0
tpTitle.Text = "TP to Player"
tpTitle.TextColor3 = TEXT_WHITE
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 14
tpTitle.Parent = tpPanel

local tpTC = Instance.new("UICorner")
tpTC.CornerRadius = UDim.new(0, 6)
tpTC.Parent = tpTitle

local tpClose = Instance.new("TextButton")
tpClose.Size = UDim2.new(0, 22, 0, 22)
tpClose.Position = UDim2.new(1, -28, 0, 3)
tpClose.BackgroundColor3 = RED_BRIGHT
tpClose.BorderSizePixel = 0
tpClose.Text = "X"
tpClose.TextColor3 = TEXT_WHITE
tpClose.Font = Enum.Font.GothamBold
tpClose.TextSize = 13
tpClose.Parent = tpTitle

local tpCC = Instance.new("UICorner")
tpCC.CornerRadius = UDim.new(0, 4)
tpCC.Parent = tpClose

tpClose.MouseButton1Click:Connect(function() tpPanel.Visible = false end)

local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1, -12, 1, -40)
tpScroll.Position = UDim2.new(0, 6, 0, 34)
tpScroll.BackgroundColor3 = BG_PANEL
tpScroll.BorderSizePixel = 0
tpScroll.ScrollBarThickness = 4
tpScroll.ScrollBarImageColor3 = RED_BRIGHT
tpScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tpScroll.Parent = tpPanel

local tpSC = Instance.new("UICorner")
tpSC.CornerRadius = UDim.new(0, 4)
tpSC.Parent = tpScroll

local tpList = Instance.new("UIListLayout")
tpList.Padding = UDim.new(0, 4)
tpList.Parent = tpScroll

local tpPad = Instance.new("UIPadding")
tpPad.PaddingTop = UDim.new(0, 6)
tpPad.PaddingLeft = UDim.new(0, 6)
tpPad.PaddingRight = UDim.new(0, 6)
tpPad.Parent = tpScroll

local function refreshTPList()
	for _, child in ipairs(tpScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -8, 0, 28)
			btn.BackgroundColor3 = RED_BRIGHT
			btn.BorderSizePixel = 0
			btn.Text = p.Name
			btn.TextColor3 = TEXT_WHITE
			btn.Font = Enum.Font.GothamBold
			btn.TextSize = 12
			btn.Parent = tpScroll

			local bc = Instance.new("UICorner")
			bc.CornerRadius = UDim.new(0, 4)
			bc.Parent = btn

			btn.MouseButton1Click:Connect(function()
				if not p.Character then return end
				local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
				if not tRoot or not rootPart then return end
				rootPart.CFrame = tRoot.CFrame * CFrame.new(0, 3, 0)
			end)
		end
	end
	tpScroll.CanvasSize = UDim2.new(0, 0, 0, tpList.AbsoluteContentSize.Y + 12)
end

Players.PlayerAdded:Connect(function() if tpPanel.Visible then refreshTPList() end end)
Players.PlayerRemoving:Connect(function() if tpPanel.Visible then refreshTPList() end end)

------------------------------------------------------------
-- FLING PANEL
------------------------------------------------------------
local flingPanel = Instance.new("Frame")
flingPanel.Size = UDim2.new(0, 200, 0, 300)
flingPanel.Position = UDim2.new(1, -420, 0.5, -150)
flingPanel.BackgroundColor3 = BG_DARK
flingPanel.BorderSizePixel = 0
flingPanel.Visible = false
flingPanel.Parent = screenGui

local fpCorner = Instance.new("UICorner")
fpCorner.CornerRadius = UDim.new(0, 6)
fpCorner.Parent = flingPanel

local fpStroke = Instance.new("UIStroke")
fpStroke.Color = RED_BORDER
fpStroke.Thickness = 2
fpStroke.Parent = flingPanel

local fpTitle = Instance.new("TextLabel")
fpTitle.Size = UDim2.new(1, 0, 0, 28)
fpTitle.BackgroundColor3 = RED_DARK
fpTitle.BorderSizePixel = 0
fpTitle.Text = "Fling Player"
fpTitle.TextColor3 = TEXT_WHITE
fpTitle.Font = Enum.Font.GothamBold
fpTitle.TextSize = 14
fpTitle.Parent = flingPanel

local fpTC = Instance.new("UICorner")
fpTC.CornerRadius = UDim.new(0, 6)
fpTC.Parent = fpTitle

local fpClose = Instance.new("TextButton")
fpClose.Size = UDim2.new(0, 22, 0, 22)
fpClose.Position = UDim2.new(1, -28, 0, 3)
fpClose.BackgroundColor3 = RED_BRIGHT
fpClose.BorderSizePixel = 0
fpClose.Text = "X"
fpClose.TextColor3 = TEXT_WHITE
fpClose.Font = Enum.Font.GothamBold
fpClose.TextSize = 13
fpClose.Parent = fpTitle

local fpCC = Instance.new("UICorner")
fpCC.CornerRadius = UDim.new(0, 4)
fpCC.Parent = fpClose

fpClose.MouseButton1Click:Connect(function() flingPanel.Visible = false end)

local fpScroll = Instance.new("ScrollingFrame")
fpScroll.Size = UDim2.new(1, -12, 1, -40)
fpScroll.Position = UDim2.new(0, 6, 0, 34)
fpScroll.BackgroundColor3 = BG_PANEL
fpScroll.BorderSizePixel = 0
fpScroll.ScrollBarThickness = 4
fpScroll.ScrollBarImageColor3 = RED_BRIGHT
fpScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
fpScroll.Parent = flingPanel

local fpSC = Instance.new("UICorner")
fpSC.CornerRadius = UDim.new(0, 4)
fpSC.Parent = fpScroll

local fpList = Instance.new("UIListLayout")
fpList.Padding = UDim.new(0, 4)
fpList.Parent = fpScroll

local fpPad = Instance.new("UIPadding")
fpPad.PaddingTop = UDim.new(0, 6)
fpPad.PaddingLeft = UDim.new(0, 6)
fpPad.PaddingRight = UDim.new(0, 6)
fpPad.Parent = fpScroll

local function refreshFlingList()
	for _, child in ipairs(fpScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -8, 0, 28)
			btn.BackgroundColor3 = RED_BRIGHT
			btn.BorderSizePixel = 0
			btn.Text = p.Name
			btn.TextColor3 = TEXT_WHITE
			btn.Font = Enum.Font.GothamBold
			btn.TextSize = 12
			btn.Parent = fpScroll

			local bc = Instance.new("UICorner")
			bc.CornerRadius = UDim.new(0, 4)
			bc.Parent = btn

			btn.MouseButton1Click:Connect(function() flingPlayer(p) end)
		end
	end
	fpScroll.CanvasSize = UDim2.new(0, 0, 0, fpList.AbsoluteContentSize.Y + 12)
end

Players.PlayerAdded:Connect(function() if flingPanel.Visible then refreshFlingList() end end)
Players.PlayerRemoving:Connect(function() if flingPanel.Visible then refreshFlingList() end end)

------------------------------------------------------------
-- MAIN PAGE
------------------------------------------------------------
makeSlider("Main", "WalkSpeed", 15, 200, 16, function(v)
	if humanoid and humanoid.Parent then humanoid.WalkSpeed = v end
end)

makeButton("Main", "Fly ON/OFF", function(btn)
	if flying then stopFly() btn.Text = "Fly ON/OFF" else startFly() btn.Text = "Fly: ON" end
end)

makeButton("Main", "Noclip: OFF", function(btn)
	if noclip then stopNoclip() btn.Text = "Noclip: OFF" else startNoclip() btn.Text = "Noclip: ON" end
end)

makeButton("Main", "Inf Jump: OFF", function(btn)
	if infJump then stopInfJump() btn.Text = "Inf Jump: OFF" else startInfJump() btn.Text = "Inf Jump: ON" end
end)

makeButton("Main", "God Mode: OFF", function(btn)
	if godModeActive then stopGodMode() btn.Text = "God Mode: OFF" else startGodMode() btn.Text = "God Mode: ON" end
end)

makeButton("Main", "Anti-Fling: OFF", function(btn)
	if antiFlingActive then stopAntiFling() btn.Text = "Anti-Fling: OFF" else startAntiFling() btn.Text = "Anti-Fling: ON" end
end)

------------------------------------------------------------
-- TP PAGE
------------------------------------------------------------
makeButton("TP", "Open TP Menu", function()
	tpPanel.Visible = not tpPanel.Visible
	if tpPanel.Visible then refreshTPList() end
end)

makeButton("TP", "TP to Closest", function()
	local closest = findClosestPlayer()
	if closest and closest.Character then
		local tRoot = closest.Character:FindFirstChild("HumanoidRootPart")
		if tRoot and rootPart then rootPart.CFrame = tRoot.CFrame * CFrame.new(0, 3, 0) end
	end
end)

------------------------------------------------------------
-- FLING PAGE
------------------------------------------------------------
makeButton("Fling", "Fling Closest", function()
	local target = findClosestPlayer()
	if target then flingPlayer(target) end
end)

makeButton("Fling", "Open Fling Menu", function()
	flingPanel.Visible = not flingPanel.Visible
	if flingPanel.Visible then refreshFlingList() end
end)

makeButton("Fling", "Fling Aura: OFF", function(btn)
	if flingAuraActive then stopFlingAura() btn.Text = "Fling Aura: OFF" else startFlingAura() btn.Text = "Fling Aura: ON" end
end)

------------------------------------------------------------
-- VISUAL PAGE
------------------------------------------------------------
makeButton("Visual", "ESP: OFF", function(btn)
	if espActive then stopESP() btn.Text = "ESP: OFF" else startESP() btn.Text = "ESP: ON" end
end)

makeButton("Visual", "Ghost: OFF", function(btn)
	if ghost then ghost = false removeGhost() btn.Text = "Ghost: OFF" else ghost = true applyGhost() btn.Text = "Ghost: ON" end
end)

makeButton("Visual", "Red Glow: OFF", function(btn)
	if redGlowActive then stopRedGlow() btn.Text = "Red Glow: OFF" else startRedGlow() btn.Text = "Red Glow: ON" end
end)

------------------------------------------------------------
-- FUN PAGE
------------------------------------------------------------
makeButton("Fun", "Say JOIN TEAM c00lkid", function() sayMessage() end)

makeButton("Fun", "Spam Chat: OFF", function(btn)
	if chatSpamActive then stopChatSpam() btn.Text = "Spam Chat: OFF" else startChatSpam() btn.Text = "Spam Chat: ON" end
end)

------------------------------------------------------------
-- C00LKIDD PAGE
------------------------------------------------------------
makeButton("c00lkidd", "Super Ring: OFF", function(btn)
	if superRingActive then stopSuperRing() btn.Text = "Super Ring: OFF" else startSuperRing() btn.Text = "Super Ring: ON" end
end)

makeButton("c00lkidd", "Tornado: OFF", function(btn)
	if tornadoActive then stopTornado() btn.Text = "Tornado: OFF" else startTornado() btn.Text = "Tornado: ON" end
end)

makeButton("c00lkidd", "Red Pad: OFF", function(btn)
	if redPadActive then stopRedPad() btn.Text = "Red Pad: OFF" else startRedPad() btn.Text = "Red Pad: ON" end
end)

makeButton("c00lkidd", "Red Sky: OFF", function(btn)
	if redSkyActive then stopRedSky() btn.Text = "Red Sky: OFF" else startRedSky() btn.Text = "Red Sky: ON" end
end)

makeButton("c00lkidd", "Cage: OFF", function(btn)
	if cageActive then stopCage() btn.Text = "Cage: OFF" else startCage() btn.Text = "Cage: ON" end
end)

makeButton("c00lkidd", "Block Storm: OFF", function(btn)
	if stormActive then stopStorm() btn.Text = "Block Storm: OFF" else startStorm() btn.Text = "Block Storm: ON" end
end)

makeButton("c00lkidd", "Black Hole: OFF", function(btn)
	if holeActive then stopBlackHole() btn.Text = "Black Hole: OFF" else startBlackHole() btn.Text = "Black Hole: ON" end
end)

makeSlider("c00lkidd", "Black Hole Range", 5, 50, 15, function(v)
	BLACK_HOLE_RANGE = v
end)

makeSlider("c00lkidd", "Black Hole Force", 20, 300, 100, function(v)
	BLACK_HOLE_FORCE = v
end)

makeButton("c00lkidd", "Gun Hand: OFF", function(btn)
	if gunHandActive then stopGunHand() btn.Text = "Gun Hand: OFF" else startGunHand() btn.Text = "Gun Hand: ON" end
end)

makeButton("c00lkidd", "Squish Hand: OFF", function(btn)
	if squishHandActive then stopSquishHand() btn.Text = "Squish Hand: OFF" else startSquishHand() btn.Text = "Squish Hand: ON" end
end)

makeButton("c00lkidd", "Clap Hand: OFF", function(btn)
	if clapHandActive then stopClapHand() btn.Text = "Clap Hand: OFF" else startClapHand() btn.Text = "Clap Hand: ON" end
end)

------------------------------------------------------------
-- NAT PAGE
------------------------------------------------------------
makeButton("Nat", "Disaster Predictor: OFF", function(btn)
	if predictorActive then stopPredictor() btn.Text = "Disaster Predictor: OFF" else startPredictor() btn.Text = "Disaster Predictor: ON" end
end)

makeButton("Nat", "Safe Spot ESP: OFF", function(btn)
	if safeSpotActive then stopSafeSpot() btn.Text = "Safe Spot ESP: OFF" else startSafeSpot() btn.Text = "Safe Spot ESP: ON" end
end)

makeButton("Nat", "Structure ESP: OFF", function(btn)
	if structActive then stopStruct() btn.Text = "Structure ESP: OFF" else startStruct() btn.Text = "Structure ESP: ON" end
end)

------------------------------------------------------------
-- MM2 PAGE
------------------------------------------------------------
makeButton("MM2", "Kill Closest", function() killClosest() end)

makeSlider("MM2", "Kill Aura Range", 0, 50, 7, function(v)
	KILL_AURA_RANGE = v
end)

makeButton("MM2", "Kill Aura: OFF", function(btn)
	if killAuraActive then stopKillAura() btn.Text = "Kill Aura: OFF" else startKillAura() btn.Text = "Kill Aura: ON" end
end)

makeButton("MM2", "Sheriff Aura: OFF", function(btn)
	if sheriffAuraActive then stopSheriffAura() btn.Text = "Sheriff Aura: OFF" else startSheriffAura() btn.Text = "Sheriff Aura: ON" end
end)

makeButton("MM2", "Role ESP: OFF", function(btn)
	if roleESPActive then stopRoleESP() btn.Text = "Role ESP: OFF" else startRoleESP() btn.Text = "Role ESP: ON" end
end)

------------------------------------------------------------
-- MUSIC PAGE
------------------------------------------------------------
local currentMusic = nil

local function playTrack(soundId, volume)
	if currentMusic then
		pcall(function()
			currentMusic:Stop()
			currentMusic:Destroy()
		end)
		currentMusic = nil
	end

	local sound = Instance.new("Sound")
	sound.SoundId = soundId
	sound.Volume = volume or 3
	sound.Looped = true
	sound.Parent = SoundService
	sound:Play()
	currentMusic = sound
end

local function stopAllMusic()
	if currentMusic then
		pcall(function()
			currentMusic:Stop()
			currentMusic:Destroy()
		end)
		currentMusic = nil
	end
	for _, s in ipairs(SoundService:GetChildren()) do
		if s:IsA("Sound") then
			pcall(function() s:Stop() end)
		end
	end
end

makeButton("Music", "Playful Master", function()
	playTrack("rbxassetid://115520764429413", 3)
end)

makeButton("Music", "c00lkidd Sound 1", function()
	playTrack("rbxassetid://72404297743317", 3)
end)

makeButton("Music", "c00lkidd Sound 2", function()
	playTrack("rbxassetid://99761211238896", 3)
end)

makeButton("Music", "Stop Music", function()
	stopAllMusic()
end)

print("c00lgui Reborn loaded — all features ready")
