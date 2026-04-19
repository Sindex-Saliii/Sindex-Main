local CloverUI = {}
local _SaveTheme = {}

local _themes = {
	index = {'Dark','Clover','Amethyst','Rose','Light','Ocean','Galaxy'},
	Dark = {
		Shadow = Color3.fromRGB(10,10,10),
		Background = Color3.fromRGB(15,15,15),
		Page = Color3.fromRGB(20,20,20),
		Main = Color3.fromRGB(70,130,180),
		['Text & Icon'] = Color3.fromRGB(230,230,230),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(20,20,20),
				True = {['Toggle Background']=Color3.fromRGB(70,130,180),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(35,35,35),['Toggle Value']=Color3.fromRGB(80,80,80)}
			},
			Label = {Background=Color3.fromRGB(20,20,20)},
			Dropdown = {
				Background=Color3.fromRGB(20,20,20),
				['Value Background']=Color3.fromRGB(28,28,28),
				['Value Stroke']=Color3.fromRGB(60,60,60),
				['Dropdown Select']={Background=Color3.fromRGB(18,18,18),Search=Color3.fromRGB(25,25,25),['Item Background']=Color3.fromRGB(22,22,22)}
			},
			Slider = {
				Background=Color3.fromRGB(20,20,20),
				['Value Background']=Color3.fromRGB(28,28,28),
				['Value Stroke']=Color3.fromRGB(60,60,60),
				['Slider Bar']=Color3.fromRGB(35,35,35),
				['Slider Bar Value']=Color3.fromRGB(70,130,180),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(18,18,18)),ColorSequenceKeypoint.new(1,Color3.fromRGB(22,22,22))},
				['Background Code']=Color3.fromRGB(25,25,25),
				['Background Code Value']=Color3.fromRGB(30,30,30),
				['ScrollingFrame Code']=Color3.fromRGB(70,130,180)
			},
			Button = {Background=Color3.fromRGB(20,20,20),Click=Color3.fromRGB(70,130,180)},
			Textbox = {Background=Color3.fromRGB(20,20,20),['Value Background']=Color3.fromRGB(28,28,28),['Value Stroke']=Color3.fromRGB(60,60,60)},
			Keybind = {
				Background=Color3.fromRGB(20,20,20),
				['Value Background']=Color3.fromRGB(28,28,28),
				['Value Stroke']=Color3.fromRGB(60,60,60),
				True={['Toggle Background']=Color3.fromRGB(70,130,180),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(35,35,35),['Toggle Value']=Color3.fromRGB(80,80,80)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(20,20,20),
				['Color Select']={Background=Color3.fromRGB(28,28,28),UIStroke=Color3.fromRGB(60,60,60)}
			}
		}
	},
	Clover = {
		Shadow = Color3.fromRGB(0,30,15),
		Background = Color3.fromRGB(10,20,13),
		Page = Color3.fromRGB(14,28,18),
		Main = Color3.fromRGB(0,180,90),
		['Text & Icon'] = Color3.fromRGB(210,255,225),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(14,28,18),
				True = {['Toggle Background']=Color3.fromRGB(0,200,100),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(30,55,38),['Toggle Value']=Color3.fromRGB(80,140,100)}
			},
			Label = {Background=Color3.fromRGB(14,28,18)},
			Dropdown = {
				Background=Color3.fromRGB(14,28,18),
				['Value Background']=Color3.fromRGB(20,40,26),
				['Value Stroke']=Color3.fromRGB(0,120,65),
				['Dropdown Select']={Background=Color3.fromRGB(12,24,16),Search=Color3.fromRGB(18,36,22),['Item Background']=Color3.fromRGB(16,32,20)}
			},
			Slider = {
				Background=Color3.fromRGB(14,28,18),
				['Value Background']=Color3.fromRGB(20,40,26),
				['Value Stroke']=Color3.fromRGB(0,120,65),
				['Slider Bar']=Color3.fromRGB(25,55,35),
				['Slider Bar Value']=Color3.fromRGB(0,200,100),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(10,22,14)),ColorSequenceKeypoint.new(1,Color3.fromRGB(14,30,18))},
				['Background Code']=Color3.fromRGB(18,38,24),
				['Background Code Value']=Color3.fromRGB(22,48,30),
				['ScrollingFrame Code']=Color3.fromRGB(0,200,100)
			},
			Button = {Background=Color3.fromRGB(14,28,18),Click=Color3.fromRGB(0,200,100)},
			Textbox = {Background=Color3.fromRGB(14,28,18),['Value Background']=Color3.fromRGB(20,40,26),['Value Stroke']=Color3.fromRGB(0,120,65)},
			Keybind = {
				Background=Color3.fromRGB(14,28,18),
				['Value Background']=Color3.fromRGB(20,40,26),
				['Value Stroke']=Color3.fromRGB(0,120,65),
				True={['Toggle Background']=Color3.fromRGB(0,200,100),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(30,55,38),['Toggle Value']=Color3.fromRGB(80,140,100)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(14,28,18),
				['Color Select']={Background=Color3.fromRGB(20,40,26),UIStroke=Color3.fromRGB(0,120,65)}
			}
		}
	},
	Amethyst = {
		Shadow = Color3.fromRGB(25,0,50),
		Background = Color3.fromRGB(15,10,25),
		Page = Color3.fromRGB(20,14,35),
		Main = Color3.fromRGB(130,60,220),
		['Text & Icon'] = Color3.fromRGB(225,210,255),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(20,14,35),
				True = {['Toggle Background']=Color3.fromRGB(130,60,220),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(45,28,70),['Toggle Value']=Color3.fromRGB(100,80,150)}
			},
			Label = {Background=Color3.fromRGB(20,14,35)},
			Dropdown = {
				Background=Color3.fromRGB(20,14,35),
				['Value Background']=Color3.fromRGB(28,20,48),
				['Value Stroke']=Color3.fromRGB(90,50,140),
				['Dropdown Select']={Background=Color3.fromRGB(16,12,28),Search=Color3.fromRGB(24,18,40),['Item Background']=Color3.fromRGB(20,15,35)}
			},
			Slider = {
				Background=Color3.fromRGB(20,14,35),
				['Value Background']=Color3.fromRGB(28,20,48),
				['Value Stroke']=Color3.fromRGB(90,50,140),
				['Slider Bar']=Color3.fromRGB(40,28,65),
				['Slider Bar Value']=Color3.fromRGB(130,60,220),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(15,10,25)),ColorSequenceKeypoint.new(1,Color3.fromRGB(22,15,38))},
				['Background Code']=Color3.fromRGB(26,18,44),
				['Background Code Value']=Color3.fromRGB(32,22,55),
				['ScrollingFrame Code']=Color3.fromRGB(130,60,220)
			},
			Button = {Background=Color3.fromRGB(20,14,35),Click=Color3.fromRGB(130,60,220)},
			Textbox = {Background=Color3.fromRGB(20,14,35),['Value Background']=Color3.fromRGB(28,20,48),['Value Stroke']=Color3.fromRGB(90,50,140)},
			Keybind = {
				Background=Color3.fromRGB(20,14,35),
				['Value Background']=Color3.fromRGB(28,20,48),
				['Value Stroke']=Color3.fromRGB(90,50,140),
				True={['Toggle Background']=Color3.fromRGB(130,60,220),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(45,28,70),['Toggle Value']=Color3.fromRGB(100,80,150)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(20,14,35),
				['Color Select']={Background=Color3.fromRGB(28,20,48),UIStroke=Color3.fromRGB(90,50,140)}
			}
		}
	},
	Rose = {
		Shadow = Color3.fromRGB(180,140,150),
		Background = Color3.fromRGB(252,235,240),
		Page = Color3.fromRGB(255,248,250),
		Main = Color3.fromRGB(230,80,150),
		['Text & Icon'] = Color3.fromRGB(50,30,40),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(248,225,232),
				True = {['Toggle Background']=Color3.fromRGB(230,80,150),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(225,200,210),['Toggle Value']=Color3.fromRGB(180,160,170)}
			},
			Label = {Background=Color3.fromRGB(248,225,232)},
			Dropdown = {
				Background=Color3.fromRGB(248,225,232),
				['Value Background']=Color3.fromRGB(255,248,250),
				['Value Stroke']=Color3.fromRGB(210,180,190),
				['Dropdown Select']={Background=Color3.fromRGB(255,248,250),Search=Color3.fromRGB(248,238,243),['Item Background']=Color3.fromRGB(250,230,237)}
			},
			Slider = {
				Background=Color3.fromRGB(248,225,232),
				['Value Background']=Color3.fromRGB(255,248,250),
				['Value Stroke']=Color3.fromRGB(210,180,190),
				['Slider Bar']=Color3.fromRGB(235,210,220),
				['Slider Bar Value']=Color3.fromRGB(230,80,150),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(248,225,232)),ColorSequenceKeypoint.new(1,Color3.fromRGB(248,225,232))},
				['Background Code']=Color3.fromRGB(255,240,246),
				['Background Code Value']=Color3.fromRGB(250,220,230),
				['ScrollingFrame Code']=Color3.fromRGB(180,80,120)
			},
			Button = {Background=Color3.fromRGB(248,225,232),Click=Color3.fromRGB(230,80,150)},
			Textbox = {Background=Color3.fromRGB(248,225,232),['Value Background']=Color3.fromRGB(255,248,250),['Value Stroke']=Color3.fromRGB(210,180,190)},
			Keybind = {
				Background=Color3.fromRGB(248,225,232),
				['Value Background']=Color3.fromRGB(255,248,250),
				['Value Stroke']=Color3.fromRGB(210,180,190),
				True={['Toggle Background']=Color3.fromRGB(230,80,150),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(225,200,210),['Toggle Value']=Color3.fromRGB(180,160,170)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(248,225,232),
				['Color Select']={Background=Color3.fromRGB(255,248,250),UIStroke=Color3.fromRGB(210,180,190)}
			}
		}
	},
	Light = {
		Shadow = Color3.fromRGB(200,200,200),
		Background = Color3.fromRGB(242,242,242),
		Page = Color3.fromRGB(255,255,255),
		Main = Color3.fromRGB(0,120,215),
		['Text & Icon'] = Color3.fromRGB(25,25,25),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(246,246,246),
				True = {['Toggle Background']=Color3.fromRGB(0,120,215),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(215,215,215),['Toggle Value']=Color3.fromRGB(170,170,170)}
			},
			Label = {Background=Color3.fromRGB(246,246,246)},
			Dropdown = {
				Background=Color3.fromRGB(246,246,246),
				['Value Background']=Color3.fromRGB(255,255,255),
				['Value Stroke']=Color3.fromRGB(200,200,200),
				['Dropdown Select']={Background=Color3.fromRGB(255,255,255),Search=Color3.fromRGB(240,240,240),['Item Background']=Color3.fromRGB(246,246,246)}
			},
			Slider = {
				Background=Color3.fromRGB(246,246,246),
				['Value Background']=Color3.fromRGB(255,255,255),
				['Value Stroke']=Color3.fromRGB(200,200,200),
				['Slider Bar']=Color3.fromRGB(220,220,220),
				['Slider Bar Value']=Color3.fromRGB(0,120,215),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(246,246,246)),ColorSequenceKeypoint.new(1,Color3.fromRGB(246,246,246))},
				['Background Code']=Color3.fromRGB(238,245,252),
				['Background Code Value']=Color3.fromRGB(225,235,248),
				['ScrollingFrame Code']=Color3.fromRGB(80,120,160)
			},
			Button = {Background=Color3.fromRGB(246,246,246),Click=Color3.fromRGB(0,120,215)},
			Textbox = {Background=Color3.fromRGB(246,246,246),['Value Background']=Color3.fromRGB(255,255,255),['Value Stroke']=Color3.fromRGB(200,200,200)},
			Keybind = {
				Background=Color3.fromRGB(246,246,246),
				['Value Background']=Color3.fromRGB(255,255,255),
				['Value Stroke']=Color3.fromRGB(200,200,200),
				True={['Toggle Background']=Color3.fromRGB(0,120,215),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(215,215,215),['Toggle Value']=Color3.fromRGB(170,170,170)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(246,246,246),
				['Color Select']={Background=Color3.fromRGB(255,255,255),UIStroke=Color3.fromRGB(200,200,200)}
			}
		}
	},
	Ocean = {
		Shadow = Color3.fromRGB(40,70,100),
		Background = Color3.fromRGB(10,18,30),
		Page = Color3.fromRGB(14,24,40),
		Main = Color3.fromRGB(0,150,220),
		['Text & Icon'] = Color3.fromRGB(190,225,255),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(14,24,40),
				True = {['Toggle Background']=Color3.fromRGB(0,150,220),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(25,45,65),['Toggle Value']=Color3.fromRGB(60,100,140)}
			},
			Label = {Background=Color3.fromRGB(14,24,40)},
			Dropdown = {
				Background=Color3.fromRGB(14,24,40),
				['Value Background']=Color3.fromRGB(20,34,55),
				['Value Stroke']=Color3.fromRGB(0,90,140),
				['Dropdown Select']={Background=Color3.fromRGB(10,20,34),Search=Color3.fromRGB(18,30,48),['Item Background']=Color3.fromRGB(14,26,42)}
			},
			Slider = {
				Background=Color3.fromRGB(14,24,40),
				['Value Background']=Color3.fromRGB(20,34,55),
				['Value Stroke']=Color3.fromRGB(0,90,140),
				['Slider Bar']=Color3.fromRGB(20,40,60),
				['Slider Bar Value']=Color3.fromRGB(0,150,220),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(10,18,30)),ColorSequenceKeypoint.new(1,Color3.fromRGB(14,24,40))},
				['Background Code']=Color3.fromRGB(16,28,46),
				['Background Code Value']=Color3.fromRGB(20,34,55),
				['ScrollingFrame Code']=Color3.fromRGB(0,150,220)
			},
			Button = {Background=Color3.fromRGB(14,24,40),Click=Color3.fromRGB(0,150,220)},
			Textbox = {Background=Color3.fromRGB(14,24,40),['Value Background']=Color3.fromRGB(20,34,55),['Value Stroke']=Color3.fromRGB(0,90,140)},
			Keybind = {
				Background=Color3.fromRGB(14,24,40),
				['Value Background']=Color3.fromRGB(20,34,55),
				['Value Stroke']=Color3.fromRGB(0,90,140),
				True={['Toggle Background']=Color3.fromRGB(0,150,220),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(25,45,65),['Toggle Value']=Color3.fromRGB(60,100,140)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(14,24,40),
				['Color Select']={Background=Color3.fromRGB(20,34,55),UIStroke=Color3.fromRGB(0,90,140)}
			}
		}
	},
	Galaxy = {
		Shadow = Color3.fromRGB(30,0,50),
		Background = Color3.fromRGB(12,8,22),
		Page = Color3.fromRGB(18,12,32),
		Main = Color3.fromRGB(120,40,210),
		['Text & Icon'] = Color3.fromRGB(220,210,255),
		Function = {
			Toggle = {
				Background = Color3.fromRGB(18,12,32),
				True = {['Toggle Background']=Color3.fromRGB(120,40,210),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False = {['Toggle Background']=Color3.fromRGB(40,22,65),['Toggle Value']=Color3.fromRGB(90,70,130)}
			},
			Label = {Background=Color3.fromRGB(18,12,32)},
			Dropdown = {
				Background=Color3.fromRGB(18,12,32),
				['Value Background']=Color3.fromRGB(26,18,44),
				['Value Stroke']=Color3.fromRGB(80,40,130),
				['Dropdown Select']={Background=Color3.fromRGB(14,10,24),Search=Color3.fromRGB(22,16,38),['Item Background']=Color3.fromRGB(18,13,30)}
			},
			Slider = {
				Background=Color3.fromRGB(18,12,32),
				['Value Background']=Color3.fromRGB(26,18,44),
				['Value Stroke']=Color3.fromRGB(80,40,130),
				['Slider Bar']=Color3.fromRGB(35,20,58),
				['Slider Bar Value']=Color3.fromRGB(120,40,210),
				['Circle Value']=Color3.fromRGB(255,255,255)
			},
			Code = {
				Background=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(12,8,22)),ColorSequenceKeypoint.new(1,Color3.fromRGB(18,12,32))},
				['Background Code']=Color3.fromRGB(22,14,38),
				['Background Code Value']=Color3.fromRGB(28,18,48),
				['ScrollingFrame Code']=Color3.fromRGB(120,40,210)
			},
			Button = {Background=Color3.fromRGB(18,12,32),Click=Color3.fromRGB(120,40,210)},
			Textbox = {Background=Color3.fromRGB(18,12,32),['Value Background']=Color3.fromRGB(26,18,44),['Value Stroke']=Color3.fromRGB(80,40,130)},
			Keybind = {
				Background=Color3.fromRGB(18,12,32),
				['Value Background']=Color3.fromRGB(26,18,44),
				['Value Stroke']=Color3.fromRGB(80,40,130),
				True={['Toggle Background']=Color3.fromRGB(120,40,210),['Toggle Value']=Color3.fromRGB(255,255,255)},
				False={['Toggle Background']=Color3.fromRGB(40,22,65),['Toggle Value']=Color3.fromRGB(90,70,130)}
			},
			['Color Picker'] = {
				Background=Color3.fromRGB(18,12,32),
				['Color Select']={Background=Color3.fromRGB(26,18,44),UIStroke=Color3.fromRGB(80,40,130)}
			}
		}
	}
}

