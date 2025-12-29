local Library = {}
local U, Tw, Ts = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("TextService")
local KeyGUI = pcall(function() return makefolder and readfile and writefile and setclipboard end)

function Library.Load(o)
	local function gl(i)
		if type(i) == 'number' then
			return "rbxassetid://".. tostring(i)
		elseif type(i) == 'string' and not i:find('rbxassetid://') then
			return "rbxassetid://".. i
		else
			return i
		end
	end
	
	local function tw(info)
		if not info or not info.v or not info.v:IsA("Instance") then 
			return { Play = function() end } 
		end
		local success, tween = pcall(function()
			return Tw:Create(
				info.v,
				TweenInfo.new(info.t or 0.3, info.s or Enum.EasingStyle.Quad, info.d or Enum.EasingDirection.Out),
				info.g or {}
			)
		end)
		return success and tween or { Play = function() end }
	end
	
	local function click(p)
		if not p then return end
		local Click = Instance.new("TextButton")
		Click.Name = "Click"
		Click.Parent = p
		Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click.BackgroundTransparency = 1
		Click.Size = UDim2.new(1, 0, 1, 0)
		Click.Font = Enum.Font.SourceSans
		Click.Text = ""
		return Click
	end

	local HubName = o.Name or 'Premium Hub'
	local MainColor = o.Color or Color3.fromRGB(98, 37, 209)
	local SecondaryColor = Color3.fromRGB(138, 43, 226)
	local AccentColor = Color3.fromRGB(255, 105, 180)
	local Icon = gl(o.Icon or 6031075938)
	local Key = o.Key or {}

	if KeyGUI then 
		pcall(function()
			makefolder("PremiumHub")
		end)
	end
	local savedKey = ""
	if KeyGUI then
		local success, key = pcall(readfile, "PremiumHub/key.txt")
		if success then
			savedKey = key or ""
		end
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "PremiumKeySystem"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	
	local isMobile = U.TouchEnabled and not U.MouseEnabled
	local baseSize = isMobile and 0.9 or 0.45
	local maxWidth = 500
	local maxHeight = 450

	local MainContainer = Instance.new("Frame")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = ScreenGui
	MainContainer.BackgroundTransparency = 1
	MainContainer.Size = UDim2.new(0, maxWidth, 0, maxHeight)
	MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)

	local BackgroundGlow = Instance.new("ImageLabel")
	BackgroundGlow.Name = "BackgroundGlow"
	BackgroundGlow.Parent = MainContainer
	BackgroundGlow.BackgroundTransparency = 1
	BackgroundGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
	BackgroundGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
	BackgroundGlow.Image = "rbxassetid://8992230677"
	BackgroundGlow.ImageColor3 = MainColor
	BackgroundGlow.ImageTransparency = 0.9
	BackgroundGlow.ScaleType = Enum.ScaleType.Slice
	BackgroundGlow.SliceCenter = Rect.new(20, 20, 180, 180)
	BackgroundGlow.SliceScale = 0.05

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = MainContainer
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	MainFrame.Size = UDim2.new(1, 0, 1, 0)
	MainFrame.ClipsDescendants = true

	local MainCorner = Instance.new("UICorner")
	MainCorner.Parent = MainFrame
	MainCorner.CornerRadius = UDim.new(0, 12)

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Parent = MainFrame
	MainStroke.Color = Color3.fromRGB(40, 40, 50)
	MainStroke.Thickness = 2
	MainStroke.Transparency = 0

	local InnerGlow = Instance.new("Frame")
	InnerGlow.Name = "InnerGlow"
	InnerGlow.Parent = MainFrame
	InnerGlow.BackgroundColor3 = MainColor
	InnerGlow.BackgroundTransparency = 0.95
	InnerGlow.Size = UDim2.new(1, 0, 1, 0)
	InnerGlow.ZIndex = 0

	local InnerCorner = Instance.new("UICorner")
	InnerCorner.Parent = InnerGlow
	InnerCorner.CornerRadius = UDim.new(0, 12)

	local Gradient = Instance.new("UIGradient")
	Gradient.Parent = InnerGlow
	Gradient.Rotation = 45
	Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, MainColor),
		ColorSequenceKeypoint.new(0.5, SecondaryColor),
		ColorSequenceKeypoint.new(1, MainColor)
	})
	Gradient.Transparency = NumberSequence.new(0.95)

	local Content = Instance.new("Frame")
	Content.Name = "Content"
	Content.Parent = MainFrame
	Content.BackgroundTransparency = 1
	Content.Size = UDim2.new(1, -40, 1, -40)
	Content.Position = UDim2.new(0, 20, 0, 20)

	local MainList = Instance.new("UIListLayout")
	MainList.Parent = Content
	MainList.Padding = UDim.new(0, 25)
	MainList.SortOrder = Enum.SortOrder.LayoutOrder
	MainList.HorizontalAlignment = Enum.HorizontalAlignment.Center

	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Parent = Content
	Header.BackgroundTransparency = 1
	Header.Size = UDim2.new(1, 0, 0, 80)
	Header.LayoutOrder = 1

	local IconContainer = Instance.new("Frame")
	IconContainer.Name = "IconContainer"
	IconContainer.Parent = Header
	IconContainer.BackgroundTransparency = 1
	IconContainer.Size = UDim2.new(0, 60, 0, 60)
	IconContainer.Position = UDim2.new(0.5, -30, 0, 0)
	IconContainer.AnchorPoint = Vector2.new(0.5, 0)

	local IconBack = Instance.new("Frame")
	IconBack.Name = "IconBack"
	IconBack.Parent = IconContainer
	IconBack.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	IconBack.Size = UDim2.new(1, 0, 1, 0)

	local IconCorner = Instance.new("UICorner")
	IconCorner.Parent = IconBack
	IconCorner.CornerRadius = UDim.new(0, 10)

	local IconStroke = Instance.new("UIStroke")
	IconStroke.Parent = IconBack
	IconStroke.Color = MainColor
	IconStroke.Thickness = 2
	IconStroke.Transparency = 0

	local IconImage = Instance.new("ImageLabel")
	IconImage.Name = "Icon"
	IconImage.Parent = IconBack
	IconImage.BackgroundTransparency = 1
	IconImage.Size = UDim2.new(0.7, 0, 0.7, 0)
	IconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	IconImage.AnchorPoint = Vector2.new(0.5, 0.5)
	IconImage.Image = Icon
	IconImage.ImageColor3 = MainColor

	local TitleContainer = Instance.new("Frame")
	TitleContainer.Name = "TitleContainer"
	TitleContainer.Parent = Header
	TitleContainer.BackgroundTransparency = 1
	TitleContainer.Size = UDim2.new(1, 0, 0, 30)
	TitleContainer.Position = UDim2.new(0, 0, 0, 70)

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = TitleContainer
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 0.6, 0)
	Title.Font = Enum.Font.GothamBold
	Title.Text = HubName
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 22
	Title.TextTransparency = 0

	local Subtitle = Instance.new("TextLabel")
	Subtitle.Name = "Subtitle"
	Subtitle.Parent = TitleContainer
	Subtitle.BackgroundTransparency = 1
	Subtitle.Size = UDim2.new(1, 0, 0.4, 0)
	Subtitle.Position = UDim2.new(0, 0, 0.6, 0)
	Subtitle.Font = Enum.Font.Gotham
	Subtitle.Text = "KEY SYSTEM"
	Subtitle.TextColor3 = MainColor
	Subtitle.TextSize = 12
	Subtitle.TextTransparency = 0

	local WelcomeFrame = Instance.new("Frame")
	WelcomeFrame.Name = "WelcomeFrame"
	WelcomeFrame.Parent = Content
	WelcomeFrame.BackgroundTransparency = 1
	WelcomeFrame.Size = UDim2.new(1, 0, 0, 40)
	WelcomeFrame.LayoutOrder = 2

	local WelcomeText = Instance.new("TextLabel")
	WelcomeText.Name = "WelcomeText"
	WelcomeText.Parent = WelcomeFrame
	WelcomeText.BackgroundTransparency = 1
	WelcomeText.Size = UDim2.new(1, 0, 1, 0)
	WelcomeText.Font = Enum.Font.Gotham
	WelcomeText.Text = "Welcome! Please enter your license key to continue."
	WelcomeText.TextColor3 = Color3.fromRGB(180, 180, 190)
	WelcomeText.TextSize = 14
	WelcomeText.TextTransparency = 0
	WelcomeText.TextWrapped = true

	local KeyInputSection = Instance.new("Frame")
	KeyInputSection.Name = "KeyInputSection"
	KeyInputSection.Parent = Content
	KeyInputSection.BackgroundTransparency = 1
	KeyInputSection.Size = UDim2.new(1, 0, 0, 60)
	KeyInputSection.LayoutOrder = 3

	local KeyBox = Instance.new("Frame")
	KeyBox.Name = "KeyBox"
	KeyBox.Parent = KeyInputSection
	KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	KeyBox.Size = UDim2.new(1, 0, 0, 50)

	local KeyBoxCorner = Instance.new("UICorner")
	KeyBoxCorner.Parent = KeyBox
	KeyBoxCorner.CornerRadius = UDim.new(0, 8)

	local KeyBoxStroke = Instance.new("UIStroke")
	KeyBoxStroke.Parent = KeyBox
	KeyBoxStroke.Color = Color3.fromRGB(50, 50, 60)
	KeyBoxStroke.Thickness = 2
	KeyBoxStroke.Transparency = 0

	local KeyBoxGlow = Instance.new("Frame")
	KeyBoxGlow.Name = "KeyBoxGlow"
	KeyBoxGlow.Parent = KeyBox
	KeyBoxGlow.BackgroundColor3 = MainColor
	KeyBoxGlow.BackgroundTransparency = 0.95
	KeyBoxGlow.Size = UDim2.new(1, 0, 1, 0)
	KeyBoxGlow.ZIndex = 0

	local GlowCorner = Instance.new("UICorner")
	GlowCorner.Parent = KeyBoxGlow
	GlowCorner.CornerRadius = UDim.new(0, 8)

	local KeyBoxGradient = Instance.new("UIGradient")
	KeyBoxGradient.Parent = KeyBoxGlow
	KeyBoxGradient.Rotation = 90
	KeyBoxGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, MainColor),
		ColorSequenceKeypoint.new(0.5, AccentColor),
		ColorSequenceKeypoint.new(1, MainColor)
	})
	KeyBoxGradient.Transparency = NumberSequence.new(0.95)

	local KeyInput = Instance.new("TextBox")
	KeyInput.Name = "KeyInput"
	KeyInput.Parent = KeyBox
	KeyInput.BackgroundTransparency = 1
	KeyInput.Size = UDim2.new(1, -50, 1, 0)
	KeyInput.Position = UDim2.new(0, 15, 0, 0)
	KeyInput.Font = Enum.Font.Gotham
	KeyInput.PlaceholderText = "Enter your license key here..."
	KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
	KeyInput.Text = savedKey
	KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	KeyInput.TextSize = 16
	KeyInput.TextTransparency = 0
	KeyInput.TextXAlignment = Enum.TextXAlignment.Left

	local KeyIcon = Instance.new("ImageLabel")
	KeyIcon.Name = "KeyIcon"
	KeyIcon.Parent = KeyBox
	KeyIcon.BackgroundTransparency = 1
	KeyIcon.Size = UDim2.new(0, 24, 0, 24)
	KeyIcon.Position = UDim2.new(1, -27, 0.5, -12)
	KeyIcon.AnchorPoint = Vector2.new(1, 0.5)
	KeyIcon.Image = "rbxassetid://6031280882"
	KeyIcon.ImageColor3 = MainColor

	local ButtonsSection = Instance.new("Frame")
	ButtonsSection.Name = "ButtonsSection"
	ButtonsSection.Parent = Content
	ButtonsSection.BackgroundTransparency = 1
	ButtonsSection.Size = UDim2.new(1, 0, 0, 50)
	ButtonsSection.LayoutOrder = 4

	local ButtonsLayout = Instance.new("UIListLayout")
	ButtonsLayout.Parent = ButtonsSection
	ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
	ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	ButtonsLayout.Padding = UDim.new(0, 15)

	local GetKeyBtn = Instance.new("Frame")
	GetKeyBtn.Name = "GetKeyBtn"
	GetKeyBtn.Parent = ButtonsSection
	GetKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	GetKeyBtn.Size = UDim2.new(0, 140, 0, 45)

	local GetKeyCorner = Instance.new("UICorner")
	GetKeyCorner.Parent = GetKeyBtn
	GetKeyCorner.CornerRadius = UDim.new(0, 8)

	local GetKeyStroke = Instance.new("UIStroke")
	GetKeyStroke.Parent = GetKeyBtn
	GetKeyStroke.Color = Color3.fromRGB(60, 60, 70)
	GetKeyStroke.Thickness = 2
	GetKeyStroke.Transparency = 0

	local GetKeyClick = click(GetKeyBtn)

	local GetKeyText = Instance.new("TextLabel")
	GetKeyText.Name = "Text"
	GetKeyText.Parent = GetKeyBtn
	GetKeyText.BackgroundTransparency = 1
	GetKeyText.Size = UDim2.new(1, -40, 1, 0)
	GetKeyText.Position = UDim2.new(0, 15, 0, 0)
	GetKeyText.Font = Enum.Font.GothamSemibold
	GetKeyText.Text = "GET KEY"
	GetKeyText.TextColor3 = Color3.fromRGB(220, 220, 230)
	GetKeyText.TextSize = 14
	GetKeyText.TextXAlignment = Enum.TextXAlignment.Left

	local GetKeyIcon = Instance.new("ImageLabel")
	GetKeyIcon.Name = "Icon"
	GetKeyIcon.Parent = GetKeyBtn
	GetKeyIcon.BackgroundTransparency = 1
	GetKeyIcon.Size = UDim2.new(0, 20, 0, 20)
	GetKeyIcon.Position = UDim2.new(1, -15, 0.5, -10)
	GetKeyIcon.AnchorPoint = Vector2.new(1, 0.5)
	GetKeyIcon.Image = "rbxassetid://6034818372"
	GetKeyIcon.ImageColor3 = MainColor

	local SubmitBtn = Instance.new("Frame")
	SubmitBtn.Name = "SubmitBtn"
	SubmitBtn.Parent = ButtonsSection
	SubmitBtn.BackgroundColor3 = MainColor
	SubmitBtn.Size = UDim2.new(0, 140, 0, 45)

	local SubmitCorner = Instance.new("UICorner")
	SubmitCorner.Parent = SubmitBtn
	SubmitCorner.CornerRadius = UDim.new(0, 8)

	local SubmitStroke = Instance.new("UIStroke")
	SubmitStroke.Parent = SubmitBtn
	SubmitStroke.Color = AccentColor
	SubmitStroke.Thickness = 2
	SubmitStroke.Transparency = 0

	local SubmitClick = click(SubmitBtn)

	local SubmitGlow = Instance.new("Frame")
	SubmitGlow.Name = "Glow"
	SubmitGlow.Parent = SubmitBtn
	SubmitGlow.BackgroundColor3 = AccentColor
	SubmitGlow.BackgroundTransparency = 0.9
	SubmitGlow.Size = UDim2.new(1, 0, 1, 0)
	SubmitGlow.ZIndex = 0

	local GlowCorner2 = Instance.new("UICorner")
	GlowCorner2.Parent = SubmitGlow
	GlowCorner2.CornerRadius = UDim.new(0, 8)

	local SubmitText = Instance.new("TextLabel")
	SubmitText.Name = "Text"
	SubmitText.Parent = SubmitBtn
	SubmitText.BackgroundTransparency = 1
	SubmitText.Size = UDim2.new(1, -40, 1, 0)
	SubmitText.Position = UDim2.new(0, 15, 0, 0)
	SubmitText.Font = Enum.Font.GothamBold
	SubmitText.Text = "SUBMIT"
	SubmitText.TextColor3 = Color3.fromRGB(255, 255, 255)
	SubmitText.TextSize = 14
	SubmitText.TextXAlignment = Enum.TextXAlignment.Left

	local SubmitIcon = Instance.new("ImageLabel")
	SubmitIcon.Name = "Icon"
	SubmitIcon.Parent = SubmitBtn
	SubmitIcon.BackgroundTransparency = 1
	SubmitIcon.Size = UDim2.new(0, 20, 0, 20)
	SubmitIcon.Position = UDim2.new(1, -15, 0.5, -10)
	SubmitIcon.AnchorPoint = Vector2.new(1, 0.5)
	SubmitIcon.Image = "rbxassetid://6034818397"
	SubmitIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

	local Footer = Instance.new("Frame")
	Footer.Name = "Footer"
	Footer.Parent = Content
	Footer.BackgroundTransparency = 1
	Footer.Size = UDim2.new(1, 0, 0, 30)
	Footer.LayoutOrder = 5

	local FooterText = Instance.new("TextLabel")
	FooterText.Name = "FooterText"
	FooterText.Parent = Footer
	FooterText.BackgroundTransparency = 1
	FooterText.Size = UDim2.new(1, 0, 1, 0)
	FooterText.Font = Enum.Font.Gotham
	FooterText.Text = "Need help? Join our Discord server"
	FooterText.TextColor3 = Color3.fromRGB(130, 130, 150)
	FooterText.TextSize = 12

	local FooterClick = click(FooterText)

	local Particles = Instance.new("Frame")
	Particles.Name = "Particles"
	Particles.Parent = ScreenGui
	Particles.BackgroundTransparency = 1
	Particles.Size = UDim2.new(1, 0, 1, 0)
	
	for i = 1, 8 do
		local Particle = Instance.new("Frame")
		Particle.Name = "Particle"..i
		Particle.Parent = Particles
		Particle.BackgroundColor3 = MainColor
		Particle.BackgroundTransparency = 0.8
		Particle.Size = UDim2.new(0, math.random(4, 10), 0, math.random(4, 10))
		Particle.Position = UDim2.new(0, math.random(-100, 800), 0, math.random(-100, 800))
		
		local ParticleCorner = Instance.new("UICorner")
		ParticleCorner.Parent = Particle
		ParticleCorner.CornerRadius = UDim.new(1, 0)
		
		task.spawn(function()
			while Particle.Parent do
				tw({v = Particle, t = 3, g = {Position = UDim2.new(0, math.random(-100, 800), 0, math.random(-100, 800))}}):Play()
				task.wait(3)
			end
		end)
	end

	local NotifyContainer = Instance.new("Frame")
	NotifyContainer.Name = "NotifyContainer"
	NotifyContainer.Parent = ScreenGui
	NotifyContainer.AnchorPoint = Vector2.new(1, 0)
	NotifyContainer.BackgroundTransparency = 1
	NotifyContainer.Position = UDim2.new(1, -20, 0, 20)
	NotifyContainer.Size = UDim2.new(0, 350, 1, -40)
	
	local UIListLayout_NotifyContainer = Instance.new("UIListLayout")
	UIListLayout_NotifyContainer.Parent = NotifyContainer
	UIListLayout_NotifyContainer.Padding = UDim.new(0, 15)
	UIListLayout_NotifyContainer.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_NotifyContainer.HorizontalAlignment = Enum.HorizontalAlignment.Right

	if game:GetService("RunService"):IsStudio() then
		ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	else
		ScreenGui.Parent = game:GetService("CoreGui")
	end
	
	ScreenGui.DisplayOrder = 999

	local function adjustSize()
		local viewportSize = workspace.CurrentCamera.ViewportSize
		local calculatedWidth = math.min(viewportSize.X * baseSize, maxWidth)
		local calculatedHeight = math.min(viewportSize.Y * baseSize, maxHeight)
		
		MainContainer.Size = UDim2.new(0, calculatedWidth, 0, calculatedHeight)
		MainContainer.Position = UDim2.new(0.5, -calculatedWidth/2, 0.5, -calculatedHeight/2)
	end
	
	adjustSize()
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(adjustSize)
	
	MainContainer.Size = UDim2.new(0, 0, 0, 0)
	MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
	
	task.spawn(function()
		task.wait(0.3)
		
		tw({v = MainContainer, t = 0.8, s = Enum.EasingStyle.Back, d = "Out", g = {Size = UDim2.new(0, maxWidth, 0, maxHeight), Position = UDim2.new(0.5, -maxWidth/2, 0.5, -maxHeight/2)}}):Play()
		tw({v = BackgroundGlow, t = 0.6, g = {ImageTransparency = 0.7}}):Play()
		
		task.wait(0.2)
		
		tw({v = IconBack, t = 0.5, g = {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}}):Play()
		tw({v = IconImage, t = 0.5, g = {ImageColor3 = MainColor}}):Play()
		
		task.wait(0.1)
		
		tw({v = Title, t = 0.4, g = {TextTransparency = 0}}):Play()
		tw({v = Subtitle, t = 0.4, g = {TextTransparency = 0}}):Play()
		
		task.wait(0.1)
		
		tw({v = WelcomeText, t = 0.4, g = {TextTransparency = 0}}):Play()
		
		task.wait(0.1)
		
		tw({v = KeyBox, t = 0.4, g = {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}}):Play()
		tw({v = KeyBoxGlow, t = 0.4, g = {BackgroundTransparency = 0.9}}):Play()
		tw({v = KeyBoxGradient, t = 0.4, g = {Transparency = NumberSequence.new(0.9)}}):Play()
		
		task.wait(0.1)
		
		tw({v = GetKeyBtn, t = 0.4, g = {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}}):Play()
		
		task.wait(0.1)
		
		tw({v = SubmitBtn, t = 0.4, g = {BackgroundColor3 = MainColor}}):Play()
		tw({v = SubmitGlow, t = 0.4, g = {BackgroundTransparency = 0.8}}):Play()
		
		task.wait(0.1)
		
		tw({v = FooterText, t = 0.4, g = {TextTransparency = 0}}):Play()
	end)
	
	local tab = {}
	
	function tab.New(p)
		if not p then return end
		
		local Title = p.Title or 'Tab'
		local Icon = gl(p.Icon or 6031075938)
		local Callback = p.Callback or function() end
		
		local TabFrame = Instance.new("Frame")
		TabFrame.Name = "TabFrame"
		TabFrame.Parent = Content
		TabFrame.BackgroundTransparency = 1
		TabFrame.Size = UDim2.new(1, 0, 0, 45)
		TabFrame.LayoutOrder = 6
		
		local TabButton = Instance.new("Frame")
		TabButton.Name = "TabButton"
		TabButton.Parent = TabFrame
		TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		TabButton.Size = UDim2.new(0, 160, 0, 45)
		TabButton.Position = UDim2.new(0.5, -80, 0, 0)
		
		local TabCorner = Instance.new("UICorner")
		TabCorner.Parent = TabButton
		TabCorner.CornerRadius = UDim.new(0, 8)
		
		local TabStroke = Instance.new("UIStroke")
		TabStroke.Parent = TabButton
		TabStroke.Color = MainColor
		TabStroke.Thickness = 2
		TabStroke.Transparency = 0.5
		
		local TabLayout = Instance.new("UIListLayout")
		TabLayout.Parent = TabButton
		TabLayout.FillDirection = Enum.FillDirection.Horizontal
		TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		TabLayout.Padding = UDim.new(0, 12)
		
		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Name = "TabIcon"
		TabIcon.Parent = TabButton
		TabIcon.BackgroundTransparency = 1
		TabIcon.Size = UDim2.new(0, 22, 0, 22)
		TabIcon.Image = Icon
		TabIcon.ImageColor3 = MainColor
		
		local TabText = Instance.new("TextLabel")
		TabText.Name = "TabText"
		TabText.Parent = TabButton
		TabText.BackgroundTransparency = 1
		TabText.Size = UDim2.new(0, 100, 0, 22)
		TabText.Font = Enum.Font.GothamSemibold
		TabText.Text = Title
		TabText.TextColor3 = Color3.fromRGB(220, 220, 230)
		TabText.TextSize = 14
		
		local TabClick = click(TabButton)
		
		if TabClick then
			TabClick.MouseButton1Click:Connect(Callback)
		end
	end
	
	function tab.Notify(p)
		if not p then return {Set = function() end} end
		
		local Title = p.Title or 'Notification'
		local Icon = gl(p.Icon or 6034818397)
		local ColorN = p.Color or Color3.fromRGB(30, 30, 40)
		local Time = p.Time or 5
		
		local NotifyFrame = Instance.new("Frame")
		NotifyFrame.Name = "Notify"
		NotifyFrame.Parent = NotifyContainer
		NotifyFrame.BackgroundColor3 = ColorN
		NotifyFrame.BackgroundTransparency = 1
		NotifyFrame.Size = UDim2.new(1, 0, 0, 0)
		NotifyFrame.ClipsDescendants = true
		
		local NotifyCorner = Instance.new("UICorner")
		NotifyCorner.Parent = NotifyFrame
		NotifyCorner.CornerRadius = UDim.new(0, 10)
		
		local NotifyStroke = Instance.new("UIStroke")
		NotifyStroke.Parent = NotifyFrame
		NotifyStroke.Color = Color3.fromRGB(60, 60, 70)
		NotifyStroke.Thickness = 2
		NotifyStroke.Transparency = 1
		
		local NotifyGlow = Instance.new("Frame")
		NotifyGlow.Name = "NotifyGlow"
		NotifyGlow.Parent = NotifyFrame
		NotifyGlow.BackgroundColor3 = MainColor
		NotifyGlow.BackgroundTransparency = 1
		NotifyGlow.Size = UDim2.new(1, 0, 1, 0)
		NotifyGlow.ZIndex = 0
		
		local GlowCorner3 = Instance.new("UICorner")
		GlowCorner3.Parent = NotifyGlow
		GlowCorner3.CornerRadius = UDim.new(0, 10)
		
		local NotifyGradient = Instance.new("UIGradient")
		NotifyGradient.Parent = NotifyGlow
		NotifyGradient.Rotation = 90
		NotifyGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, MainColor),
			ColorSequenceKeypoint.new(0.5, AccentColor),
			ColorSequenceKeypoint.new(1, MainColor)
		})
		NotifyGradient.Transparency = NumberSequence.new(1)
		
		local NotifyContent = Instance.new("Frame")
		NotifyContent.Name = "NotifyContent"
		NotifyContent.Parent = NotifyFrame
		NotifyContent.BackgroundTransparency = 1
		NotifyContent.Size = UDim2.new(1, -20, 1, -20)
		NotifyContent.Position = UDim2.new(0, 10, 0, 10)
		
		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.Parent = NotifyContent
		ContentLayout.FillDirection = Enum.FillDirection.Horizontal
		ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ContentLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		ContentLayout.Padding = UDim.new(0, 15)
		
		local NotifyIcon = Instance.new("ImageLabel")
		NotifyIcon.Name = "NotifyIcon"
		NotifyIcon.Parent = NotifyContent
		NotifyIcon.BackgroundTransparency = 1
		NotifyIcon.Size = UDim2.new(0, 32, 0, 32)
		NotifyIcon.Image = Icon
		NotifyIcon.ImageColor3 = MainColor
		NotifyIcon.ImageTransparency = 1
		
		local NotifyText = Instance.new("TextLabel")
		NotifyText.Name = "NotifyText"
		NotifyText.Parent = NotifyContent
		NotifyText.BackgroundTransparency = 1
		NotifyText.Size = UDim2.new(1, -50, 1, 0)
		NotifyText.Font = Enum.Font.Gotham
		NotifyText.Text = Title
		NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
		NotifyText.TextSize = 14
		NotifyText.TextTransparency = 1
		NotifyText.TextWrapped = true
		NotifyText.TextXAlignment = Enum.TextXAlignment.Left
		
		local textSize = Ts:GetTextSize(Title, 14, Enum.Font.Gotham, Vector2.new(280, math.huge))
		local height = math.max(70, textSize.Y + 40)
		
		NotifyFrame.Size = UDim2.new(1, 0, 0, height)
		
		tw({v = NotifyFrame, t = 0.4, s = Enum.EasingStyle.Back, d = "Out", g = {BackgroundTransparency = 0}}):Play()
		tw({v = NotifyStroke, t = 0.4, g = {Transparency = 0}}):Play()
		tw({v = NotifyGlow, t = 0.4, g = {BackgroundTransparency = 0.9}}):Play()
		tw({v = NotifyGradient, t = 0.4, g = {Transparency = NumberSequence.new(0.9)}}):Play()
		tw({v = NotifyIcon, t = 0.4, g = {ImageTransparency = 0}}):Play()
		tw({v = NotifyText, t = 0.4, g = {TextTransparency = 0}}):Play()
		
		local connection
		connection = game:GetService("RunService").Heartbeat:Connect(function()
			if NotifyFrame.Parent then
				UIListLayout_NotifyContainer:ApplyLayout()
			else
				connection:Disconnect()
			end
		end)
		
		task.spawn(function()
			task.wait(Time)
			
			tw({v = NotifyFrame, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {BackgroundTransparency = 1}}):Play()
			tw({v = NotifyStroke, t = 0.3, g = {Transparency = 1}}):Play()
			tw({v = NotifyGlow, t = 0.3, g = {BackgroundTransparency = 1}}):Play()
			tw({v = NotifyGradient, t = 0.3, g = {Transparency = NumberSequence.new(1)}}):Play()
			tw({v = NotifyIcon, t = 0.3, g = {ImageTransparency = 1}}):Play()
			tw({v = NotifyText, t = 0.3, g = {TextTransparency = 1}}):Play()
			
			task.delay(0.3, function()
				if NotifyFrame.Parent then
					NotifyFrame:Destroy()
				end
			end)
		end)
		
		local n = {}
		
		function n:Set(newText)
			if NotifyText then
				NotifyText.Text = newText
				local newTextSize = Ts:GetTextSize(newText, 14, Enum.Font.Gotham, Vector2.new(280, math.huge))
				local newHeight = math.max(70, newTextSize.Y + 40)
				tw({v = NotifyFrame, t = 0.2, g = {Size = UDim2.new(1, 0, 0, newHeight)}}):Play()
			end
		end
		
		return n
	end
	
	if FooterClick then
		FooterClick.MouseButton1Click:Connect(function()
			if o.DiscordLink then
				if KeyGUI then 
					pcall(setclipboard, o.DiscordLink) 
				end
				tab.Notify({
					Title = 'Discord link copied to clipboard!',
					Icon = 6034818372,
					Time = 3,
					Color = Color3.fromRGB(30, 30, 40)
				})
			end
		end)
	end
	
	local checkingKey = false
	
	if GetKeyClick then
		GetKeyClick.MouseButton1Click:Connect(function()
			tw({v = GetKeyBtn, t = 0.1, g = {Size = UDim2.new(0, 136, 0, 43)}}):Play()
			task.delay(0.1, function()
				tw({v = GetKeyBtn, t = 0.1, g = {Size = UDim2.new(0, 140, 0, 45)}}):Play()
			end)
			
			if o.KeyLink then
				if KeyGUI then 
					pcall(setclipboard, o.KeyLink) 
				end
				tab.Notify({
					Title = 'Key link copied to clipboard',
					Icon = 6034818372,
					Time = 3,
					Color = Color3.fromRGB(30, 30, 40)
				})
			else
				tab.Notify({
					Title = 'No key link provided',
					Icon = 6034818390,
					Time = 3,
					Color = Color3.fromRGB(30, 30, 40)
				})
			end
		end)
	end
	
	if SubmitClick then
		SubmitClick.MouseButton1Click:Connect(function()
			if checkingKey then return end
			checkingKey = true
			
			tw({v = SubmitBtn, t = 0.1, g = {Size = UDim2.new(0, 136, 0, 43)}}):Play()
			
			local checkNotify = tab.Notify({
				Title = 'Checking Key...',
				Icon = 6034818397,
				Time = 10,
				Color = Color3.fromRGB(30, 30, 40)
			})
			
			task.delay(0.5, function()
				local input = KeyInput.Text
				local found = false

				for _, v in ipairs(Key) do
					if input == v then
						found = true
						break
					end
				end

				if found then
					if KeyGUI then 
						pcall(writefile, "PremiumHub/key.txt", input) 
					end
					
					task.delay(0.3, function()
						checkNotify:Set('Key Verified Successfully!')
						tab.Notify({
							Title = 'Loading script...',
							Icon = 6034818397,
							Time = 2,
							Color = Color3.fromRGB(30, 30, 40)
						})
					end)
					
					tw({v = SubmitBtn, t = 0.2, g = {BackgroundColor3 = Color3.fromRGB(76, 175, 80)}}):Play()
					tw({v = SubmitGlow, t = 0.2, g = {BackgroundColor3 = Color3.fromRGB(76, 175, 80)}}):Play()
					
					task.delay(1.5, function()
						tw({v = MainContainer, t = 0.4, g = {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}}):Play()
						tw({v = BackgroundGlow, t = 0.4, g = {ImageTransparency = 1}}):Play()
						
						task.delay(0.4, function()
							ScreenGui:Destroy()
							if o.Callback then
								o.Callback()
							end
						end)	
					end)
				else
					tw({v = KeyBox, t = 0.2, g = {BackgroundColor3 = Color3.fromRGB(244, 67, 54)}}):Play()
					task.delay(0.2, function()
						tw({v = KeyBox, t = 0.2, g = {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}}):Play()
					end)
					
					checkNotify:Set('Invalid Key!')
					
					tab.Notify({
						Title = 'Invalid key! Please check and try again.',
						Icon = 6034818390,
						Time = 3,
						Color = Color3.fromRGB(30, 30, 40)
					})
					
					tw({v = SubmitBtn, t = 0.2, g = {BackgroundColor3 = Color3.fromRGB(244, 67, 54)}}):Play()
					tw({v = SubmitGlow, t = 0.2, g = {BackgroundColor3 = Color3.fromRGB(244, 67, 54)}}):Play()
					
					task.delay(0.5, function()
						tw({v = SubmitBtn, t = 0.2, g = {BackgroundColor3 = MainColor, Size = UDim2.new(0, 140, 0, 45)}}):Play()
						tw({v = SubmitGlow, t = 0.2, g = {BackgroundColor3 = AccentColor}}):Play()
						checkingKey = false
					end)
				end
			end)
		end)
	end

	return tab
end

return Library
