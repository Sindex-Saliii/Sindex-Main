local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local TrigonKey = Instance.new("ScreenGui")
local BackgroundBlur = Instance.new("Frame")
local Container = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke")
local UICorner = Instance.new("UICorner")
local ContentLayer = Instance.new("Frame")
local LiquidLayer = Instance.new("Frame")
local Orb1 = Instance.new("Frame")
local Orb2 = Instance.new("Frame")
local Header = Instance.new("Frame")
local Logo = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("ImageButton")
local Content = Instance.new("Frame")
local KeyBoxFrame = Instance.new("Frame")
local KeyInput = Instance.new("TextBox")
local StatusLabel = Instance.new("TextLabel")
local GetKeyBtn = Instance.new("TextButton")
local ActionGroup = Instance.new("Frame")
local DiscordBtn = Instance.new("TextButton")
local SubmitBtn = Instance.new("TextButton")

TrigonKey.Name = "TrigonHyperOS"
TrigonKey.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TrigonKey.IgnoreGuiInset = true

if gethui then TrigonKey.Parent = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(TrigonKey); TrigonKey.Parent = CoreGui
else TrigonKey.Parent = CoreGui end

BackgroundBlur.Size = UDim2.new(1, 0, 1, 0)
BackgroundBlur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundBlur.BackgroundTransparency = 1
BackgroundBlur.BorderSizePixel = 0
BackgroundBlur.Parent = TrigonKey

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = game:GetService("Lighting")

Container.AnchorPoint = Vector2.new(0.5, 0.5)
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.Size = UDim2.new(0, 380, 0, 440)
Container.BackgroundTransparency = 1
Container.Parent = TrigonKey

local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.AspectRatio = 0.86
UIAspectRatioConstraint.Parent = Container

local UISizeConstraint = Instance.new("UISizeConstraint")
UISizeConstraint.MaxSize = Vector2.new(400, 500)
UISizeConstraint.MinSize = Vector2.new(280, 350)
UISizeConstraint.Parent = Container

MainFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.88
MainFrame.ClipsDescendants = true
MainFrame.Parent = Container

UICorner.CornerRadius = UDim.new(0, 35)
UICorner.Parent = MainFrame

UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.55
UIStroke.Parent = MainFrame

LiquidLayer.Size = UDim2.new(1, 0, 1, 0)
LiquidLayer.BackgroundTransparency = 1
LiquidLayer.ZIndex = 1
LiquidLayer.Parent = MainFrame

Orb1.Size = UDim2.new(0, 350, 0, 350)
Orb1.Position = UDim2.new(-0.3, 0, -0.2, 0)
Orb1.BackgroundColor3 = Color3.fromRGB(140, 110, 255)
Orb1.BackgroundTransparency = 0.65
Orb1.Parent = LiquidLayer
Instance.new("UICorner", Orb1).CornerRadius = UDim.new(1, 0)

Orb2.Size = UDim2.new(0, 280, 0, 280)
Orb2.Position = UDim2.new(0.6, 0, 0.7, 0)
Orb2.BackgroundColor3 = Color3.fromRGB(80, 220, 255)
Orb2.BackgroundTransparency = 0.65
Orb2.Parent = LiquidLayer
Instance.new("UICorner", Orb2).CornerRadius = UDim.new(1, 0)

ContentLayer.Size = UDim2.new(1, 0, 1, 0)
ContentLayer.BackgroundTransparency = 1
ContentLayer.ZIndex = 5
ContentLayer.Parent = MainFrame

Header.Size = UDim2.new(1, 0, 0, 130)
Header.BackgroundTransparency = 1
Header.Parent = ContentLayer

Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.Position = UDim2.new(0.5, 0, 0.45, 0)
Logo.Size = UDim2.new(0, 65, 0, 65)
Logo.Image = "rbxassetid://82500352718600"
Logo.BackgroundTransparency = 1
Logo.Parent = Header

Title.Position = UDim2.new(0, 0, 0.78, 0)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "TRIGON EVO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Parent = Header

CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Position = UDim2.new(1, -25, 0, 25)
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Image = "rbxassetid://6031094670"
CloseButton.BackgroundTransparency = 0.9
CloseButton.ImageTransparency = 0.2
CloseButton.ZIndex = 10
CloseButton.Parent = Header
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)

Content.Position = UDim2.new(0, 0, 0, 130)
Content.Size = UDim2.new(1, 0, 1, -130)
Content.BackgroundTransparency = 1
Content.Parent = ContentLayer

local Padding = Instance.new("UIPadding", Content)
Padding.PaddingLeft = UDim.new(0, 30)
Padding.PaddingRight = UDim.new(0, 30)

KeyBoxFrame.Size = UDim2.new(1, 0, 0, 55)
KeyBoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyBoxFrame.BackgroundTransparency = 0.94
KeyBoxFrame.Parent = Content
Instance.new("UICorner", KeyBoxFrame).CornerRadius = UDim.new(0, 16)
local ks = Instance.new("UIStroke", KeyBoxFrame)
ks.Color = Color3.fromRGB(255, 255, 255)
ks.Transparency = 0.8

KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 15, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Text = ""
KeyInput.PlaceholderText = "License Key"
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.TextSize = 15
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Parent = KeyBoxFrame

StatusLabel.Position = UDim2.new(0, 0, 0, 65)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Text = ""
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 14
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextTransparency = 1
StatusLabel.Parent = Content

GetKeyBtn.Position = UDim2.new(0, 0, 0, 110)
GetKeyBtn.Size = UDim2.new(1, 0, 0, 55)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.BackgroundTransparency = 0.92
GetKeyBtn.Text = "GET ACCESS KEY"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 15
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Parent = Content
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 16)

ActionGroup.AnchorPoint = Vector2.new(0, 1)
ActionGroup.Position = UDim2.new(0, 0, 1, -30)
ActionGroup.Size = UDim2.new(1, 0, 0, 55)
ActionGroup.BackgroundTransparency = 1
ActionGroup.Parent = Content

DiscordBtn.Size = UDim2.new(0.48, 0, 1, 0)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.BackgroundTransparency = 0.92
DiscordBtn.Text = "DISCORD"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 13
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.Parent = ActionGroup
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 16)

SubmitBtn.AnchorPoint = Vector2.new(1, 0)
SubmitBtn.Position = UDim2.new(1, 0, 0, 0)
SubmitBtn.Size = UDim2.new(0.48, 0, 1, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundTransparency = 0.1
SubmitBtn.Text = "SUBMIT"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 13
SubmitBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SubmitBtn.Parent = ActionGroup
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 16)

local function animateStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
    StatusLabel.Position = UDim2.new(0, 0, 0, 75)
    StatusLabel.TextTransparency = 1
    
    TweenService:Create(StatusLabel, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 65),
        TextTransparency = 0
    }):Play()
end

local function getHWID()
    local success, result = pcall(function() return game:GetService("RbxAnalyticsService"):GetClientId() end)
    return (success and result) or tostring(Player.UserId)
end

local function validateKey(key)
    local hwid = getHWID()
    local url = "https://whitelist.projectsindex.space/api/validate-key/?hwid=" .. HttpService:UrlEncode(hwid)
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = url, Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({key = key})
        })
    end)
    if success and response.Success then
        local data = HttpService:JSONDecode(response.Body)
        return data.valid, data.reason or data.message
    end
    return false, "Connection Error"
end

local function finish()
    local t = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    TweenService:Create(BackgroundBlur, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 0}):Play()
    t:Play()
    t.Completed:Connect(function()
        TrigonKey:Destroy()
        if Blur then Blur:Destroy() end
    end)
end

local function checkKey(key)
    animateStatus("VERIFYING...", Color3.fromRGB(255, 255, 255))
    task.wait(0.6)
    local ok, msg = validateKey(key)
    if ok then
        if not isfolder("TrigonEvo") then makefolder("TrigonEvo") end
        writefile("TrigonEvo/key.txt", key)
        animateStatus("ACCESS GRANTED!", Color3.fromRGB(120, 255, 120))
        task.wait(1.5)
        finish()
    else
        animateStatus(tostring(msg):upper(), Color3.fromRGB(255, 120, 120))
    end
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text ~= "" then checkKey(KeyInput.Text) else animateStatus("MISSING KEY", Color3.fromRGB(255, 120, 120)) end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://whitelist.projectsindex.space/?hwid=" .. getHWID())
    animateStatus("LINK COPIED!", Color3.fromRGB(255, 255, 255))
end)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("discord.gg/trigon")
    animateStatus("DISCORD COPIED!", Color3.fromRGB(120, 180, 255))
end)

CloseButton.MouseButton1Click:Connect(finish)

RunService.RenderStepped:Connect(function()
    local t = tick()
    Orb1.Position = UDim2.new(-0.3 + math.sin(t*0.4)*0.12, 0, -0.2 + math.cos(t*0.4)*0.12, 0)
    Orb2.Position = UDim2.new(0.6 + math.sin(t*0.3)*0.12, 0, 0.7 + math.cos(t*0.5)*0.12, 0)
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
BackgroundBlur.BackgroundTransparency = 1
TweenService:Create(BackgroundBlur, TweenInfo.new(0.6), {BackgroundTransparency = 0.55}):Play()
TweenService:Create(Blur, TweenInfo.new(0.6), {Size = 25}):Play()
TweenService:Create(MainFrame, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.9, 0, 0.9, 0)}):Play()

task.spawn(function()
    if isfile("TrigonEvo/key.txt") then
        local k = readfile("TrigonEvo/key.txt")
        if #k > 10 then 
            KeyInput.Text = "Verifying saved key..."
            task.wait(1.5)
            checkKey(k) 
        end
    end
end)
