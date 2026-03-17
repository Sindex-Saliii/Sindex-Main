local Library = {}
local ThemeStore = {}

local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- ================================
-- THEMES
-- ================================
local Themes = {
	Midnight = {
		Bg = Color3.fromRGB(10, 10, 15),
		Surface = Color3.fromRGB(18, 18, 24),
		Elevated = Color3.fromRGB(24, 24, 32),
		Primary = Color3.fromRGB(130, 87, 255),
		PrimarySoft = Color3.fromRGB(70, 45, 140),
		Text = Color3.fromRGB(245, 245, 255),
		TextSoft = Color3.fromRGB(160, 160, 180),
		Border = Color3.fromRGB(40, 40, 50),
		Success = Color3.fromRGB(70, 200, 120),
		Danger = Color3.fromRGB(240, 80, 80),
		Glow = Color3.fromRGB(130, 87, 255)
	},
	Rose = {
		Bg = Color3.fromRGB(20, 12, 20),
		Surface = Color3.fromRGB(30, 20, 28),
		Elevated = Color3.fromRGB(40, 28, 36),
		Primary = Color3.fromRGB(255, 120, 180),
		PrimarySoft = Color3.fromRGB(140, 60, 100),
		Text = Color3.fromRGB(255, 240, 245),
		TextSoft = Color3.fromRGB(200, 160, 180),
		Border = Color3.fromRGB(60, 40, 50),
		Success = Color3.fromRGB(150, 220, 150),
		Danger = Color3.fromRGB(255, 100, 120),
		Glow = Color3.fromRGB(255, 120, 180)
	},
	Ocean = {
		Bg = Color3.fromRGB(8, 18, 26),
		Surface = Color3.fromRGB(14, 26, 36),
		Elevated = Color3.fromRGB(20, 34, 46),
		Primary = Color3.fromRGB(70, 180, 240),
		PrimarySoft = Color3.fromRGB(30, 90, 130),
		Text = Color3.fromRGB(230, 245, 255),
		TextSoft = Color3.fromRGB(140, 180, 210),
		Border = Color3.fromRGB(30, 50, 70),
		Success = Color3.fromRGB(100, 220, 180),
		Danger = Color3.fromRGB(255, 100, 120),
		Glow = Color3.fromRGB(70, 180, 240)
	},
	Forest = {
		Bg = Color3.fromRGB(12, 22, 12),
		Surface = Color3.fromRGB(18, 30, 18),
		Elevated = Color3.fromRGB(26, 40, 24),
		Primary = Color3.fromRGB(120, 220, 120),
		PrimarySoft = Color3.fromRGB(50, 120, 60),
		Text = Color3.fromRGB(240, 250, 240),
		TextSoft = Color3.fromRGB(160, 200, 160),
		Border = Color3.fromRGB(40, 65, 40),
		Success = Color3.fromRGB(180, 230, 140),
		Danger = Color3.fromRGB(240, 120, 100),
		Glow = Color3.fromRGB(120, 220, 120)
	},
	Amethyst = {
		Bg = Color3.fromRGB(18, 12, 26),
		Surface = Color3.fromRGB(26, 18, 34),
		Elevated = Color3.fromRGB(34, 24, 44),
		Primary = Color3.fromRGB(180, 130, 255),
		PrimarySoft = Color3.fromRGB(100, 70, 160),
		Text = Color3.fromRGB(250, 245, 255),
		TextSoft = Color3.fromRGB(190, 170, 220),
		Border = Color3.fromRGB(50, 40, 70),
		Success = Color3.fromRGB(140, 220, 140),
		Danger = Color3.fromRGB(255, 100, 150),
		Glow = Color3.fromRGB(180, 130, 255)
	}
}

-- ================================
-- UTILITIES
-- ================================
local function AddToTheme(key, obj)
	ThemeStore[key] = ThemeStore[key] or {}
	table.insert(ThemeStore[key], obj)
end

local function GetIcon(icon)
	local icons = {
		home = "6023426917",
		settings = "6023426951",
		user = "6023426933",
		close = "6023426890",
		menu = "6023426919",
		check = "6023426888",
		arrow = "6023426883",
		plus = "6023426925",
		minus = "6023426920",
		edit = "6023426905",
		search = "6023426935",
		download = "6031082835",
		upload = "6031082843",
		refresh = "6031082839",
		lock = "6031082831",
		unlock = "6031082847",
		heart = "6031082823",
		star = "6031082841"
	}
	local id = icons[icon] or (type(icon) == "string" and icon:match("^%d+$") and icon) or "6023426917"
	return {
		Image = "rbxassetid://" .. id,
		ImageRectSize = Vector2.new(16, 16),
		ImageRectOffset = Vector2.new(0, 0)
	}
end

local function TweenObject(obj, props, duration, style)
	return Tween:Create(obj, TweenInfo.new(duration or 0.2, Enum.EasingStyle[style or "Quad"], Enum.EasingDirection.Out), props)
end

local function CreateClickEffect(parent, pos)
	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 0, 0, 0)
	circle.Position = UDim2.new(0, pos.X - parent.AbsolutePosition.X, 0, pos.Y - parent.AbsolutePosition.Y)
	circle.AnchorPoint = Vector2.new(0.5, 0.5)
	circle.BackgroundColor3 = Color3.new(1, 1, 1)
	circle.BackgroundTransparency = 0.7
	circle.BorderSizePixel = 0
	circle.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = circle
	
	TweenObject(circle, {
		Size = UDim2.new(0, parent.AbsoluteSize.X * 1.5, 0, parent.AbsoluteSize.X * 1.5),
		BackgroundTransparency = 1
	}, 0.8):Play()
	
	game:GetService("Debris"):AddItem(circle, 1)