local RunService = game:GetService("RunService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CloverUI"
ScreenGui.Parent = not RunService:IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local UIS = game:GetService("UserInputService")
local TwS = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local function _addTheme(name, obj)
	if not _SaveTheme[name] then _SaveTheme[name] = {} end
	table.insert(_SaveTheme[name], obj)
end

local function _pathGet(tbl, path)
	local r = tbl
	for _, p in ipairs(string.split(path, ".")) do r = r and r[p] end
	return r
end

function CloverUI:setTheme(st)
	for name, objs in pairs(_SaveTheme) do
		local color = _pathGet(st, name)
		if color then
			for _, obj in pairs(objs) do
				if obj:IsA("Frame") or obj:IsA("CanvasGroup") then
					obj.BackgroundColor3 = color
				elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
					obj.TextColor3 = color
				elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
					obj.ImageColor3 = color
				elseif obj:IsA("ScrollingFrame") then
					obj.ScrollBarImageColor3 = color
				elseif obj:IsA("UIStroke") then
					obj.Color = color
				elseif obj:IsA("UIGradient") then
					obj.Color = color
				end
			end
		end
	end
end

local _IconList = loadstring(game:HttpGet('https://raw.githubusercontent.com/Dummyrme/Library/refs/heads/main/Icon.lua'))()

local function _gl(i)
	local iconData = _IconList.Icons[i]
	if iconData then
		local ss = _IconList.Spritesheets[tostring(iconData.Image)]
		if ss then return {Image=ss,ImageRectSize=iconData.ImageRectSize,ImageRectPosition=iconData.ImageRectPosition} end
	end
	if type(i)=='string' and not i:find('rbxassetid://') then
		return {Image="rbxassetid://"..i,ImageRectSize=Vector2.new(0,0),ImageRectPosition=Vector2.new(0,0)}
	elseif type(i)=='number' then
		return {Image="rbxassetid://"..i,ImageRectSize=Vector2.new(0,0),ImageRectPosition=Vector2.new(0,0)}
	else
		return i
	end
end

local function _tw(v, t, s, d, g)
	return TwS:Create(v, TweenInfo.new(t, s, Enum.EasingDirection[d]), g)
end

local function _cc(sf, ll, plus)
	ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sf.CanvasSize = UDim2.new(0,0,0, ll.AbsoluteContentSize.Y + (plus or 5))
	end)
end

local function _mkClick(p)
	local btn = Instance.new("TextButton")
	btn.BackgroundTransparency = 1
	btn.BorderSizePixel = 0
	btn.Size = UDim2.new(1,0,1,0)
	btn.Font = Enum.Font.SourceSans
	btn.Text = ""
	btn.TextColor3 = Color3.new()
	btn.TextSize = 14
	btn.Parent = p
	return btn
end

local function _mkCorner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 5)
	c.Parent = parent
	return c
end

local function _mkStroke(parent, color, thick, trans)
	local s = Instance.new("UIStroke")
	s.Color = color or Color3.fromRGB(60,60,60)
	s.Thickness = thick or 1
	s.Transparency = trans or 0.1
	s.Parent = parent
	return s
end

local function _ripple(container, cx, cy)
	local r = Instance.new("Frame")
	r.BackgroundColor3 = Color3.fromRGB(255,255,255)
	r.BackgroundTransparency = 0.75
	r.BorderSizePixel = 0
	r.AnchorPoint = Vector2.new(0.5,0.5)
	r.Position = UDim2.new(0, cx or container.AbsoluteSize.X/2, 0, cy or container.AbsoluteSize.Y/2)
	r.Size = UDim2.new(0,0,0,0)
	r.ZIndex = 10
	r.Parent = container
	_mkCorner(r, 999)
	local sz = math.max(container.AbsoluteSize.X, container.AbsoluteSize.Y) * 2
	local t = _tw(r, 0.5, Enum.EasingStyle.Quad, "Out", {Size=UDim2.new(0,sz,0,sz), BackgroundTransparency=1})
	t.Completed:Connect(function() r:Destroy() end)
	t:Play()
end

local function _drag(trigger, target)
	local dragging, startPos, startObj = false, nil, nil
	trigger.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startPos = i.Position
			startObj = target.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	trigger.InputChanged:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				local d = i.Position - startPos
				_tw(target, 0.05, Enum.EasingStyle.Linear, "InOut", {
					Position = UDim2.new(startObj.X.Scale, startObj.X.Offset + d.X, startObj.Y.Scale, startObj.Y.Offset + d.Y)
				}):Play()
			end
		end
	end)
end

