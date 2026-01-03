
local Library = {}
local U, Tw = game:GetService("UserInputService"), game:GetService("TweenService")
local KeyGUI = pcall(function() return makefolder and readfile and writefile and setclipboard end)

function Library.Load(o)
	local function init(getFrame)
		if not getFrame then return {nil, nil} end
		
		local MTREL = "Glass"
		local binds = {}
		local root = Instance.new('Folder', workspace.CurrentCamera)
		root.Name = 'BlurSnox'

		local gTokenMH = 99999999
		local gToken = math.random(1, gTokenMH)

		local DepthOfField = Instance.new('DepthOfFieldEffect', game:GetService('Lighting'))
		DepthOfField.FarIntensity = 0
		DepthOfField.FocusDistance = 51.6
		DepthOfField.InFocusRadius = 50
		DepthOfField.NearIntensity = 1
		DepthOfField.Name = "DPT_"..gToken

		local frame = Instance.new('Frame')
		frame.Parent = getFrame
		frame.Size = UDim2.new(0.95, 0, 0.95, 0)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.BackgroundTransparency = 1

		local GenUid
		do
			local id = 0
			function GenUid()
				id = id + 1
				return 'neon::'..tostring(id)
			end
		end

		do
			local function IsNotNaN(x)
				return x == x
			end
			local continue = IsNotNaN(workspace.CurrentCamera:ScreenPointToRay(0,0).Origin.x)
			while not continue do
				game:GetService('RunService').RenderStepped:Wait()
				continue = IsNotNaN(workspace.CurrentCamera:ScreenPointToRay(0,0).Origin.x)
			end
		end

		local DrawQuad
		do
			local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
			local sz = 0.2

			local function DrawTriangle(v1, v2, v3, p0, p1)
				local s1 = (v1 - v2).magnitude
				local s2 = (v2 - v3).magnitude
				local s3 = (v3 - v1).magnitude
				local smax = max(s1, s2, s3)
				local A, B, C
				if s1 == smax then
					A, B, C = v1, v2, v3
				elseif s2 == smax then
					A, B, C = v2, v3, v1
				elseif s3 == smax then
					A, B, C = v3, v1, v2
				end

				local para = ( (B-A).x*(C-A).x + (B-A).y*(C-A).y + (B-A).z*(C-A).z ) / (A-B).magnitude
				local perp = sqrt((C-A).magnitude^2 - para*para)
				local dif_para = (A - B).magnitude - para

				local st = CFrame.new(B, A)
				local za = CFrame.Angles(pi/2,0,0)

				local cf0 = st
				local Top_Look = (cf0 * za).lookVector
				local Mid_Point = A + CFrame.new(A, B).lookVector * para
				local Needed_Look = CFrame.new(Mid_Point, C).lookVector
				local dot = Top_Look.x*Needed_Look.x + Top_Look.y*Needed_Look.y + Top_Look.z*Needed_Look.z
				local ac = CFrame.Angles(0, 0, acos(dot))

				cf0 = cf0 * ac
				if ((cf0 * za).lookVector - Needed_Look).magnitude > 0.01 then
					cf0 = cf0 * CFrame.Angles(0, 0, -2*acos(dot))
				end
				cf0 = cf0 * CFrame.new(0, perp/2, -(dif_para + para/2))

				local cf1 = st * ac * CFrame.Angles(0, pi, 0)
				if ((cf1 * za).lookVector - Needed_Look).magnitude > 0.01 then
					cf1 = cf1 * CFrame.Angles(0, 0, 2*acos(dot))
				end
				cf1 = cf1 * CFrame.new(0, perp/2, dif_para/2)

				if not p0 then
					p0 = Instance.new('Part')
					p0.FormFactor = 'Custom'
					p0.TopSurface = 0
					p0.BottomSurface = 0
					p0.Anchored = true
					p0.CanCollide = false
					p0.CastShadow = false
					p0.Material = MTREL
					p0.Size = Vector3.new(sz, sz, sz)
					local mesh = Instance.new('SpecialMesh', p0)
					mesh.MeshType = 2
					mesh.Name = 'WedgeMesh'
				end
				p0.WedgeMesh.Scale = Vector3.new(0, perp/sz, para/sz)
				p0.CFrame = cf0

				if not p1 then
					p1 = p0:Clone()
				end
				p1.WedgeMesh.Scale = Vector3.new(0, perp/sz, dif_para/sz)
				p1.CFrame = cf1

				return p0, p1
			end

			function DrawQuad(v1, v2, v3, v4, parts)
				parts[1], parts[2] = DrawTriangle(v1, v2, v3, parts[1], parts[2])
				parts[3], parts[4] = DrawTriangle(v3, v2, v4, parts[3], parts[4])
			end
		end

		if binds[frame] then
			return binds[frame].parts
		end

		local uid = GenUid()
		local parts = {}
		local f = Instance.new('Folder', root)
		f.Name = frame.Name

		local parents = {}
		do
			local function add(child)
				if child:IsA('GuiObject') then
					parents[#parents + 1] = child
					add(child.Parent)
				end
			end
			add(frame)
		end

		local function UpdateOrientation(fetchProps)
			local properties = {
				Transparency = 0.98;
				BrickColor = BrickColor.new('Institutional white');
			}
			local zIndex = 1 - 0.05*frame.ZIndex

			local tl, br = frame.AbsolutePosition, frame.AbsolutePosition + frame.AbsoluteSize
			local tr, bl = Vector2.new(br.x, tl.y), Vector2.new(tl.x, br.y)
			do
				local rot = 0;
				for _, v in ipairs(parents) do
					rot = rot + v.Rotation
				end
				if rot ~= 0 and rot%180 ~= 0 then
					local mid = tl:lerp(br, 0.5)
					local s, c = math.sin(math.rad(rot)), math.cos(math.rad(rot))
					local vec = tl
					tl = Vector2.new(c*(tl.x - mid.x) - s*(tl.y - mid.y), s*(tl.x - mid.x) + c*(tl.y - mid.y)) + mid
					tr = Vector2.new(c*(tr.x - mid.x) - s*(tr.y - mid.y), s*(tr.x - mid.x) + c*(tr.y - mid.y)) + mid
					bl = Vector2.new(c*(bl.x - mid.x) - s*(bl.y - mid.y), s*(bl.x - mid.x) + c*(bl.y - mid.y)) + mid
					br = Vector2.new(c*(br.x - mid.x) - s*(br.y - mid.y), s*(br.x - mid.x) + c*(br.y - mid.y)) + mid
				end
			end
			DrawQuad(
				workspace.CurrentCamera:ScreenPointToRay(tl.x, tl.y, zIndex).Origin, 
				workspace.CurrentCamera:ScreenPointToRay(tr.x, tr.y, zIndex).Origin, 
				workspace.CurrentCamera:ScreenPointToRay(bl.x, bl.y, zIndex).Origin, 
				workspace.CurrentCamera:ScreenPointToRay(br.x, br.y, zIndex).Origin, 
				parts
			)
			if fetchProps then
				for _, pt in pairs(parts) do
					pt.Parent = f
				end
				for propName, propValue in pairs(properties) do
					for _, pt in pairs(parts) do
						pt[propName] = propValue
					end
				end
			end
		end

		UpdateOrientation(true)
		game:GetService('RunService'):BindToRenderStep(uid, 2000, UpdateOrientation)
		return {
			DepthOfField,
			frame
		}
	end
	
	local function gl(i)
		if not i then
			return {
				Image = "",
				ImageRectSize = Vector2.new(0, 0),
				ImageRectOffset = Vector2.new(0, 0),
			}
		elseif type(i) == 'number' then
			return {
				Image = "rbxassetid://".. tostring(i),
				ImageRectSize = Vector2.new(0, 0),
				ImageRectOffset = Vector2.new(0, 0),
			}
		elseif type(i) == 'string' and not i:find('rbxassetid://') then
			return {
				Image = "rbxassetid://".. i,
				ImageRectSize = Vector2.new(0, 0),
				ImageRectOffset = Vector2.new(0, 0),
			}
		else
			return {
				Image = i,
				ImageRectSize = Vector2.new(0, 0),
				ImageRectOffset = Vector2.new(0, 0),
			}
		end
	end
	
	local function tw(info)
		if not info then 
			return { Play = function() end } 
		end
		if not info.v or not info.v:IsA("Instance") then 
			return { Play = function() end } 
		end
		
		local direction = Enum.EasingDirection.Out
		if type(info.d) == "string" then
			if Enum.EasingDirection[info.d] then
				direction = Enum.EasingDirection[info.d]
			end
		elseif info.d then
			direction = info.d
		end
		
		local style = info.s or Enum.EasingStyle.Quad
		local time = info.t or 0.3
		
		local success, tween = pcall(function()
			return Tw:Create(
				info.v,
				TweenInfo.new(time, style, direction),
				info.g or {}
			)
		end)
		
		if success and tween then
			return tween
		else
			return { Play = function() end }
		end
	end
	
	local function lak(t, o)
		if not t or not o then return end
		
		local a, b, c, d
		local function u(i)
			if not i or not d then return end
			local dt = i.Position - c
			tw({v = o, t = 0.05, s = Enum.EasingStyle.Linear, d = "InOut", g = {Position = UDim2.new(d.X.Scale, d.X.Offset + dt.X, d.Y.Scale, d.Y.Offset + dt.Y)}}):Play()
		end
		t.InputBegan:Connect(function(i) 
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
				a = true 
				c = i.Position 
				d = o.Position
				i.Changed:Connect(function() 
					if i.UserInputState == Enum.UserInputState.End then 
						a = false 
					end 
				end) 
			end 
		end)
		t.InputChanged:Connect(function(i) 
			if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then 
				b = i 
			end 
		end)
		U.InputChanged:Connect(function(i) 
			if i == b and a then 
				u(i) 
			end 
		end)
	end
	
	local function click(p)
		if not p then return end
		
		local Click = Instance.new("TextButton")
		Click.Name = "Click"
		Click.Parent = p
		Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click.BackgroundTransparency = 1.000
		Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click.BorderSizePixel = 0
		Click.Size = UDim2.new(1, 0, 1, 0)
		Click.Font = Enum.Font.SourceSans
		Click.Text = ""
		Click.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click.TextSize = 14.000
		return Click
	end

	local HubName = o.Name or 'SindexHub'
	local Color = o.Color or Color3.fromRGB(138, 43, 226)
	local Icon = o.Icon or 14930953469
	local Key = o.Key or {}
	local DiscordLink = o.Discord or o.DiscordLink or 'discord.gg'

	if KeyGUI then 
		pcall(function()
			makefolder("SindexHub")
		end)
	end
	local savedKey = ""
	if KeyGUI then
		local success, key = pcall(readfile, "SindexHub/key.txt")
		if success then
			savedKey = key or ""
		end
	end

	local ScreenGui = Instance.new("ScreenGui")
	local MainContainer = Instance.new("Frame")
	local BackgroundBlur = Instance.new("BlurEffect", game:GetService("Lighting"))
	BackgroundBlur.Size = 0

	ScreenGui.Parent = (not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Name = "SindexKeySystem"

	MainContainer.Name = "MainContainer"
	MainContainer.Parent = ScreenGui
	MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
	MainContainer.BackgroundTransparency = 1
	MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainContainer.Size = UDim2.new(0, 400, 0, 500)

	local Background_1 = Instance.new("Frame")
	local UICorner_1 = Instance.new("UICorner")
	local MainGradient = Instance.new("UIGradient")
	local UIPadding_1 = Instance.new("UIPadding")
	local Left_1 = Instance.new("CanvasGroup")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local Header = Instance.new("Frame")
	local HeaderGradient = Instance.new("UIGradient")
	local HeaderContent = Instance.new("Frame")
	local IconContainer = Instance.new("Frame")
	local IconGradient = Instance.new("UIGradient")
	local ImageLabel_1 = Instance.new("ImageLabel")
	local TitleContainer = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local SubtitleLabel = Instance.new("TextLabel")
	local adsframe_1 = Instance.new("Frame")
	local ads_1 = Instance.new("TextLabel")
	local KeyFrame_1 = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local TextLabel_2 = Instance.new("TextLabel")
	local EyeButton = Instance.new("Frame")
	local UICorner_Eye = Instance.new("UICorner")
	local EyeStroke = Instance.new("UIStroke")
	local EyeIcon = Instance.new("ImageLabel")
	local Keybox_1 = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local KeyboxStroke = Instance.new("UIStroke")
	local KeyboxGradient = Instance.new("UIGradient")
	local KeyboxGlow = Instance.new("ImageLabel")
	local UIPadding_2 = Instance.new("UIPadding")
	local TextBox_1 = Instance.new("TextBox")
	local ButtonContainer = Instance.new("Frame")
	local UIListLayout_4 = Instance.new("UIListLayout")
	local RedeemButton = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ButtonGradient = Instance.new("UIGradient")
	local ButtonGlow = Instance.new("ImageLabel")
	local ButtonContent = Instance.new("Frame")
	local UIListLayout_5 = Instance.new("UIListLayout")
	local ButtonLabel = Instance.new("TextLabel")
	local ButtonIcon = Instance.new("ImageLabel")
	local ButtonClick = Instance.new("TextButton")
	local HoverButton1 = Instance.new("Frame")
	local GetKeyButton = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local ButtonGradient2 = Instance.new("UIGradient")
	local ButtonGlow2 = Instance.new("ImageLabel")
	local ButtonContent2 = Instance.new("Frame")
	local UIListLayout_6 = Instance.new("UIListLayout")
	local ButtonLabel2 = Instance.new("TextLabel")
	local ButtonIcon2 = Instance.new("ImageLabel")
	local ButtonClick2 = Instance.new("TextButton")
	local HoverButton2 = Instance.new("Frame")
	local Footer = Instance.new("Frame")
	local FooterText = Instance.new("TextLabel")
	local DiscordButton = Instance.new("TextButton")
	local Divider = Instance.new("Frame")
	local TabList_1 = Instance.new("Frame")
	local UIListLayout_7 = Instance.new("UIListLayout")

	Background_1.Name = "Background"
	Background_1.Parent = MainContainer
	Background_1.AutomaticSize = Enum.AutomaticSize.Y
	Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Background_1.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
	Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderSizePixel = 0
	Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Background_1.Size = UDim2.new(0.9, 0,0, 0)
	Background_1.ClipsDescendants = true
	Background_1.BackgroundTransparency = 1
	
	lak(Background_1, Background_1)

	init(Background_1)

	UICorner_1.Parent = Background_1
	UICorner_1.CornerRadius = UDim.new(0, 20)

	MainGradient.Parent = Background_1
	MainGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 15, 30)),
		ColorSequenceKeypoint.new(0.3, Color3.fromRGB(40, 30, 60)),
		ColorSequenceKeypoint.new(0.7, Color3.fromRGB(40, 30, 60)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 30))
	}
	MainGradient.Rotation = 90

	local BorderGlow = Instance.new("UIStroke")
	BorderGlow.Parent = Background_1
	BorderGlow.Color = Color
	BorderGlow.Thickness = 2
	BorderGlow.Transparency = 1

	local OuterGlow = Instance.new("ImageLabel")
	OuterGlow.Name = "OuterGlow"
	OuterGlow.Parent = Background_1
	OuterGlow.AnchorPoint = Vector2.new(0.5, 0.5)
	OuterGlow.BackgroundTransparency = 1
	OuterGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
	OuterGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
	OuterGlow.Image = "rbxassetid://8992230671"
	OuterGlow.ImageColor3 = Color
	OuterGlow.ImageTransparency = 1
	OuterGlow.ScaleType = Enum.ScaleType.Slice
	OuterGlow.SliceCenter = Rect.new(100, 100, 100, 100)
	OuterGlow.ZIndex = 0

	UIPadding_1.Parent = Background_1
	UIPadding_1.PaddingBottom = UDim.new(0, 20)
	UIPadding_1.PaddingLeft = UDim.new(0, 25)
	UIPadding_1.PaddingRight = UDim.new(0, 25)
	UIPadding_1.PaddingTop = UDim.new(0, 20)

	Left_1.Name = "Left"
	Left_1.Parent = Background_1
	Left_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Left_1.BackgroundTransparency = 1
	Left_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Left_1.BorderSizePixel = 0
	Left_1.Size = UDim2.new(1, 0,1, 0)
	Left_1.GroupTransparency = 1

	UIListLayout_1.Parent = Left_1
	UIListLayout_1.Padding = UDim.new(0, 20)
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

	Header.Name = "Header"
	Header.Parent = Left_1
	Header.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Header.BackgroundTransparency = 1
	Header.Size = UDim2.new(1, 0, 0, 70)

	HeaderGradient.Parent = Header
	HeaderGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 25, 45)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 35))
	}
	HeaderGradient.Rotation = 90

	HeaderContent = Instance.new("Frame")
	HeaderContent.Name = "HeaderContent"
	HeaderContent.Parent = Header
	HeaderContent.BackgroundTransparency = 1
	HeaderContent.Size = UDim2.new(1, 0, 1, 0)

	local HeaderList = Instance.new("UIListLayout")
	HeaderList.Parent = HeaderContent
	HeaderList.FillDirection = Enum.FillDirection.Horizontal
	HeaderList.Padding = UDim.new(0, 15)
	HeaderList.VerticalAlignment = Enum.VerticalAlignment.Center

	IconContainer = Instance.new("Frame")
	IconContainer.Name = "IconContainer"
	IconContainer.Parent = HeaderContent
	IconContainer.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
	IconContainer.Size = UDim2.new(0, 50, 0, 50)
	IconContainer.BackgroundTransparency = 1

	local IconCorner = Instance.new("UICorner")
	IconCorner.Parent = IconContainer
	IconCorner.CornerRadius = UDim.new(0, 12)

	IconGradient = Instance.new("UIGradient")
	IconGradient.Parent = IconContainer
	IconGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 255))
	}
	IconGradient.Rotation = 135
	IconGradient.Transparency = NumberSequence.new(1)

	ImageLabel_1.Parent = IconContainer
	ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_1.BackgroundTransparency = 1
	ImageLabel_1.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel_1.Size = UDim2.new(0.7, 0, 0.7, 0)
	ImageLabel_1.Image = gl(Icon).Image
	ImageLabel_1.ImageTransparency = 1

	TitleContainer = Instance.new("Frame")
	TitleContainer.Name = "TitleContainer"
	TitleContainer.Parent = HeaderContent
	TitleContainer.BackgroundTransparency = 1
	TitleContainer.Size = UDim2.new(1, -65, 1, 0)

	local TitleList = Instance.new("UIListLayout")
	TitleList.Parent = TitleContainer
	TitleList.Padding = UDim.new(0, 5)

	TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "TitleLabel"
	TitleLabel.Parent = TitleContainer
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = HubName
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 18
	TitleLabel.TextTransparency = 1
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	SubtitleLabel = Instance.new("TextLabel")
	SubtitleLabel.Name = "SubtitleLabel"
	SubtitleLabel.Parent = TitleContainer
	SubtitleLabel.BackgroundTransparency = 1
	SubtitleLabel.Font = Enum.Font.Gotham
	SubtitleLabel.Text = "KEY SYSTEM"
	SubtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
	SubtitleLabel.TextSize = 12
	SubtitleLabel.TextTransparency = 1
	SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	adsframe_1.Name = "adsframe"
	adsframe_1.Parent = Left_1
	adsframe_1.AutomaticSize = Enum.AutomaticSize.Y
	adsframe_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	adsframe_1.BackgroundTransparency = 1
	adsframe_1.Size = UDim2.new(1, 0, 0, 0)

	ads_1.Name = "ads"
	ads_1.Parent = adsframe_1
	ads_1.AutomaticSize = Enum.AutomaticSize.Y
	ads_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ads_1.BackgroundTransparency = 1
	ads_1.Size = UDim2.new(1, 0, 1, 0)
	ads_1.Font = Enum.Font.Gotham
	ads_1.RichText = true
	ads_1.Text = "Enter your license key to access premium features"
	ads_1.TextColor3 = Color3.fromRGB(220, 220, 240)
	ads_1.TextSize = 14
	ads_1.TextTransparency = 1
	ads_1.TextWrapped = true
	ads_1.TextXAlignment = Enum.TextXAlignment.Left

	KeyFrame_1.Name = "KeyFrame"
	KeyFrame_1.Parent = Left_1
	KeyFrame_1.AutomaticSize = Enum.AutomaticSize.Y
	KeyFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	KeyFrame_1.BackgroundTransparency = 1
	KeyFrame_1.Size = UDim2.new(1, 0, 0, 0)

	UIListLayout_3.Parent = KeyFrame_1
	UIListLayout_3.Padding = UDim.new(0, 8)

	TextLabel_2.Parent = KeyFrame_1
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextLabel_2.BackgroundTransparency = 1
	TextLabel_2.Font = Enum.Font.GothamMedium
	TextLabel_2.Text = "License Key"
	TextLabel_2.TextColor3 = Color3.fromRGB(240, 240, 250)
	TextLabel_2.TextSize = 13
	TextLabel_2.TextTransparency = 1
	TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

	EyeButton = Instance.new("Frame")
	EyeButton.Name = "EyeButton"
	EyeButton.Parent = TextLabel_2
	EyeButton.AnchorPoint = Vector2.new(1, 0.5)
	EyeButton.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
	EyeButton.BackgroundTransparency = 1
	EyeButton.Position = UDim2.new(1, 0, 0.5, 0)
	EyeButton.Size = UDim2.new(0, 32, 0, 32)

	UICorner_Eye.Parent = EyeButton
	UICorner_Eye.CornerRadius = UDim.new(1, 0)

	EyeStroke = Instance.new("UIStroke")
	EyeStroke.Parent = EyeButton
	EyeStroke.Color = Color
	EyeStroke.Thickness = 1
	EyeStroke.Transparency = 1

	EyeIcon = Instance.new("ImageLabel")
	EyeIcon.Parent = EyeButton
	EyeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	EyeIcon.BackgroundColor3 = Color3.fromRGB(255,255,255)
	EyeIcon.BackgroundTransparency = 1
	EyeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	EyeIcon.Size = UDim2.new(0, 18, 0, 18)
	EyeIcon.Image = "rbxassetid://13868333926"
	EyeIcon.ImageTransparency = 1
	
	local HideShowKey = click(EyeButton)

	Keybox_1.Name = "Keybox"
	Keybox_1.Parent = KeyFrame_1
	Keybox_1.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
	Keybox_1.Size = UDim2.new(1, 0, 0, 45)
	Keybox_1.Transparency = 1

	UICorner_3.Parent = Keybox_1
	UICorner_3.CornerRadius = UDim.new(0, 10)

	KeyboxStroke = Instance.new("UIStroke")
	KeyboxStroke.Parent = Keybox_1
	KeyboxStroke.Color = Color
	KeyboxStroke.Thickness = 1.5
	KeyboxStroke.Transparency = 1

	KeyboxGradient = Instance.new("UIGradient")
	KeyboxGradient.Parent = Keybox_1
	KeyboxGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 45, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 35, 60))
	}
	KeyboxGradient.Transparency = NumberSequence.new(1)

	KeyboxGlow = Instance.new("ImageLabel")
	KeyboxGlow.Name = "KeyboxGlow"
	KeyboxGlow.Parent = Keybox_1
	KeyboxGlow.AnchorPoint = Vector2.new(0.5, 0.5)
	KeyboxGlow.BackgroundTransparency = 1
	KeyboxGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
	KeyboxGlow.Size = UDim2.new(1.05, 0, 1.05, 0)
	KeyboxGlow.Image = "rbxassetid://8992230671"
	KeyboxGlow.ImageColor3 = Color
	KeyboxGlow.ImageTransparency = 1
	KeyboxGlow.ScaleType = Enum.ScaleType.Slice
	KeyboxGlow.SliceCenter = Rect.new(100, 100, 100, 100)
	KeyboxGlow.ZIndex = 0

	UIPadding_2.Parent = Keybox_1
	UIPadding_2.PaddingLeft = UDim.new(0, 15)
	UIPadding_2.PaddingRight = UDim.new(0, 15)

	TextBox_1.Parent = Keybox_1
	TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextBox_1.BackgroundTransparency = 1
	TextBox_1.Size = UDim2.new(1, 0, 1, 0)
	TextBox_1.Font = Enum.Font.GothamMedium
	TextBox_1.PlaceholderColor3 = Color3.fromRGB(150, 150, 170)
	TextBox_1.PlaceholderText = "XXXX-XXXX-XXXX-XXXX"
	TextBox_1.Text = ""
	TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox_1.TextSize = 14
	TextBox_1.TextTransparency = 1
	TextBox_1.TextXAlignment = Enum.TextXAlignment.Left

	ButtonContainer = Instance.new("Frame")
	ButtonContainer.Name = "ButtonContainer"
	ButtonContainer.Parent = Left_1
	ButtonContainer.BackgroundTransparency = 1
	ButtonContainer.Size = UDim2.new(1, 0, 0, 40)

	UIListLayout_4.Parent = ButtonContainer
	UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_4.Padding = UDim.new(0, 12)
	UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Center

	RedeemButton = Instance.new("Frame")
	RedeemButton.Name = "RedeemButton"
	RedeemButton.Parent = ButtonContainer
	RedeemButton.BackgroundColor3 = Color
	RedeemButton.Size = UDim2.new(0.5, -6, 1, 0)
	RedeemButton.BackgroundTransparency = 1

	UICorner_4.Parent = RedeemButton
	UICorner_4.CornerRadius = UDim.new(0, 10)

	ButtonGradient.Parent = RedeemButton
	ButtonGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 130, 255))
	}
	ButtonGradient.Rotation = 135
	ButtonGradient.Transparency = NumberSequence.new(1)

	ButtonGlow = Instance.new("ImageLabel")
	ButtonGlow.Name = "ButtonGlow"
	ButtonGlow.Parent = RedeemButton
	ButtonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
	ButtonGlow.BackgroundTransparency = 1
	ButtonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
	ButtonGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
	ButtonGlow.Image = "rbxassetid://8992230671"
	ButtonGlow.ImageColor3 = Color
	ButtonGlow.ImageTransparency = 1
	ButtonGlow.ScaleType = Enum.ScaleType.Slice
	ButtonGlow.SliceCenter = Rect.new(100, 100, 100, 100)

	ButtonContent = Instance.new("Frame")
	ButtonContent.Name = "ButtonContent"
	ButtonContent.Parent = RedeemButton
	ButtonContent.BackgroundTransparency = 1
	ButtonContent.Size = UDim2.new(1, 0, 1, 0)

	UIListLayout_5.Parent = ButtonContent
	UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_5.Padding = UDim.new(0, 8)
	UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Center

	ButtonLabel = Instance.new("TextLabel")
	ButtonLabel.Name = "ButtonLabel"
	ButtonLabel.Parent = ButtonContent
	ButtonLabel.BackgroundTransparency = 1
	ButtonLabel.Font = Enum.Font.GothamBold
	ButtonLabel.Text = "REDEEM"
	ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonLabel.TextSize = 13
	ButtonLabel.TextTransparency = 1

	ButtonIcon = Instance.new("ImageLabel")
	ButtonIcon.Name = "ButtonIcon"
	ButtonIcon.Parent = ButtonContent
	ButtonIcon.BackgroundTransparency = 1
	ButtonIcon.Size = UDim2.new(0, 18, 0, 18)
	ButtonIcon.Image = "rbxassetid://14938884688"
	ButtonIcon.ImageTransparency = 1

	ButtonClick = Instance.new("TextButton")
	ButtonClick.Name = "ButtonClick"
	ButtonClick.Parent = RedeemButton
	ButtonClick.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ButtonClick.BackgroundTransparency = 1
	ButtonClick.Size = UDim2.new(1, 0, 1, 0)
	ButtonClick.Font = Enum.Font.SourceSans
	ButtonClick.Text = ""
	ButtonClick.TextSize = 14

	HoverButton1 = Instance.new("Frame")
	HoverButton1.Name = "HoverButton"
	HoverButton1.Parent = RedeemButton
	HoverButton1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	HoverButton1.BackgroundTransparency = 0.9
	HoverButton1.Size = UDim2.new(1,0,1,0)
	HoverButton1.Visible = false

	local HoverCorner1 = Instance.new("UICorner")
	HoverCorner1.Parent = HoverButton1
	HoverCorner1.CornerRadius = UDim.new(0, 10)

	RedeemButton.MouseEnter:Connect(function()
		HoverButton1.Visible = true
		tw({v = HoverButton1, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.7}}):Play()
	end)

	RedeemButton.MouseLeave:Connect(function()
		tw({v = HoverButton1, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.9}}):Play()
		task.delay(0.15, function() HoverButton1.Visible = false end)
	end)

	GetKeyButton = Instance.new("Frame")
	GetKeyButton.Name = "GetKeyButton"
	GetKeyButton.Parent = ButtonContainer
	GetKeyButton.BackgroundColor3 = Color3.fromRGB(50, 45, 70)
	GetKeyButton.Size = UDim2.new(0.5, -6, 1, 0)
	GetKeyButton.BackgroundTransparency = 1

	UICorner_5.Parent = GetKeyButton
	UICorner_5.CornerRadius = UDim.new(0, 10)

	ButtonGradient2.Parent = GetKeyButton
	ButtonGradient2.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 55, 80)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 45, 70))
	}
	ButtonGradient2.Rotation = 135
	ButtonGradient2.Transparency = NumberSequence.new(1)

	ButtonGlow2 = Instance.new("ImageLabel")
	ButtonGlow2.Name = "ButtonGlow2"
	ButtonGlow2.Parent = GetKeyButton
	ButtonGlow2.AnchorPoint = Vector2.new(0.5, 0.5)
	ButtonGlow2.BackgroundTransparency = 1
	ButtonGlow2.Position = UDim2.new(0.5, 0, 0.5, 0)
	ButtonGlow2.Size = UDim2.new(1.1, 0, 1.1, 0)
	ButtonGlow2.Image = "rbxassetid://8992230671"
	ButtonGlow2.ImageColor3 = Color3.fromRGB(100, 100, 120)
	ButtonGlow2.ImageTransparency = 1
	ButtonGlow2.ScaleType = Enum.ScaleType.Slice
	ButtonGlow2.SliceCenter = Rect.new(100, 100, 100, 100)

	ButtonContent2 = Instance.new("Frame")
	ButtonContent2.Name = "ButtonContent2"
	ButtonContent2.Parent = GetKeyButton
	ButtonContent2.BackgroundTransparency = 1
	ButtonContent2.Size = UDim2.new(1, 0, 1, 0)

	UIListLayout_6.Parent = ButtonContent2
	UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_6.Padding = UDim.new(0, 8)
	UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center

	ButtonLabel2 = Instance.new("TextLabel")
	ButtonLabel2.Name = "ButtonLabel2"
	ButtonLabel2.Parent = ButtonContent2
	ButtonLabel2.BackgroundTransparency = 1
	ButtonLabel2.Font = Enum.Font.GothamBold
	ButtonLabel2.Text = "GET KEY"
	ButtonLabel2.TextColor3 = Color3.fromRGB(220, 220, 240)
	ButtonLabel2.TextSize = 13
	ButtonLabel2.TextTransparency = 1

	ButtonIcon2 = Instance.new("ImageLabel")
	ButtonIcon2.Name = "ButtonIcon2"
	ButtonIcon2.Parent = ButtonContent2
	ButtonIcon2.BackgroundTransparency = 1
	ButtonIcon2.Size = UDim2.new(0, 18, 0, 18)
	ButtonIcon2.Image = "rbxassetid://14924054039"
	ButtonIcon2.ImageTransparency = 1

	ButtonClick2 = Instance.new("TextButton")
	ButtonClick2.Name = "ButtonClick2"
	ButtonClick2.Parent = GetKeyButton
	ButtonClick2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ButtonClick2.BackgroundTransparency = 1
	ButtonClick2.Size = UDim2.new(1, 0, 1, 0)
	ButtonClick2.Font = Enum.Font.SourceSans
	ButtonClick2.Text = ""
	ButtonClick2.TextSize = 14

	HoverButton2 = Instance.new("Frame")
	HoverButton2.Name = "HoverButton"
	HoverButton2.Parent = GetKeyButton
	HoverButton2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	HoverButton2.BackgroundTransparency = 0.9
	HoverButton2.Size = UDim2.new(1,0,1,0)
	HoverButton2.Visible = false

	local HoverCorner2 = Instance.new("UICorner")
	HoverCorner2.Parent = HoverButton2
	HoverCorner2.CornerRadius = UDim.new(0, 10)

	GetKeyButton.MouseEnter:Connect(function()
		HoverButton2.Visible = true
		tw({v = HoverButton2, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.8}}):Play()
	end)

	GetKeyButton.MouseLeave:Connect(function()
		tw({v = HoverButton2, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.9}}):Play()
		task.delay(0.15, function() HoverButton2.Visible = false end)
	end)

	Footer = Instance.new("Frame")
	Footer.Name = "Footer"
	Footer.Parent = Left_1
	Footer.BackgroundTransparency = 1
	Footer.Size = UDim2.new(1, 0, 0, 40)

	FooterText = Instance.new("TextLabel")
	FooterText.Name = "FooterText"
	FooterText.Parent = Footer
	FooterText.BackgroundTransparency = 1
	FooterText.Font = Enum.Font.Gotham
	FooterText.Text = "Need support?"
	FooterText.TextColor3 = Color3.fromRGB(180, 180, 200)
	FooterText.TextSize = 12
	FooterText.TextTransparency = 1

	DiscordButton = Instance.new("TextButton")
	DiscordButton.Name = "DiscordButton"
	DiscordButton.Parent = Footer
	DiscordButton.BackgroundTransparency = 1
	DiscordButton.Font = Enum.Font.GothamBold
	DiscordButton.Text = " Join Discord"
	DiscordButton.TextColor3 = Color
	DiscordButton.TextSize = 12
	DiscordButton.TextTransparency = 1
	DiscordButton.TextXAlignment = Enum.TextXAlignment.Left
	DiscordButton.Position = UDim2.new(0, 80, 0, 0)
	DiscordButton.Size = UDim2.new(0, 100, 1, 0)

	Divider = Instance.new("Frame")
	Divider.Name = "Divider"
	Divider.Parent = Footer
	Divider.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
	Divider.BackgroundTransparency = 1
	Divider.Position = UDim2.new(0, 0, 1, 10)
	Divider.Size = UDim2.new(1, 0, 0, 1)

	TabList_1.Name = "TabList"
	TabList_1.Parent = Left_1
	TabList_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TabList_1.BackgroundTransparency = 1
	TabList_1.Size = UDim2.new(1, 0, 0, 20)

	UIListLayout_7.Parent = TabList_1
	UIListLayout_7.Padding = UDim.new(0, 8)
	UIListLayout_7.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_7.VerticalAlignment = Enum.VerticalAlignment.Center

	local NotifyContainer = Instance.new("Frame")
	NotifyContainer.Name = "NotifyContainer"
	NotifyContainer.Parent = ScreenGui
	NotifyContainer.AnchorPoint = Vector2.new(1, 0.5)
	NotifyContainer.BackgroundTransparency = 1
	NotifyContainer.Position = UDim2.new(1, -20, 0.5, 0)
	NotifyContainer.Size = UDim2.new(0, 300, 0, 500)
	
	local UIListLayout_NotifyContainer = Instance.new("UIListLayout")
	UIListLayout_NotifyContainer.Parent = NotifyContainer
	UIListLayout_NotifyContainer.Padding = UDim.new(0, 10)
	UIListLayout_NotifyContainer.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_NotifyContainer.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout_NotifyContainer.VerticalAlignment = Enum.VerticalAlignment.Bottom

	-- Animation Sequence
	task.spawn(function()
		MainContainer.Position = UDim2.new(0.5, 0, 0.5, -50)
		MainContainer.Size = UDim2.new(0, 0, 0, 0)
		
		tw({v = BackgroundBlur, t = 0.5, g = {Size = 10}}):Play()
		
		tw({v = MainContainer, t = 0.6, s = Enum.EasingStyle.Back, d = "Out", g = {
			Size = UDim2.new(0, 400, 0, 500)
		}}):Play()
		
		task.delay(0.1, function()
			tw({v = Background_1, t = 0.4, g = {BackgroundTransparency = 0}}):Play()
			tw({v = BorderGlow, t = 0.4, g = {Transparency = 0.3}}):Play()
			tw({v = OuterGlow, t = 0.4, g = {ImageTransparency = 0.8}}):Play()
			
			task.delay(0.1, function()
				tw({v = Left_1, t = 0.3, g = {GroupTransparency = 0}}):Play()
				
				task.delay(0.05, function()
					-- Icon animation
					tw({v = IconContainer, t = 0.3, g = {BackgroundTransparency = 0}}):Play()
					tw({v = IconGradient, t = 0.3, g = {Transparency = NumberSequence.new(0)}}):Play()
					tw({v = ImageLabel_1, t = 0.3, g = {ImageTransparency = 0}}):Play()
					
					-- Title animation
					tw({v = TitleLabel, t = 0.3, g = {TextTransparency = 0}}):Play()
					tw({v = SubtitleLabel, t = 0.3, g = {TextTransparency = 0.2}}):Play()
					
					task.delay(0.05, function()
						tw({v = ads_1, t = 0.3, g = {TextTransparency = 0.2}}):Play()
						
						task.delay(0.05, function()
							tw({v = TextLabel_2, t = 0.3, g = {TextTransparency = 0}}):Play()
							tw({v = EyeButton, t = 0.3, g = {BackgroundTransparency = 0.8}}):Play()
							tw({v = EyeStroke, t = 0.3, g = {Transparency = 0.5}}):Play()
							tw({v = EyeIcon, t = 0.3, g = {ImageTransparency = 0}}):Play()
							
							task.delay(0.05, function()
								tw({v = Keybox_1, t = 0.3, g = {Transparency = 0}}):Play()
								tw({v = KeyboxStroke, t = 0.3, g = {Transparency = 0.4}}):Play()
								tw({v = KeyboxGradient, t = 0.3, g = {Transparency = NumberSequence.new(0)}}):Play()
								tw({v = KeyboxGlow, t = 0.3, g = {ImageTransparency = 0.9}}):Play()
								tw({v = TextBox_1, t = 0.3, g = {TextTransparency = 0}}):Play()
								
								task.delay(0.05, function()
									-- Buttons animation
									tw({v = RedeemButton, t = 0.3, g = {BackgroundTransparency = 0}}):Play()
									tw({v = ButtonGradient, t = 0.3, g = {Transparency = NumberSequence.new(0)}}):Play()
									tw({v = ButtonGlow, t = 0.3, g = {ImageTransparency = 0.9}}):Play()
									tw({v = ButtonLabel, t = 0.3, g = {TextTransparency = 0}}):Play()
									tw({v = ButtonIcon, t = 0.3, g = {ImageTransparency = 0}}):Play()
									
									tw({v = GetKeyButton, t = 0.3, g = {BackgroundTransparency = 0}}):Play()
									tw({v = ButtonGradient2, t = 0.3, g = {Transparency = NumberSequence.new(0)}}):Play()
									tw({v = ButtonGlow2, t = 0.3, g = {ImageTransparency = 0.9}}):Play()
									tw({v = ButtonLabel2, t = 0.3, g = {TextTransparency = 0}}):Play()
									tw({v = ButtonIcon2, t = 0.3, g = {ImageTransparency = 0}}):Play()
									
									task.delay(0.05, function()
										tw({v = FooterText, t = 0.3, g = {TextTransparency = 0.3}}):Play()
										tw({v = DiscordButton, t = 0.3, g = {TextTransparency = 0}}):Play()
										tw({v = Divider, t = 0.3, g = {BackgroundTransparency = 0.7}}):Play()
									end)
								end)
							end)
						end)
					end)
				end)
			end)
		end)
	end)

	local tab = {}

	function tab.New(p)
		if not p then return end
		
		local Title = p.Title or 'null'
		local Icon = p.Icon or 14924054039
		local Callback = p.Callback or function() end
		local Tab_1 = Instance.new("Frame")
		local UICorner_Tab = Instance.new("UICorner")
		local UIGradient_Tab = Instance.new("UIGradient")
		local UIListLayout_Tab = Instance.new("UIListLayout")
		local UIPadding_Tab = Instance.new("UIPadding")
		local ImageLabel_Tab = Instance.new("ImageLabel")
		local TextLabel_Tab = Instance.new("TextLabel")
		local newf = Instance.new('Frame')

		newf.Parent = Tab_1
		newf.BackgroundTransparency = 1
		newf.Size = UDim2.new(1, 0, 1, 0)

		Tab_1.Name = "Tab"
		Tab_1.Parent = TabList_1
		Tab_1.AutomaticSize = Enum.AutomaticSize.X
		Tab_1.BackgroundColor3 = Color
		Tab_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Tab_1.BorderSizePixel = 0
		Tab_1.Size = UDim2.new(0, 25,0, 25)

		UICorner_Tab.Parent = Tab_1
		UICorner_Tab.CornerRadius = UDim.new(1,0)

		UIGradient_Tab.Parent = Tab_1
		UIGradient_Tab.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 168, 168))}
		UIGradient_Tab.Rotation = 0

		UIListLayout_Tab.Parent = newf
		UIListLayout_Tab.Padding = UDim.new(0,6)
		UIListLayout_Tab.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_Tab.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_Tab.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_Tab.VerticalAlignment = Enum.VerticalAlignment.Center

		UIPadding_Tab.Parent = newf
		UIPadding_Tab.PaddingLeft = UDim.new(0,8)
		UIPadding_Tab.PaddingRight = UDim.new(0,8)

		ImageLabel_Tab.Parent = newf
		ImageLabel_Tab.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ImageLabel_Tab.BackgroundTransparency = 1
		ImageLabel_Tab.BorderColor3 = Color3.fromRGB(0,0,0)
		ImageLabel_Tab.BorderSizePixel = 0
		ImageLabel_Tab.Size = UDim2.new(0, 15,0, 15)
		ImageLabel_Tab.Image = gl(Icon).Image

		TextLabel_Tab.Parent = newf
		TextLabel_Tab.AutomaticSize = Enum.AutomaticSize.X
		TextLabel_Tab.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabel_Tab.BackgroundTransparency = 1
		TextLabel_Tab.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabel_Tab.BorderSizePixel = 0
		TextLabel_Tab.LayoutOrder = 1
		TextLabel_Tab.Size = UDim2.new(0, 0,1, 0)
		TextLabel_Tab.Font = Enum.Font.Gotham
		TextLabel_Tab.Text = Title
		TextLabel_Tab.TextColor3 = Color3.fromRGB(255,255,255)
		TextLabel_Tab.TextSize = 13

		task.delay(0.1, function()
			TextLabel_Tab.TextXAlignment = Enum.TextXAlignment.Left
		end)

		local Click = click(Tab_1)
		if Click then
			Click.MouseButton1Click:Connect(Callback)
		end
	end

	function tab.Notify(p)
		if not p then return {Set = function() end} end
		
		local Title = p.Title or 'Notification'
		local Icon = p.Icon or 14924054039
		local ColorN = p.Color or Color3.fromRGB(50, 50, 50)
		local Time = p.Time or 5
		
		local NotifyFrame = Instance.new("Frame")
		local UICorner_Notify = Instance.new("UICorner")
		local UIStroke_Notify = Instance.new("UIStroke")
		local Shadow_Notify = Instance.new("ImageLabel")
		local Content = Instance.new("Frame")
		local UIListLayout_Content = Instance.new("UIListLayout")
		local IconFrame = Instance.new("Frame")
		local IconImage = Instance.new("ImageLabel")
		local TextFrame = Instance.new("Frame")
		local TextLabel_Notify = Instance.new("TextLabel")
		
		NotifyFrame.Name = "Notify"
		NotifyFrame.Parent = NotifyContainer
		NotifyFrame.BackgroundColor3 = ColorN
		NotifyFrame.BackgroundTransparency = 1
		NotifyFrame.Size = UDim2.new(1, 0, 0, 0)
		NotifyFrame.Position = UDim2.new(1, 0, 1, 0)
		NotifyFrame.ClipsDescendants = true
		
		UICorner_Notify.Parent = NotifyFrame
		UICorner_Notify.CornerRadius = UDim.new(0, 8)
		
		UIStroke_Notify.Parent = NotifyFrame
		UIStroke_Notify.Color = ColorN
		UIStroke_Notify.Thickness = 1
		UIStroke_Notify.Transparency = 1
		
		Shadow_Notify.Name = "Shadow"
		Shadow_Notify.Parent = NotifyFrame
		Shadow_Notify.AnchorPoint = Vector2.new(0.5, 0.5)
		Shadow_Notify.BackgroundTransparency = 1
		Shadow_Notify.Position = UDim2.new(0.5, 0, 0.5, 0)
		Shadow_Notify.Size = UDim2.new(1.1, 0, 1.1, 0)
		Shadow_Notify.Image = "rbxassetid://1316045217"
		Shadow_Notify.ImageColor3 = Color3.fromRGB(0, 0, 0)
		Shadow_Notify.ImageTransparency = 1
		Shadow_Notify.ScaleType = Enum.ScaleType.Slice
		Shadow_Notify.SliceCenter = Rect.new(10, 10, 118, 118)
		Shadow_Notify.ZIndex = -1
		
		Content.Name = "Content"
		Content.Parent = NotifyFrame
		Content.BackgroundTransparency = 1
		Content.Size = UDim2.new(1, 0, 1, 0)
		
		UIListLayout_Content.Parent = Content
		UIListLayout_Content.Padding = UDim.new(0, 10)
		UIListLayout_Content.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_Content.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_Content.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_Content.VerticalAlignment = Enum.VerticalAlignment.Center
		
		IconFrame.Name = "IconFrame"
		IconFrame.Parent = Content
		IconFrame.BackgroundTransparency = 1
		IconFrame.Size = UDim2.new(0, 30, 0, 30)
		
		IconImage.Name = "Icon"
		IconImage.Parent = IconFrame
		IconImage.AnchorPoint = Vector2.new(0.5, 0.5)
		IconImage.BackgroundTransparency = 1
		IconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		IconImage.Size = UDim2.new(1, 0, 1, 0)
		IconImage.Image = gl(Icon).Image
		IconImage.ImageTransparency = 1
		
		TextFrame.Name = "TextFrame"
		TextFrame.Parent = Content
		TextFrame.BackgroundTransparency = 1
		TextFrame.Size = UDim2.new(1, -50, 1, 0)
		
		TextLabel_Notify.Name = "Text"
		TextLabel_Notify.Parent = TextFrame
		TextLabel_Notify.BackgroundTransparency = 1
		TextLabel_Notify.Size = UDim2.new(1, 0, 1, 0)
		TextLabel_Notify.Font = Enum.Font.GothamBold
		TextLabel_Notify.Text = Title
		TextLabel_Notify.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_Notify.TextSize = 14
		TextLabel_Notify.TextTransparency = 1
		TextLabel_Notify.TextWrapped = true
		TextLabel_Notify.TextXAlignment = Enum.TextXAlignment.Left
		
		local textSize = game:GetService("TextService"):GetTextSize(Title, 14, Enum.Font.GothamBold, Vector2.new(240, math.huge))
		local height = math.max(60, textSize.Y + 30)
		
		NotifyFrame.Size = UDim2.new(1, 0, 0, height)
		
		tw({v = NotifyFrame, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 0.2}}):Play()
		tw({v = UIStroke_Notify, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {Transparency = 0}}):Play()
		tw({v = Shadow_Notify, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {ImageTransparency = 0.5}}):Play()
		tw({v = IconImage, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {ImageTransparency = 0}}):Play()
		tw({v = TextLabel_Notify, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {TextTransparency = 0}}):Play()
		
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
			
			tw({v = NotifyFrame, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {Position = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}}):Play()
			tw({v = UIStroke_Notify, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {Transparency = 1}}):Play()
			tw({v = Shadow_Notify, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {ImageTransparency = 1}}):Play()
			tw({v = IconImage, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {ImageTransparency = 1}}):Play()
			tw({v = TextLabel_Notify, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {TextTransparency = 1}}):Play()
			
			task.delay(0.3, function()
				if NotifyFrame.Parent then
					NotifyFrame:Destroy()
				end
			end)
		end)
		
		local n = {}
		
		function n:Set(newText)
			if TextLabel_Notify then
				TextLabel_Notify.Text = newText
				local newTextSize = game:GetService("TextService"):GetTextSize(newText, 14, Enum.Font.GothamBold, Vector2.new(240, math.huge))
				local newHeight = math.max(60, newTextSize.Y + 30)
				tw({v = NotifyFrame, t = 0.2, g = {Size = UDim2.new(1, 0, 0, newHeight)}}):Play()
			end
		end
		
		return n
	end

	local realText = ""
	local hidden = true
	local lastLength = 0
	local te = "*"
	
	local TextLabel_Overlay = Instance.new('TextLabel')
	TextLabel_Overlay.Text = realText
	TextLabel_Overlay.TextTransparency = 1
	TextLabel_Overlay.BackgroundTransparency = 1
	TextLabel_Overlay.Size = TextBox_1.Size
	TextLabel_Overlay.Font = TextBox_1.Font
	TextLabel_Overlay.TextSize = TextBox_1.TextSize
	TextLabel_Overlay.TextColor3 = TextBox_1.TextColor3
	TextLabel_Overlay.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel_Overlay.TextYAlignment = Enum.TextYAlignment.Center
	TextLabel_Overlay.Parent = TextBox_1
	
	TextBox_1.TextTransparency = 1
	TextBox_1.Text = ""
	TextLabel_Overlay.Text = ""
	TextLabel_Overlay.TextTransparency = 1

	if savedKey ~= "" then
		realText = savedKey
		TextBox_1.Text = string.rep(te, #realText)
		TextLabel_Overlay.Text = realText
		lastLength = #realText
	end

	TextBox_1:GetPropertyChangedSignal("Text"):Connect(function()
		if hidden then
			if TextBox_1.Text == "" then
				realText = ""
			else
				local newLen = #TextBox_1.Text
				if newLen < lastLength then
					realText = realText:sub(1, -2)
				elseif newLen > lastLength then
					realText = realText .. TextBox_1.Text:sub(-1)
				end
			end
			TextBox_1.Text = string.rep(te, #realText)
		else
			realText = TextBox_1.Text
		end

		lastLength = #realText
		TextLabel_Overlay.Text = realText
	end)

	if HideShowKey then
		HideShowKey.MouseButton1Click:Connect(function()
			hidden = not hidden

			if hidden then
				TextBox_1.Text = string.rep(te, #realText)
				EyeIcon.Image = "rbxassetid://13868333926"
			else
				TextBox_1.Text = realText
				EyeIcon.Image = "rbxassetid://13868333927"
			end

			lastLength = #realText
		end)
	end

	if DiscordButton then
		DiscordButton.MouseButton1Click:Connect(function()
			if KeyGUI then 
				pcall(setclipboard, DiscordLink) 
			end
			tab.Notify({
				Title = 'Discord link copied!',
				Icon = 14939475472,
				Time = 3,
				Color = Color3.fromRGB(88, 101, 242)
			})
		end)
	end
	
	local checkingKey = false
	
	if ButtonClick2 then
		ButtonClick2.MouseButton1Click:Connect(function()
			tw({v = GetKeyButton, t = 0.1, s = Enum.EasingStyle.Quad, d = "InOut", g = {Size = UDim2.new(0.5, -10, 0.95, 0), BackgroundColor3 = Color3.fromRGB(100, 220, 100)}}):Play()
			task.delay(0.1, function()
				tw({v = GetKeyButton, t = 0.1, s = Enum.EasingStyle.Quad, d = "InOut", g = {Size = UDim2.new(0.5, -6, 1, 0), BackgroundColor3 = Color3.fromRGB(50, 45, 70)}}):Play()
			end)
			if o.KeyLink then
				if KeyGUI then 
					pcall(setclipboard, o.KeyLink) 
				end
				tab.Notify({
					Title = 'Key link copied to clipboard!',
					Icon = 14938884688,
					Time = 3,
					Color = Color3.fromRGB(76, 175, 80)
				})
			else
				tab.Notify({
					Title = 'No key link provided',
					Icon = 14943813832,
					Time = 3,
					Color = Color3.fromRGB(244, 67, 54)
				})
			end
		end)
	end
	
	if ButtonClick then
		ButtonClick.MouseButton1Click:Connect(function()
			if checkingKey then return end
			checkingKey = true
			
			tw({v = RedeemButton, t = 0.1, s = Enum.EasingStyle.Quad, d = "InOut", g = {Size = UDim2.new(0.5, -10, 0.95, 0), BackgroundColor3 = Color3.fromRGB(255, 193, 7)}}):Play()
			
			local checkNotify = tab.Notify({
				Title = 'Checking Key...',
				Icon = 14939512891,
				Time = 10,
				Color = Color3.fromRGB(255, 193, 7)
			})
			
			task.delay(0.5, function()
				local input = realText
				local found = false

				for _, v in ipairs(Key) do
					if input == v then
						found = true
						break
					end
				end

				if found then
					if KeyGUI then 
						pcall(writefile, "SindexHub/key.txt", input) 
					end
					
					task.delay(0.3, function()
						checkNotify:Set('Key Verified Successfully!')
						tab.Notify({
							Title = 'Loading script...',
							Icon = 14939512891,
							Time = 2,
							Color = Color3.fromRGB(76, 175, 80)
						})
					end)
					
					tw({v = RedeemButton, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(76, 175, 80)}}):Play()
					
					task.delay(1.5, function()
						tw({v = Left_1, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {GroupTransparency = 1}}):Play()
						task.delay(0.25, function()
							tw({v = Background_1, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
							tw({v = BorderGlow, t = 0.25, g = {Transparency = 1}}):Play()
							tw({v = OuterGlow, t = 0.25, g = {ImageTransparency = 1}}):Play()
							tw({v = BackgroundBlur, t = 0.25, g = {Size = 0}}):Play()
							task.delay(0.3, function()
								ScreenGui:Destroy()
								if o.Callback then
									o.Callback()
								end
							end)	
						end)
					end)
				else
					tw({v = Keybox_1, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(244, 67, 54)}}):Play()
					task.delay(0.2, function()
						tw({v = Keybox_1, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(35, 30, 50)}}):Play()
					end)
					
					checkNotify:Set('Invalid Key!')
					
					tab.Notify({
						Title = 'Invalid key! Please check and try again.',
						Icon = 14943813832,
						Time = 3,
						Color = Color3.fromRGB(244, 67, 54)
					})
					
					tw({v = RedeemButton, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(244, 67, 54)}}):Play()
					
					task.delay(0.5, function()
						tw({v = RedeemButton, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color, Size = UDim2.new(0.5, -6, 1, 0)}}):Play()
						checkingKey = false
					end)
				end
			end)
		end)
	end

	return tab
end

return Library
[file content end]
