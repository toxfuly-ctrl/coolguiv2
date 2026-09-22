-- c00lgui Reborn - Part 1 (GUI + Core)
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

-- Expose globals so Part 2 can access them
_G.c00lgui = {
	screenGui = screenGui,
	makeButton = makeButton,
	pages = pages,
	RED_BRIGHT = RED_BRIGHT,
	RED_DARK = RED_DARK,
	RED_BORDER = RED_BORDER,
	TEXT_WHITE = TEXT_WHITE,
	player = player,
}

print("Part 1 loaded — GUI built")