local function _mkItemBg(parent, title, desc, icon, funcType)
	local wrap = Instance.new("Frame")
	wrap.BackgroundTransparency = 1
	wrap.BorderSizePixel = 0
	wrap.Size = UDim2.new(1,0,0,36)
	wrap.ClipsDescendants = true
	wrap.Parent = parent

	local bg = Instance.new("Frame")
	bg.BorderSizePixel = 0
	bg.Size = UDim2.new(1,0,1,0)
	bg.ClipsDescendants = true
	bg.Parent = wrap
	_mkCorner(bg, 5)
	_addTheme('Function.'..funcType..'.Background', bg)

	local stroke = _mkStroke(bg)
	stroke.Transparency = 0.85

	local inner = Instance.new("Frame")
	inner.AnchorPoint = Vector2.new(0,0.5)
	inner.BackgroundTransparency = 1
	inner.BorderSizePixel = 0
	inner.Position = UDim2.new(0,0,0.5,0)
	inner.Size = UDim2.new(1,0,1,0)
	inner.Parent = bg

	local ll = Instance.new("UIListLayout")
	ll.SortOrder = Enum.SortOrder.LayoutOrder
	ll.VerticalAlignment = Enum.VerticalAlignment.Center
	ll.Parent = inner

	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0,12)
	pad.PaddingRight = UDim.new(0,70)
	pad.Parent = inner

	local titleLbl = Instance.new("TextLabel")
	titleLbl.BackgroundTransparency = 1
	titleLbl.BorderSizePixel = 0
	titleLbl.LayoutOrder = 2
	titleLbl.Size = UDim2.new(1,0,0,15)
	titleLbl.Font = Enum.Font.BuilderSansBold
	titleLbl.RichText = true
	titleLbl.Text = tostring(title)
	titleLbl.TextColor3 = Color3.fromRGB(230,230,230)
	titleLbl.TextSize = 12
	titleLbl.TextTransparency = 0.7
	titleLbl.TextWrapped = true
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.AutomaticSize = Enum.AutomaticSize.Y
	titleLbl.Name = 'Title'
	titleLbl.Parent = inner
	_addTheme('Text & Icon', titleLbl)

	local descLbl = Instance.new("TextLabel")
	descLbl.BackgroundTransparency = 1
	descLbl.BorderSizePixel = 0
	descLbl.LayoutOrder = 1
	descLbl.Size = UDim2.new(1,0,0,11)
	descLbl.Font = Enum.Font.BuilderSans
	descLbl.RichText = true
	descLbl.Text = tostring(desc)
	descLbl.TextColor3 = Color3.fromRGB(230,230,230)
	descLbl.TextSize = 10
	descLbl.TextTransparency = 0.5
	descLbl.TextWrapped = true
	descLbl.TextXAlignment = Enum.TextXAlignment.Left
	descLbl.Visible = desc and desc ~= ""
	descLbl.AutomaticSize = Enum.AutomaticSize.Y
	descLbl.Name = 'Desc'
	descLbl.Parent = inner
	_addTheme('Text & Icon', descLbl)

	if icon and icon ~= "" then
		pad.PaddingLeft = UDim.new(0,46)
		local iconWrap = Instance.new("Frame")
		iconWrap.BackgroundTransparency = 1
		iconWrap.BorderSizePixel = 0
		iconWrap.Size = UDim2.new(0,38,1,0)
		iconWrap.Parent = bg

		local ico = Instance.new("ImageLabel")
		ico.AnchorPoint = Vector2.new(0.5,0.5)
		ico.BackgroundTransparency = 1
		ico.BorderSizePixel = 0
		ico.Position = UDim2.new(0.5,0,0.5,0)
		ico.Size = UDim2.new(0,18,0,18)
		ico.Image = _gl(icon).Image
		ico.ImageRectSize = _gl(icon).ImageRectSize
		ico.ImageRectOffset = _gl(icon).ImageRectPosition
		ico.ImageTransparency = 0.5
		ico.Name = 'Icon'
		ico.Parent = iconWrap
		_addTheme('Text & Icon', ico)

		local sep = Instance.new("Frame")
		sep.AnchorPoint = Vector2.new(1,0.5)
		sep.BackgroundTransparency = 0.85
		sep.BorderSizePixel = 0
		sep.Position = UDim2.new(1,0,0.5,0)
		sep.Size = UDim2.new(0,1,0.65,0)
		sep.Parent = iconWrap
		_addTheme('Text & Icon', sep)
	end

	local function updateHeight()
		task.defer(function()
			local h = ll.AbsoluteContentSize.Y + 18
			if wrap.Size.Y.Offset ~= h then wrap.Size = UDim2.new(1,0,0,h) end
		end)
	end

	task.delay(0.1, updateHeight)
	ll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateHeight)

	local api = {}
	function api:SetTitle(v) titleLbl.Text = tostring(v) end
	function api:SetDesc(v)
		descLbl.Text = tostring(v)
		descLbl.Visible = v and v ~= ""
	end
	function api:SetTextTransparencyTitle(v)
		_tw(titleLbl, 0.12, Enum.EasingStyle.Quart, "Out", {TextTransparency=v}):Play()
		if icon and icon ~= "" and bg:FindFirstChild('Frame') then
			_tw(bg.Frame.Icon, 0.12, Enum.EasingStyle.Quart, "Out", {ImageTransparency=v}):Play()
		end
	end
	function api:SetRightPad(v) pad.PaddingRight = UDim.new(0, v) end
	function api:GetBg() return bg end

	return bg, api
end