end

local function MakeDraggable(dragObj, target)
	local dragging, dragStart, objStart
	
	dragObj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			objStart = target.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement) then
			local delta = input.Position - dragStart
			target.Position = UDim2.new(
				objStart.X.Scale, 
				objStart.X.Offset + delta.X, 
				objStart.Y.Scale, 
				objStart.Y.Offset + delta.Y
			)
		end
	end)
end

-- ================================
-- MAIN WINDOW
-- ================================
function Library:Window(config)
	local theme = Themes[config.Theme] or Themes.Midnight
	local gui = Instance.new("ScreenGui")
	gui.Name = "ModernUI"
	gui.Parent = RunService:IsStudio() and Players.LocalPlayer.PlayerGui or game:GetService("CoreGui")
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.ResetOnSpawn = false
	
	-- Main container with enhanced shadow
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.Parent = gui
	shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	shadow.Size = config.Size or UDim2.new(0, 600, 0, 500)
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.6
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(10, 10, 118, 118)
	AddToTheme("Bg", shadow)
	
	-- Main frame with rounded corners
	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Parent = shadow
	main.BackgroundColor3 = theme.Surface
	main.BorderSizePixel = 0
	main.Size = UDim2.new(1, -12, 1, -12)
	main.Position = UDim2.new(0.5, 0, 0.5, 0)
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	AddToTheme("Surface", main)
	
	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 20) -- Increased corner radius
	mainCorner.Parent = main
	
	-- Inner glow effect
	local innerGlow = Instance.new("Frame")
	innerGlow.Parent = main
	innerGlow.Size = UDim2.new(1, -2, 1, -2)
	innerGlow.Position = UDim2.new(0, 1, 0, 1)
	innerGlow.BackgroundColor3 = theme.Glow
	innerGlow.BackgroundTransparency = 0.95
	innerGlow.BorderSizePixel = 0
	innerGlow.ZIndex = 0
	
	local glowCorner = Instance.new("UICorner")
	glowCorner.CornerRadius = UDim.new(0, 18)
	glowCorner.Parent = innerGlow
	
	-- Header
	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Parent = main
	header.BackgroundTransparency = 1
	header.Size = UDim2.new(1, 0, 0, 60)
	
	local headerContent = Instance.new("Frame")
	headerContent.BackgroundTransparency = 1
	headerContent.Size = UDim2.new(1, -30, 1, 0)
	headerContent.Position = UDim2.new(0, 15, 0, 0)
	headerContent.Parent = header
	
	-- Icon with glow
	local iconGlow = Instance.new("ImageLabel")
	iconGlow.Image = GetIcon(config.Icon or "home").Image
	iconGlow.Size = UDim2.new(0, 36, 0, 36)
	iconGlow.Position = UDim2.new(0, 0, 0.5, -18)
	iconGlow.BackgroundTransparency = 1
	iconGlow.ImageColor3 = theme.Glow
	iconGlow.ImageTransparency = 0.7
	iconGlow.Parent = headerContent
	
	local icon = Instance.new("ImageLabel")
	icon.Image = GetIcon(config.Icon or "home").Image
	icon.Size = UDim2.new(0, 32, 0, 32)
	icon.Position = UDim2.new(0, 2, 0.5, -16)
	icon.BackgroundTransparency = 1
	icon.ImageColor3 = theme.Text
	icon.Parent = headerContent
	AddToTheme("Text", icon)
	
	local title = Instance.new("TextLabel")
	title.Text = config.Title or "UI"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 20
	title.TextColor3 = theme.Text
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0, 45, 0.3, -10)
	title.Size = UDim2.new(0, 200, 0, 24)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = headerContent
	AddToTheme("Text", title)
	
	if config.Desc then
		local desc = Instance.new("TextLabel")
		desc.Text = config.Desc
		desc.Font = Enum.Font.Gotham
		desc.TextSize = 12
		desc.TextColor3 = theme.TextSoft
		desc.BackgroundTransparency = 1
		desc.Position = UDim2.new(0, 45, 0.5, 2)
		desc.Size = UDim2.new(0, 200, 0, 18)
		desc.TextXAlignment = Enum.TextXAlignment.Left
		desc.Parent = headerContent
		AddToTheme("TextSoft", desc)
	end
	
	-- Window controls with modern design
	local controls = Instance.new("Frame")
	controls.BackgroundTransparency = 1
	controls.Size = UDim2.new(0, 100, 1, 0)
	controls.Position = UDim2.new(1, -100, 0, 0)
	controls.Parent = headerContent
	
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 12)
	layout.Parent = controls
	
	local function createControl(iconName, callback)
		local btn = Instance.new("ImageButton")
		btn.Image = GetIcon(iconName).Image
		btn.Size = UDim2.new(0, 22, 0, 22)
		btn.BackgroundTransparency = 1
		btn.ImageColor3 = theme.TextSoft
		btn.Parent = controls
		AddToTheme("TextSoft", btn)
		
		btn.MouseEnter:Connect(function()
			TweenObject(btn, {ImageColor3 = theme.Text, Size = UDim2.new(0, 24, 0, 24)}, 0.2)
		end)
		
		btn.MouseLeave:Connect(function()
			TweenObject(btn, {ImageColor3 = theme.TextSoft, Size = UDim2.new(0, 22, 0, 22)}, 0.2)
		end)
		
		btn.MouseButton1Click:Connect(function()
			CreateClickEffect(main, UIS:GetMouseLocation())
			callback()
		end)
		
		return btn
	end
	
	local minimized = false
	local originalSize, originalPos
	
	createControl("minus", function()
		minimized = not minimized
		if minimized then
			originalSize = shadow.Size
			originalPos = shadow.Position
			TweenObject(shadow, {Size = UDim2.new(0, 350, 0, 70)}, 0.3, "Back")
		else
			TweenObject(shadow, {Size = originalSize, Position = originalPos}, 0.3, "Back")
		end
	end)
	
	createControl("close", function()
		gui:Destroy()
	end)
	
	-- Gradient separator
	local separator = Instance.new("Frame")
	separator.Parent = main
	separator.Size = UDim2.new(1, -30, 0, 2)
	separator.Position = UDim2.new(0, 15, 0, 65)
	separator.BackgroundColor3 = theme.Primary
	separator.BorderSizePixel = 0
	separator.BackgroundTransparency = 0.7
	AddToTheme("Primary", separator)
	
	local separatorCorner = Instance.new("UICorner")
	separatorCorner.CornerRadius = UDim.new(1, 0)
	separatorCorner.Parent = separator
	
	-- Content area
	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Parent = main
	content.BackgroundTransparency = 1
	content.Size = UDim2.new(1, -30, 1, -85)
	content.Position = UDim2.new(0, 15, 0, 75)
	
	-- Tab buttons with curved design
	local tabArea = Instance.new("Frame")
	tabArea.Parent = content
	tabArea.BackgroundTransparency = 1
	tabArea.Size = UDim2.new(0, 130, 1, 0)
	
	local tabList = Instance.new("ScrollingFrame")
	tabList.Parent = tabArea
	tabList.Size = UDim2.new(1, 0, 1, 0)
	tabList.BackgroundTransparency = 1
	tabList.BorderSizePixel = 0
	tabList.ScrollBarThickness = 3
	tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tabList.ScrollBarImageColor3 = theme.Primary
	AddToTheme("Primary", tabList)
	
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0, 6)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Parent = tabList
	
	-- Tab pages with curved corners
	local pageContainer = Instance.new("Frame")
	pageContainer.Parent = content
	pageContainer.BackgroundColor3 = theme.Elevated
	pageContainer.Size = UDim2.new(1, -140, 1, 0)
	pageContainer.Position = UDim2.new(0, 135, 0, 0)
	pageContainer.ClipsDescendants = true
	AddToTheme("Elevated", pageContainer)
	
	local pageCorner = Instance.new("UICorner")
	pageCorner.CornerRadius = UDim.new(0, 16)
	pageCorner.Parent = pageContainer
	
	local pages = {}
	
	-- ================================
	-- TAB SYSTEM
	-- ================================
	local tabs = {}
	
	function tabs:Tab(tabConfig)
		local tabBtn = Instance.new("TextButton")
		tabBtn.Parent = tabList
		tabBtn.Size = UDim2.new(1, -5, 0, 42)
		tabBtn.BackgroundColor3 = theme.Surface
		tabBtn.BorderSizePixel = 0
		tabBtn.Text = ""
		tabBtn.AutoButtonColor = false
		AddToTheme("Surface", tabBtn)
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 12)
		btnCorner.Parent = tabBtn
		
		local btnGlow = Instance.new("Frame")
		btnGlow.Parent = tabBtn
		btnGlow.Size = UDim2.new(1, -2, 1, -2)
		btnGlow.Position = UDim2.new(0, 1, 0, 1)
		btnGlow.BackgroundColor3 = theme.Glow
		btnGlow.BackgroundTransparency = 1
		btnGlow.BorderSizePixel = 0
		
		local btnGlowCorner = Instance.new("UICorner")
		btnGlowCorner.CornerRadius = UDim.new(0, 10)
		btnGlowCorner.Parent = btnGlow
		
		local btnIcon = Instance.new("ImageLabel")
		btnIcon.Image = GetIcon(tabConfig.Icon or "home").Image
		btnIcon.Size = UDim2.new(0, 20, 0, 20)
		btnIcon.Position = UDim2.new(0, 12, 0.5, -10)
		btnIcon.BackgroundTransparency = 1
		btnIcon.ImageColor3 = theme.TextSoft
		btnIcon.Parent = tabBtn
		AddToTheme("TextSoft", btnIcon)
		
		local btnText = Instance.new("TextLabel")
		btnText.Text = tabConfig.Title or "Tab"
		btnText.Font = Enum.Font.Gotham
		btnText.TextSize = 13
		btnText.TextColor3 = theme.TextSoft
		btnText.BackgroundTransparency = 1
		btnText.Position = UDim2.new(0, 40, 0, 0)
		btnText.Size = UDim2.new(1, -45, 1, 0)
		btnText.TextXAlignment = Enum.TextXAlignment.Left
		btnText.Parent = tabBtn
		AddToTheme("TextSoft", btnText)
		
		-- Page
		local page = Instance.new("ScrollingFrame")
		page.Parent = pageContainer
		page.Size = UDim2.new(1, 0, 1, 0)
		page.BackgroundTransparency = 1
		page.BorderSizePixel = 0
		page.ScrollBarThickness = 4
		page.Visible = false
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.CanvasSize = UDim2.new(0, 0, 0, 0)
		page.ScrollBarImageColor3 = theme.Primary
		page.ElasticBehavior = Enum.ElasticBehavior.Always
		AddToTheme("Primary", page)
		
		local pageLayout = Instance.new("UIListLayout")
		pageLayout.Padding = UDim.new(0, 12)
		pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		pageLayout.Parent = page
		
		local pagePadding = Instance.new("UIPadding")
		pagePadding.PaddingLeft = UDim.new(0, 15)
		pagePadding.PaddingRight = UDim.new(0, 15)
		pagePadding.PaddingTop = UDim.new(0, 15)
		pagePadding.PaddingBottom = UDim.new(0, 15)
		pagePadding.Parent = page
		
		local function selectTab()
			for _, otherBtn in ipairs(tabList:GetChildren()) do
				if otherBtn:IsA("TextButton") then
					TweenObject(otherBtn, {BackgroundColor3 = theme.Surface}, 0.2)
					TweenObject(otherBtn.btnGlow, {BackgroundTransparency = 1}, 0.2)
					if otherBtn:FindFirstChild("TextLabel") then
						TweenObject(otherBtn.TextLabel, {TextColor3 = theme.TextSoft}, 0.2)
					end
					if otherBtn:FindFirstChild("ImageLabel") then
						TweenObject(otherBtn.ImageLabel, {ImageColor3 = theme.TextSoft}, 0.2)
					end
				end
			end
			
			for _, otherPage in ipairs(pageContainer:GetChildren()) do
				if otherPage:IsA("ScrollingFrame") then
					otherPage.Visible = false
				end
			end
			
			TweenObject(tabBtn, {BackgroundColor3 = theme.PrimarySoft}, 0.2)
			TweenObject(btnGlow, {BackgroundTransparency = 0.85}, 0.2)
			TweenObject(btnText, {TextColor3 = theme.Text}, 0.2)
			TweenObject(btnIcon, {ImageColor3 = theme.Text}, 0.2)
			page.Visible = true
			
			-- Animate elements
			local delay = 0
			for _, child in ipairs(page:GetChildren()) do
				if child:IsA("Frame") and child:FindFirstChild("Content") then
					child.Content.Position = UDim2.new(1, 0, 0, 0)
					TweenObject(child.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3 + delay, "Back")
					delay = delay + 0.03
				end
			end
		end
		
		tabBtn.MouseButton1Click:Connect(selectTab)
		
		if #tabs == 0 then
			task.defer(selectTab)
		end
		
		table.insert(tabs, page)
		
		-- Store references
		tabBtn.btnGlow = btnGlow
		
		-- ================================
		-- SECTION
		-- ================================
		local sectionMethods = {}
		
		function sectionMethods:Section(sectionConfig)
			local section = Instance.new("Frame")
			section.Parent = page
			section.BackgroundTransparency = 1
			section.Size = UDim2.new(1, 0, 0, 30)
			section.AutomaticSize = Enum.AutomaticSize.Y
			
			local title = Instance.new("TextLabel")
			title.Text = sectionConfig.Title or "Section"
			title.Font = Enum.Font.GothamBold
			title.TextSize = 16
			title.TextColor3 = theme.Text
			title.BackgroundTransparency = 1
			title.Size = UDim2.new(1, -10, 0, 24)
			title.Position = UDim2.new(0, 10, 0, 0)
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.Parent = section
			AddToTheme("Text", title)
			
			local sectionContent = Instance.new("Frame")
			sectionContent.Name = "Content"
			sectionContent.Parent = section
			sectionContent.BackgroundTransparency = 1
			sectionContent.Size = UDim2.new(1, 0, 0, 0)
			sectionContent.Position = UDim2.new(0, 0, 0, 30)
			sectionContent.AutomaticSize = Enum.AutomaticSize.Y
			
			local contentLayout = Instance.new("UIListLayout")
			contentLayout.Padding = UDim.new(0, 8)
			contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			contentLayout.Parent = sectionContent
			
			local contentPadding = Instance.new("UIPadding")
			contentPadding.PaddingLeft = UDim.new(0, 10)
			contentPadding.PaddingRight = UDim.new(0, 10)
			contentPadding.Parent = sectionContent
			
			return {
				AddToggle = function(itemConfig) return self:_createToggle(sectionContent, itemConfig, theme) end,
				AddButton = function(itemConfig) return self:_createButton(sectionContent, itemConfig, theme) end,
				AddSlider = function(itemConfig) return self:_createSlider(sectionContent, itemConfig, theme) end,
				AddDropdown = function(itemConfig) return self:_createDropdown(sectionContent, itemConfig, theme, gui) end,
				AddTextbox = function(itemConfig) return self:_createTextbox(sectionContent, itemConfig, theme) end,
				AddLabel = function(itemConfig) return self:_createLabel(sectionContent, itemConfig, theme) end,
				AddKeybind = function(itemConfig) return self:_createKeybind(sectionContent, itemConfig, theme) end
			}
		end
		
		return sectionMethods
	end
	
	-- ================================
	-- UI ELEMENTS
	-- ================================
	function tabs:_createBaseFrame(parent, config, theme)
		local frame = Instance.new("Frame")
		frame.Parent = parent
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 0, 45)
		frame.AutomaticSize = Enum.AutomaticSize.Y
		
		local content = Instance.new("Frame")
		content.Name = "Content"
		content.Parent = frame
		content.BackgroundTransparency = 1
		content.Size = UDim2.new(1, 0, 0, 45)
		content.Position = UDim2.new(0, 0, 0, 0)
		content.AutomaticSize = Enum.AutomaticSize.Y
		
		local layout = Instance.new("UIListLayout")
		layout.FillDirection = Enum.FillDirection.Horizontal
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		layout.VerticalAlignment = Enum.VerticalAlignment.Center
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 12)
		layout.Parent = content
		
		local left = Instance.new("Frame")
		left.BackgroundTransparency = 1
		left.Size = UDim2.new(1, -250, 1, 0)
		left.AutomaticSize = Enum.AutomaticSize.Y
		left.Parent = content
		
		local leftLayout = Instance.new("UIListLayout")
		leftLayout.Padding = UDim.new(0, 2)
		leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
		leftLayout.Parent = left
		
		local title = Instance.new("TextLabel")
		title.Text = config.Title or ""
		title.Font = Enum.Font.Gotham
		title.TextSize = 14
		title.TextColor3 = theme.Text
		title.BackgroundTransparency = 1
		title.Size = UDim2.new(1, 0, 0, 22)
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.AutomaticSize = Enum.AutomaticSize.Y
		title.Parent = left
		AddToTheme("Text", title)
		
		if config.Desc then
			local desc = Instance.new("TextLabel")
			desc.Text = config.Desc
			desc.Font = Enum.Font.Gotham
			desc.TextSize = 12
			desc.TextColor3 = theme.TextSoft
			desc.BackgroundTransparency = 1
			desc.Size = UDim2.new(1, 0, 0, 18)
			desc.TextXAlignment = Enum.TextXAlignment.Left
			desc.AutomaticSize = Enum.AutomaticSize.Y
			desc.Parent = left
			AddToTheme("TextSoft", desc)
		end
		
		frame.Content = content
		frame.Left = left
		
		return frame
	end
	
	function tabs:_createToggle(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local toggle = Instance.new("Frame")
		toggle.Size = UDim2.new(0, 48, 0, 24)
		toggle.BackgroundColor3 = theme.Surface
		toggle.BorderSizePixel = 0
		toggle.Parent = frame.Content
		AddToTheme("Surface", toggle)
		
		local toggleCorner = Instance.new("UICorner")
		toggleCorner.CornerRadius = UDim.new(1, 0)
		toggleCorner.Parent = toggle
		
		local knob = Instance.new("Frame")
		knob.Size = UDim2.new(0, 20, 0, 20)
		knob.Position = UDim2.new(0, 2, 0.5, -10)
		knob.BackgroundColor3 = theme.Text
		knob.BorderSizePixel = 0
		knob.Parent = toggle
		AddToTheme("Text", knob)
		
		local knobCorner = Instance.new("UICorner")
		knobCorner.CornerRadius = UDim.new(1, 0)
		knobCorner.Parent = knob
		
		local state = config.Value or false
		
		local function updateState()
			if state then
				TweenObject(toggle, {BackgroundColor3 = theme.Primary}, 0.2)
				TweenObject(knob, {
					Position = UDim2.new(1, -22, 0.5, -10),
					BackgroundColor3 = theme.Text
				}, 0.2, "Back")
			else
				TweenObject(toggle, {BackgroundColor3 = theme.Surface}, 0.2)
				TweenObject(knob, {
					Position = UDim2.new(0, 2, 0.5, -10),
					BackgroundColor3 = theme.Text
				}, 0.2, "Back")
			end
			pcall(config.Callback, state)
		end
		
		local click = Instance.new("TextButton")
		click.Size = UDim2.new(1, 0, 1, 0)
		click.BackgroundTransparency = 1
		click.Text = ""
		click.Parent = toggle
		
		click.MouseButton1Click:Connect(function()
			state = not state
			updateState()
			CreateClickEffect(toggle, UIS:GetMouseLocation())
		end)
		
		updateState()
		
		return {
			SetValue = function(v) 
				state = v 
				updateState() 
			end
		}
	end
	
	function tabs:_createButton(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 90, 0, 32)
		btn.BackgroundColor3 = theme.Primary
		btn.BorderSizePixel = 0
		btn.Text = config.Title or "Button"
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 13
		btn.TextColor3 = theme.Text
		btn.AutoButtonColor = false
		btn.Parent = frame.Content
		AddToTheme("Primary", btn)
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 8)
		btnCorner.Parent = btn
		
		btn.MouseEnter:Connect(function()
			TweenObject(btn, {BackgroundColor3 = theme.PrimarySoft}, 0.2)
		end)
		
		btn.MouseLeave:Connect(function()
			TweenObject(btn, {BackgroundColor3 = theme.Primary}, 0.2)
		end)
		
		btn.MouseButton1Click:Connect(function()
			CreateClickEffect(btn, UIS:GetMouseLocation())
			TweenObject(btn, {BackgroundColor3 = theme.PrimarySoft}, 0.1):Play()
			task.wait(0.1)
			TweenObject(btn, {BackgroundColor3 = theme.Primary}, 0.1):Play()
			pcall(config.Callback)
		end)
	end
	
	function tabs:_createLabel(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0, 200, 0, 32)
		label.BackgroundColor3 = theme.Elevated
		label.BorderSizePixel = 0
		label.Text = config.Value or ""
		label.Font = Enum.Font.Gotham
		label.TextSize = 13
		label.TextColor3 = theme.Text
		label.Parent = frame.Content
		AddToTheme("Elevated", label)
		
		local labelCorner = Instance.new("UICorner")
		labelCorner.CornerRadius = UDim.new(0, 8)
		labelCorner.Parent = label
		
		local padding = Instance.new("UIPadding")
		padding.PaddingLeft = UDim.new(0, 12)
		padding.PaddingRight = UDim.new(0, 12)
		padding.Parent = label
		
		return {
			SetValue = function(v) label.Text = v end
		}
	end
	
	function tabs:_createSlider(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local value = config.Value or 50
		local min = config.Min or 0
		local max = config.Max or 100
		
		local container = Instance.new("Frame")
		container.Size = UDim2.new(0, 200, 0, 32)
		container.BackgroundTransparency = 1
		container.Parent = frame.Content
		
		local sliderBg = Instance.new("Frame")
		sliderBg.Size = UDim2.new(1, -50, 0, 6)
		sliderBg.Position = UDim2.new(0, 0, 0.5, -3)
		sliderBg.BackgroundColor3 = theme.Surface
		sliderBg.BorderSizePixel = 0
		sliderBg.Parent = container
		AddToTheme("Surface", sliderBg)
		
		local sliderBgCorner = Instance.new("UICorner")
		sliderBgCorner.CornerRadius = UDim.new(1, 0)
		sliderBgCorner.Parent = sliderBg
		
		local fill = Instance.new("Frame")
		fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
		fill.BackgroundColor3 = theme.Primary
		fill.BorderSizePixel = 0
		fill.Parent = sliderBg
		AddToTheme("Primary", fill)
		
		local fillCorner = Instance.new("UICorner")
		fillCorner.CornerRadius = UDim.new(1, 0)
		fillCorner.Parent = fill
		
		local knob = Instance.new("Frame")
		knob.Size = UDim2.new(0, 18, 0, 18)
		knob.Position = UDim2.new((value - min) / (max - min), -9, 0.5, -9)
		knob.BackgroundColor3 = theme.Text
		knob.BorderSizePixel = 0
		knob.Parent = container
		AddToTheme("Text", knob)
		
		local knobCorner = Instance.new("UICorner")
		knobCorner.CornerRadius = UDim.new(1, 0)
		knobCorner.Parent = knob
		
		local valueLabel = Instance.new("TextLabel")
		valueLabel.Size = UDim2.new(0, 40, 1, 0)
		valueLabel.Position = UDim2.new(1, -40, 0, 0)
		valueLabel.BackgroundTransparency = 1
		valueLabel.Font = Enum.Font.Gotham
		valueLabel.TextSize = 13
		valueLabel.TextColor3 = theme.Text
		valueLabel.Text = tostring(value)
		valueLabel.TextXAlignment = Enum.TextXAlignment.Right
		valueLabel.Parent = container
		AddToTheme("Text", valueLabel)
		
		local dragging = false
		
		local function updateFromMouse(input)
			local pos = input.Position.X - sliderBg.AbsolutePosition.X
			local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
			value = min + (max - min) * percent
			value = math.floor(value * 100) / 100
			
			fill.Size = UDim2.new(percent, 0, 1, 0)
			knob.Position = UDim2.new(percent, -9, 0.5, -9)
			valueLabel.Text = tostring(value)
			pcall(config.Callback, value)
		end
		
		local click = Instance.new("TextButton")
		click.Size = UDim2.new(1, -50, 1, 0)
		click.BackgroundTransparency = 1
		click.Text = ""
		click.Parent = container
		
		click.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				updateFromMouse(input)
			end
		end)
		
		click.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
		
		UIS.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				updateFromMouse(input)
			end
		end)
		
		return {
			SetValue = function(v) 
				value = v 
				local percent = (v - min) / (max - min)
				fill.Size = UDim2.new(percent, 0, 1, 0)
				knob.Position = UDim2.new(percent, -9, 0.5, -9)
				valueLabel.Text = tostring(v)
			end,
			SetMin = function(v) 
				min = v 
				value = math.max(value, min)
				local percent = (value - min) / (max - min)
				fill.Size = UDim2.new(percent, 0, 1, 0)
				knob.Position = UDim2.new(percent, -9, 0.5, -9)
			end,
			SetMax = function(v) 
				max = v 
				value = math.min(value, max)
				local percent = (value - min) / (max - min)
				fill.Size = UDim2.new(percent, 0, 1, 0)
				knob.Position = UDim2.new(percent, -9, 0.5, -9)
			end
		}
	end
	
	function tabs:_createDropdown(parent, config, theme, gui)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local dropdown = Instance.new("Frame")
		dropdown.Size = UDim2.new(0, 150, 0, 34)
		dropdown.BackgroundColor3 = theme.Surface
		dropdown.BorderSizePixel = 0
		dropdown.Parent = frame.Content
		AddToTheme("Surface", dropdown)
		
		local dropdownCorner = Instance.new("UICorner")
		dropdownCorner.CornerRadius = UDim.new(0, 8)
		dropdownCorner.Parent = dropdown
		
		local valueLabel = Instance.new("TextLabel")
		valueLabel.Size = UDim2.new(1, -40, 1, 0)
		valueLabel.Position = UDim2.new(0, 12, 0, 0)
		valueLabel.BackgroundTransparency = 1
		valueLabel.Font = Enum.Font.Gotham
		valueLabel.TextSize = 13
		valueLabel.TextColor3 = theme.Text
		valueLabel.Text = config.Value or (config.List and config.List[1]) or "Select"
		valueLabel.TextXAlignment = Enum.TextXAlignment.Left
		valueLabel.Parent = dropdown
		AddToTheme("Text", valueLabel)
		
		local arrow = Instance.new("ImageLabel")
		arrow.Image = GetIcon("arrow").Image
		arrow.Size = UDim2.new(0, 18, 0, 18)
		arrow.Position = UDim2.new(1, -28, 0.5, -9)
		arrow.BackgroundTransparency = 1
		arrow.ImageColor3 = theme.TextSoft
		arrow.Parent = dropdown
		AddToTheme("TextSoft", arrow)
		
		local dropdownList = Instance.new("Frame")
		dropdownList.Size = UDim2.new(1, 0, 0, 0)
		dropdownList.Position = UDim2.new(0, 0, 1, 6)
		dropdownList.BackgroundColor3 = theme.Elevated
		dropdownList.BorderSizePixel = 0
		dropdownList.ClipsDescendants = true
		dropdownList.Visible = false
		dropdownList.Parent = dropdown
		AddToTheme("Elevated", dropdownList)
		
		local listCorner = Instance.new("UICorner")
		listCorner.CornerRadius = UDim.new(0, 8)
		listCorner.Parent = dropdownList
		
		local listPadding = Instance.new("UIPadding")
		listPadding.PaddingLeft = UDim.new(0, 6)
		listPadding.PaddingRight = UDim.new(0, 6)
		listPadding.PaddingTop = UDim.new(0, 6)
		listPadding.PaddingBottom = UDim.new(0, 6)
		listPadding.Parent = dropdownList
		
		local listLayout = Instance.new("UIListLayout")
		listLayout.Padding = UDim.new(0, 4)
		listLayout.SortOrder = Enum.SortOrder.LayoutOrder
		listLayout.Parent = dropdownList
		
		local items = {}
		local selected = valueLabel.Text
		
		local function updateList()
			local height = listLayout.AbsoluteContentSize.Y + 12
			TweenObject(dropdownList, {Size = UDim2.new(1, 0, 0, height)}, 0.2)
		end
		
		listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateList)
		
		local function addItem(text)
			local item = Instance.new("TextButton")
			item.Size = UDim2.new(1, 0, 0, 28)
			item.BackgroundColor3 = theme.Surface
			item.BorderSizePixel = 0
			item.Text = ""
			item.AutoButtonColor = false
			item.Parent = dropdownList
			AddToTheme("Surface", item)
			
			local itemCorner = Instance.new("UICorner")
			itemCorner.CornerRadius = UDim.new(0, 6)
			itemCorner.Parent = item
			
			local itemText = Instance.new("TextLabel")
			itemText.Text = text
			itemText.Size = UDim2.new(1, -12, 1, 0)
			itemText.Position = UDim2.new(0, 6, 0, 0)
			itemText.BackgroundTransparency = 1
			itemText.Font = Enum.Font.Gotham
			itemText.TextSize = 13
			itemText.TextColor3 = theme.TextSoft
			itemText.TextXAlignment = Enum.TextXAlignment.Left
			itemText.Parent = item
			AddToTheme("TextSoft", itemText)
			
			item.MouseEnter:Connect(function()
				if itemText.TextColor3 ~= theme.Text then
					TweenObject(item, {BackgroundColor3 = theme.PrimarySoft}, 0.2)
				end
			end)
			
			item.MouseLeave:Connect(function()
				if itemText.TextColor3 ~= theme.Text then
					TweenObject(item, {BackgroundColor3 = theme.Surface}, 0.2)
				end
			end)
			
			item.MouseButton1Click:Connect(function()
				selected = text
				valueLabel.Text = text
				dropdownList.Visible = false
				TweenObject(arrow, {Rotation = 0, ImageColor3 = theme.TextSoft}, 0.2)
				pcall(config.Callback, text)
				
				for _, i in ipairs(items) do
					TweenObject(i, {BackgroundColor3 = theme.Surface}, 0.2)
					TweenObject(i.TextLabel, {TextColor3 = theme.TextSoft}, 0.2)
				end
				TweenObject(item, {BackgroundColor3 = theme.Primary}, 0.2)
				TweenObject(itemText, {TextColor3 = theme.Text}, 0.2)
			end)
			
			table.insert(items, item)
			
			if text == selected then
				TweenObject(item, {BackgroundColor3 = theme.Primary}, 0)
				TweenObject(itemText, {TextColor3 = theme.Text}, 0)
			end
		end
		
		for _, item in ipairs(config.List or {}) do
			addItem(item)
		end
		
		local click = Instance.new("TextButton")
		click.Size = UDim2.new(1, 0, 1, 0)
		click.BackgroundTransparency = 1
		click.Text = ""
		click.Parent = dropdown
		
		click.MouseButton1Click:Connect(function()
			dropdownList.Visible = not dropdownList.Visible
			TweenObject(arrow, {
				Rotation = dropdownList.Visible and 180 or 0,
				ImageColor3 = dropdownList.Visible and theme.Primary or theme.TextSoft
			}, 0.2)
			if dropdownList.Visible then 
				updateList() 
				
				-- Close when clicking outside
				local connection
				connection = UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local pos = UIS:GetMouseLocation()
						local abs = dropdown.AbsolutePosition
						local size = dropdown.AbsoluteSize
						local listPos = dropdownList.AbsolutePosition
						local listSize = dropdownList.AbsoluteSize
						
						if pos.X < abs.X or pos.X > abs.X + size.X or 
						   pos.Y < abs.Y or pos.Y > listPos.Y + listSize.Y then
							dropdownList.Visible = false
							TweenObject(arrow, {Rotation = 0, ImageColor3 = theme.TextSoft}, 0.2)
							connection:Disconnect()
						end
					end
				end)
			end
		end)
		
		return {
			Add = addItem,
			SetValue = function(v) 
				selected = v 
				valueLabel.Text = v
				for _, i in ipairs(items) do
					if i.TextLabel.Text == v then
						TweenObject(i, {BackgroundColor3 = theme.Primary}, 0.2)
						TweenObject(i.TextLabel, {TextColor3 = theme.Text}, 0.2)
					else
						TweenObject(i, {BackgroundColor3 = theme.Surface}, 0.2)
						TweenObject(i.TextLabel, {TextColor3 = theme.TextSoft}, 0.2)
					end
				end
			end
		}
	end
	
	function tabs:_createTextbox(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local box = Instance.new("Frame")
		box.Size = UDim2.new(0, 160, 0, 34)
		box.BackgroundColor3 = theme.Surface
		box.BorderSizePixel = 0
		box.Parent = frame.Content
		AddToTheme("Surface", box)
		
		local boxCorner = Instance.new("UICorner")
		boxCorner.CornerRadius = UDim.new(0, 8)
		boxCorner.Parent = box
		
		local textbox = Instance.new("TextBox")
		textbox.Size = UDim2.new(1, -16, 1, 0)
		textbox.Position = UDim2.new(0, 8, 0, 0)
		textbox.BackgroundTransparency = 1
		textbox.Font = Enum.Font.Gotham
		textbox.TextSize = 13
		textbox.TextColor3 = theme.Text
		textbox.PlaceholderColor3 = theme.TextSoft
		textbox.PlaceholderText = config.Placeholder or "Enter text"
		textbox.Text = config.Value or ""
		textbox.ClearTextOnFocus = config.ClearText or false
		textbox.Parent = box
		AddToTheme("Text", textbox)
		
		textbox.FocusLost:Connect(function()
			pcall(config.Callback, textbox.Text)
		end)
		
		return {
			SetValue = function(v) textbox.Text = v end,
			SetPlaceholder = function(v) textbox.PlaceholderText = v end
		}
	end
	
	function tabs:_createKeybind(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local currentKey = config.Key or "E"
		local active = config.Value or false
		
		local container = Instance.new("Frame")
		container.Size = UDim2.new(0, 120, 0, 34)
		container.BackgroundTransparency = 1
		container.Parent = frame.Content
		
		local keyBtn = Instance.new("Frame")
		keyBtn.Size = UDim2.new(0, 70, 1, 0)
		keyBtn.BackgroundColor3 = theme.Surface
		keyBtn.BorderSizePixel = 0
		keyBtn.Parent = container
		AddToTheme("Surface", keyBtn)
		
		local keyCorner = Instance.new("UICorner")
		keyCorner.CornerRadius = UDim.new(0, 8)
		keyCorner.Parent = keyBtn
		
		local keyText = Instance.new("TextLabel")
		keyText.Size = UDim2.new(1, 0, 1, 0)
		keyText.BackgroundTransparency = 1
		keyText.Font = Enum.Font.Gotham
		keyText.TextSize = 13
		keyText.TextColor3 = theme.Text
		keyText.Text = tostring(currentKey)
		keyText.Parent = keyBtn
		AddToTheme("Text", keyText)
		
		local toggle = Instance.new("Frame")
		toggle.Size = UDim2.new(0, 44, 0, 24)
		toggle.Position = UDim2.new(1, -48, 0.5, -12)
		toggle.BackgroundColor3 = theme.Surface
		toggle.BorderSizePixel = 0
		toggle.Parent = container
		AddToTheme("Surface", toggle)
		
		local toggleCorner = Instance.new("UICorner")
		toggleCorner.CornerRadius = UDim.new(1, 0)
		toggleCorner.Parent = toggle
		
		local knob = Instance.new("Frame")
		knob.Size = UDim2.new(0, 20, 0, 20)
		knob.Position = UDim2.new(active and 1 or 0, active and -22 or 2, 0.5, -10)
		knob.BackgroundColor3 = active and theme.Primary or theme.Text
		knob.BorderSizePixel = 0
		knob.Parent = toggle
		AddToTheme(active and "Primary" or "Text", knob)
		
		local knobCorner = Instance.new("UICorner")
		knobCorner.CornerRadius = UDim.new(1, 0)
		knobCorner.Parent = knob
		
		local function updateToggle()
			TweenObject(toggle, {BackgroundColor3 = active and theme.PrimarySoft or theme.Surface}, 0.2)
			TweenObject(knob, {
				Position = active and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
				BackgroundColor3 = active and theme.Primary or theme.Text
			}, 0.2, "Back")
			pcall(config.Callback, currentKey, active)
		end
		
		local keyClick = Instance.new("TextButton")
		keyClick.Size = UDim2.new(1, 0, 1, 0)
		keyClick.BackgroundTransparency = 1
		keyClick.Text = ""
		keyClick.Parent = keyBtn
		
		local toggleClick = Instance.new("TextButton")
		toggleClick.Size = UDim2.new(1, 0, 1, 0)
		toggleClick.BackgroundTransparency = 1
		toggleClick.Text = ""
		toggleClick.Parent = toggle
		
		local listening = false
		
		keyClick.MouseButton1Click:Connect(function()
			listening = true
			keyText.Text = "..."
			TweenObject(keyBtn, {BackgroundColor3 = theme.PrimarySoft}, 0.2)
		end)
		
		toggleClick.MouseButton1Click:Connect(function()
			active = not active
			updateToggle()
			CreateClickEffect(toggle, UIS:GetMouseLocation())
		end)
		
		UIS.InputBegan:Connect(function(input)
			if listening and input.UserInputType == Enum.UserInputType.Keyboard then
				listening = false
				currentKey = input.KeyCode.Name
				keyText.Text = currentKey
				TweenObject(keyBtn, {BackgroundColor3 = theme.Surface}, 0.2)
				pcall(config.Callback, currentKey, active)
			end
			
			if input.KeyCode.Name == currentKey and active then
				pcall(config.Callback, currentKey, active)
			end
		end)
		
		return {
			SetKey = function(v) 
				currentKey = v 
				keyText.Text = v 
			end,
			SetValue = function(v) 
				active = v 
				updateToggle() 
			end
		}
	end
	
	MakeDraggable(header, shadow)
	
	return tabs
end

return Library
