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
		Bg = Color3.fromRGB(18, 18, 22),
		Surface = Color3.fromRGB(24, 24, 30),
		Elevated = Color3.fromRGB(30, 30, 38),
		Primary = Color3.fromRGB(130, 87, 255),
		PrimarySoft = Color3.fromRGB(70, 45, 140),
		Text = Color3.fromRGB(245, 245, 245),
		TextSoft = Color3.fromRGB(160, 160, 170),
		Border = Color3.fromRGB(40, 40, 48),
		Success = Color3.fromRGB(70, 200, 120),
		Danger = Color3.fromRGB(240, 80, 80)
	},
	Rose = {
		Bg = Color3.fromRGB(26, 18, 24),
		Surface = Color3.fromRGB(36, 26, 34),
		Elevated = Color3.fromRGB(46, 34, 42),
		Primary = Color3.fromRGB(255, 120, 180),
		PrimarySoft = Color3.fromRGB(140, 60, 100),
		Text = Color3.fromRGB(255, 240, 245),
		TextSoft = Color3.fromRGB(200, 160, 175),
		Border = Color3.fromRGB(60, 40, 50),
		Success = Color3.fromRGB(150, 220, 150),
		Danger = Color3.fromRGB(255, 100, 100)
	},
	Ocean = {
		Bg = Color3.fromRGB(10, 22, 30),
		Surface = Color3.fromRGB(16, 30, 40),
		Elevated = Color3.fromRGB(22, 38, 50),
		Primary = Color3.fromRGB(70, 180, 240),
		PrimarySoft = Color3.fromRGB(30, 90, 130),
		Text = Color3.fromRGB(230, 245, 255),
		TextSoft = Color3.fromRGB(140, 180, 200),
		Border = Color3.fromRGB(30, 50, 65),
		Success = Color3.fromRGB(100, 220, 180),
		Danger = Color3.fromRGB(255, 100, 120)
	},
	Forest = {
		Bg = Color3.fromRGB(18, 26, 18),
		Surface = Color3.fromRGB(24, 34, 24),
		Elevated = Color3.fromRGB(32, 44, 30),
		Primary = Color3.fromRGB(120, 220, 120),
		PrimarySoft = Color3.fromRGB(50, 120, 60),
		Text = Color3.fromRGB(240, 250, 240),
		TextSoft = Color3.fromRGB(160, 190, 160),
		Border = Color3.fromRGB(40, 60, 40),
		Success = Color3.fromRGB(180, 230, 140),
		Danger = Color3.fromRGB(240, 120, 100)
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
		edit = "6023426905"
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
	circle.Position = UDim2.new(0, pos.X, 0, pos.Y)
	circle.AnchorPoint = Vector2.new(0.5, 0.5)
	circle.BackgroundColor3 = Color3.new(1, 1, 1)
	circle.BackgroundTransparency = 0.5
	circle.BorderSizePixel = 0
	circle.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = circle
	
	TweenObject(circle, {Size = UDim2.new(0, parent.AbsoluteSize.X * 2, 0, parent.AbsoluteSize.X * 2), BackgroundTransparency = 1}, 0.8):Play()
	
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
			target.Position = UDim2.new(objStart.X.Scale, objStart.X.Offset + delta.X, objStart.Y.Scale, objStart.Y.Offset + delta.Y)
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
	
	-- Main container with shadow
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.Parent = gui
	shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	shadow.Size = config.Size or UDim2.new(0, 500, 0, 400)
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageColor3 = theme.Bg
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(10, 10, 118, 118)
	AddToTheme("Bg", shadow)
	
	local padding = Instance.new("UIPadding")
	padding.Padding = UDim.new(0, 5)
	padding.Parent = shadow
	
	-- Main frame
	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Parent = shadow
	main.BackgroundColor3 = theme.Surface
	main.BorderSizePixel = 0
	main.Size = UDim2.new(1, -10, 1, -10)
	main.Position = UDim2.new(0.5, 0, 0.5, 0)
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	AddToTheme("Surface", main)
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = main
	
	-- Header
	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Parent = main
	header.BackgroundTransparency = 1
	header.Size = UDim2.new(1, 0, 0, 45)
	
	local headerContent = Instance.new("Frame")
	headerContent.BackgroundTransparency = 1
	headerContent.Size = UDim2.new(1, -20, 1, 0)
	headerContent.Position = UDim2.new(0, 10, 0, 0)
	headerContent.Parent = header
	
	local icon = Instance.new("ImageLabel")
	icon.Image = GetIcon(config.Icon or "home").Image
	icon.Size = UDim2.new(0, 24, 0, 24)
	icon.Position = UDim2.new(0, 0, 0.5, -12)
	icon.BackgroundTransparency = 1
	icon.Parent = headerContent
	AddToTheme("Text", icon)
	
	local title = Instance.new("TextLabel")
	title.Text = config.Title or "UI"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.TextColor3 = theme.Text
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0, 32, 0.5, -10)
	title.Size = UDim2.new(0, 100, 0, 20)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = headerContent
	AddToTheme("Text", title)
	
	if config.Desc then
		local desc = Instance.new("TextLabel")
		desc.Text = config.Desc
		desc.Font = Enum.Font.Gotham
		desc.TextSize = 11
		desc.TextColor3 = theme.TextSoft
		desc.BackgroundTransparency = 1
		desc.Position = UDim2.new(0, 32, 0.5, 6)
		desc.Size = UDim2.new(0, 150, 0, 14)
		desc.TextXAlignment = Enum.TextXAlignment.Left
		desc.Parent = headerContent
		AddToTheme("TextSoft", desc)
	end
	
	-- Window controls
	local controls = Instance.new("Frame")
	controls.BackgroundTransparency = 1
	controls.Size = UDim2.new(0, 72, 1, 0)
	controls.Position = UDim2.new(1, -72, 0, 0)
	controls.Parent = headerContent
	
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 8)
	layout.Parent = controls
	
	local function createControl(iconName, callback)
		local btn = Instance.new("ImageButton")
		btn.Image = GetIcon(iconName).Image
		btn.Size = UDim2.new(0, 20, 0, 20)
		btn.BackgroundTransparency = 1
		btn.Parent = controls
		AddToTheme("Text", btn)
		
		btn.MouseButton1Click:Connect(function()
			CreateClickEffect(main, UIS:GetMouseLocation())
			callback()
		end)
	end
	
	local minimized = false
	local originalSize, originalPos
	
	createControl("minus", function()
		minimized = not minimized
		if minimized then
			originalSize = shadow.Size
			originalPos = shadow.Position
			TweenObject(shadow, {Size = UDim2.new(0, 300, 0, 45)}, 0.3):Play()
		else
			TweenObject(shadow, {Size = originalSize, Position = originalPos}, 0.3):Play()
		end
	end)
	
	createControl("close", function()
		gui:Destroy()
	end)
	
	-- Separator
	local separator = Instance.new("Frame")
	separator.Parent = main
	separator.Size = UDim2.new(1, -20, 0, 1)
	separator.Position = UDim2.new(0, 10, 0, 45)
	separator.BackgroundColor3 = theme.Border
	separator.BorderSizePixel = 0
	AddToTheme("Border", separator)
	
	-- Content area
	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Parent = main
	content.BackgroundTransparency = 1
	content.Size = UDim2.new(1, -20, 1, -55)
	content.Position = UDim2.new(0, 10, 0, 50)
	
	-- Tab buttons
	local tabArea = Instance.new("Frame")
	tabArea.Parent = content
	tabArea.BackgroundTransparency = 1
	tabArea.Size = UDim2.new(0, 100, 1, 0)
	
	local tabList = Instance.new("ScrollingFrame")
	tabList.Parent = tabArea
	tabList.Size = UDim2.new(1, 0, 1, 0)
	tabList.BackgroundTransparency = 1
	tabList.BorderSizePixel = 0
	tabList.ScrollBarThickness = 2
	tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
	tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	AddToTheme("PrimarySoft", tabList)
	
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0, 4)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Parent = tabList
	
	-- Tab pages
	local pageContainer = Instance.new("Frame")
	pageContainer.Parent = content
	pageContainer.BackgroundColor3 = theme.Elevated
	pageContainer.Size = UDim2.new(1, -110, 1, 0)
	pageContainer.Position = UDim2.new(0, 105, 0, 0)
	pageContainer.ClipsDescendants = true
	AddToTheme("Elevated", pageContainer)
	
	local pageCorner = Instance.new("UICorner")
	pageCorner.CornerRadius = UDim.new(0, 8)
	pageCorner.Parent = pageContainer
	
	local pages = {}
	
	-- ================================
	-- TAB SYSTEM
	-- ================================
	local tabs = {}
	
	function tabs:Tab(tabConfig)
		local tabBtn = Instance.new("TextButton")
		tabBtn.Parent = tabList
		tabBtn.Size = UDim2.new(1, -5, 0, 32)
		tabBtn.BackgroundColor3 = theme.Surface
		tabBtn.BorderSizePixel = 0
		tabBtn.Text = ""
		AddToTheme("Surface", tabBtn)
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = tabBtn
		
		local btnIcon = Instance.new("ImageLabel")
		btnIcon.Image = GetIcon(tabConfig.Icon or "home").Image
		btnIcon.Size = UDim2.new(0, 16, 0, 16)
		btnIcon.Position = UDim2.new(0, 8, 0.5, -8)
		btnIcon.BackgroundTransparency = 1
		btnIcon.Parent = tabBtn
		AddToTheme("Text", btnIcon)
		
		local btnText = Instance.new("TextLabel")
		btnText.Text = tabConfig.Title or "Tab"
		btnText.Font = Enum.Font.Gotham
		btnText.TextSize = 12
		btnText.TextColor3 = theme.TextSoft
		btnText.BackgroundTransparency = 1
		btnText.Position = UDim2.new(0, 28, 0, 0)
		btnText.Size = UDim2.new(1, -32, 1, 0)
		btnText.TextXAlignment = Enum.TextXAlignment.Left
		btnText.Parent = tabBtn
		AddToTheme("TextSoft", btnText)
		
		-- Page
		local page = Instance.new("ScrollingFrame")
		page.Parent = pageContainer
		page.Size = UDim2.new(1, 0, 1, 0)
		page.BackgroundTransparency = 1
		page.BorderSizePixel = 0
		page.ScrollBarThickness = 2
		page.Visible = false
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.CanvasSize = UDim2.new(0, 0, 0, 0)
		AddToTheme("Primary", page)
		
		local pageLayout = Instance.new("UIListLayout")
		pageLayout.Padding = UDim.new(0, 8)
		pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		pageLayout.Parent = page
		
		local padding = Instance.new("UIPadding")
		padding.PaddingLeft = UDim.new(0, 10)
		padding.PaddingRight = UDim.new(0, 10)
		padding.PaddingTop = UDim.new(0, 10)
		padding.PaddingBottom = UDim.new(0, 10)
		padding.Parent = page
		
		local function selectTab()
			for _, otherBtn in ipairs(tabList:GetChildren()) do
				if otherBtn:IsA("TextButton") then
					TweenObject(otherBtn.Background, {BackgroundColor3 = theme.Surface}, 0.2)
					if otherBtn:FindFirstChild("TextLabel") then
						TweenObject(otherBtn.TextLabel, {TextColor3 = theme.TextSoft}, 0.2)
					end
				end
			end
			
			for _, otherPage in ipairs(pageContainer:GetChildren()) do
				if otherPage:IsA("ScrollingFrame") then
					otherPage.Visible = false
				end
			end
			
			TweenObject(tabBtn.Background, {BackgroundColor3 = theme.PrimarySoft}, 0.2)
			TweenObject(btnText, {TextColor3 = theme.Text}, 0.2)
			page.Visible = true
			
			-- Animate elements
			for i, child in ipairs(page:GetChildren()) do
				if child:IsA("Frame") and child:FindFirstChild("Content") then
					child.Content.Position = UDim2.new(1, 0, 0, 0)
					TweenObject(child.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3, "Back"):Play()
					task.wait(0.03)
				end
			end
		end
		
		tabBtn.MouseButton1Click:Connect(selectTab)
		
		if #tabs == 0 then
			task.defer(selectTab)
		end
		
		table.insert(tabs, page)
		
		-- ================================
		-- SECTION
		-- ================================
		local sectionMethods = {}
		
		function sectionMethods:Section(sectionConfig)
			local section = Instance.new("Frame")
			section.Parent = page
			section.BackgroundTransparency = 1
			section.Size = UDim2.new(1, 0, 0, 20)
			section.AutomaticSize = Enum.AutomaticSize.Y
			
			local title = Instance.new("TextLabel")
			title.Text = sectionConfig.Title or "Section"
			title.Font = Enum.Font.GothamBold
			title.TextSize = 14
			title.TextColor3 = theme.Text
			title.BackgroundTransparency = 1
			title.Size = UDim2.new(1, -10, 0, 20)
			title.Position = UDim2.new(0, 10, 0, 0)
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.Parent = section
			AddToTheme("Text", title)
			
			local sectionContent = Instance.new("Frame")
			sectionContent.Name = "Content"
			sectionContent.Parent = section
			sectionContent.BackgroundTransparency = 1
			sectionContent.Size = UDim2.new(1, 0, 0, 0)
			sectionContent.Position = UDim2.new(0, 0, 0, 25)
			sectionContent.AutomaticSize = Enum.AutomaticSize.Y
			
			local contentLayout = Instance.new("UIListLayout")
			contentLayout.Padding = UDim.new(0, 6)
			contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			contentLayout.Parent = sectionContent
			
			return {
				AddToggle = function(itemConfig) return self:_createToggle(sectionContent, itemConfig, theme) end,
				AddButton = function(itemConfig) return self:_createButton(sectionContent, itemConfig, theme) end,
				AddSlider = function(itemConfig) return self:_createSlider(sectionContent, itemConfig, theme) end,
				AddDropdown = function(itemConfig) return self:_createDropdown(sectionContent, itemConfig, theme, gui) end,
				AddTextbox = function(itemConfig) return self:_createTextbox(sectionContent, itemConfig, theme) end
			}
		end
		
		return sectionMethods
	end
	
	-- ================================
	-- UI ELEMENTS
	-- ================================
	function tabs:_createToggle(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local toggle = Instance.new("Frame")
		toggle.Size = UDim2.new(0, 40, 0, 20)
		toggle.BackgroundColor3 = theme.Surface
		toggle.BorderSizePixel = 0
		toggle.Parent = frame.Content
		AddToTheme("Surface", toggle)
		
		local toggleCorner = Instance.new("UICorner")
		toggleCorner.CornerRadius = UDim.new(1, 0)
		toggleCorner.Parent = toggle
		
		local knob = Instance.new("Frame")
		knob.Size = UDim2.new(0, 16, 0, 16)
		knob.Position = UDim2.new(0, 2, 0.5, -8)
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
				TweenObject(knob, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = theme.Text}, 0.2)
			else
				TweenObject(toggle, {BackgroundColor3 = theme.Surface}, 0.2)
				TweenObject(knob, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = theme.Text}, 0.2)
			end
			pcall(config.Callback, state)
		end
		
		local click = Instance.new("TextButton")
		click.Size = UDim2.new(1, 0, 1, 0)
		click.BackgroundTransparency = 1
		click.Text = ""
		click.Parent = frame
		
		click.MouseButton1Click:Connect(function()
			state = not state
			updateState()
			CreateClickEffect(frame, UIS:GetMouseLocation())
		end)
		
		updateState()
		
		return {
			SetValue = function(v) state = v updateState() end
		}
	end
	
	function tabs:_createButton(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 80, 0, 28)
		btn.BackgroundColor3 = theme.Primary
		btn.BorderSizePixel = 0
		btn.Text = config.Title or "Button"
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 12
		btn.TextColor3 = theme.Text
		btn.Parent = frame.Content
		AddToTheme("Primary", btn)
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = btn
		
		btn.MouseButton1Click:Connect(function()
			CreateClickEffect(btn, UIS:GetMouseLocation())
			TweenObject(btn, {BackgroundColor3 = theme.PrimarySoft}, 0.1):Play()
			task.wait(0.1)
			TweenObject(btn, {BackgroundColor3 = theme.Primary}, 0.1):Play()
			pcall(config.Callback)
		end)
	end
	
	function tabs:_createSlider(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local value = config.Value or 50
		local min = config.Min or 0
		local max = config.Max or 100
		
		local container = Instance.new("Frame")
		container.Size = UDim2.new(0, 150, 0, 28)
		container.BackgroundTransparency = 1
		container.Parent = frame.Content
		
		local sliderBg = Instance.new("Frame")
		sliderBg.Size = UDim2.new(1, 0, 0, 4)
		sliderBg.Position = UDim2.new(0, 0, 0.5, -2)
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
		knob.Size = UDim2.new(0, 16, 0, 16)
		knob.Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8)
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
		valueLabel.TextSize = 12
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
			knob.Position = UDim2.new(percent, -8, 0.5, -8)
			valueLabel.Text = tostring(value)
			pcall(config.Callback, value)
		end
		
		local click = Instance.new("TextButton")
		click.Size = UDim2.new(1, 0, 1, 0)
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
			SetValue = function(v) value = v updateFromMouse({Position = {X = sliderBg.AbsolutePosition.X + (v - min) / (max - min) * sliderBg.AbsoluteSize.X}}) end,
			SetMin = function(v) min = v updateFromMouse({Position = {X = sliderBg.AbsolutePosition.X + (value - min) / (max - min) * sliderBg.AbsoluteSize.X}}) end,
			SetMax = function(v) max = v updateFromMouse({Position = {X = sliderBg.AbsolutePosition.X + (value - min) / (max - min) * sliderBg.AbsoluteSize.X}}) end
		}
	end
	
	function tabs:_createDropdown(parent, config, theme, gui)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local dropdown = Instance.new("Frame")
		dropdown.Size = UDim2.new(0, 120, 0, 28)
		dropdown.BackgroundColor3 = theme.Surface
		dropdown.BorderSizePixel = 0
		dropdown.Parent = frame.Content
		AddToTheme("Surface", dropdown)
		
		local dropdownCorner = Instance.new("UICorner")
		dropdownCorner.CornerRadius = UDim.new(0, 6)
		dropdownCorner.Parent = dropdown
		
		local valueLabel = Instance.new("TextLabel")
		valueLabel.Size = UDim2.new(1, -30, 1, 0)
		valueLabel.Position = UDim2.new(0, 8, 0, 0)
		valueLabel.BackgroundTransparency = 1
		valueLabel.Font = Enum.Font.Gotham
		valueLabel.TextSize = 12
		valueLabel.TextColor3 = theme.Text
		valueLabel.Text = config.Value or (config.List and config.List[1]) or "Select"
		valueLabel.TextXAlignment = Enum.TextXAlignment.Left
		valueLabel.Parent = dropdown
		AddToTheme("Text", valueLabel)
		
		local arrow = Instance.new("ImageLabel")
		arrow.Image = GetIcon("arrow").Image
		arrow.Size = UDim2.new(0, 16, 0, 16)
		arrow.Position = UDim2.new(1, -22, 0.5, -8)
		arrow.BackgroundTransparency = 1
		arrow.Parent = dropdown
		AddToTheme("Text", arrow)
		
		local dropdownList = Instance.new("Frame")
		dropdownList.Size = UDim2.new(1, 0, 0, 0)
		dropdownList.Position = UDim2.new(0, 0, 1, 4)
		dropdownList.BackgroundColor3 = theme.Elevated
		dropdownList.BorderSizePixel = 0
		dropdownList.ClipsDescendants = true
		dropdownList.Visible = false
		dropdownList.Parent = dropdown
		AddToTheme("Elevated", dropdownList)
		
		local listCorner = Instance.new("UICorner")
		listCorner.CornerRadius = UDim.new(0, 6)
		listCorner.Parent = dropdownList
		
		local listPadding = Instance.new("UIPadding")
		listPadding.PaddingLeft = UDim.new(0, 4)
		listPadding.PaddingRight = UDim.new(0, 4)
		listPadding.PaddingTop = UDim.new(0, 4)
		listPadding.PaddingBottom = UDim.new(0, 4)
		listPadding.Parent = dropdownList
		
		local listLayout = Instance.new("UIListLayout")
		listLayout.Padding = UDim.new(0, 2)
		listLayout.SortOrder = Enum.SortOrder.LayoutOrder
		listLayout.Parent = dropdownList
		
		local items = {}
		local selected = valueLabel.Text
		
		local function updateList()
			local height = listLayout.AbsoluteContentSize.Y + 8
			TweenObject(dropdownList, {Size = UDim2.new(1, 0, 0, height)}, 0.2)
		end
		
		listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateList)
		
		local function addItem(text)
			local item = Instance.new("TextButton")
			item.Size = UDim2.new(1, 0, 0, 24)
			item.BackgroundColor3 = theme.Surface
			item.BorderSizePixel = 0
			item.Text = ""
			item.Parent = dropdownList
			AddToTheme("Surface", item)
			
			local itemCorner = Instance.new("UICorner")
			itemCorner.CornerRadius = UDim.new(0, 4)
			itemCorner.Parent = item
			
			local itemText = Instance.new("TextLabel")
			itemText.Text = text
			itemText.Size = UDim2.new(1, -8, 1, 0)
			itemText.Position = UDim2.new(0, 4, 0, 0)
			itemText.BackgroundTransparency = 1
			itemText.Font = Enum.Font.Gotham
			itemText.TextSize = 12
			itemText.TextColor3 = theme.TextSoft
			itemText.TextXAlignment = Enum.TextXAlignment.Left
			itemText.Parent = item
			AddToTheme("TextSoft", itemText)
			
			item.MouseButton1Click:Connect(function()
				selected = text
				valueLabel.Text = text
				dropdownList.Visible = false
				TweenObject(arrow, {Rotation = 0}, 0.2)
				pcall(config.Callback, text)
				
				for _, i in ipairs(items) do
					TweenObject(i.Background, {BackgroundColor3 = theme.Surface}, 0.2)
					TweenObject(i.TextLabel, {TextColor3 = theme.TextSoft}, 0.2)
				end
				TweenObject(item.Background, {BackgroundColor3 = theme.PrimarySoft}, 0.2)
				TweenObject(itemText, {TextColor3 = theme.Text}, 0.2)
			end)
			
			table.insert(items, item)
			
			if text == selected then
				TweenObject(item.Background, {BackgroundColor3 = theme.PrimarySoft}, 0)
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
			TweenObject(arrow, {Rotation = dropdownList.Visible and 180 or 0}, 0.2)
			if dropdownList.Visible then updateList() end
			
			-- Close when clicking outside
			if dropdownList.Visible then
				local connection
				connection = UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local pos = UIS:GetMouseLocation()
						local abs = dropdown.AbsolutePosition
						local size = dropdown.AbsoluteSize
						local listPos = dropdownList.AbsolutePosition
						local listSize = dropdownList.AbsoluteSize
						
						if pos.X < abs.X or pos.X > abs.X + size.X or pos.Y < abs.Y or pos.Y > listPos.Y + listSize.Y then
							dropdownList.Visible = false
							TweenObject(arrow, {Rotation = 0}, 0.2)
							connection:Disconnect()
						end
					end
				end)
			end
		end)
		
		return {
			Add = addItem,
			SetValue = function(v) selected = v valueLabel.Text = v end
		}
	end
	
	function tabs:_createTextbox(parent, config, theme)
		local frame = self:_createBaseFrame(parent, config, theme)
		
		local box = Instance.new("Frame")
		box.Size = UDim2.new(0, 140, 0, 28)
		box.BackgroundColor3 = theme.Surface
		box.BorderSizePixel = 0
		box.Parent = frame.Content
		AddToTheme("Surface", box)
		
		local boxCorner = Instance.new("UICorner")
		boxCorner.CornerRadius = UDim.new(0, 6)
		boxCorner.Parent = box
		
		local textbox = Instance.new("TextBox")
		textbox.Size = UDim2.new(1, -10, 1, 0)
		textbox.Position = UDim2.new(0, 5, 0, 0)
		textbox.BackgroundTransparency = 1
		textbox.Font = Enum.Font.Gotham
		textbox.TextSize = 12
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
	
	function tabs:_createBaseFrame(parent, config, theme)
		local frame = Instance.new("Frame")
		frame.Parent = parent
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 0, 40)
		frame.AutomaticSize = Enum.AutomaticSize.Y
		
		local content = Instance.new("Frame")
		content.Name = "Content"
		content.Parent = frame
		content.BackgroundTransparency = 1
		content.Size = UDim2.new(1, 0, 0, 40)
		content.Position = UDim2.new(0, 0, 0, 0)
		content.AutomaticSize = Enum.AutomaticSize.Y
		
		local layout = Instance.new("UIListLayout")
		layout.FillDirection = Enum.FillDirection.Horizontal
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		layout.VerticalAlignment = Enum.VerticalAlignment.Center
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 10)
		layout.Parent = content
		
		local left = Instance.new("Frame")
		left.BackgroundTransparency = 1
		left.Size = UDim2.new(1, -200, 1, 0)
		left.AutomaticSize = Enum.AutomaticSize.Y
		left.Parent = content
		
		local title = Instance.new("TextLabel")
		title.Text = config.Title or ""
		title.Font = Enum.Font.Gotham
		title.TextSize = 13
		title.TextColor3 = theme.Text
		title.BackgroundTransparency = 1
		title.Size = UDim2.new(1, 0, 0, 20)
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.AutomaticSize = Enum.AutomaticSize.Y
		title.Parent = left
		AddToTheme("Text", title)
		
		if config.Desc then
			local desc = Instance.new("TextLabel")
			desc.Text = config.Desc
			desc.Font = Enum.Font.Gotham
			desc.TextSize = 11
			desc.TextColor3 = theme.TextSoft
			desc.BackgroundTransparency = 1
			desc.Size = UDim2.new(1, 0, 0, 16)
			desc.TextXAlignment = Enum.TextXAlignment.Left
			desc.AutomaticSize = Enum.AutomaticSize.Y
			desc.Parent = left
			AddToTheme("TextSoft", desc)
		end
		
		frame.Content = content
		frame.Left = left
		
		return frame
	end
	
	MakeDraggable(header, shadow)
	
	return tabs
end

return Library