local function _mkDropdownLogic(parent, isMulti, callback, defaultVal, list)
	local F = Instance.new("Frame")
	F.AnchorPoint = Vector2.new(1,0.5)
	F.BackgroundTransparency = 1
	F.BorderSizePixel = 0
	F.Position = UDim2.new(1,0,0.5,0)
	F.Size = UDim2.new(0,115,0.8,0)
	F.Parent = parent

	local ll = Instance.new("UIListLayout")
	ll.FillDirection = Enum.FillDirection.Horizontal
	ll.HorizontalAlignment = Enum.HorizontalAlignment.Right
	ll.VerticalAlignment = Enum.VerticalAlignment.Center
	ll.SortOrder = Enum.SortOrder.LayoutOrder
	ll.Parent = F

	local pad = Instance.new("UIPadding")
	pad.PaddingRight = UDim.new(0,12)
	pad.Parent = F

	local valBox = Instance.new("Frame")
	valBox.BorderSizePixel = 0
	valBox.Size = UDim2.new(0,95,0,20)
	valBox.Parent = F
	_mkCorner(valBox, 4)
	local vs = _mkStroke(valBox)
	vs.Transparency = 0.7
	_addTheme('Function.Dropdown.Value Background', valBox)
	_addTheme('Function.Dropdown.Value Stroke', vs)

	local valLbl = Instance.new("TextLabel")
	valLbl.BackgroundTransparency = 1
	valLbl.BorderSizePixel = 0
	valLbl.Size = UDim2.new(0.82,0,1,0)
	valLbl.Font = Enum.Font.BuilderSansBold
	valLbl.RichText = true
	valLbl.Text = "--"
	valLbl.TextColor3 = Color3.fromRGB(230,230,230)
	valLbl.TextSize = 10
	valLbl.TextTransparency = 0.3
	valLbl.TextXAlignment = Enum.TextXAlignment.Left
	valLbl.Parent = valBox
	local valPad = Instance.new("UIPadding")
	valPad.PaddingLeft = UDim.new(0,6)
	valPad.Parent = valBox
	_addTheme('Text & Icon', valLbl)

	local arrow = Instance.new("ImageLabel")
	arrow.AnchorPoint = Vector2.new(1,0.5)
	arrow.BackgroundTransparency = 1
	arrow.BorderSizePixel = 0
	arrow.Position = UDim2.new(1,-5,0.5,0)
	arrow.Size = UDim2.new(0,10,0,10)
	arrow.Image = "rbxassetid://7072706663"
	arrow.ImageTransparency = 0.5
	arrow.Parent = valBox
	_addTheme('Text & Icon', arrow)

	local open = false
	local selectedVal = isMulti and {} or nil
	local dropFrame = nil

	if isMulti and type(defaultVal) == "table" then
		selectedVal = {}
		for _, v in ipairs(defaultVal) do selectedVal[v] = true end
		local parts = {}
		for k in pairs(selectedVal) do table.insert(parts, k) end
		valLbl.Text = #parts > 0 and table.concat(parts, ", ") or "--"
	elseif not isMulti and defaultVal then
		valLbl.Text = tostring(defaultVal)
	end

	local itemsApi = {}

	local function closeDropdown()
		if dropFrame then
			_tw(dropFrame, 0.12, Enum.EasingStyle.Quart, "Out", {Size=UDim2.new(1,0,0,0), BackgroundTransparency=1}):Play()
			task.delay(0.15, function() if dropFrame then dropFrame:Destroy() dropFrame = nil end end)
			_tw(arrow, 0.12, Enum.EasingStyle.Quart, "Out", {Rotation=0}):Play()
			open = false
		end
	end

	local function buildDropdown()
		if dropFrame then closeDropdown() return end
		open = true
		local parentPage = parent
		while parentPage and not parentPage:IsA("ScrollingFrame") do parentPage = parentPage.Parent end
		if not parentPage then return end

		dropFrame = Instance.new("Frame")
		dropFrame.BorderSizePixel = 0
		dropFrame.Size = UDim2.new(1,0,0,0)
		dropFrame.BackgroundTransparency = 0
		dropFrame.ZIndex = 5
		dropFrame.ClipsDescendants = true
		dropFrame.Parent = parentPage:FindFirstAncestorWhichIsA("Frame") or parentPage.Parent
		_mkCorner(dropFrame, 5)
		_mkStroke(dropFrame, nil, 1, 0.8)
		_addTheme('Function.Dropdown.Dropdown Select.Background', dropFrame)

		local absPos = valBox.AbsolutePosition
		local absSize = valBox.AbsoluteSize
		local parentAbs = dropFrame.Parent.AbsolutePosition
		dropFrame.Position = UDim2.new(0, absPos.X - parentAbs.X, 0, absPos.Y - parentAbs.Y + absSize.Y + 3)
		dropFrame.Size = UDim2.new(0, math.max(absSize.X, 120), 0, 0)

		local searchBox = Instance.new("TextBox")
		searchBox.BackgroundTransparency = 1
		searchBox.BorderSizePixel = 0
		searchBox.Size = UDim2.new(1,0,0,24)
		searchBox.Font = Enum.Font.BuilderSans
		searchBox.PlaceholderText = "Search..."
		searchBox.PlaceholderColor3 = Color3.fromRGB(130,130,130)
		searchBox.Text = ""
		searchBox.TextColor3 = Color3.fromRGB(220,220,220)
		searchBox.TextSize = 10
		searchBox.ClearTextOnFocus = false
		searchBox.ZIndex = 6
		searchBox.Parent = dropFrame
		local sPad = Instance.new("UIPadding")
		sPad.PaddingLeft = UDim.new(0,8)
		sPad.Parent = searchBox
		_addTheme('Function.Dropdown.Dropdown Select.Search', searchBox)

		local sf = Instance.new("ScrollingFrame")
		sf.BackgroundTransparency = 1
		sf.BorderSizePixel = 0
		sf.Size = UDim2.new(1,0,1,-26)
		sf.Position = UDim2.new(0,0,0,26)
		sf.ScrollBarThickness = 2
		sf.ScrollBarImageColor3 = Color3.fromRGB(120,120,120)
		sf.CanvasSize = UDim2.new(0,0,0,0)
		sf.ZIndex = 6
		sf.Parent = dropFrame

		local sfLL = Instance.new("UIListLayout")
		sfLL.SortOrder = Enum.SortOrder.LayoutOrder
		sfLL.Parent = sf
		_cc(sf, sfLL, 4)

		local function mkItem(v)
			local item = Instance.new("Frame")
			item.BackgroundTransparency = 1
			item.BorderSizePixel = 0
			item.Size = UDim2.new(1,0,0,22)
			item.ZIndex = 6
			item.Parent = sf
			_addTheme('Function.Dropdown.Dropdown Select.Item Background', item)

			local lbl = Instance.new("TextLabel")
			lbl.BackgroundTransparency = 1
			lbl.BorderSizePixel = 0
			lbl.Size = UDim2.new(1,0,1,0)
			lbl.Font = Enum.Font.BuilderSans
			lbl.Text = tostring(v)
			lbl.TextColor3 = Color3.fromRGB(220,220,220)
			lbl.TextSize = 10
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.ZIndex = 7
			lbl.Parent = item
			local lp = Instance.new("UIPadding")
			lp.PaddingLeft = UDim.new(0,8)
			lp.Parent = lbl
			_addTheme('Text & Icon', lbl)

			local selected = isMulti and selectedVal[v] or (not isMulti and valLbl.Text == v)
			lbl.TextTransparency = selected and 0 or 0.5

			local ib = _mkClick(item)
			ib.ZIndex = 8
			ib.MouseButton1Click:Connect(function()
				if isMulti then
					selectedVal[v] = not selectedVal[v]
					lbl.TextTransparency = selectedVal[v] and 0 or 0.5
					local parts = {}
					for k in pairs(selectedVal) do table.insert(parts, k) end
					valLbl.Text = #parts > 0 and table.concat(parts, ", ") or "--"
					pcall(callback, selectedVal)
				else
					for _, c in ipairs(sf:GetChildren()) do
						if c:IsA("Frame") and c:FindFirstChildOfClass("TextLabel") then
							c:FindFirstChildOfClass("TextLabel").TextTransparency = 0.5
						end
					end
					lbl.TextTransparency = 0
					valLbl.Text = v
					pcall(callback, v)
					closeDropdown()
				end
			end)
			return item, lbl
		end

		local itemRefs = {}
		for _, v in ipairs(list) do
			local it, lb = mkItem(v)
			table.insert(itemRefs, {frame=it, lbl=lb, val=tostring(v)})
		end

		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			local q = searchBox.Text:lower()
			for _, ref in ipairs(itemRefs) do
				ref.frame.Visible = q == "" or ref.val:lower():find(q, 1, true) ~= nil
			end
		end)

		local targetH = math.min(#list * 22 + 30, 140)
		_tw(dropFrame, 0.15, Enum.EasingStyle.Quart, "Out", {Size=UDim2.new(0, math.max(valBox.AbsoluteSize.X,120), 0, targetH)}):Play()
		_tw(arrow, 0.12, Enum.EasingStyle.Quart, "Out", {Rotation=180}):Play()
	end

	local clickBtn = _mkClick(valBox)
	clickBtn.MouseButton1Click:Connect(buildDropdown)

	UIS.InputBegan:Connect(function(i, gp)
		if not gp and i.UserInputType == Enum.UserInputType.MouseButton1 then
			if dropFrame and not valBox:IsAncestorOf(i.Target) and dropFrame ~= i.Target and not dropFrame:IsAncestorOf(i.Target) then
				closeDropdown()
			end
		end
	end)

	function itemsApi:SetValue(v)
		if isMulti then
			selectedVal = {}
			if type(v) == "table" then
				for _, k in ipairs(v) do selectedVal[k] = true end
			end
			local parts = {}
			for k in pairs(selectedVal) do table.insert(parts, k) end
			valLbl.Text = #parts > 0 and table.concat(parts, ", ") or "--"
		else
			valLbl.Text = tostring(v)
		end
		pcall(callback, v)
	end

	return itemsApi, valBox
end

function CloverUI:Window(p)
	local Title = p.Title or 'CloverUI'
	local Desc = p.Desc or ''
	local Icon = p.Icon or 'leaf'
	local Theme = p.Theme or 'Clover'
	local Keybind = (p.Config and p.Config.Keybind) or Enum.KeyCode.LeftControl
	local Size = (p.Config and p.Config.Size) or UDim2.new(0,550,0,420)

	local IsTheme = Theme
	local firstOpen = true

	getgenv().CloverSettings = getgenv().CloverSettings or {}

	local shadow = Instance.new("Frame")
	shadow.Name = "CloverShadow"
	shadow.AnchorPoint = Vector2.new(0.5,0.5)
	shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
	shadow.BackgroundTransparency = 0.5
	shadow.BorderSizePixel = 0
	shadow.Position = UDim2.new(0.5,0,0.5,0)
	shadow.Size = Size + UDim2.fromOffset(14,14)
	shadow.Visible = false
	shadow.Parent = ScreenGui
	_mkCorner(shadow, 10)

	local mainBg = Instance.new("Frame")
	mainBg.Name = "MainBg"
	mainBg.AnchorPoint = Vector2.new(0.5,0.5)
	mainBg.BorderSizePixel = 0
	mainBg.Position = UDim2.new(0.5,0,0.5,0)
	mainBg.Size = Size
	mainBg.ClipsDescendants = false
	mainBg.Parent = shadow
	_mkCorner(mainBg, 8)
	local outerStroke = _mkStroke(mainBg, nil, 1, 0.1)
	_addTheme('Background', mainBg)
	_addTheme('Text & Icon', outerStroke)

	shadow.Size = Size + UDim2.fromOffset(14,14)
	shadow.Visible = true
	mainBg.Size = Size - UDim2.fromOffset(8,8)
	_tw(mainBg, 0.18, Enum.EasingStyle.Quart, "Out", {Size=Size}):Play()

	local sidebar = Instance.new("Frame")
	sidebar.Name = "Sidebar"
	sidebar.BorderSizePixel = 0
	sidebar.Size = UDim2.new(0,118,1,0)
	sidebar.ClipsDescendants = true
	sidebar.Parent = mainBg
	_mkCorner(sidebar, 8)
	_addTheme('Page', sidebar)

	local sideStroke = _mkStroke(sidebar, nil, 1, 0.15)
	_addTheme('Text & Icon', sideStroke)

	local sideTopbar = Instance.new("Frame")
	sideTopbar.BackgroundTransparency = 1
	sideTopbar.BorderSizePixel = 0
	sideTopbar.Size = UDim2.new(1,0,0,48)
	sideTopbar.Parent = sidebar

	local sideIcon = Instance.new("ImageLabel")
	sideIcon.AnchorPoint = Vector2.new(0,0.5)
	sideIcon.BackgroundTransparency = 1
	sideIcon.BorderSizePixel = 0
	sideIcon.Position = UDim2.new(0,10,0.5,0)
	sideIcon.Size = UDim2.new(0,18,0,18)
	local gi = _gl(Icon)
	sideIcon.Image = gi.Image
	sideIcon.ImageRectSize = gi.ImageRectSize
	sideIcon.ImageRectOffset = gi.ImageRectPosition
	sideIcon.ImageTransparency = 0.2
	sideIcon.Parent = sideTopbar
	_addTheme('Text & Icon', sideIcon)

	local sideTitleLbl = Instance.new("TextLabel")
	sideTitleLbl.AnchorPoint = Vector2.new(0,0.5)
	sideTitleLbl.BackgroundTransparency = 1
	sideTitleLbl.BorderSizePixel = 0
	sideTitleLbl.Position = UDim2.new(0,34,0.5,0)
	sideTitleLbl.Size = UDim2.new(1,-34,0,14)
	sideTitleLbl.Font = Enum.Font.BuilderSansBold
	sideTitleLbl.Text = Title
	sideTitleLbl.TextColor3 = Color3.fromRGB(230,230,230)
	sideTitleLbl.TextSize = 13
	sideTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
	sideTitleLbl.Parent = sideTopbar
	_addTheme('Text & Icon', sideTitleLbl)

	local sideDivider = Instance.new("Frame")
	sideDivider.AnchorPoint = Vector2.new(0,1)
	sideDivider.BorderSizePixel = 0
	sideDivider.BackgroundTransparency = 0.85
	sideDivider.Position = UDim2.new(0,0,1,0)
	sideDivider.Size = UDim2.new(1,0,0,1)
	sideDivider.Parent = sideTopbar
	_addTheme('Text & Icon', sideDivider)

	local searchWrap = Instance.new("Frame")
	searchWrap.BackgroundTransparency = 1
	searchWrap.BorderSizePixel = 0
	searchWrap.Position = UDim2.new(0,0,0,50)
	searchWrap.Size = UDim2.new(1,0,0,28)
	searchWrap.Parent = sidebar

	local searchBg = Instance.new("Frame")
	searchBg.AnchorPoint = Vector2.new(0.5,0.5)
	searchBg.BorderSizePixel = 0
	searchBg.Position = UDim2.new(0.5,0,0.5,0)
	searchBg.Size = UDim2.new(1,-16,0,22)
	searchBg.Parent = searchWrap
	_mkCorner(searchBg, 4)
	_mkStroke(searchBg, nil, 1, 0.75)
	_addTheme('Background', searchBg)

	local searchBox = Instance.new("TextBox")
	searchBox.BackgroundTransparency = 1
	searchBox.BorderSizePixel = 0
	searchBox.Size = UDim2.new(1,-24,1,0)
	searchBox.Position = UDim2.new(0,22,0,0)
	searchBox.Font = Enum.Font.BuilderSans
	searchBox.PlaceholderText = "Search tabs..."
	searchBox.PlaceholderColor3 = Color3.fromRGB(100,100,100)
	searchBox.Text = ""
	searchBox.TextColor3 = Color3.fromRGB(200,200,200)
	searchBox.TextSize = 10
	searchBox.ClearTextOnFocus = false
	searchBox.Parent = searchBg
	_addTheme('Text & Icon', searchBox)

	local searchIcon = Instance.new("ImageLabel")
	searchIcon.AnchorPoint = Vector2.new(0,0.5)
	searchIcon.BackgroundTransparency = 1
	searchIcon.BorderSizePixel = 0
	searchIcon.Position = UDim2.new(0,5,0.5,0)
	searchIcon.Size = UDim2.new(0,13,0,13)
	searchIcon.Image = _gl('search').Image
	searchIcon.ImageRectSize = _gl('search').ImageRectSize
	searchIcon.ImageRectOffset = _gl('search').ImageRectPosition
	searchIcon.ImageTransparency = 0.5
	searchIcon.Parent = searchBg
	_addTheme('Text & Icon', searchIcon)

	local tabScroll = Instance.new("ScrollingFrame")
	tabScroll.BackgroundTransparency = 1
	tabScroll.BorderSizePixel = 0
	tabScroll.Position = UDim2.new(0,0,0,80)
	tabScroll.Size = UDim2.new(1,0,1,-88)
	tabScroll.ScrollBarThickness = 2
	tabScroll.ScrollBarImageColor3 = Color3.fromRGB(120,120,120)
	tabScroll.CanvasSize = UDim2.new(0,0,0,0)
	tabScroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	tabScroll.Parent = sidebar
	_addTheme('Main', tabScroll)

	local tabList = Instance.new("Frame")
	tabList.BackgroundTransparency = 1
	tabList.BorderSizePixel = 0
	tabList.Size = UDim2.new(1,0,1,0)
	tabList.Parent = tabScroll

	local tabLL = Instance.new("UIListLayout")
	tabLL.SortOrder = Enum.SortOrder.LayoutOrder
	tabLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tabLL.Padding = UDim.new(0,2)
	tabLL.Parent = tabList
	_cc(tabScroll, tabLL, 5)

	local selBar = Instance.new("Frame")
	selBar.AnchorPoint = Vector2.new(1,0.5)
	selBar.BorderSizePixel = 0
	selBar.Position = UDim2.new(0,3,0,20)
	selBar.Size = UDim2.new(0,3,0,16)
	selBar.Parent = tabScroll
	_mkCorner(selBar, 99)
	_addTheme('Main', selBar)

	local contentArea = Instance.new("Frame")
	contentArea.BackgroundTransparency = 1
	contentArea.BorderSizePixel = 0
	contentArea.Position = UDim2.new(0,120,0,0)
	contentArea.Size = UDim2.new(1,-120,1,0)
	contentArea.Parent = mainBg

	local topbar = Instance.new("Frame")
	topbar.BackgroundTransparency = 1
	topbar.BorderSizePixel = 0
	topbar.Size = UDim2.new(1,0,0,40)
	topbar.Parent = contentArea

	local topDivider = Instance.new("Frame")
	topDivider.AnchorPoint = Vector2.new(0,1)
	topDivider.BackgroundTransparency = 0.85
	topDivider.BorderSizePixel = 0
	topDivider.Position = UDim2.new(0,0,1,0)
	topDivider.Size = UDim2.new(1,0,0,1)
	topDivider.Parent = topbar
	_addTheme('Text & Icon', topDivider)

	local ctrlWrap = Instance.new("Frame")
	ctrlWrap.BackgroundTransparency = 1
	ctrlWrap.BorderSizePixel = 0
	ctrlWrap.AnchorPoint = Vector2.new(1,0.5)
	ctrlWrap.Position = UDim2.new(1,-10,0.5,0)
	ctrlWrap.Size = UDim2.new(0,80,0,20)
	ctrlWrap.Parent = topbar

	local ctrlLL = Instance.new("UIListLayout")
	ctrlLL.FillDirection = Enum.FillDirection.Horizontal
	ctrlLL.HorizontalAlignment = Enum.HorizontalAlignment.Right
	ctrlLL.VerticalAlignment = Enum.VerticalAlignment.Center
	ctrlLL.Padding = UDim.new(0,8)
	ctrlLL.Parent = ctrlWrap

	local function mkCtrlBtn(imgId, order)
		local btn = Instance.new("ImageButton")
		btn.BackgroundTransparency = 1
		btn.BorderSizePixel = 0
		btn.LayoutOrder = order
		btn.Size = UDim2.new(0,14,0,14)
		btn.Image = imgId
		btn.ImageTransparency = 0.45
		btn.Parent = ctrlWrap
		_addTheme('Text & Icon', btn)
		return btn
	end

	local minimizeBtn = mkCtrlBtn("rbxassetid://13857987062", 1)
	local closeBtn = mkCtrlBtn("rbxassetid://15082305656", 2)

	local themeDropWrap = Instance.new("Frame")
	themeDropWrap.BackgroundTransparency = 1
	themeDropWrap.BorderSizePixel = 0
	themeDropWrap.AnchorPoint = Vector2.new(1,0.5)
	themeDropWrap.Position = UDim2.new(0.45,0,0.5,0)
	themeDropWrap.Size = UDim2.new(0,110,0,24)
	themeDropWrap.Parent = topbar

	local pageHolder = Instance.new("Frame")
	pageHolder.BackgroundTransparency = 1
	pageHolder.BorderSizePixel = 0
	pageHolder.Position = UDim2.new(0,0,0,42)
	pageHolder.Size = UDim2.new(1,0,1,-42)
	pageHolder.ClipsDescendants = true
	pageHolder.Parent = contentArea

	local Tabs = {_list={}, _defaultIdx=1, _selected=false}

	function Tabs:SelectTab(idx) self._defaultIdx = idx or 1 end

	function Tabs:Line()
		local lw = Instance.new("Frame")
		lw.BackgroundTransparency = 1
		lw.BorderSizePixel = 0
		lw.Size = UDim2.new(1,0,0,8)
		lw.Name = "Line"
		lw.Parent = tabList
		local ln = Instance.new("Frame")
		ln.AnchorPoint = Vector2.new(0.5,0.5)
		ln.BackgroundTransparency = 0.85
		ln.BorderSizePixel = 0
		ln.Position = UDim2.new(0.5,0,0.5,0)
		ln.Size = UDim2.new(0.8,0,0,1)
		ln.Parent = lw
		_addTheme('Text & Icon', ln)
	end

	function Tabs:Notify(p)
		local nTitle = p.Title or ''
		local nDesc = p.Desc or ''
		local nTime = p.Time or 5

		local notif = Instance.new("Frame")
		notif.BackgroundTransparency = 1
		notif.BorderSizePixel = 0
		notif.AnchorPoint = Vector2.new(1,1)
		notif.Position = UDim2.new(1,-10,1,-10)
		notif.Size = UDim2.new(0,220,0,0)
		notif.ClipsDescendants = true
		notif.ZIndex = 20
		notif.Parent = ScreenGui

		local nb = Instance.new("Frame")
		nb.BorderSizePixel = 0
		nb.Size = UDim2.new(1,0,1,0)
		nb.ZIndex = 20
		nb.Parent = notif
		_mkCorner(nb, 6)
		_mkStroke(nb, nil, 1, 0.1)
		_addTheme('Background', nb)

		local nbPad = Instance.new("UIPadding")
		nbPad.PaddingLeft = UDim.new(0,10)
		nbPad.PaddingRight = UDim.new(0,10)
		nbPad.PaddingTop = UDim.new(0,8)
		nbPad.PaddingBottom = UDim.new(0,8)
		nbPad.Parent = nb

		local nLL = Instance.new("UIListLayout")
		nLL.SortOrder = Enum.SortOrder.LayoutOrder
		nLL.Padding = UDim.new(0,3)
		nLL.Parent = nb

		local nTL = Instance.new("TextLabel")
		nTL.BackgroundTransparency = 1
		nTL.BorderSizePixel = 0
		nTL.Size = UDim2.new(1,0,0,14)
		nTL.Font = Enum.Font.BuilderSansBold
		nTL.RichText = true
		nTL.Text = nTitle
		nTL.TextColor3 = Color3.fromRGB(230,230,230)
		nTL.TextSize = 12
		nTL.TextXAlignment = Enum.TextXAlignment.Left
		nTL.ZIndex = 21
		nTL.AutomaticSize = Enum.AutomaticSize.Y
		nTL.Parent = nb
		_addTheme('Text & Icon', nTL)

		local nDL = Instance.new("TextLabel")
		nDL.BackgroundTransparency = 1
		nDL.BorderSizePixel = 0
		nDL.Size = UDim2.new(1,0,0,11)
		nDL.Font = Enum.Font.BuilderSans
		nDL.RichText = true
		nDL.Text = nDesc
		nDL.TextColor3 = Color3.fromRGB(200,200,200)
		nDL.TextSize = 10
		nDL.TextTransparency = 0.3
		nDL.TextXAlignment = Enum.TextXAlignment.Left
		nDL.ZIndex = 21
		nDL.AutomaticSize = Enum.AutomaticSize.Y
		nDL.Parent = nb
		_addTheme('Text & Icon', nDL)

		task.defer(function()
			local h = nLL.AbsoluteContentSize.Y + 20
			notif.Size = UDim2.new(0,220,0,h)
			_tw(notif, 0.18, Enum.EasingStyle.Quart, "Out", {BackgroundTransparency=0}):Play()
			task.delay(nTime, function()
				_tw(notif, 0.18, Enum.EasingStyle.Quart, "In", {Size=UDim2.new(0,220,0,0), BackgroundTransparency=1}):Play()
				task.delay(0.22, function() notif:Destroy() end)
			end)
		end)
	end

	function Tabs:Dialog(p)
		local dTitle = p.Title or 'Dialog'
		local b1 = p.Button1 or {}
		local b2 = p.Button2 or {}

		local overlay = Instance.new("Frame")
		overlay.BackgroundTransparency = 0.5
		overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
		overlay.BorderSizePixel = 0
		overlay.Size = UDim2.new(1,0,1,0)
		overlay.ZIndex = 30
		overlay.Parent = ScreenGui

		local dBox = Instance.new("Frame")
		dBox.AnchorPoint = Vector2.new(0.5,0.5)
		dBox.BorderSizePixel = 0
		dBox.Position = UDim2.new(0.5,0,0.5,0)
		dBox.Size = UDim2.new(0,260,0,100)
		dBox.ZIndex = 31
		dBox.Parent = overlay
		_mkCorner(dBox, 7)
		_mkStroke(dBox, nil, 1, 0.1)
		_addTheme('Background', dBox)

		local dPad = Instance.new("UIPadding")
		dPad.PaddingLeft = UDim.new(0,14)
		dPad.PaddingRight = UDim.new(0,14)
		dPad.PaddingTop = UDim.new(0,12)
		dPad.PaddingBottom = UDim.new(0,12)
		dPad.Parent = dBox

		local dLL = Instance.new("UIListLayout")
		dLL.SortOrder = Enum.SortOrder.LayoutOrder
		dLL.Padding = UDim.new(0,10)
		dLL.VerticalAlignment = Enum.VerticalAlignment.Center
		dLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
		dLL.Parent = dBox

		local dTL = Instance.new("TextLabel")
		dTL.BackgroundTransparency = 1
		dTL.BorderSizePixel = 0
		dTL.Size = UDim2.new(1,0,0,30)
		dTL.Font = Enum.Font.BuilderSansBold
		dTL.RichText = true
		dTL.Text = dTitle
		dTL.TextColor3 = Color3.fromRGB(230,230,230)
		dTL.TextSize = 12
		dTL.TextWrapped = true
		dTL.ZIndex = 32
		dTL.AutomaticSize = Enum.AutomaticSize.Y
		dTL.Parent = dBox
		_addTheme('Text & Icon', dTL)

		local bRow = Instance.new("Frame")
		bRow.BackgroundTransparency = 1
		bRow.BorderSizePixel = 0
		bRow.Size = UDim2.new(1,0,0,26)
		bRow.ZIndex = 32
		bRow.Parent = dBox
		local bRowLL = Instance.new("UIListLayout")
		bRowLL.FillDirection = Enum.FillDirection.Horizontal
		bRowLL.HorizontalAlignment = Enum.HorizontalAlignment.Center
		bRowLL.VerticalAlignment = Enum.VerticalAlignment.Center
		bRowLL.Padding = UDim.new(0,10)
		bRowLL.Parent = bRow

		local function mkDialogBtn(cfg, isConfirm)
			if not cfg or not cfg.Title then return end
			local bb = Instance.new("TextButton")
			bb.BackgroundColor3 = cfg.Color or Color3.fromRGB(60,60,60)
			bb.BorderSizePixel = 0
			bb.Size = UDim2.new(0,90,0,24)
			bb.Font = Enum.Font.BuilderSansBold
			bb.Text = cfg.Title
			bb.TextColor3 = Color3.fromRGB(255,255,255)
			bb.TextSize = 11
			bb.ZIndex = 33
			bb.Parent = bRow
			_mkCorner(bb, 4)
			bb.MouseButton1Click:Connect(function()
				if cfg.Callback then pcall(cfg.Callback) end
				overlay:Destroy()
			end)
		end

		mkDialogBtn(b1, true)
		mkDialogBtn(b2, false)
	end

	function Tabs:Tab(p)
		local tabTitle = p.Title or 'Tab'
		local tabIcon = p.Icon or 'circle'

		local tabBtn = Instance.new("Frame")
		tabBtn.BackgroundTransparency = 1
		tabBtn.BorderSizePixel = 0
		tabBtn.Size = UDim2.new(1,0,0,30)
		tabBtn.Parent = tabList

		local tabInner = Instance.new("Frame")
		tabInner.BackgroundTransparency = 1
		tabInner.BorderSizePixel = 0
		tabInner.Size = UDim2.new(1,0,1,0)
		tabInner.Parent = tabBtn

		local tabIconImg = Instance.new("ImageLabel")
		tabIconImg.BackgroundTransparency = 1
		tabIconImg.BorderSizePixel = 0
		tabIconImg.AnchorPoint = Vector2.new(0,0.5)
		tabIconImg.Position = UDim2.new(0,10,0.5,0)
		tabIconImg.Size = UDim2.new(0,14,0,14)
		local ti = _gl(tabIcon)
		tabIconImg.Image = ti.Image
		tabIconImg.ImageRectSize = ti.ImageRectSize
		tabIconImg.ImageRectOffset = ti.ImageRectPosition
		tabIconImg.ImageTransparency = 0.6
		tabIconImg.Parent = tabInner
		_addTheme('Text & Icon', tabIconImg)

		local tabTitleLbl = Instance.new("TextLabel")
		tabTitleLbl.BackgroundTransparency = 1
		tabTitleLbl.BorderSizePixel = 0
		tabTitleLbl.AnchorPoint = Vector2.new(0,0.5)
		tabTitleLbl.Position = UDim2.new(0,30,0.5,0)
		tabTitleLbl.Size = UDim2.new(1,-32,0,14)
		tabTitleLbl.Font = Enum.Font.BuilderSansBold
		tabTitleLbl.Text = tostring(tabTitle)
		tabTitleLbl.TextColor3 = Color3.fromRGB(230,230,230)
		tabTitleLbl.TextSize = 11
		tabTitleLbl.TextTransparency = 0.65
		tabTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
		tabTitleLbl.TextWrapped = true
		tabTitleLbl.Parent = tabInner
		_addTheme('Text & Icon', tabTitleLbl)

		local page = Instance.new("Frame")
		page.BackgroundTransparency = 1
		page.BorderSizePixel = 0
		page.Size = UDim2.new(1,0,1,0)
		page.Visible = false
		page.Parent = pageHolder

		local sf = Instance.new("ScrollingFrame")
		sf.BackgroundTransparency = 1
		sf.BorderSizePixel = 0
		sf.Size = UDim2.new(1,0,1,0)
		sf.ScrollBarThickness = 2
		sf.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)
		sf.CanvasSize = UDim2.new(0,0,0,0)
		sf.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		sf.Parent = page

		local sfLL = Instance.new("UIListLayout")
		sfLL.SortOrder = Enum.SortOrder.LayoutOrder
		sfLL.Padding = UDim.new(0,4)
		sfLL.Parent = sf

		local sfPad = Instance.new("UIPadding")
		sfPad.PaddingLeft = UDim.new(0,8)
		sfPad.PaddingRight = UDim.new(0,8)
		sfPad.PaddingTop = UDim.new(0,6)
		sfPad.PaddingBottom = UDim.new(0,8)
		sfPad.Parent = sf
		_cc(sf, sfLL, 10)

		local clickBtn = _mkClick(tabBtn)

		table.insert(self._list, {page=page, btn=tabBtn, titleLbl=tabTitleLbl, iconImg=tabIconImg})
		local myIdx = #self._list

		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			local q = searchBox.Text:lower()
			tabBtn.Visible = q == "" or tabTitle:lower():find(q, 1, true) ~= nil
		end)

		local function selectThis()
			for _, v in ipairs(self._list) do
				v.page.Visible = false
				_tw(v.titleLbl, 0.12, Enum.EasingStyle.Quart, "InOut", {TextTransparency=0.65}):Play()
				_tw(v.iconImg, 0.12, Enum.EasingStyle.Quart, "InOut", {ImageTransparency=0.6}):Play()
			end
			page.Visible = true
			_tw(tabTitleLbl, 0.12, Enum.EasingStyle.Quart, "InOut", {TextTransparency=0}):Play()
			_tw(tabIconImg, 0.12, Enum.EasingStyle.Quart, "InOut", {ImageTransparency=0.1}):Play()

			task.defer(function()
				local tabCY = tabBtn.AbsolutePosition.Y + tabBtn.AbsoluteSize.Y / 2
				local scrollAbs = tabScroll.AbsolutePosition.Y
				local relY = tabCY - scrollAbs - selBar.AbsoluteSize.Y / 2
				_tw(selBar, 0.25, Enum.EasingStyle.Quart, "Out", {Position=UDim2.new(0,0,0,relY+tabScroll.CanvasPosition.Y)}):Play()
			end)
		end

		clickBtn.MouseButton1Click:Connect(selectThis)

		task.delay(0.1, function()
			if not self._selected then
				if myIdx == self._defaultIdx then
					selectThis()
					self._selected = true
				end
			end
		end)

		local Func = {}

		function Func:Section(p)
			local sTitle = p.Title or ''
			local sw = Instance.new("Frame")
			sw.BackgroundTransparency = 1
			sw.BorderSizePixel = 0
			sw.Size = UDim2.new(1,0,0,22)
			sw.Parent = sf

			local sLbl = Instance.new("TextLabel")
			sLbl.BackgroundTransparency = 1
			sLbl.BorderSizePixel = 0
			sLbl.Size = UDim2.new(1,0,0,14)
			sLbl.Position = UDim2.new(0,0,0.5,-7)
			sLbl.Font = Enum.Font.BuilderSansBold
			sLbl.Text = sTitle
			sLbl.TextColor3 = Color3.fromRGB(200,200,200)
			sLbl.TextSize = 11
			sLbl.TextTransparency = 0.3
			sLbl.TextXAlignment = Enum.TextXAlignment.Left
			sLbl.Parent = sw
			_addTheme('Main', sLbl)

			local sLine = Instance.new("Frame")
			sLine.AnchorPoint = Vector2.new(0,1)
			sLine.BackgroundTransparency = 0.8
			sLine.BorderSizePixel = 0
			sLine.Position = UDim2.new(0,0,1,0)
			sLine.Size = UDim2.new(1,0,0,1)
			sLine.Parent = sw
			_addTheme('Main', sLine)

			local api = {}
			function api:SetTitle(v) sLbl.Text = tostring(v) end
			return api
		end

		function Func:Label(p)
			local lTitle = p.Title or ''
			local lDesc = p.Desc or ''
			local lImage = p.Image or ''

			local bg, cfg = _mkItemBg(sf, lTitle, lDesc, lImage, 'Label')
			cfg:SetTextTransparencyTitle(0)
			cfg:SetRightPad(8)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			return api
		end

		function Func:Toggle(p)
			local tVal = p.Value or false
			local tTitle = p.Title or ''
			local tDesc = p.Desc or ''
			local tImage = p.Image or ''
			local tCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, tTitle, tDesc, tImage, 'Toggle')
			cfg:SetTextTransparencyTitle(tVal and 0 or 0.65)
			cfg:SetRightPad(70)

			local togBg = Instance.new("Frame")
			togBg.AnchorPoint = Vector2.new(1,0.5)
			togBg.BorderSizePixel = 0
			togBg.Position = UDim2.new(1,-12,0.5,0)
			togBg.Size = UDim2.new(0,32,0,16)
			togBg.Parent = bg
			_mkCorner(togBg, 99)

			local togDot = Instance.new("Frame")
			togDot.BorderSizePixel = 0
			togDot.Size = UDim2.new(0,12,0,12)
			togDot.AnchorPoint = Vector2.new(tVal and 1 or 0, 0.5)
			togDot.Position = UDim2.new(tVal and 1 or 0, 0, 0.5, 0)
			togDot.Parent = togBg
			_mkCorner(togDot, 99)

			local togPad = Instance.new("UIPadding")
			togPad.PaddingLeft = UDim.new(0,2)
			togPad.PaddingRight = UDim.new(0,2)
			togPad.Parent = togBg

			local function applyVisual(v)
				local th = _themes[IsTheme]
				local trueC = th.Function.Toggle.True
				local falseC = th.Function.Toggle.False
				local bgC = v and trueC['Toggle Background'] or falseC['Toggle Background']
				local dotC = v and trueC['Toggle Value'] or falseC['Toggle Value']
				_tw(togBg, 0.15, Enum.EasingStyle.Quart, "Out", {BackgroundColor3=bgC}):Play()
				_tw(togDot, 0.15, Enum.EasingStyle.Quart, "Out", {
					BackgroundColor3=dotC,
					AnchorPoint=Vector2.new(v and 1 or 0, 0.5),
					Position=UDim2.new(v and 1 or 0, 0, 0.5, 0)
				}):Play()
				cfg:SetTextTransparencyTitle(v and 0 or 0.65)
			end

			applyVisual(tVal)

			local clickBtn = _mkClick(bg)
			clickBtn.MouseButton1Click:Connect(function()
				tVal = not tVal
				applyVisual(tVal)
				pcall(tCallback, tVal)
			end)

			bg:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
				applyVisual(tVal)
			end)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			function api:SetValue(v)
				tVal = v
				applyVisual(tVal)
				pcall(tCallback, tVal)
			end
			return api
		end

		function Func:Button(p)
			local bTitle = p.Title or ''
			local bDesc = p.Desc or ''
			local bImage = p.Image or ''
			local bCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, bTitle, bDesc, bImage, 'Button')
			cfg:SetTextTransparencyTitle(0)
			cfg:SetRightPad(40)
			bg.ClipsDescendants = true

			local arrowImg = Instance.new("ImageLabel")
			arrowImg.AnchorPoint = Vector2.new(1,0.5)
			arrowImg.BackgroundTransparency = 1
			arrowImg.BorderSizePixel = 0
			arrowImg.Position = UDim2.new(1,-12,0.5,0)
			arrowImg.Size = UDim2.new(0,14,0,14)
			arrowImg.Image = "rbxassetid://14923748517"
			arrowImg.ImageTransparency = 0.4
			arrowImg.Parent = bg
			_addTheme('Text & Icon', arrowImg)

			local clickBtn = _mkClick(bg)
			clickBtn.MouseButton1Click:Connect(function()
				local mp = game:GetService("Players").LocalPlayer:GetMouse()
				local rx = mp.X - bg.AbsolutePosition.X
				local ry = mp.Y - bg.AbsolutePosition.Y
				_ripple(bg, rx, ry)
				_tw(bg, 0.08, Enum.EasingStyle.Quart, "Out", {BackgroundTransparency=0.3}):Play()
				task.delay(0.08, function()
					_tw(bg, 0.12, Enum.EasingStyle.Quart, "Out", {BackgroundTransparency=0}):Play()
				end)
				pcall(bCallback)
			end)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			return api
		end

		function Func:Slider(p)
			local sTitle = p.Title or ''
			local sDesc = p.Desc or ''
			local sImage = p.Image or ''
			local sMin = p.Min or 0
			local sMax = p.Max or 100
			local sVal = p.Value or sMin
			local sRound = p.Rounding or 2
			local sCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, sTitle, sDesc, sImage, 'Slider')
			cfg:SetTextTransparencyTitle(0)
			cfg:SetRightPad(190)

			local valBox = Instance.new("Frame")
			valBox.AnchorPoint = Vector2.new(1,0.5)
			valBox.BorderSizePixel = 0
			valBox.Position = UDim2.new(1,-140,0.5,0)
			valBox.Size = UDim2.new(0,44,0,18)
			valBox.Parent = bg
			_mkCorner(valBox, 4)
			_mkStroke(valBox, nil, 1, 0.7)
			_addTheme('Function.Slider.Value Background', valBox)

			local valTb = Instance.new("TextBox")
			valTb.BackgroundTransparency = 1
			valTb.BorderSizePixel = 0
			valTb.Size = UDim2.new(1,0,1,0)
			valTb.Font = Enum.Font.BuilderSans
			valTb.Text = tostring(sVal)
			valTb.TextColor3 = Color3.fromRGB(220,220,220)
			valTb.TextSize = 10
			valTb.Parent = valBox
			_addTheme('Text & Icon', valTb)

			local trackOuter = Instance.new("Frame")
			trackOuter.AnchorPoint = Vector2.new(1,0.5)
			trackOuter.BorderSizePixel = 0
			trackOuter.Position = UDim2.new(1,-12,0.5,0)
			trackOuter.Size = UDim2.new(0,118,0,8)
			trackOuter.Parent = bg
			_mkCorner(trackOuter, 99)
			_addTheme('Function.Slider.Slider Bar', trackOuter)

			local trackFill = Instance.new("Frame")
			trackFill.AnchorPoint = Vector2.new(0,0.5)
			trackFill.BorderSizePixel = 0
			trackFill.Position = UDim2.new(0,0,0.5,0)
			trackFill.Size = UDim2.new(0,0,1,0)
			trackFill.Parent = trackOuter
			_mkCorner(trackFill, 99)
			_addTheme('Function.Slider.Slider Bar Value', trackFill)

			local trackPad = Instance.new("UIPadding")
			trackPad.PaddingLeft = UDim.new(0,1)
			trackPad.PaddingRight = UDim.new(0,1)
			trackPad.Parent = trackOuter

			local dot = Instance.new("Frame")
			dot.AnchorPoint = Vector2.new(1,0.5)
			dot.BorderSizePixel = 0
			dot.Position = UDim2.new(0,0,0.5,0)
			dot.Size = UDim2.new(0,11,0,11)
			dot.Parent = trackFill
			_mkCorner(dot, 99)
			_addTheme('Function.Slider.Circle Value', dot)

			local function rnd(v, d)
				local f = 10^d
				return math.floor(v*f+0.5)/f
			end

			local function updateSlider(v)
				v = math.clamp(v, sMin, sMax)
				v = rnd(v, sRound)
				sVal = v
				local pct = (v - sMin) / (sMax - sMin)
				_tw(trackFill, 0.1, Enum.EasingStyle.Quart, "Out", {Size=UDim2.new(math.clamp(pct,0.01,1),0,1,0)}):Play()
				valTb.Text = tostring(v)
				pcall(sCallback, v)
			end

			updateSlider(sVal)

			valTb.FocusLost:Connect(function()
				updateSlider(tonumber(valTb.Text) or sMin)
			end)

			local dragging = false
			local clickOv = _mkClick(trackOuter)

			local function doMove(input)
				local rel = math.clamp((input.Position.X - trackOuter.AbsolutePosition.X) / trackOuter.AbsoluteSize.X, 0, 1)
				updateSlider(rel * (sMax - sMin) + sMin)
			end

			clickOv.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					doMove(i)
				end
			end)
			clickOv.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
			UIS.InputChanged:Connect(function(i)
				if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					doMove(i)
				end
			end)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			function api:SetValue(v) updateSlider(v) end
			function api:SetMin(v) sMin=v; if sVal<v then updateSlider(v) end end
			function api:SetMax(v) sMax=v; if sVal>v then updateSlider(v) end end
			return api
		end

		function Func:Textbox(p)
			local tbTitle = p.Title or ''
			local tbDesc = p.Desc or ''
			local tbImage = p.Image or ''
			local tbPlaceholder = p.Placeholder or ''
			local tbValue = p.Value or ''
			local tbClear = p.ClearTextOnFocus ~= nil and p.ClearTextOnFocus or false
			local tbCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, tbTitle, tbDesc, tbImage, 'Textbox')
			cfg:SetTextTransparencyTitle(0)
			cfg:SetRightPad(130)

			local valBox = Instance.new("Frame")
			valBox.AnchorPoint = Vector2.new(1,0.5)
			valBox.BorderSizePixel = 0
			valBox.Position = UDim2.new(1,-12,0.5,0)
			valBox.Size = UDim2.new(0,112,0,20)
			valBox.Parent = bg
			_mkCorner(valBox, 4)
			_mkStroke(valBox, nil, 1, 0.7)
			_addTheme('Function.Textbox.Value Background', valBox)

			local tb = Instance.new("TextBox")
			tb.BackgroundTransparency = 1
			tb.BorderSizePixel = 0
			tb.Size = UDim2.new(1,-8,1,0)
			tb.Position = UDim2.new(0,6,0,0)
			tb.Font = Enum.Font.BuilderSans
			tb.PlaceholderText = tbPlaceholder
			tb.PlaceholderColor3 = Color3.fromRGB(100,100,100)
			tb.Text = tbValue
			tb.TextColor3 = Color3.fromRGB(220,220,220)
			tb.TextSize = 10
			tb.ClearTextOnFocus = tbClear
			tb.Parent = valBox
			_addTheme('Text & Icon', tb)

			tb.FocusLost:Connect(function(enter)
				pcall(tbCallback, tb.Text)
			end)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			function api:SetValue(v) tb.Text = tostring(v); pcall(tbCallback, v) end
			function api:SetPlaceholder(v) tb.PlaceholderText = tostring(v) end
			function api:SetClearTextOnFocus(v) tb.ClearTextOnFocus = v end
			return api
		end

		function Func:Code(p)
			local cTitle = p.Title or ''
			local cCode = p.Code or '-- code'

			local wrap = Instance.new("Frame")
			wrap.BackgroundTransparency = 1
			wrap.BorderSizePixel = 0
			wrap.Size = UDim2.new(1,0,0,120)
			wrap.ClipsDescendants = true
			wrap.Parent = sf

			local codeBg = Instance.new("Frame")
			codeBg.BorderSizePixel = 0
			codeBg.Size = UDim2.new(1,0,1,0)
			codeBg.ClipsDescendants = true
			codeBg.Parent = wrap
			_mkCorner(codeBg, 5)
			_addTheme('Function.Code.Background Code', codeBg)

			local headerBar = Instance.new("Frame")
			headerBar.BackgroundTransparency = 1
			headerBar.BorderSizePixel = 0
			headerBar.Size = UDim2.new(1,0,0,28)
			headerBar.Parent = codeBg

			local hPad = Instance.new("UIPadding")
			hPad.PaddingLeft = UDim.new(0,10)
			hPad.PaddingRight = UDim.new(0,10)
			hPad.Parent = headerBar

			local hLL = Instance.new("UIListLayout")
			hLL.FillDirection = Enum.FillDirection.Horizontal
			hLL.VerticalAlignment = Enum.VerticalAlignment.Center
			hLL.SortOrder = Enum.SortOrder.LayoutOrder
			hLL.Parent = headerBar

			local titleLbl = Instance.new("TextLabel")
			titleLbl.BackgroundTransparency = 1
			titleLbl.BorderSizePixel = 0
			titleLbl.Size = UDim2.new(1,-60,0,14)
			titleLbl.Font = Enum.Font.BuilderSansBold
			titleLbl.Text = cTitle
			titleLbl.TextColor3 = Color3.fromRGB(220,220,220)
			titleLbl.TextSize = 11
			titleLbl.TextXAlignment = Enum.TextXAlignment.Left
			titleLbl.Parent = headerBar
			_addTheme('Text & Icon', titleLbl)

			local copyBtn = Instance.new("TextButton")
			copyBtn.AnchorPoint = Vector2.new(1,0.5)
			copyBtn.BackgroundTransparency = 1
			copyBtn.BorderSizePixel = 0
			copyBtn.Position = UDim2.new(1,-10,0.5,0)
			copyBtn.Size = UDim2.new(0,40,0,16)
			copyBtn.Font = Enum.Font.BuilderSansBold
			copyBtn.Text = "Copy"
			copyBtn.TextColor3 = Color3.fromRGB(200,200,200)
			copyBtn.TextSize = 10
			copyBtn.TextTransparency = 0.4
			copyBtn.TextXAlignment = Enum.TextXAlignment.Right
			copyBtn.Parent = headerBar
			_addTheme('Text & Icon', copyBtn)

			local divLine = Instance.new("Frame")
			divLine.BackgroundTransparency = 0.85
			divLine.BorderSizePixel = 0
			divLine.Position = UDim2.new(0,0,0,28)
			divLine.Size = UDim2.new(1,0,0,1)
			divLine.Parent = codeBg
			_addTheme('Text & Icon', divLine)

			local codeInner = Instance.new("Frame")
			codeInner.BackgroundTransparency = 1
			codeInner.BorderSizePixel = 0
			codeInner.Position = UDim2.new(0,0,0,30)
			codeInner.Size = UDim2.new(1,0,1,-30)
			codeInner.ClipsDescendants = true
			codeInner.Parent = codeBg
			_addTheme('Function.Code.Background Code Value', codeInner)

			local codePad = Instance.new("UIPadding")
			codePad.PaddingLeft = UDim.new(0,8)
			codePad.PaddingRight = UDim.new(0,8)
			codePad.PaddingTop = UDim.new(0,6)
			codePad.Parent = codeInner

			local codeSf = Instance.new("ScrollingFrame")
			codeSf.BackgroundTransparency = 1
			codeSf.BorderSizePixel = 0
			codeSf.Size = UDim2.new(1,0,1,0)
			codeSf.ScrollBarThickness = 3
			codeSf.CanvasSize = UDim2.new(2,0,0,0)
			codeSf.Parent = codeInner
			_addTheme('Function.Code.ScrollingFrame Code', codeSf)

			local codeLbl = Instance.new("TextLabel")
			codeLbl.BackgroundTransparency = 1
			codeLbl.BorderSizePixel = 0
			codeLbl.Size = UDim2.new(0,0,0,0)
			codeLbl.Font = Enum.Font.Code
			codeLbl.RichText = true
			codeLbl.Text = cCode
			codeLbl.TextColor3 = Color3.fromRGB(220,220,220)
			codeLbl.TextSize = 11
			codeLbl.TextXAlignment = Enum.TextXAlignment.Left
			codeLbl.TextYAlignment = Enum.TextYAlignment.Top
			codeLbl.AutomaticSize = Enum.AutomaticSize.XY
			codeLbl.Parent = codeSf
			_addTheme('Text & Icon', codeLbl)

			copyBtn.MouseButton1Click:Connect(function()
				pcall(function() setclipboard(cCode) end)
				copyBtn.Text = "Copied!"
				task.delay(1.5, function() copyBtn.Text = "Copy" end)
			end)

			local api = {}
			function api:SetTitle(v) titleLbl.Text = tostring(v) end
			function api:SetCode(v)
				cCode = v
				codeLbl.Text = v
			end
			return api
		end

		function Func:Dropdown(p)
			local dTitle = p.Title or ''
			local dDesc = p.Desc or ''
			local dImage = p.Image or ''
			local dList = p.List or {}
			local dVal = p.Value
			local dMulti = p.Multi or false
			local dCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, dTitle, dDesc, dImage, 'Dropdown')
			cfg:SetTextTransparencyTitle(0)
			cfg:SetRightPad(125)

			local itemsApi, valBox = _mkDropdownLogic(bg, dMulti, dCallback, dVal, dList)

			local mutableList = {table.unpack(dList)}

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			function api:SetValue(v) itemsApi:SetValue(v) end
			function api:Add(v)
				table.insert(mutableList, v)
			end
			function api:Clear(v)
				if v == nil then
					mutableList = {}
				elseif type(v) == "table" then
					for _, r in ipairs(v) do
						for i, k in ipairs(mutableList) do
							if k == r then table.remove(mutableList, i) break end
						end
					end
				else
					for i, k in ipairs(mutableList) do
						if k == v then table.remove(mutableList, i) break end
					end
				end
			end
			return api
		end

		function Func:Keybind(p)
			local kbTitle = p.Title or ''
			local kbDesc = p.Desc or ''
			local kbImage = p.Image or ''
			local kbKey = p.Key or Enum.KeyCode.E
			local kbVal = p.Value or false
			local kbCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, kbTitle, kbDesc, kbImage, 'Keybind')
			cfg:SetTextTransparencyTitle(kbVal and 0 or 0.65)
			cfg:SetRightPad(110)

			local togBg = Instance.new("Frame")
			togBg.AnchorPoint = Vector2.new(1,0.5)
			togBg.BorderSizePixel = 0
			togBg.Position = UDim2.new(1,-66,0.5,0)
			togBg.Size = UDim2.new(0,32,0,16)
			togBg.Parent = bg
			_mkCorner(togBg, 99)

			local togDot = Instance.new("Frame")
			togDot.BorderSizePixel = 0
			togDot.Size = UDim2.new(0,12,0,12)
			togDot.AnchorPoint = Vector2.new(kbVal and 1 or 0, 0.5)
			togDot.Position = UDim2.new(kbVal and 1 or 0, 0, 0.5, 0)
			togDot.Parent = togBg
			_mkCorner(togDot, 99)

			local togPad = Instance.new("UIPadding")
			togPad.PaddingLeft = UDim.new(0,2)
			togPad.PaddingRight = UDim.new(0,2)
			togPad.Parent = togBg

			local keyBox = Instance.new("Frame")
			keyBox.AnchorPoint = Vector2.new(1,0.5)
			keyBox.BorderSizePixel = 0
			keyBox.Position = UDim2.new(1,-12,0.5,0)
			keyBox.Size = UDim2.new(0,48,0,18)
			keyBox.Parent = bg
			_mkCorner(keyBox, 4)
			_mkStroke(keyBox, nil, 1, 0.7)
			_addTheme('Function.Keybind.Value Background', keyBox)

			local keyLbl = Instance.new("TextLabel")
			keyLbl.BackgroundTransparency = 1
			keyLbl.BorderSizePixel = 0
			keyLbl.Size = UDim2.new(1,0,1,0)
			keyLbl.Font = Enum.Font.BuilderSansBold
			keyLbl.Text = tostring(kbKey):gsub("Enum.KeyCode.","")
			keyLbl.TextColor3 = Color3.fromRGB(220,220,220)
			keyLbl.TextSize = 10
			keyLbl.TextTransparency = 0.3
			keyLbl.Parent = keyBox
			_addTheme('Text & Icon', keyLbl)

			local function applyToggle(v)
				local th = _themes[IsTheme]
				local tC = th.Function.Keybind.True
				local fC = th.Function.Keybind.False
				_tw(togBg, 0.15, Enum.EasingStyle.Quart, "Out", {BackgroundColor3=v and tC['Toggle Background'] or fC['Toggle Background']}):Play()
				_tw(togDot, 0.15, Enum.EasingStyle.Quart, "Out", {
					BackgroundColor3=v and tC['Toggle Value'] or fC['Toggle Value'],
					AnchorPoint=Vector2.new(v and 1 or 0, 0.5),
					Position=UDim2.new(v and 1 or 0, 0, 0.5, 0)
				}):Play()
				cfg:SetTextTransparencyTitle(v and 0 or 0.65)
			end

			applyToggle(kbVal)

			local function adjustKeySize()
				local ts = TextService:GetTextSize(keyLbl.Text, 10, Enum.Font.BuilderSansBold, Vector2.new(1000,1000))
				_tw(keyBox, 0.1, Enum.EasingStyle.Quart, "Out", {Size=UDim2.new(0, ts.X+18, 0, 18)}):Play()
			end
			adjustKeySize()

			local changing = false

			local clickOv = _mkClick(bg)
			clickOv.MouseButton1Click:Connect(function()
				kbVal = not kbVal
				applyToggle(kbVal)
				pcall(kbCallback, kbKey, kbVal)
			end)

			keyBox.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					changing = true
					keyLbl.Text = "..."
					local conn
					conn = UIS.InputBegan:Connect(function(inp)
						if inp.UserInputType == Enum.UserInputType.Keyboard then
							kbKey = inp.KeyCode
							keyLbl.Text = tostring(kbKey):gsub("Enum.KeyCode.","")
							adjustKeySize()
							conn:Disconnect()
							pcall(kbCallback, kbKey, kbVal)
							task.delay(0.1, function() changing = false end)
						end
					end)
				end
			end)

			UIS.InputBegan:Connect(function(i, gp)
				if not gp and i.KeyCode == kbKey and not changing then
					kbVal = not kbVal
					applyToggle(kbVal)
					pcall(kbCallback, kbKey, kbVal)
				end
			end)

			bg:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
				applyToggle(kbVal)
			end)

			task.delay(0, function() pcall(kbCallback, kbKey, kbVal) end)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			function api:SetValue(v) kbVal=v; applyToggle(v); pcall(kbCallback, kbKey, kbVal) end
			function api:SetKey(v)
				kbKey = v
				keyLbl.Text = tostring(v):gsub("Enum.KeyCode.","")
				adjustKeySize()
				pcall(kbCallback, kbKey, kbVal)
			end
			return api
		end

		function Func:ColorPicker(p)
			local cpTitle = p.Title or ''
			local cpDesc = p.Desc or ''
			local cpImage = p.Image or ''
			local cpVal = p.Value or Color3.fromRGB(255,255,255)
			local cpCallback = p.Callback or function() end

			local bg, cfg = _mkItemBg(sf, cpTitle, cpDesc, cpImage, 'Color Picker')
			cfg:SetTextTransparencyTitle(0)
			cfg:SetRightPad(50)

			local swatch = Instance.new("Frame")
			swatch.AnchorPoint = Vector2.new(1,0.5)
			swatch.BackgroundColor3 = cpVal
			swatch.BorderSizePixel = 0
			swatch.Position = UDim2.new(1,-12,0.5,0)
			swatch.Size = UDim2.new(0,20,0,20)
			swatch.Parent = bg
			_mkCorner(swatch, 99)
			_mkStroke(swatch, nil, 1, 0.6)

			local pickerOpen = false
			local pickerFrame = nil

			local h, s, v = Color3.toHSV(cpVal)

			local function buildHSV(parent)
				local pf = Instance.new("Frame")
				pf.BorderSizePixel = 0
				pf.Size = UDim2.new(1,0,0,130)
				pf.ZIndex = 8
				pf.ClipsDescendants = true
				pf.Parent = parent
				_mkCorner(pf, 6)
				_mkStroke(pf, nil, 1, 0.1)
				_addTheme('Function.Color Picker.Color Select.Background', pf)

				local pad = Instance.new("UIPadding")
				pad.PaddingLeft = UDim.new(0,8)
				pad.PaddingRight = UDim.new(0,8)
				pad.PaddingTop = UDim.new(0,8)
				pad.PaddingBottom = UDim.new(0,8)
				pad.Parent = pf

				local svBox = Instance.new("ImageLabel")
				svBox.BorderSizePixel = 0
				svBox.Size = UDim2.new(1,0,0,80)
				svBox.Image = "rbxassetid://4155801252"
				svBox.BackgroundColor3 = Color3.fromHSV(h,1,1)
				svBox.ZIndex = 9
				svBox.Parent = pf
				_mkCorner(svBox, 4)

				local svDot = Instance.new("Frame")
				svDot.AnchorPoint = Vector2.new(0.5,0.5)
				svDot.BackgroundColor3 = Color3.fromRGB(255,255,255)
				svDot.BorderSizePixel = 0
				svDot.Position = UDim2.new(s, 0, 1-v, 0)
				svDot.Size = UDim2.new(0,10,0,10)
				svDot.ZIndex = 10
				svDot.Parent = svBox
				_mkCorner(svDot, 99)

				local hueBar = Instance.new("ImageLabel")
				hueBar.BorderSizePixel = 0
				hueBar.Position = UDim2.new(0,0,0,88)
				hueBar.Size = UDim2.new(1,0,0,12)
				hueBar.Image = "rbxassetid://698852612"
				hueBar.ZIndex = 9
				hueBar.Parent = pf
				_mkCorner(hueBar, 4)

				local hueDot = Instance.new("Frame")
				hueDot.AnchorPoint = Vector2.new(0.5,0.5)
				hueDot.BackgroundColor3 = Color3.fromRGB(255,255,255)
				hueDot.BorderSizePixel = 0
				hueDot.Position = UDim2.new(h, 0, 0.5, 0)
				hueDot.Size = UDim2.new(0,8,0,8)
				hueDot.ZIndex = 10
				hueDot.Parent = hueBar
				_mkCorner(hueDot, 99)

				local hexBox = Instance.new("TextBox")
				hexBox.BackgroundTransparency = 0.8
				hexBox.BorderSizePixel = 0
				hexBox.Position = UDim2.new(0,0,0,106)
				hexBox.Size = UDim2.new(1,0,0,16)
				hexBox.Font = Enum.Font.Code
				hexBox.Text = string.format("#%02X%02X%02X", math.round(cpVal.R*255), math.round(cpVal.G*255), math.round(cpVal.B*255))
				hexBox.TextColor3 = Color3.fromRGB(220,220,220)
				hexBox.TextSize = 10
				hexBox.ZIndex = 10
				hexBox.Parent = pf
				_mkCorner(hexBox, 3)

				local function applyColor()
					cpVal = Color3.fromHSV(h, s, v)
					swatch.BackgroundColor3 = cpVal
					svBox.BackgroundColor3 = Color3.fromHSV(h,1,1)
					svDot.Position = UDim2.new(s, 0, 1-v, 0)
					hueDot.Position = UDim2.new(h, 0, 0.5, 0)
					hexBox.Text = string.format("#%02X%02X%02X", math.round(cpVal.R*255), math.round(cpVal.G*255), math.round(cpVal.B*255))
					pcall(cpCallback, cpVal.R, cpVal.G, cpVal.B)
				end

				local svDragging = false
				local hueDragging = false

				local svClick = _mkClick(svBox)
				svClick.ZIndex = 11
				svClick.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						svDragging = true
						local rel = Vector2.new(
							math.clamp((i.Position.X - svBox.AbsolutePosition.X)/svBox.AbsoluteSize.X,0,1),
							math.clamp((i.Position.Y - svBox.AbsolutePosition.Y)/svBox.AbsoluteSize.Y,0,1)
						)
						s = rel.X; v = 1 - rel.Y
						applyColor()
					end
				end)
				svClick.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						svDragging = false
					end
				end)

				local hueClick = _mkClick(hueBar)
				hueClick.ZIndex = 11
				hueClick.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						hueDragging = true
						h = math.clamp((i.Position.X - hueBar.AbsolutePosition.X)/hueBar.AbsoluteSize.X,0,1)
						applyColor()
					end
				end)
				hueClick.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						hueDragging = false
					end
				end)

				UIS.InputChanged:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
						if svDragging then
							local rel = Vector2.new(
								math.clamp((i.Position.X - svBox.AbsolutePosition.X)/svBox.AbsoluteSize.X,0,1),
								math.clamp((i.Position.Y - svBox.AbsolutePosition.Y)/svBox.AbsoluteSize.Y,0,1)
							)
							s = rel.X; v = 1 - rel.Y
							applyColor()
						elseif hueDragging then
							h = math.clamp((i.Position.X - hueBar.AbsolutePosition.X)/hueBar.AbsoluteSize.X,0,1)
							applyColor()
						end
					end
				end)

				hexBox.FocusLost:Connect(function()
					local hex = hexBox.Text:gsub("#","")
					if #hex == 6 then
						local r = tonumber(hex:sub(1,2),16) or 0
						local g = tonumber(hex:sub(3,4),16) or 0
						local b = tonumber(hex:sub(5,6),16) or 0
						cpVal = Color3.fromRGB(r,g,b)
						h,s,v = Color3.toHSV(cpVal)
						applyColor()
					end
				end)

				return pf
			end

			local swatchClick = _mkClick(swatch)
			swatchClick.ZIndex = 5
			swatchClick.MouseButton1Click:Connect(function()
				if pickerOpen then
					if pickerFrame then
						_tw(pickerFrame, 0.12, Enum.EasingStyle.Quart, "Out", {Size=UDim2.new(1,0,0,0)}):Play()
						task.delay(0.15, function() if pickerFrame then pickerFrame:Destroy(); pickerFrame=nil end end)
					end
					pickerOpen = false
				else
					pickerOpen = true
					pickerFrame = buildHSV(sf)
					pickerFrame.Size = UDim2.new(1,0,0,0)
					_tw(pickerFrame, 0.15, Enum.EasingStyle.Quart, "Out", {Size=UDim2.new(1,0,0,130)}):Play()
				end
			end)

			local api = {}
			function api:SetTitle(v) cfg:SetTitle(v) end
			function api:SetDesc(v) cfg:SetDesc(v) end
			function api:SetVisible(v) bg.Parent.Visible = v end
			function api:SetValue(v)
				cpVal = v
				swatch.BackgroundColor3 = v
				h,s,_v = Color3.toHSV(v)
				v = _v
				pcall(cpCallback, cpVal.R, cpVal.G, cpVal.B)
			end
			return api
		end

		return Func
	end

	local uiVisible = true
	local oSize = mainBg.Size

	local function toggleUI()
		uiVisible = not uiVisible
		if uiVisible then
			shadow.Visible = true
			mainBg.Size = oSize - UDim2.fromOffset(6,6)
			_tw(mainBg, 0.18, Enum.EasingStyle.Quart, "Out", {Size=oSize}):Play()
		else
			local t = _tw(mainBg, 0.15, Enum.EasingStyle.Quart, "In", {Size=oSize - UDim2.fromOffset(6,6)})
			t:Play()
			t.Completed:Connect(function()
				shadow.Visible = false
			end)
		end
		if firstOpen then
			firstOpen = false
			Tabs:Notify({
				Title = 'CloverUI',
				Desc = 'Press <b>'..tostring(Keybind):gsub("Enum.KeyCode.","")..'</b> to toggle the UI.',
				Time = 7
			})
		end
	end

	minimizeBtn.MouseButton1Click:Connect(toggleUI)
	closeBtn.MouseButton1Click:Connect(function()
		Tabs:Dialog({
			Title = "Close <font color='#FF4444'>CloverUI</font>?",
			Button1 = {
				Title = 'Confirm',
				Color = Color3.fromRGB(0,180,0),
				Callback = function() ScreenGui:Destroy() end
			},
			Button2 = {Title='Cancel', Color=Color3.fromRGB(180,40,40)}
		})
	end)

	UIS.InputBegan:Connect(function(i, gp)
		if i.KeyCode == Keybind and not gp then
			if not UIS:GetFocusedTextBox() then toggleUI() end
		end
	end)

	local _drag_click = _mkClick(sideTopbar)
	_drag(sideTopbar, shadow)

	local callTheme = function(tn)
		IsTheme = tn
		local t = _themes[tn]
		if not t then return end
		CloverUI:setTheme({
			Shadow = t.Shadow,
			Background = t.Background,
			Page = t.Page,
			Main = t.Main,
			['Text & Icon'] = t['Text & Icon'],
			Function = t.Function
		})
	end

	local themeApi, _ = _mkDropdownLogic(themeDropWrap, false, callTheme, Theme, _themes.index)
	callTheme(Theme)

	if p.CloseUIButton and p.CloseUIButton.Enabled then
		local cub = p.CloseUIButton
		local bubbleWrap = Instance.new("Frame")
		bubbleWrap.BackgroundTransparency = 1
		bubbleWrap.BorderSizePixel = 0
		bubbleWrap.AnchorPoint = Vector2.new(0,0.5)
		bubbleWrap.Position = UDim2.new(0,10,0.2,0)
		bubbleWrap.Size = UDim2.new(0,80,0,26)
		bubbleWrap.Parent = ScreenGui

		local bubbleBg = Instance.new("Frame")
		bubbleBg.BorderSizePixel = 0
		bubbleBg.Size = UDim2.new(1,0,1,0)
		bubbleBg.Parent = bubbleWrap
		_mkCorner(bubbleBg, 5)
		_mkStroke(bubbleBg, nil, 1, 0.1)
		_addTheme('Background', bubbleBg)

		local bubbleLbl = Instance.new("TextLabel")
		bubbleLbl.BackgroundTransparency = 1
		bubbleLbl.BorderSizePixel = 0
		bubbleLbl.Size = UDim2.new(1,0,1,0)
		bubbleLbl.Font = Enum.Font.BuilderSansBold
		bubbleLbl.Text = cub.Text or 'Close UI'
		bubbleLbl.TextColor3 = Color3.fromRGB(230,230,230)
		bubbleLbl.TextSize = 11
		bubbleLbl.Parent = bubbleBg
		_addTheme('Text & Icon', bubbleLbl)

		local bubbleClick = _mkClick(bubbleWrap)
		_drag(bubbleWrap, bubbleWrap)
		bubbleClick.MouseButton1Click:Connect(toggleUI)
	end

	return Tabs
end

return CloverUI
