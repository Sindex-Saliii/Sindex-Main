local Library, SaveTheme = {}, {}
local U, Tw = game:GetService("UserInputService"), game:GetService("TweenService")
local KeyGUI = pcall(function() return makefolder and readfile and writefile and setclipboard end)

function Library.Load(o)
    local function init(getFrame)
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

        local GenUid; do
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
                game:GetService('RunService').RenderStepped:wait()
                continue = IsNotNaN(workspace.CurrentCamera:ScreenPointToRay(0,0).Origin.x)
            end
        end

        local DrawQuad; do
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
                    p1 = p0:clone()
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
                if child:IsA'GuiObject' then
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
        if type(i) == 'string' and not i:find('rbxassetid://') then
            return {
                Image = "rbxassetid://".. i,
                ImageRectSize = Vector2.new(0, 0),
                ImageRectPosition = Vector2.new(0, 0),
            }
        elseif type(i) == 'number' then
            return {
                Image = "rbxassetid://".. i,
                ImageRectSize = Vector2.new(0, 0),
                ImageRectPosition = Vector2.new(0, 0),
            }
        else
            return i
        end
    end
    
    local function tw(info)
        return Tw:Create(info.v,TweenInfo.new(info.t, info.s, Enum.EasingDirection[info.d]),info.g)
    end
    
    local function lak(t, o)
        local a, b, c, d
        local function u(i)
            local dt = i.Position - c
            tw({v = o, t = 0.05, s = Enum.EasingStyle.Linear, d = "InOut", g = {Position = UDim2.new(d.X.Scale, d.X.Offset + dt.X, d.Y.Scale, d.Y.Offset + dt.Y)}}):Play()
        end
        t.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then a = true c = i.Position d = o.Position; i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then a = false end end) end end)
        t.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then b = i end end)
        U.InputChanged:Connect(function(i) if i == b and a then u(i) end end)
    end
    
    local function click(p)
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

    local HubName = o.Name or 'Premium Hub'
    local Color = o.Color or Color3.fromRGB(216, 52, 164)
    local Icon = o.Icon or 6031075938
    local Key = o.Key or {}
    local KeyLink = o.KeyLink or ""
    local DiscordLink = o.DiscordLink or ""
    local Callback = o.Callback or function() end

    if KeyGUI then 
        makefolder("SindexHub") 
    end
    local savedKey = ""
    if KeyGUI then
        local success, key = pcall(readfile, "SindexHub/key.txt")
        savedKey = success and key or ""
    end

    local ScreenGui = Instance.new("ScreenGui")
    local Background_1 = Instance.new("Frame")
    local UICorner_1 = Instance.new("UICorner")
    local UIGradient_1 = Instance.new("UIGradient")
    local UIPadding_1 = Instance.new("UIPadding")
    local Left_1 = Instance.new("CanvasGroup")
    local UIListLayout_1 = Instance.new("UIListLayout")
    local TItleIcon_1 = Instance.new("Frame")
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
    local RedeemFrame_1 = Instance.new("Frame")
    local UIListLayout_4 = Instance.new("UIListLayout")
    local Button_1 = Instance.new("Frame")
    local UICorner_4 = Instance.new("UICorner")
    local Shadow_1 = Instance.new("ImageLabel")
    local Text_1 = Instance.new("Frame")
    local UIListLayout_5 = Instance.new("UIListLayout")
    local TextLabel_3 = Instance.new("TextLabel")
    local ImageLabel_3 = Instance.new("ImageLabel")
    local Click_1 = Instance.new("TextButton")
    local TextLabel_4 = Instance.new("TextLabel")
    local Line_1 = Instance.new("Frame")
    local TabList_1 = Instance.new("Frame")
    local UIListLayout_7 = Instance.new("UIListLayout")

    ScreenGui.Parent = not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local screenSize = workspace.CurrentCamera.ViewportSize
    local uiScale = screenSize.X < 800 and 0.7 or 0.4

    Background_1.Name = "Background"
    Background_1.Parent = ScreenGui
    Background_1.AutomaticSize = Enum.AutomaticSize.Y
    Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Background_1.BackgroundColor3 = Color3.fromRGB(30,30,34)
    Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Background_1.BorderSizePixel = 0
    Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
    Background_1.Size = UDim2.new(uiScale, 0,0, 0)
    Background_1.ClipsDescendants = true
    Background_1.BackgroundTransparency = 1
    
    lak(Background_1, Background_1)

    local blurframe = init(Background_1)

    UICorner_1.Parent = Background_1
    UICorner_1.CornerRadius = UDim.new(0,15)

    UIGradient_1.Parent = Background_1
    UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 12, 20)), ColorSequenceKeypoint.new(0.5, Color), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 20))}
    UIGradient_1.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(0.5,0.04375), NumberSequenceKeypoint.new(1,0)}

    local UIStroke_3 = Instance.new("UIStroke")
    UIStroke_3.Parent = Background_1
    UIStroke_3.Color = Color
    UIStroke_3.Thickness = 1.2
    UIStroke_3.Transparency = 0.5

    UIPadding_1.Parent = Left_1
    UIPadding_1.PaddingBottom = UDim.new(0,12)
    UIPadding_1.PaddingLeft = UDim.new(0,12)
    UIPadding_1.PaddingRight = UDim.new(0,12)
    UIPadding_1.PaddingTop = UDim.new(0,12)

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
    UIListLayout_1.Padding = UDim.new(0,10)
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

    TItleIcon_1.Name = "TItleIcon"
    TItleIcon_1.Parent = Left_1
    TItleIcon_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TItleIcon_1.BackgroundTransparency = 1
    TItleIcon_1.BorderColor3 = Color3.fromRGB(0,0,0)
    TItleIcon_1.BorderSizePixel = 0
    TItleIcon_1.Size = UDim2.new(0, 100,0, 22)

    UIListLayout_2.Parent = TItleIcon_1
    UIListLayout_2.Padding = UDim.new(0,8)
    UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

    local success, icons = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/Icon.txt")
    local LucideIcons = {}
    if success then
        for line in icons:gmatch("[^\r\n]+") do
            local name, id = line:match("(.+):(%d+)")
            if name and id then
                LucideIcons[name:lower()] = tonumber(id)
            end
        end
    end

    local function getLucideIcon(name)
        return LucideIcons[name:lower()] or 6031075938
    end

    ImageLabel_1.Parent = TItleIcon_1
    ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ImageLabel_1.BackgroundTransparency = 1
    ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
    ImageLabel_1.BorderSizePixel = 0
    ImageLabel_1.Size = UDim2.new(0, 18,0, 18)
    ImageLabel_1.Image = gl(getLucideIcon("key")).Image
    ImageLabel_1.ImageColor3 = Color

    TextLabel_1.Parent = TItleIcon_1
    TextLabel_1.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextLabel_1.BackgroundTransparency = 1
    TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
    TextLabel_1.BorderSizePixel = 0
    TextLabel_1.Size = UDim2.new(0, 0,0, 22)
    TextLabel_1.Font = Enum.Font.GothamBold
    TextLabel_1.Text = "Key System"
    TextLabel_1.TextColor3 = Color
    TextLabel_1.TextSize = 12
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
    ads_1.Font = Enum.Font.GothamBold
    ads_1.RichText = true
    ads_1.Text = "Welcome to\n<font color='"..string.format("rgb(%d, %d, %d)", Color.r * 255, Color.g * 255, Color.b * 255).."'>"..HubName.."</font>"
    ads_1.TextColor3 = Color3.fromRGB(255,255,255)
    ads_1.TextSize = 24
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
    UIListLayout_3.Padding = UDim.new(0,6)
    UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

    TextLabel_2.Parent = KeyFrame_1
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
    TextLabel_2.BorderSizePixel = 0
    TextLabel_2.Size = UDim2.new(1, 0,0, 20)
    TextLabel_2.Font = Enum.Font.Gotham
    TextLabel_2.Text = "License Key"
    TextLabel_2.TextColor3 = Color3.fromRGB(255,255,255)
    TextLabel_2.TextSize = 13
    TextLabel_2.TextTransparency = 0.3
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

    Frame_1.Parent = TextLabel_2
    Frame_1.AnchorPoint = Vector2.new(1, 0.5)
    Frame_1.BackgroundColor3 = Color
    Frame_1.BackgroundTransparency = 0.56
    Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Frame_1.BorderSizePixel = 0
    Frame_1.Position = UDim2.new(1, 0,0.5, 0)
    Frame_1.Size = UDim2.new(0, 20,0, 20)

    UICorner_2.Parent = Frame_1
    UICorner_2.CornerRadius = UDim.new(1,0)

    ImageLabel_2.Parent = Frame_1
    ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
    ImageLabel_2.BorderSizePixel = 0
    ImageLabel_2.Position = UDim2.new(0.5, 0,0.5, 0)
    ImageLabel_2.Size = UDim2.new(0, 14,0, 14)
    ImageLabel_2.Image = gl(getLucideIcon("check-circle")).Image
    ImageLabel_2.ImageColor3 = Color3.fromRGB(255,255,255)

    Keybox_1.Name = "Keybox"
    Keybox_1.Parent = KeyFrame_1
    Keybox_1.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Keybox_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Keybox_1.BorderSizePixel = 0
    Keybox_1.LayoutOrder = 1
    Keybox_1.Size = UDim2.new(1, 0,0, 35)
    Keybox_1.Transparency = 0.3

    UICorner_3.Parent = Keybox_1
    UICorner_3.CornerRadius = UDim.new(0,8)

    UIStroke_1.Parent = Keybox_1
    UIStroke_1.Color = Color
    UIStroke_1.Thickness = 1.5
    UIStroke_1.Transparency = 0.5

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
    TextBox_1.PlaceholderColor3 = Color3.fromRGB(150,150,150)
    TextBox_1.PlaceholderText = "XXXX-XXXX-XXXX-XXXX"
    TextBox_1.Text = ""
    TextBox_1.TextColor3 = Color3.fromRGB(255,255,255)
    TextBox_1.TextSize = 13
    TextBox_1.TextXAlignment = Enum.TextXAlignment.Left
    TextBox_1.ClearTextOnFocus = false

    RedeemFrame_1.Name = "RedeemFrame"
    RedeemFrame_1.Parent = Left_1
    RedeemFrame_1.AutomaticSize = Enum.AutomaticSize.Y
    RedeemFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    RedeemFrame_1.BackgroundTransparency = 1
    RedeemFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
    RedeemFrame_1.BorderSizePixel = 0
    RedeemFrame_1.LayoutOrder = 3
    RedeemFrame_1.Size = UDim2.new(1, 0,0, 0)

    UIListLayout_4.Parent = RedeemFrame_1
    UIListLayout_4.Padding = UDim.new(0,12)
    UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

    Button_1.Name = "Button"
    Button_1.Parent = RedeemFrame_1
    Button_1.BackgroundColor3 = Color
    Button_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Button_1.BorderSizePixel = 0
    Button_1.Size = UDim2.new(1, 0,0, 38)

    UICorner_4.Parent = Button_1
    UICorner_4.CornerRadius = UDim.new(0,8)

    Shadow_1.Name = "Shadow"
    Shadow_1.Parent = Button_1
    Shadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
    Shadow_1.BackgroundTransparency = 1
    Shadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
    Shadow_1.Size = UDim2.new(1.1, 0,1.2, 0)
    Shadow_1.Image = "rbxassetid://1316045217"
    Shadow_1.ImageColor3 = Color
    Shadow_1.ImageTransparency = 0.85
    Shadow_1.ScaleType = Enum.ScaleType.Slice
    Shadow_1.SliceCenter = Rect.new(10, 10, 118, 118)

    Text_1.Name = "Text"
    Text_1.Parent = Button_1
    Text_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Text_1.BackgroundTransparency = 1
    Text_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Text_1.BorderSizePixel = 0
    Text_1.Size = UDim2.new(1, 0,1, 0)

    UIListLayout_5.Parent = Text_1
    UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_5.VerticalAlignment = Enum.VerticalAlignment.Center

    TextLabel_3.Parent = Text_1
    TextLabel_3.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextLabel_3.BackgroundTransparency = 1
    TextLabel_3.BorderColor3 = Color3.fromRGB(0,0,0)
    TextLabel_3.BorderSizePixel = 0
    TextLabel_3.Size = UDim2.new(0, 0,1, 0)
    TextLabel_3.Font = Enum.Font.GothamBold
    TextLabel_3.Text = "VERIFY KEY"
    TextLabel_3.TextColor3 = Color3.fromRGB(255,255,255)
    TextLabel_3.TextSize = 14

    ImageLabel_3.Parent = Text_1
    ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ImageLabel_3.BackgroundTransparency = 1
    ImageLabel_3.BorderColor3 = Color3.fromRGB(0,0,0)
    ImageLabel_3.BorderSizePixel = 0
    ImageLabel_3.LayoutOrder = 2
    ImageLabel_3.Size = UDim2.new(0, 20,0, 20)
    ImageLabel_3.Image = gl(getLucideIcon("shield-check")).Image
    ImageLabel_3.ImageColor3 = Color3.fromRGB(255,255,255)

    Click_1.Name = "Click"
    Click_1.Parent = Button_1
    Click_1.Active = true
    Click_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Click_1.BackgroundTransparency = 1
    Click_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Click_1.BorderSizePixel = 0
    Click_1.Size = UDim2.new(1, 0,1, 0)
    Click_1.Font = Enum.Font.SourceSans
    Click_1.Text = ""
    Click_1.TextSize = 14

    TextLabel_4.Parent = RedeemFrame_1
    TextLabel_4.AutomaticSize = Enum.AutomaticSize.XY
    TextLabel_4.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextLabel_4.BackgroundTransparency = 1
    TextLabel_4.BorderColor3 = Color3.fromRGB(0,0,0)
    TextLabel_4.BorderSizePixel = 0
    TextLabel_4.LayoutOrder = 2
    TextLabel_4.Size = UDim2.new(0, 0,0, 0)
    TextLabel_4.Font = Enum.Font.Gotham
    TextLabel_4.RichText = true
    TextLabel_4.Text = "Need a key? <font color='"..string.format("rgb(%d, %d, %d)", Color.r * 255, Color.g * 255, Color.b * 255).."'>Get Key</font> • <font color='"..string.format("rgb(%d, %d, %d)", Color.r * 255, Color.g * 255, Color.b * 255).."'>Discord</font>"
    TextLabel_4.TextColor3 = Color3.fromRGB(255,255,255)
    TextLabel_4.TextSize = 12
    TextLabel_4.TextTransparency = 0.5
    
    local Button_2 = Instance.new("Frame")
    Button_2.Name = "Button"
    Button_2.Parent = RedeemFrame_1
    Button_2.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    Button_2.BorderColor3 = Color3.fromRGB(0,0,0)
    Button_2.BorderSizePixel = 0
    Button_2.Size = UDim2.new(1, 0,0, 35)
    Button_2.LayoutOrder = 1
    
    local UICorner_5 = Instance.new("UICorner")
    UICorner_5.Parent = Button_2
    UICorner_5.CornerRadius = UDim.new(0,8)
    
    local Shadow_2 = Instance.new("ImageLabel")
    Shadow_2.Name = "Shadow"
    Shadow_2.Parent = Button_2
    Shadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow_2.BackgroundColor3 = Color3.fromRGB(163,162,165)
    Shadow_2.BackgroundTransparency = 1
    Shadow_2.Position = UDim2.new(0.5, 0,0.5, 0)
    Shadow_2.Size = UDim2.new(1.1, 0,1.2, 0)
    Shadow_2.Image = "rbxassetid://1316045217"
    Shadow_2.ImageColor3 = Color
    Shadow_2.ImageTransparency = 0.9
    Shadow_2.ScaleType = Enum.ScaleType.Slice
    Shadow_2.SliceCenter = Rect.new(10, 10, 118, 118)
    
    local Text_2 = Instance.new("Frame")
    Text_2.Name = "Text"
    Text_2.Parent = Button_2
    Text_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Text_2.BackgroundTransparency = 1
    Text_2.BorderColor3 = Color3.fromRGB(0,0,0)
    Text_2.BorderSizePixel = 0
    Text_2.Size = UDim2.new(1, 0,1, 0)
    
    local UIListLayout_6 = Instance.new("UIListLayout")
    UIListLayout_6.Parent = Text_2
    UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center
    
    local TextLabel_6 = Instance.new("TextLabel")
    TextLabel_6.Parent = Text_2
    TextLabel_6.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_6.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextLabel_6.BackgroundTransparency = 1
    TextLabel_6.BorderColor3 = Color3.fromRGB(0,0,0)
    TextLabel_6.BorderSizePixel = 0
    TextLabel_6.Size = UDim2.new(0, 0,1, 0)
    TextLabel_6.Font = Enum.Font.GothamBold
    TextLabel_6.Text = "GET KEY"
    TextLabel_6.TextColor3 = Color3.fromRGB(255,255,255)
    TextLabel_6.TextSize = 13
    
    local ImageLabel_4 = Instance.new("ImageLabel")
    ImageLabel_4.Parent = Text_2
    ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ImageLabel_4.BackgroundTransparency = 1
    ImageLabel_4.BorderColor3 = Color3.fromRGB(0,0,0)
    ImageLabel_4.BorderSizePixel = 0
    ImageLabel_4.LayoutOrder = 2
    ImageLabel_4.Size = UDim2.new(0, 18,0, 18)
    ImageLabel_4.Image = gl(getLucideIcon("external-link")).Image
    ImageLabel_4.ImageColor3 = Color3.fromRGB(255,255,255)
    
    local Click_2 = Instance.new("TextButton")
    Click_2.Name = "Click"
    Click_2.Parent = Button_2
    Click_2.Active = true
    Click_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Click_2.BackgroundTransparency = 1
    Click_2.BorderColor3 = Color3.fromRGB(0,0,0)
    Click_2.BorderSizePixel = 0
    Click_2.Size = UDim2.new(1, 0,1, 0)
    Click_2.Font = Enum.Font.SourceSans
    Click_2.Text = ""
    Click_2.TextSize = 14

    local ClickJoinDis = click(TextLabel_4)

    Line_1.Name = "Line"
    Line_1.Parent = RedeemFrame_1
    Line_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Line_1.BackgroundTransparency = 0.9
    Line_1.BorderColor3 = Color3.fromRGB(0,0,0)
    Line_1.BorderSizePixel = 0
    Line_1.LayoutOrder = 4
    Line_1.Size = UDim2.new(1, 0,0, 1)

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
        if #TabList_1:GetChildren() > 1 then
            TabList_1.Visible = true
        else
            TabList_1.Visible = false
        end
    end)

    local tab = {}

    function tab.New(p)
        local Title = p.Title or 'null'
        local Icon = p.Icon or getLucideIcon("settings")
        local Callback = p.Callback or function() end
        local Tab_1 = Instance.new("Frame")
        local UICorner_5 = Instance.new("UICorner")
        local UIGradient_2 = Instance.new("UIGradient")
        local UIListLayout_6 = Instance.new("UIListLayout")
        local UIPadding_3 = Instance.new("UIPadding")
        local ImageLabel_4 = Instance.new("ImageLabel")
        local TextLabel_5 = Instance.new("TextLabel")
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
        Tab_1.Size = UDim2.new(0, 30,0, 30)

        UICorner_5.Parent = Tab_1
        UICorner_5.CornerRadius = UDim.new(1,0)

        UIGradient_2.Parent = Tab_1
        UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 50, 120))}
        UIGradient_2.Rotation = 90

        UIListLayout_6.Parent = newf
        UIListLayout_6.Padding = UDim.new(0,6)
        UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center

        UIPadding_3.Parent = newf
        UIPadding_3.PaddingLeft = UDim.new(0,8)
        UIPadding_3.PaddingRight = UDim.new(0,8)

        ImageLabel_4.Parent = newf
        ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255,255,255)
        ImageLabel_4.BackgroundTransparency = 1
        ImageLabel_4.BorderColor3 = Color3.fromRGB(0,0,0)
        ImageLabel_4.BorderSizePixel = 0
        ImageLabel_4.Size = UDim2.new(0, 16,0, 16)
        ImageLabel_4.Image = gl(Icon).Image
        ImageLabel_4.ImageColor3 = Color3.fromRGB(255,255,255)

        TextLabel_5.Parent = newf
        TextLabel_5.AutomaticSize = Enum.AutomaticSize.X
        TextLabel_5.BackgroundColor3 = Color3.fromRGB(255,255,255)
        TextLabel_5.BackgroundTransparency = 1
        TextLabel_5.BorderColor3 = Color3.fromRGB(0,0,0)
        TextLabel_5.BorderSizePixel = 0
        TextLabel_5.LayoutOrder = 1
        TextLabel_5.Size = UDim2.new(0, 0,1, 0)
        TextLabel_5.Font = Enum.Font.GothamBold
        TextLabel_5.Text = Title
        TextLabel_5.TextColor3 = Color3.fromRGB(255,255,255)
        TextLabel_5.TextSize = 12

        local Click = click(Tab_1)
        Click.MouseButton1Click:Connect(Callback)
    end

    local Notify = Instance.new("Frame")
    local UIListLayout_1 = Instance.new("UIListLayout")

    Notify.Name = "Notify"
    Notify.Parent = Background_1
    Notify.AnchorPoint = Vector2.new(0.5, 1)
    Notify.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Notify.BackgroundTransparency = 1
    Notify.BorderColor3 = Color3.fromRGB(0,0,0)
    Notify.BorderSizePixel = 0
    Notify.Position = UDim2.new(0.5, 0,1, 0)
    Notify.Size = UDim2.new(0, 200,0, 50)

    UIListLayout_1.Parent = Notify
    UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Bottom

    function tab.Notify(p)
        local Title = p.Title or 'Notification'
        local Icon = p.Icon or getLucideIcon("bell")
        local ColorN = p.Color or Color
        local Time = p.Time or 3
        
        local Shadow = Instance.new("ImageLabel")
        local Notifytemple_1 = Instance.new("Frame")
        local UIPadding_1 = Instance.new("UIPadding")
        local UICorner_1 = Instance.new("UICorner")
        local UIStroke_1 = Instance.new("UIStroke")
        local Frame_1 = Instance.new("Frame")
        local ImageLabel_1 = Instance.new("ImageLabel")
        local TextLabel_1 = Instance.new("TextLabel")
        local UIListLayout_1 = Instance.new("UIListLayout")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local UIPadding_2 = Instance.new("UIPadding")
        local Glow = Instance.new("ImageLabel")

        Shadow.Name = "Shadow"
        Shadow.Parent = Notify
        Shadow.AutomaticSize = Enum.AutomaticSize.XY
        Shadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
        Shadow.BackgroundTransparency = 1
        Shadow.Size = UDim2.new(0, 0,0, 0)
        Shadow.Image = "rbxassetid://1316045217"
        Shadow.ImageColor3 = ColorN
        Shadow.ImageTransparency = 1
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

        Glow.Name = "Glow"
        Glow.Parent = Shadow
        Glow.AnchorPoint = Vector2.new(0.5, 0.5)
        Glow.BackgroundTransparency = 1
        Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
        Glow.Size = UDim2.new(1.2, 0, 1.2, 0)
        Glow.Image = "rbxassetid://1316045217"
        Glow.ImageColor3 = ColorN
        Glow.ImageTransparency = 1
        Glow.ScaleType = Enum.ScaleType.Slice
        Glow.SliceCenter = Rect.new(10, 10, 118, 118)

        Notifytemple_1.Name = "Notifytemple"
        Notifytemple_1.Parent = Shadow
        Notifytemple_1.AnchorPoint = Vector2.new(0.5, 0.5)
        Notifytemple_1.AutomaticSize = Enum.AutomaticSize.X
        Notifytemple_1.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        Notifytemple_1.BackgroundTransparency = 1
        Notifytemple_1.BorderColor3 = Color3.fromRGB(0,0,0)
        Notifytemple_1.BorderSizePixel = 0
        Notifytemple_1.Position = UDim2.new(0.5, 0,0.5, 0)
        Notifytemple_1.Size = UDim2.new(0, 0,0, 45)

        UIPadding_1.Parent = Notifytemple_1
        UIPadding_1.PaddingLeft = UDim.new(0,15)
        UIPadding_1.PaddingRight = UDim.new(0,15)

        UICorner_1.Parent = Notifytemple_1
        UICorner_1.CornerRadius = UDim.new(1,0)

        UIStroke_1.Parent = Notifytemple_1
        UIStroke_1.Color = ColorN
        UIStroke_1.Thickness = 1.5
        UIStroke_1.Transparency = 1

        Frame_1.Parent = Notifytemple_1
        Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Frame_1.BackgroundTransparency = 1
        Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
        Frame_1.BorderSizePixel = 0
        Frame_1.Size = UDim2.new(1, 0,1, 0)

        ImageLabel_1.Parent = Frame_1
        ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
        ImageLabel_1.BackgroundTransparency = 1
        ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
        ImageLabel_1.BorderSizePixel = 0
        ImageLabel_1.Size = UDim2.new(0, 22,0, 22)
        ImageLabel_1.Image = gl(Icon).Image
        ImageLabel_1.ImageColor3 = ColorN
        ImageLabel_1.ImageTransparency = 1

        TextLabel_1.Parent = Frame_1
        TextLabel_1.AutomaticSize = Enum.AutomaticSize.X
        TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
        TextLabel_1.BackgroundTransparency = 1
        TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
        TextLabel_1.BorderSizePixel = 0
        TextLabel_1.LayoutOrder = 1
        TextLabel_1.Size = UDim2.new(0, 0,1, 0)
        TextLabel_1.Font = Enum.Font.GothamBold
        TextLabel_1.Text = Title
        TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
        TextLabel_1.TextSize = 0
        TextLabel_1.TextTransparency = 1

        UIListLayout_1.Parent = Frame_1
        UIListLayout_1.Padding = UDim.new(0,10)
        UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

        UIListLayout_2.Parent = Shadow
        UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

        UIPadding_2.Parent = Shadow
        UIPadding_2.PaddingBottom = UDim.new(0,8)
        UIPadding_2.PaddingLeft = UDim.new(0,8)
        UIPadding_2.PaddingRight = UDim.new(0,8)
        UIPadding_2.PaddingTop = UDim.new(0,8)
        
        local tweenIn = tw({v = Shadow, t = 0.3, s = Enum.EasingStyle.Quart, d = "Out", g = {ImageTransparency = 0.7}})
        local tweenInGlow = tw({v = Glow, t = 0.3, s = Enum.EasingStyle.Quart, d = "Out", g = {ImageTransparency = 0.4}})
        local tweenIn2 = tw({v = Notifytemple_1, t = 0.3, s = Enum.EasingStyle.Quart, d = "Out", g = {BackgroundTransparency = 0}})
        local tweenIn3 = tw({v = TextLabel_1, t = 0.3, s = Enum.EasingStyle.Back, d = "Out", g = {TextSize = 14, TextTransparency = 0}})
        local tweenIn4 = tw({v = UIStroke_1, t = 0.3, s = Enum.EasingStyle.Quart, d = "Out", g = {Transparency = 0}})
        local tweenIn5 = tw({v = ImageLabel_1, t = 0.3, s = Enum.EasingStyle.Quart, d = "Out", g = {ImageTransparency = 0, Rotation = 360}})
        
        tweenIn:Play()
        tweenInGlow:Play()
        tweenIn2:Play()
        tweenIn3:Play()
        tweenIn4:Play()
        tweenIn5:Play()
        
        task.spawn(function()
            task.wait(Time)
            
            local tweenOut = tw({v = Shadow, t = 0.3, s = Enum.EasingStyle.Quart, d = "In", g = {ImageTransparency = 1}})
            local tweenOutGlow = tw({v = Glow, t = 0.3, s = Enum.EasingStyle.Quart, d = "In", g = {ImageTransparency = 1}})
            local tweenOut2 = tw({v = Notifytemple_1, t = 0.3, s = Enum.EasingStyle.Quart, d = "In", g = {BackgroundTransparency = 1}})
            local tweenOut3 = tw({v = TextLabel_1, t = 0.3, s = Enum.EasingStyle.Back, d = "In", g = {TextSize = 0, TextTransparency = 1}})
            local tweenOut4 = tw({v = UIStroke_1, t = 0.3, s = Enum.EasingStyle.Quart, d = "In", g = {Transparency = 1}})
            local tweenOut5 = tw({v = ImageLabel_1, t = 0.3, s = Enum.EasingStyle.Quart, d = "In", g = {ImageTransparency = 1, Rotation = 0}})
            
            tweenOut:Play()
            tweenOutGlow:Play()
            tweenOut2:Play()
            tweenOut3:Play()
            tweenOut4:Play()
            tweenOut5:Play()
            
            task.delay(0.3, function()
                Shadow:Destroy()
            end)
        end)
        
        local n = {}
        
        function n:Set(n)
            TextLabel_1.Text = n
        end
        
        return n
    end

    do
        local GetKeyBtn = click(Button_2)
        local DiscordBtn = Instance.new("TextButton")
        DiscordBtn.Name = "DiscordBtn"
        DiscordBtn.Parent = TextLabel_4
        DiscordBtn.BackgroundTransparency = 1
        DiscordBtn.Size = UDim2.new(0.5, 0, 1, 0)
        DiscordBtn.Position = UDim2.new(0.5, 0, 0, 0)
        DiscordBtn.Text = ""
        DiscordBtn.TextSize = 12
        
        GetKeyBtn.MouseButton1Click:Connect(function()
            tw({v = Button_2, t = 0.1, s = Enum.EasingStyle.Linear, d = "InOut", g = {Size = UDim2.new(1, 0,0, 32), BackgroundColor3 = Color3.fromRGB(60, 60, 70)}}):Play()
            task.delay(0.1, function()
                tw({v = Button_2, t = 0.1, s = Enum.EasingStyle.Linear, d = "InOut", g = {Size = UDim2.new(1, 0,0, 35), BackgroundColor3 = Color3.fromRGB(50, 50, 55)}}):Play()
            end)
            
            tab.Notify({
                Title = 'Copied Key Link',
                Icon = getLucideIcon("copy-check"),
                Time = 3,
                Color = Color3.fromRGB(98, 37, 209)
            })
            
            if KeyLink ~= "" and KeyGUI then
                pcall(setclipboard, KeyLink)
            end
        end)
        
        DiscordBtn.MouseButton1Click:Connect(function()
            tab.Notify({
                Title = 'Copied Discord Link',
                Icon = getLucideIcon("copy"),
                Time = 3,
                Color = Color3.fromRGB(98, 37, 209)
            })
            
            if DiscordLink ~= "" and KeyGUI then
                pcall(setclipboard, DiscordLink)
            end
        end)
        
        do
            if savedKey ~= "" then
                TextBox_1.Text = savedKey
            end

            local function validateKey(key)
                for _, v in ipairs(Key) do
                    if key == v then
                        return true
                    end
                end
                return false
            end
            
            tw({v = Background_1, t = 0.2, s = Enum.EasingStyle.Quart, d = "Out", g = {BackgroundTransparency = 0.1}}):Play()
            task.delay(0.15, function()
                tw({v = Left_1, t = 0.2, s = Enum.EasingStyle.Quart, d = "Out", g = {GroupTransparency = 0}}):Play()
            end)
            
            Click_1.MouseButton1Click:Connect(function()
                tw({v = Button_1, t = 0.1, s = Enum.EasingStyle.Linear, d = "InOut", g = {Size = UDim2.new(1, 0,0, 35), BackgroundColor3 = Color3.fromRGB(180, 40, 80)}}):Play()
                task.delay(0.1, function()
                    tw({v = Button_1, t = 0.1, s = Enum.EasingStyle.Linear, d = "InOut", g = {Size = UDim2.new(1, 0,0, 38), BackgroundColor3 = Color}}):Play()
                end)
                
                local input = TextBox_1.Text
                local isValid = validateKey(input)

                if isValid then
                    if KeyGUI then 
                        pcall(writefile, "SindexHub/key.txt", input) 
                    end
                    
                    tab.Notify({
                        Title = 'Key Verified Successfully!',
                        Icon = getLucideIcon("circle-check"),
                        Time = 2,
                        Color = Color3.fromRGB(0, 200, 83)
                    })
                    
                    task.delay(1, function()
                        tab.Notify({
                            Title = 'Loading Script...',
                            Icon = getLucideIcon("loader-circle"),
                            Time = 2,
                            Color = Color
                        })
                    end)
                    
                    task.delay(2, function()
                        tw({v = Left_1, t = 0.25, s = Enum.EasingStyle.Quart, d = "In", g = {GroupTransparency = 1}}):Play()
                        task.delay(0.2, function()
                            tw({v = Background_1, t = 0.25, s = Enum.EasingStyle.Quart, d = "In", g = {BackgroundTransparency = 1}}):Play()
                            task.delay(0.3, function()
                                ScreenGui:Destroy()
                                if blurframe and blurframe[1] then
                                    blurframe[1]:Destroy()
                                end
                                Callback()
                            end)    
                        end)
                    end)
                else
                    tab.Notify({
                        Title = 'Invalid Key!',
                        Icon = getLucideIcon("x"),
                        Time = 3,
                        Color = Color3.fromRGB(255, 87, 87)
                    })
                end
            end)
        end
    end

    return tab
end

return Library
