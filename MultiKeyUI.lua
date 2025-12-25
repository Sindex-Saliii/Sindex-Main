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
		
		local direction = info.d or Enum.EasingDirection.Out
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
	local Icon = gl(1234567890)
	local Key = o.Key or {}

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
	local Background_1 = Instance.new("Frame")
	local UICorner_1 = Instance.new("UICorner")
	local UIPadding_1 = Instance.new("UIPadding")
	local Left_1 = Instance.new("CanvasGroup")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local Header = Instance.new("Frame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local ImageLabel_1 = Instance.new("ImageLabel")
	local TextLabel_1 = Instance.new("TextLabel")
	local adsframe_1 = Instance.new("Frame")
	local ads_1 = Instance.new("TextLabel")
	local KeyFrame_1 = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local TextLabel_2 = Instance.new("TextLabel")
	local Frame_1 = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local ImageLabel_2 = Instance.new("ImageLabel")
	local Keybox_1 = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIStroke_1 = Instance.new("UIStroke")
	local UIPadding_2 = Instance.new("UIPadding")
	local TextBox_1 = Instance.new("TextBox")
	local ButtonFrame = Instance.new("Frame")
	local UIListLayout_4 = Instance.new("UIListLayout")
	local ExitButton = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ExitText = Instance.new("TextLabel")
	local ExitClick = Instance.new("TextButton")
	local GetKeyButton = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local GetKeyText = Instance.new("TextLabel")
	local GetKeyClick = Instance.new("TextButton")
	local SubmitButton = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local SubmitText = Instance.new("TextLabel")
	local SubmitClick = Instance.new("TextButton")
	local TabList_1 = Instance.new("Frame")
	local UIListLayout_7 = Instance.new("UIListLayout")

	ScreenGui.Parent = (not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Name = "SindexKeySystem"

	Background_1.Name = "Background"
	Background_1.Parent = ScreenGui
	Background_1.AutomaticSize = Enum.AutomaticSize.Y
	Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Background_1.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderSizePixel = 0
	Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Background_1.Size = UDim2.new(0.35, 0,0, 0)
	Background_1.ClipsDescendants = true
	Background_1.BackgroundTransparency = 1
	
	lak(Background_1, Background_1)

	init(Background_1)

	UICorner_1.Parent = Background_1
	UICorner_1.CornerRadius = UDim.new(0,12)

	local UIStroke_3 = Instance.new("UIStroke")
	UIStroke_3.Parent = Background_1
	UIStroke_3.Color = Color3.fromRGB(64, 64, 64)
	UIStroke_3.Thickness = 1
	UIStroke_3.Transparency = 0.7

	local Shadow_BG = Instance.new("ImageLabel")
	Shadow_BG.Name = "Shadow_BG"
	Shadow_BG.Parent = ScreenGui
	Shadow_BG.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow_BG.BackgroundTransparency = 1
	Shadow_BG.Position = Background_1.Position
	Shadow_BG.Size = UDim2.new(1.1, 0,1.1, 0)
	Shadow_BG.Image = "rbxassetid://1316045217"
	Shadow_BG.ImageColor3 = Color3.fromRGB(0,0,0)
	Shadow_BG.ImageTransparency = 0.8
	Shadow_BG.ScaleType = Enum.ScaleType.Slice
	Shadow_BG.SliceCenter = Rect.new(10, 10, 118, 118)
	Shadow_BG.ZIndex = 0

	UIPadding_1.Parent = Background_1
	UIPadding_1.PaddingBottom = UDim.new(0,20)
	UIPadding_1.PaddingLeft = UDim.new(0,20)
	UIPadding_1.PaddingRight = UDim.new(0,20)
	UIPadding_1.PaddingTop = UDim.new(0,20)

	Left_1.Name = "Left"
	Left_1.Parent = Background_1
	Left_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Left_1.BackgroundTransparency = 1
	Left_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Left_1.BorderSizePixel = 0
	Left_1.Size = UDim2.new(1, 0,1, 0)
	Left_1.GroupTransparency = 1
	Left_1.ClipsDescendants = false

	UIListLayout_1.Parent = Left_1
	UIListLayout_1.Padding = UDim.new(0,15)
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

	Header.Name = "Header"
	Header.Parent = Left_1
	Header.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Header.BackgroundTransparency = 1
	Header.BorderColor3 = Color3.fromRGB(0,0,0)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0,0, 24)

	UIListLayout_2.Parent = Header
	UIListLayout_2.Padding = UDim.new(0,10)
	UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

	ImageLabel_1.Parent = Header
	ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_1.BackgroundTransparency = 1
	ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel_1.BorderSizePixel = 0
	ImageLabel_1.Size = UDim2.new(0, 20,0, 20)
	ImageLabel_1.Image = "rbxassetid://14501439493"
	ImageLabel_1.ImageTransparency = 1

	TextLabel_1.Parent = Header
	TextLabel_1.AutomaticSize = Enum.AutomaticSize.X
	TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextLabel_1.BackgroundTransparency = 1
	TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TextLabel_1.BorderSizePixel = 0
	TextLabel_1.Size = UDim2.new(0, 0,0, 20)
	TextLabel_1.Font = Enum.Font.GothamBold
	TextLabel_1.Text = "Sindex Key System (24 H)"
	TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
	TextLabel_1.TextSize = 16
	TextLabel_1.TextTransparency = 1
	TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left

	adsframe_1.Name = "adsframe"
	adsframe_1.Parent = Left_1
	adsframe_1.AutomaticSize = Enum.AutomaticSize.Y
	adsframe_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	adsframe_1.BackgroundTransparency = 1
	adsframe_1.BorderColor3 = Color3.fromRGB(0,0,0)
	adsframe_1.BorderSizePixel = 0
	adsframe_1.LayoutOrder = 1
	adsframe_1.Size = UDim2.new(1, 0,0, 0)

	ads_1.Name = "ads"
	ads_1.Parent = adsframe_1
	ads_1.AutomaticSize = Enum.AutomaticSize.Y
	ads_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ads_1.BackgroundTransparency = 1
	ads_1.BorderColor3 = Color3.fromRGB(0,0,0)
	ads_1.BorderSizePixel = 0
	ads_1.Size = UDim2.new(1, 0,1, 0)
	ads_1.Font = Enum.Font.Gotham
	ads_1.RichText = true
	ads_1.Text = "Welcome to "..HubName.."\nEnter your license key below"
	ads_1.TextColor3 = Color3.fromRGB(200, 200, 200)
	ads_1.TextSize = 14
	ads_1.TextTransparency = 1
	ads_1.TextWrapped = true
	ads_1.TextXAlignment = Enum.TextXAlignment.Left

	KeyFrame_1.Name = "KeyFrame"
	KeyFrame_1.Parent = Left_1
	KeyFrame_1.AutomaticSize = Enum.AutomaticSize.Y
	KeyFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	KeyFrame_1.BackgroundTransparency = 1
	KeyFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
	KeyFrame_1.BorderSizePixel = 0
	KeyFrame_1.LayoutOrder = 2
	KeyFrame_1.Size = UDim2.new(1, 0,0, 0)

	UIListLayout_3.Parent = KeyFrame_1
	UIListLayout_3.Padding = UDim.new(0,8)
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

	TextLabel_2.Parent = KeyFrame_1
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextLabel_2.BackgroundTransparency = 1
	TextLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Size = UDim2.new(1, 0,0, 18)
	TextLabel_2.Font = Enum.Font.Gotham
	TextLabel_2.Text = "Enter Key"
	TextLabel_2.TextColor3 = Color3.fromRGB(255,255,255)
	TextLabel_2.TextSize = 12
	TextLabel_2.TextTransparency = 1
	TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

	Frame_1.Parent = TextLabel_2
	Frame_1.AnchorPoint = Vector2.new(1, 0.5)
	Frame_1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Frame_1.BackgroundTransparency = 1
	Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_1.BorderSizePixel = 0
	Frame_1.Position = UDim2.new(1, 0,0.5, 0)
	Frame_1.Size = UDim2.new(0, 24,0, 24)

	UICorner_2.Parent = Frame_1
	UICorner_2.CornerRadius = UDim.new(0,6)

	ImageLabel_2.Parent = Frame_1
	ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel_2.BackgroundTransparency = 1
	ImageLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel_2.BorderSizePixel = 0
	ImageLabel_2.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel_2.Size = UDim2.new(0, 16,0, 16)
	ImageLabel_2.Image = "rbxassetid://14501439490"
	ImageLabel_2.ImageTransparency = 1
	
	local HideShowKey = click(Frame_1)

	Keybox_1.Name = "Keybox"
	Keybox_1.Parent = KeyFrame_1
	Keybox_1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Keybox_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Keybox_1.BorderSizePixel = 0
	Keybox_1.LayoutOrder = 1
	Keybox_1.Size = UDim2.new(1, 0,0, 40)
	Keybox_1.Transparency = 1

	UICorner_3.Parent = Keybox_1
	UICorner_3.CornerRadius = UDim.new(0,8)

	UIStroke_1.Parent = Keybox_1
	UIStroke_1.Color = Color3.fromRGB(64, 64, 64)
	UIStroke_1.Thickness = 1.2
	UIStroke_1.Transparency = 1

	UIPadding_2.Parent = Keybox_1
	UIPadding_2.PaddingLeft = UDim.new(0,12)
	UIPadding_2.PaddingRight = UDim.new(0,12)

	TextBox_1.Parent = Keybox_1
	TextBox_1.Active = true
	TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TextBox_1.BackgroundTransparency = 1
	TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TextBox_1.BorderSizePixel = 0
	TextBox_1.CursorPosition = -1
	TextBox_1.Size = UDim2.new(1, 0,1, 0)
	TextBox_1.Font = Enum.Font.Gotham
	TextBox_1.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	TextBox_1.PlaceholderText = "XXXX-XXXX-XXXX-XXXX"
	TextBox_1.Text = ""
	TextBox_1.TextColor3 = Color3.fromRGB(255,255,255)
	TextBox_1.TextSize = 14
	TextBox_1.TextTransparency = 1
	TextBox_1.TextXAlignment = Enum.TextXAlignment.Left
	TextBox_1.ClearTextOnFocus = false

	ButtonFrame.Name = "ButtonFrame"
	ButtonFrame.Parent = Left_1
	ButtonFrame.AutomaticSize = Enum.AutomaticSize.Y
	ButtonFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ButtonFrame.BackgroundTransparency = 1
	ButtonFrame.BorderColor3 = Color3.fromRGB(0,0,0)
	ButtonFrame.BorderSizePixel = 0
	ButtonFrame.LayoutOrder = 3
	ButtonFrame.Size = UDim2.new(1, 0,0, 0)

	UIListLayout_4.Parent = ButtonFrame
	UIListLayout_4.Padding = UDim.new(0,8)
	UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Center

	ExitButton.Name = "ExitButton"
	ExitButton.Parent = ButtonFrame
	ExitButton.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
	ExitButton.BorderColor3 = Color3.fromRGB(0,0,0)
	ExitButton.BorderSizePixel = 0
	ExitButton.Size = UDim2.new(0, 80,0, 36)
	ExitButton.BackgroundTransparency = 1

	UICorner_4.Parent = ExitButton
	UICorner_4.CornerRadius = UDim.new(0,8)

	ExitText.Name = "ExitText"
	ExitText.Parent = ExitButton
	ExitText.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ExitText.BackgroundTransparency = 1
	ExitText.BorderColor3 = Color3.fromRGB(0,0,0)
	ExitText.BorderSizePixel = 0
	ExitText.Size = UDim2.new(1, 0,1, 0)
	ExitText.Font = Enum.Font.Gotham
	ExitText.Text = "Exit"
	ExitText.TextColor3 = Color3.fromRGB(255,255,255)
	ExitText.TextSize = 14
	ExitText.TextTransparency = 1

	ExitClick = click(ExitButton)

	GetKeyButton.Name = "GetKeyButton"
	GetKeyButton.Parent = ButtonFrame
	GetKeyButton.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
	GetKeyButton.BorderColor3 = Color3.fromRGB(0,0,0)
	GetKeyButton.BorderSizePixel = 0
	GetKeyButton.Size = UDim2.new(0, 100,0, 36)
	GetKeyButton.BackgroundTransparency = 1

	UICorner_5.Parent = GetKeyButton
	UICorner_5.CornerRadius = UDim.new(0,8)

	GetKeyText.Name = "GetKeyText"
	GetKeyText.Parent = GetKeyButton
	GetKeyText.BackgroundColor3 = Color3.fromRGB(255,255,255)
	GetKeyText.BackgroundTransparency = 1
	GetKeyText.BorderColor3 = Color3.fromRGB(0,0,0)
	GetKeyText.BorderSizePixel = 0
	GetKeyText.Size = UDim2.new(1, 0,1, 0)
	GetKeyText.Font = Enum.Font.Gotham
	GetKeyText.Text = "Get Key"
	GetKeyText.TextColor3 = Color3.fromRGB(255,255,255)
	GetKeyText.TextSize = 14
	GetKeyText.TextTransparency = 1

	GetKeyClick = click(GetKeyButton)

	SubmitButton.Name = "SubmitButton"
	SubmitButton.Parent = ButtonFrame
	SubmitButton.BackgroundColor3 = Color
	SubmitButton.BorderColor3 = Color3.fromRGB(0,0,0)
	SubmitButton.BorderSizePixel = 0
	SubmitButton.Size = UDim2.new(0, 100,0, 36)
	SubmitButton.BackgroundTransparency = 1

	UICorner_6.Parent = SubmitButton
	UICorner_6.CornerRadius = UDim.new(0,8)

	SubmitText.Name = "SubmitText"
	SubmitText.Parent = SubmitButton
	SubmitText.BackgroundColor3 = Color3.fromRGB(255,255,255)
	SubmitText.BackgroundTransparency = 1
	SubmitText.BorderColor3 = Color3.fromRGB(0,0,0)
	SubmitText.BorderSizePixel = 0
	SubmitText.Size = UDim2.new(1, 0,1, 0)
	SubmitText.Font = Enum.Font.GothamBold
	SubmitText.Text = "Submit"
	SubmitText.TextColor3 = Color3.fromRGB(255,255,255)
	SubmitText.TextSize = 14
	SubmitText.TextTransparency = 1

	SubmitClick = click(SubmitButton)

	TabList_1.Name = "TabList"
	TabList_1.Parent = Left_1
	TabList_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TabList_1.BackgroundTransparency = 1
	TabList_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TabList_1.BorderSizePixel = 0
	TabList_1.LayoutOrder = 4
	TabList_1.Size = UDim2.new(1, 0,0, 20)

	UIListLayout_7.Parent = TabList_1
	UIListLayout_7.Padding = UDim.new(0,8)
	UIListLayout_7.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_7.VerticalAlignment = Enum.VerticalAlignment.Center

	UIListLayout_7:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabList_1.Visible = (#TabList_1:GetChildren() > 1)
	end)

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

	task.spawn(function()
		Background_1.Position = UDim2.new(0.5, 0,0.5, -100)
		Background_1.BackgroundTransparency = 1
		Shadow_BG.ImageTransparency = 1
		
		tw({v = Background_1, t = 0.7, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0.5, 0,0.5, 0)}}):Play()
		tw({v = Background_1, t = 0.5, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0}}):Play()
		tw({v = Shadow_BG, t = 0.5, s = Enum.EasingStyle.Quad, d = "Out", g = {ImageTransparency = 0.8}}):Play()
		
		task.delay(0.1, function()
			tw({v = Left_1, t = 0.4, s = Enum.EasingStyle.Quad, d = "Out", g = {GroupTransparency = 0}}):Play()
			
			task.delay(0.1, function()
				tw({v = ImageLabel_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {ImageTransparency = 0}}):Play()
				tw({v = TextLabel_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
				
				task.delay(0.05, function()
					tw({v = ads_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
					
					task.delay(0.05, function()
						tw({v = TextLabel_2, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
						tw({v = Frame_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0}}):Play()
						tw({v = ImageLabel_2, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {ImageTransparency = 0}}):Play()
						
						task.delay(0.05, function()
							tw({v = Keybox_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {Transparency = 0}}):Play()
							tw({v = UIStroke_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {Transparency = 0}}):Play()
							tw({v = TextBox_1, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
							
							task.delay(0.05, function()
								tw({v = ExitButton, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0}}):Play()
								tw({v = ExitText, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
								
								task.delay(0.05, function()
									tw({v = GetKeyButton, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0}}):Play()
									tw({v = GetKeyText, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
									
									task.delay(0.05, function()
										tw({v = SubmitButton, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0}}):Play()
										tw({v = SubmitText, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {TextTransparency = 0}}):Play()
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
		local UIListLayout_Tab = Instance.new("UIListLayout")
		local UIPadding_Tab = Instance.new("UIPadding")
		local ImageLabel_Tab = Instance.new("ImageLabel")
		local TextLabel_Tab = Instance.new("TextLabel")

		Tab_1.Name = "Tab"
		Tab_1.Parent = TabList_1
		Tab_1.AutomaticSize = Enum.AutomaticSize.X
		Tab_1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Tab_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Tab_1.BorderSizePixel = 0
		Tab_1.Size = UDim2.new(0, 25,0, 30)

		UICorner_Tab.Parent = Tab_1
		UICorner_Tab.CornerRadius = UDim.new(0,6)

		UIListLayout_Tab.Parent = Tab_1
		UIListLayout_Tab.Padding = UDim.new(0,8)
		UIListLayout_Tab.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_Tab.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_Tab.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_Tab.VerticalAlignment = Enum.VerticalAlignment.Center

		UIPadding_Tab.Parent = Tab_1
		UIPadding_Tab.PaddingLeft = UDim.new(0,12)
		UIPadding_Tab.PaddingRight = UDim.new(0,12)

		ImageLabel_Tab.Parent = Tab_1
		ImageLabel_Tab.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ImageLabel_Tab.BackgroundTransparency = 1
		ImageLabel_Tab.BorderColor3 = Color3.fromRGB(0,0,0)
		ImageLabel_Tab.BorderSizePixel = 0
		ImageLabel_Tab.Size = UDim2.new(0, 16,0, 16)
		ImageLabel_Tab.Image = gl(Icon)

		TextLabel_Tab.Parent = Tab_1
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

		local Click = click(Tab_1)
		if Click then
			Click.MouseButton1Click:Connect(Callback)
		end
	end

	function tab.Notify(p)
		if not p then return {Set = function() end} end
		
		local Title = p.Title or 'Notification'
		local Icon = p.Icon or 14501439493
		local ColorN = p.Color or Color3.fromRGB(40, 40, 40)
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
		UIStroke_Notify.Color = Color3.fromRGB(64, 64, 64)
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
		UIListLayout_Content.Padding = UDim.new(0, 12)
		UIListLayout_Content.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_Content.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_Content.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_Content.VerticalAlignment = Enum.VerticalAlignment.Center
		
		IconFrame.Name = "IconFrame"
		IconFrame.Parent = Content
		IconFrame.BackgroundTransparency = 1
		IconFrame.Size = UDim2.new(0, 24, 0, 24)
		
		IconImage.Name = "Icon"
		IconImage.Parent = IconFrame
		IconImage.AnchorPoint = Vector2.new(0.5, 0.5)
		IconImage.BackgroundTransparency = 1
		IconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		IconImage.Size = UDim2.new(1, 0, 1, 0)
		IconImage.Image = gl(Icon)
		IconImage.ImageTransparency = 1
		
		TextFrame.Name = "TextFrame"
		TextFrame.Parent = Content
		TextFrame.BackgroundTransparency = 1
		TextFrame.Size = UDim2.new(1, -50, 1, 0)
		
		TextLabel_Notify.Name = "Text"
		TextLabel_Notify.Parent = TextFrame
		TextLabel_Notify.BackgroundTransparency = 1
		TextLabel_Notify.Size = UDim2.new(1, 0, 1, 0)
		TextLabel_Notify.Font = Enum.Font.Gotham
		TextLabel_Notify.Text = Title
		TextLabel_Notify.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_Notify.TextSize = 14
		TextLabel_Notify.TextTransparency = 1
		TextLabel_Notify.TextWrapped = true
		TextLabel_Notify.TextXAlignment = Enum.TextXAlignment.Left
		
		local textSize = game:GetService("TextService"):GetTextSize(Title, 14, Enum.Font.Gotham, Vector2.new(240, math.huge))
		local height = math.max(60, textSize.Y + 30)
		
		NotifyFrame.Size = UDim2.new(1, 0, 0, height)
		
		tw({v = NotifyFrame, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0, 0, 1, 0), BackgroundTransparency = 0}}):Play()
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
				local newTextSize = game:GetService("TextService"):GetTextSize(newText, 14, Enum.Font.Gotham, Vector2.new(240, math.huge))
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
				ImageLabel_2.Image = "rbxassetid://14501439490"
			else
				TextBox_1.Text = realText
				ImageLabel_2.Image = "rbxassetid://14501439491"
			end

			lastLength = #realText
		end)
	end

	if ExitClick then
		ExitClick.MouseButton1Click:Connect(function()
			tw({v = Left_1, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {GroupTransparency = 1}}):Play()
			task.delay(0.25, function()
				tw({v = Background_1, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
				tw({v = Shadow_BG, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {ImageTransparency = 1}}):Play()
				task.delay(0.3, function()
					ScreenGui:Destroy()
				end)	
			end)
		end)
	end
	
	local checkingKey = false
	
	if GetKeyClick then
		GetKeyClick.MouseButton1Click:Connect(function()
			tw({v = GetKeyButton, t = 0.1, s = Enum.EasingStyle.Quad, d = "InOut", g = {Size = UDim2.new(0, 98,0, 34)}}):Play()
			task.delay(0.1, function()
				tw({v = GetKeyButton, t = 0.1, s = Enum.EasingStyle.Quad, d = "InOut", g = {Size = UDim2.new(0, 100,0, 36)}}):Play()
			end)
			
			if o.KeyLink then
				if KeyGUI then 
					pcall(setclipboard, o.KeyLink) 
				end
				tab.Notify({
					Title = 'Key link copied to clipboard',
					Icon = 14501439492,
					Time = 3,
					Color = Color3.fromRGB(40, 40, 40)
				})
			else
				tab.Notify({
					Title = 'No key link provided',
					Icon = 14501439493,
					Time = 3,
					Color = Color3.fromRGB(40, 40, 40)
				})
			end
		end)
	end
	
	if SubmitClick then
		SubmitClick.MouseButton1Click:Connect(function()
			if checkingKey then return end
			checkingKey = true
			
			tw({v = SubmitButton, t = 0.1, s = Enum.EasingStyle.Quad, d = "InOut", g = {Size = UDim2.new(0, 98,0, 34)}}):Play()
			
			local checkNotify = tab.Notify({
				Title = 'Checking Key...',
				Icon = 14501439494,
				Time = 10,
				Color = Color3.fromRGB(40, 40, 40)
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
							Icon = 14501439494,
							Time = 2,
							Color = Color3.fromRGB(40, 40, 40)
						})
					end)
					
					tw({v = SubmitButton, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(76, 175, 80)}}):Play()
					
					task.delay(1.5, function()
						tw({v = Left_1, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {GroupTransparency = 1}}):Play()
						task.delay(0.25, function()
							tw({v = Background_1, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
							tw({v = Shadow_BG, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {ImageTransparency = 1}}):Play()
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
						tw({v = Keybox_1, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}}):Play()
					end)
					
					checkNotify:Set('Invalid Key!')
					
					tab.Notify({
						Title = 'Invalid key! Please check and try again.',
						Icon = 14501439493,
						Time = 3,
						Color = Color3.fromRGB(40, 40, 40)
					})
					
					tw({v = SubmitButton, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color3.fromRGB(244, 67, 54)}}):Play()
					
					task.delay(0.5, function()
						tw({v = SubmitButton, t = 0.2, s = Enum.EasingStyle.Quad, d = "InOut", g = {BackgroundColor3 = Color, Size = UDim2.new(0, 100,0, 36)}}):Play()
						checkingKey = false
					end)
				end
			end)
		end)
	end

	return tab
end

return Library
