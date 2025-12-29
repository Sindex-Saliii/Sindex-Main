Language = "English"
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Events = ReplicatedStorage:WaitForChild("Events"):WaitForChild("To_Server")
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local HubTitle = "Saliii Hub"

local TextData = {
    English = {
        MainTab = "Main",
        AutoClicker = "Auto Clicker",
        AutoFarmMonster = "Auto Farm Monster", 
        AutoFarmNearest = "Auto Farm Nearest",
        FarmingMethod = "Farming Method",
        SelectEnemy = "Select Enemy",
        SelectDungeon = "Select Dungeon",
        RefreshEnemyLists = "Refresh Enemy Lists",
        ClearSelectedEnemies = "Clear Selected Enemies",
        AutoAddStats = "Auto Add Stats",
        AutoJoinDungeon = "Auto Join Dungeon",
        AutoFarmDungeon = "Auto Farm Dungeon",
        ServerInfo = "Server Info",
        CopyJobID = "Copy JobID",
        JoinByJobID = "Join by Job ID",
        Settings = "Settings",
        Language = "Language",
        UnlockFPS = "Unlock FPS",
        BoostFPS = "Boost FPS",
        WalkSpeed = "WalkSpeed",
        JumpPower = "JumpPower",
        Fly = "Fly",
        Loaded = "Loaded Successfully",
        AutoClickEnabled = "Auto Clicker Enabled",
        AutoClickDisabled = "Auto Clicker Disabled",
        AutoFarmEnabled = "Auto Farm Enabled",
        AutoFarmDisabled = "Auto Farm Disabled",
        FarmNearestEnabled = "Farm Nearest Enabled",
        FarmNearestDisabled = "Farm Nearest Disabled",
        FarmMethod = "Farm Method: ",
        EnemySelected = "Enemy Selected: ",
        DungeonSelected = "Dungeon Selected: ",
        EnemyListRefreshed = "Enemy List Refreshed",
        EnemiesCleared = "Enemies Cleared",
        AutoStatsEnabled = "Auto Stats Enabled",
        AutoStatsDisabled = "Auto Stats Disabled",
        AutoDungeonEnabled = "Auto Dungeon Enabled",
        AutoDungeonDisabled = "Auto Dungeon Disabled",
        AutoFarmDungeonEnabled = "Auto Farm Dungeon Enabled",
        AutoFarmDungeonDisabled = "Auto Farm Dungeon Disabled",
        JobIDCopied = "JobID Copied",
        FPSUnlocked = "FPS Unlocked",
        FPSBoostEnabled = "FPS Boost Enabled",
        FPSBoostDisabled = "FPS Boost Disabled",
        FlyEnabled = "Fly Enabled",
        FlyDisabled = "Fly Disabled"
    },
    Thai = {
        MainTab = "หลัก",
        AutoClicker = "คลิกอัตโนมัติ",
        AutoFarmMonster = "ฟาร์มมอนสเตอร์อัตโนมัติ",
        AutoFarmNearest = "ฟาร์มใกล้สุดอัตโนมัติ",
        FarmingMethod = "วิธีการฟาร์ม",
        SelectEnemy = "เลือกศัตรู",
        SelectDungeon = "เลือกดันเจี้ยน", 
        RefreshEnemyLists = "รีเฟรชลิสต์ศัตรู",
        ClearSelectedEnemies = "ล้างศัตรูที่เลือก",
        AutoAddStats = "เพิ่มสเตตอัตโนมัติ",
        AutoJoinDungeon = "เขาดันเจี้ยนอัตโนมัติ",
        AutoFarmDungeon = "ฟาร์มดันเจี้ยนอัตโนมัติ",
        ServerInfo = "ข้อมูลเซิร์ฟเวอร์",
        CopyJobID = "คัดลอก JobID",
        JoinByJobID = "เข้ารหัสเซิร์ฟเวอร์",
        Settings = "ตั้งค่า",
        Language = "ภาษา",
        UnlockFPS = "ปลดล็อค FPS",
        BoostFPS = "บูส FPS",
        WalkSpeed = "ความเร็วเดิน",
        JumpPower = "พลังกระโดด", 
        Fly = "บิน",
        Loaded = "โหลดสำเร็จ",
        AutoClickEnabled = "เปิดคลิกอัตโนมัติแล้ว",
        AutoClickDisabled = "ปิดคลิกอัตโนมัติแล้ว",
        AutoFarmEnabled = "เปิดฟาร์มอัตโนมัติแล้ว",
        AutoFarmDisabled = "ปิดฟาร์มอัตโนมัติแล้ว",
        FarmNearestEnabled = "เปิดฟาร์มใกล้สุดแล้ว",
        FarmNearestDisabled = "ปิดฟาร์มใกล้สุดแล้ว",
        FarmMethod = "วิธีการฟาร์ม: ",
        EnemySelected = "เลือกศัตรู: ",
        DungeonSelected = "เลือกดันเจี้ยน: ",
        EnemyListRefreshed = "รีเฟรชลิสต์ศัตรูแล้ว",
        EnemiesCleared = "ล้างศัตรูที่เลือกแล้ว",
        AutoStatsEnabled = "เปิดเพิ่มสเตตอัตโนมัติแล้ว",
        AutoStatsDisabled = "ปิดเพิ่มสเตตอัตโนมัติแล้ว",
        AutoDungeonEnabled = "เปิดเขาดันเจี้ยนอัตโนมัติแล้ว",
        AutoDungeonDisabled = "ปิดเขาดันเจี้ยนอัตโนมัติแล้ว",
        AutoFarmDungeonEnabled = "เปิดฟาร์มดันเจี้ยนอัตโนมัติแล้ว",
        AutoFarmDungeonDisabled = "ปิดฟาร์มดันเจี้ยนอัตโนมัติแล้ว",
        JobIDCopied = "คัดลอก JobID แล้ว",
        FPSUnlocked = "ปลดล็อค FPS แล้ว",
        FPSBoostEnabled = "เปิดบูส FPS แล้ว",
        FPSBoostDisabled = "ปิดบูส FPS แล้ว",
        FlyEnabled = "เปิดบินแล้ว",
        FlyDisabled = "ปิดบินแล้ว"
    },
    Chinese = {
        MainTab = "主菜单",
        AutoClicker = "自动点击",
        AutoFarmMonster = "自动农场怪物",
        AutoFarmNearest = "自动最近农场", 
        FarmingMethod = "农场方法",
        SelectEnemy = "选择敌人",
        SelectDungeon = "选择地下城",
        RefreshEnemyLists = "刷新敌人列表",
        ClearSelectedEnemies = "清除选择敌人",
        AutoAddStats = "自动加属性",
        AutoJoinDungeon = "自动进入地下城",
        AutoFarmDungeon = "自动农场地下城",
        ServerInfo = "服务器信息",
        CopyJobID = "复制JobID",
        JoinByJobID = "通过JobID加入",
        Settings = "设置",
        Language = "语言",
        UnlockFPS = "解锁FPS",
        BoostFPS = "加速FPS",
        WalkSpeed = "移动速度",
        JumpPower = "跳跃力量",
        Fly = "飞行",
        Loaded = "加载成功",
        AutoClickEnabled = "自动点击已开启",
        AutoClickDisabled = "自动点击已关闭",
        AutoFarmEnabled = "自动农场已开启",
        AutoFarmDisabled = "自动农场已关闭",
        FarmNearestEnabled = "最近农场已开启",
        FarmNearestDisabled = "最近农场已关闭",
        FarmMethod = "农场方法: ",
        EnemySelected = "选择敌人: ",
        DungeonSelected = "选择地下城: ",
        EnemyListRefreshed = "敌人列表已刷新",
        EnemiesCleared = "已清除敌人",
        AutoStatsEnabled = "自动加属性已开启",
        AutoStatsDisabled = "自动加属性已关闭",
        AutoDungeonEnabled = "自动进入地下城已开启",
        AutoDungeonDisabled = "自动进入地下城已关闭",
        AutoFarmDungeonEnabled = "自动农场地下城已开启",
        AutoFarmDungeonDisabled = "自动农场地下城已关闭",
        JobIDCopied = "已复制JobID",
        FPSUnlocked = "FPS已解锁",
        FPSBoostEnabled = "FPS加速已开启",
        FPSBoostDisabled = "FPS加速已关闭",
        FlyEnabled = "飞行已开启",
        FlyDisabled = "飞行已关闭"
    },
    Japanese = {
        MainTab = "メイン",
        AutoClicker = "オートクリック",
        AutoFarmMonster = "モンスター自動ファーム",
        AutoFarmNearest = "最寄り自動ファーム",
        FarmingMethod = "ファーム方法",
        SelectEnemy = "敵を選択",
        SelectDungeon = "ダンジョンを選択",
        RefreshEnemyLists = "敵リストを更新",
        ClearSelectedEnemies = "選択をクリア",
        AutoAddStats = "自動ステータス追加",
        AutoJoinDungeon = "自動ダンジョン参加",
        AutoFarmDungeon = "自動ダンジョンファーム",
        ServerInfo = "サーバー情報",
        CopyJobID = "JobIDをコピー",
        JoinByJobID = "JobIDで参加",
        Settings = "設定",
        Language = "言語",
        UnlockFPS = "FPS制限解除",
        BoostFPS = "FPSブースト",
        WalkSpeed = "移動速度",
        JumpPower = "ジャンプ力",
        Fly = "飛行",
        Loaded = "読み込み成功",
        AutoClickEnabled = "オートクリック有効",
        AutoClickDisabled = "オートクリック無効",
        AutoFarmEnabled = "自動ファーム有効",
        AutoFarmDisabled = "自動ファーム無効",
        FarmNearestEnabled = "最寄りファーム有効",
        FarmNearestDisabled = "最寄りファーム無効",
        FarmMethod = "ファーム方法: ",
        EnemySelected = "選択した敵: ",
        DungeonSelected = "選択したダンジョン: ",
        EnemyListRefreshed = "敵リストを更新しました",
        EnemiesCleared = "選択をクリアしました",
        AutoStatsEnabled = "自動ステータス有効",
        AutoStatsDisabled = "自動ステータス無効",
        AutoDungeonEnabled = "自動ダンジョン有効",
        AutoDungeonDisabled = "自動ダンジョン無効",
        AutoFarmDungeonEnabled = "自動ダンジョンファーム有効",
        AutoFarmDungeonDisabled = "自動ダンジョンファーム無効",
        JobIDCopied = "JobIDをコピーしました",
        FPSUnlocked = "FPS制限を解除しました",
        FPSBoostEnabled = "FPSブースト有効",
        FPSBoostDisabled = "FPSブースト無効",
        FlyEnabled = "飛行有効",
        FlyDisabled = "飛行無効"
    }
}

local function GetText(key)
    return TextData[Language][key] or key
end

local Window = WindUI:CreateWindow({
    Title = "[Anime Eternal] " .. HubTitle,
    Author = "x.saliii",
    Folder = HubTitle:gsub(" ", "") .. "Folder",
    HideSearchBar = false,
    OpenButton = {
        Title = "Open Hub", 
        CornerRadius = UDim.new(1,0), 
        StrokeThickness = 3, 
        Enabled = true, 
        Draggable = true,
        Color = ColorSequence.new(Color3.fromHex("#FFD700"), Color3.fromHex("#FFFFFF"))
    }
})

local Config = {
    AutoClick = false,
    AutoFarm = false,
    AutoFarmNearest = false,
    FarmMethod = "Instant",
    SelectedEnemyNames = {},
    SelectedDungeons = {},
    AutoAddStats = false,
    SelectedStats = {},
    AutoJoinDungeon = false,
    AutoFarmDungeon = false,
    AntiAFK = true,
    InstantDelay = 0.1,
    ClickDelay = 0.1,
    TweenDelay = 0.15,
    WalkSpeed = 16,
    JumpPower = 50,
    UnlockFPS = false,
    BoostFPS = false,
    Fly = false
}

local lastNotifyTime = 0
local notifyCooldown = 1

local function CreateParticleEffect(parent)
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, 2, 0, 2)
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    particle.BorderSizePixel = 0
    particle.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle
    
    local tween = TweenService:Create(particle, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(math.random(), 0, math.random(), 0),
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function()
        particle:Destroy()
    end)
end

local function MakeModernNotify(title, content)
    local currentTime = tick()
    if currentTime - lastNotifyTime < notifyCooldown then
        return
    end
    lastNotifyTime = currentTime

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 250, 0, 80)
    MainFrame.Position = UDim2.new(1, 260, 0.1, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame
    
    local BackgroundGradient = Instance.new("UIGradient")
    BackgroundGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8))
    })
    BackgroundGradient.Rotation = 135
    BackgroundGradient.Parent = MainFrame
    
    local GlowEffect = Instance.new("ImageLabel")
    GlowEffect.Size = UDim2.new(1, 30, 1, 30)
    GlowEffect.Position = UDim2.new(0, -15, 0, -15)
    GlowEffect.BackgroundTransparency = 1
    GlowEffect.Image = "rbxassetid://8992230675"
    GlowEffect.ImageColor3 = Color3.fromRGB(255, 215, 0)
    GlowEffect.ImageTransparency = 0.7
    GlowEffect.ScaleType = Enum.ScaleType.Slice
    GlowEffect.SliceCenter = Rect.new(23, 23, 277, 277)
    GlowEffect.Parent = MainFrame
    
    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
    ParticleContainer.BackgroundTransparency = 1
    ParticleContainer.Parent = MainFrame
    
    local IconFrame = Instance.new("Frame")
    IconFrame.Size = UDim2.new(0, 50, 1, 0)
    IconFrame.Position = UDim2.new(0, 0, 0, 0)
    IconFrame.BackgroundTransparency = 1
    IconFrame.Parent = MainFrame
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 30, 0, 30)
    Icon.Position = UDim2.new(0.5, -15, 0.5, -15)
    Icon.BackgroundTransparency = 1
    Icon.Text = "✨"
    Icon.TextColor3 = Color3.fromRGB(255, 215, 0)
    Icon.TextSize = 18
    Icon.Font = Enum.Font.GothamBlack
    Icon.TextStrokeTransparency = 0.8
    Icon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    Icon.Parent = IconFrame
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -60, 1, -15)
    ContentFrame.Position = UDim2.new(0, 50, 0, 8)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 25)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextStrokeTransparency = 0.8
    TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.Parent = ContentFrame
    
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Size = UDim2.new(1, 0, 0, 25)
    ContentLabel.Position = UDim2.new(0, 0, 0, 25)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = content
    ContentLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ContentLabel.TextSize = 12
    ContentLabel.Font = Enum.Font.Gotham
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.Parent = ContentFrame
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(0, 0, 0, 3)
    ProgressBar.Position = UDim2.new(0, 0, 1, -3)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = MainFrame
    
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(0, 1)
    ProgressCorner.Parent = ProgressBar
    
    local ProgressGradient = Instance.new("UIGradient")
    ProgressGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 235, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 200))
    })
    ProgressGradient.Parent = ProgressBar
    
    local SparkleEffect = Instance.new("Frame")
    SparkleEffect.Size = UDim2.new(0, 15, 0, 15)
    SparkleEffect.Position = UDim2.new(0, 10, 0.5, -7)
    SparkleEffect.BackgroundTransparency = 1
    SparkleEffect.Parent = MainFrame
    
    local Sparkle = Instance.new("ImageLabel")
    Sparkle.Size = UDim2.new(1, 0, 1, 0)
    Sparkle.BackgroundTransparency = 1
    Sparkle.Image = "rbxassetid://8992230675"
    Sparkle.ImageColor3 = Color3.fromRGB(255, 215, 0)
    Sparkle.ImageTransparency = 0.6
    Sparkle.Parent = SparkleEffect
    
    local sparkleTween = TweenService:Create(Sparkle, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1), {
        Rotation = 360
    })
    sparkleTween:Play()
    
    task.spawn(function()
        while ScreenGui.Parent do
            CreateParticleEffect(ParticleContainer)
            task.wait(0.3)
        end
    end)
    
    local EnterTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -260, 0.1, 0)
    })
    
    local ProgressTween = TweenService:Create(ProgressBar, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 0, 3)
    })
    
    EnterTween:Play()
    ProgressTween:Play()
    
    task.wait(2)
    
    sparkleTween:Cancel()
    
    local ShakeTween = TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2), {
        Position = UDim2.new(1, -262, 0.1, 0)
    })
    
    ShakeTween:Play()
    task.wait(0.2)
    
    local ExitTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 260, 0.1, 0)
    })
    
    ExitTween:Play()
    ExitTween.Completed:Wait()
    ScreenGui:Destroy()
end

local function notify(title, content)
    MakeModernNotify(title, content)
end

local function MakeJoinJobIDUI()
    local JoinScreenGui = Instance.new("ScreenGui")
    JoinScreenGui.Name = "JoinJobIDUI"
    JoinScreenGui.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -160, 0.3, -100)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = JoinScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = MainFrame
    
    local BackgroundGradient = Instance.new("UIGradient")
    BackgroundGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8))
    })
    BackgroundGradient.Rotation = 135
    BackgroundGradient.Parent = MainFrame
    
    local GlowEffect = Instance.new("ImageLabel")
    GlowEffect.Size = UDim2.new(1, 40, 1, 40)
    GlowEffect.Position = UDim2.new(0, -20, 0, -20)
    GlowEffect.BackgroundTransparency = 1
    GlowEffect.Image = "rbxassetid://8992230675"
    GlowEffect.ImageColor3 = Color3.fromRGB(255, 215, 0)
    GlowEffect.ImageTransparency = 0.7
    GlowEffect.ScaleType = Enum.ScaleType.Slice
    GlowEffect.SliceCenter = Rect.new(23, 23, 277, 277)
    GlowEffect.Parent = MainFrame
    
    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
    ParticleContainer.BackgroundTransparency = 1
    ParticleContainer.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 50)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🔗 " .. GetText("JoinByJobID")
    TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.TextStrokeTransparency = 0.8
    TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.Parent = MainFrame
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 10)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBlack
    CloseButton.Parent = MainFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseButton
    
    local CloseHover = Instance.new("Frame")
    CloseHover.Size = UDim2.new(1, 0, 1, 0)
    CloseHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseHover.BackgroundTransparency = 0.9
    CloseHover.BorderSizePixel = 0
    CloseHover.Visible = false
    CloseHover.Parent = CloseButton
    
    local hoverCorner = Instance.new("UICorner")
    hoverCorner.CornerRadius = UDim.new(1, 0)
    hoverCorner.Parent = CloseHover
    
    CloseButton.MouseEnter:Connect(function()
        CloseHover.Visible = true
    end)
    
    CloseButton.MouseLeave:Connect(function()
        CloseHover.Visible = false
    end)
    
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, -40, 0, 40)
    InputFrame.Position = UDim2.new(0, 20, 0, 65)
    InputFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    InputFrame.BorderSizePixel = 0
    InputFrame.Parent = JoinScreenGui
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 10)
    InputCorner.Parent = InputFrame
    
    local InputStroke = Instance.new("UIStroke")
    InputStroke.Color = Color3.fromRGB(255, 215, 0)
    InputStroke.Thickness = 2
    InputStroke.Parent = InputFrame
    
    local JobIDTextBox = Instance.new("TextBox")
    JobIDTextBox.Size = UDim2.new(1, -15, 1, -8)
    JobIDTextBox.Position = UDim2.new(0, 7, 0, 4)
    JobIDTextBox.BackgroundTransparency = 1
    JobIDTextBox.Text = ""
    JobIDTextBox.PlaceholderText = "Enter Job ID here..."
    JobIDTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    JobIDTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    JobIDTextBox.TextSize = 14
    JobIDTextBox.Font = Enum.Font.Gotham
    JobIDTextBox.Parent = InputFrame
    
    local JoinButton = Instance.new("TextButton")
    JoinButton.Size = UDim2.new(1, -40, 0, 45)
    JoinButton.Position = UDim2.new(0, 20, 0, 120)
    JoinButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    JoinButton.Text = "🚀 JOIN SERVER"
    JoinButton.TextColor3 = Color3.fromRGB(10, 10, 10)
    JoinButton.TextSize = 16
    JoinButton.Font = Enum.Font.GothamBlack
    JoinButton.Parent = JoinScreenGui
    
    local JoinCorner = Instance.new("UICorner")
    JoinCorner.CornerRadius = UDim.new(0, 12)
    JoinCorner.Parent = JoinButton
    
    local JoinGradient = Instance.new("UIGradient")
    JoinGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 80)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 215, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 190, 0))
    })
    JoinGradient.Parent = JoinButton
    
    local JoinStroke = Instance.new("UIStroke")
    JoinStroke.Color = Color3.fromRGB(255, 255, 150)
    JoinStroke.Thickness = 2
    JoinStroke.Parent = JoinButton
    
    local JoinHover = Instance.new("Frame")
    JoinHover.Size = UDim2.new(1, 0, 1, 0)
    JoinHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    JoinHover.BackgroundTransparency = 0.9
    JoinHover.BorderSizePixel = 0
    JoinHover.Visible = false
    JoinHover.Parent = JoinButton
    
    local hoverCorner2 = Instance.new("UICorner")
    hoverCorner2.CornerRadius = UDim.new(0, 12)
    hoverCorner2.Parent = JoinHover
    
    local ButtonParticles = Instance.new("Frame")
    ButtonParticles.Size = UDim2.new(1, 0, 1, 0)
    ButtonParticles.BackgroundTransparency = 1
    ButtonParticles.Parent = JoinButton
    
    JoinButton.MouseEnter:Connect(function()
        JoinHover.Visible = true
        JoinStroke.Color = Color3.fromRGB(255, 255, 255)
        
        for i = 1, 4 do
            CreateParticleEffect(ButtonParticles)
        end
    end)
    
    JoinButton.MouseLeave:Connect(function()
        JoinHover.Visible = false
        JoinStroke.Color = Color3.fromRGB(255, 255, 150)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        local scaleTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.3, 0)
        })
        
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        
        scaleTween:Play()
        fadeTween:Play()
        
        task.wait(0.5)
        JoinScreenGui:Destroy()
    end)
    
    JoinButton.MouseButton1Click:Connect(function()
        local jobId = JobIDTextBox.Text
        if jobId and jobId ~= "" then
            for i = 1, 8 do
                CreateParticleEffect(ParticleContainer)
            end
            
            local pulseTween = TweenService:Create(JoinButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0.95, -40, 0, 42)
            })
            pulseTween:Play()
            
            task.wait(0.2)
            
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, Players.LocalPlayer)
            end)
        else
            notify("Join Server", "Please enter a valid Job ID")
        end
    end)
    
    task.spawn(function()
        while JoinScreenGui.Parent do
            CreateParticleEffect(ParticleContainer)
            task.wait(0.5)
        end
    end)
    
    local EnterTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -160, 0.3, -100)
    })
    
    MainFrame.Position = UDim2.new(0.5, -160, 0, -220)
    EnterTween:Play()
end

local MainTab = Window:Tab({Title=GetText("MainTab"),Icon="compass"})

MainTab:Toggle({Title="🖱️ "..GetText("AutoClicker"), Callback=function(s) 
    Config.AutoClick=s 
    if s then
        notify(GetText("AutoClicker"), GetText("AutoClickEnabled"))
    else
        notify(GetText("AutoClicker"), GetText("AutoClickDisabled"))
    end
end})

MainTab:Toggle({Title="🤖 "..GetText("AutoFarmMonster"), Callback=function(s) 
    Config.AutoFarm=s 
    if s then
        notify(GetText("AutoFarmMonster"), GetText("AutoFarmEnabled"))
    else
        notify(GetText("AutoFarmMonster"), GetText("AutoFarmDisabled"))
    end
end})

MainTab:Toggle({Title="🔎 "..GetText("AutoFarmNearest"), Callback=function(s) 
    Config.AutoFarmDungeon=s 
    if s then
        notify(GetText("AutoFarmNearest"), GetText("FarmNearestEnabled"))
    else
        notify(GetText("AutoFarmNearest"), GetText("FarmNearestDisabled"))
    end
end})

local FarmMethodDropdown = MainTab:Dropdown({
    Title="🚶 "..GetText("FarmingMethod"), 
    Values={
        {Title="Instant", Callback=function() Config.FarmMethod="Instant" notify(GetText("FarmingMethod"), GetText("FarmMethod").."Instant") end},
        {Title="Fly", Callback=function() Config.FarmMethod="Fly" notify(GetText("FarmingMethod"), GetText("FarmMethod").."Fly") end},
        {Title="Walk", Callback=function() Config.FarmMethod="Walk" notify(GetText("FarmingMethod"), GetText("FarmMethod").."Walk") end}
    }
})

local EnemyList = {}
local SelectedEnemies = {}
local EnemyDropdown = MainTab:Dropdown({
    Title = "🎯 "..GetText("SelectEnemy"),
    Values = EnemyList,
    Multi = true,
    Callback = function(selected)
        SelectedEnemies = selected
        Config.SelectedEnemyNames = selected
        if #selected > 0 then
            notify(GetText("SelectEnemy"), GetText("EnemySelected")..table.concat(selected, ", "))
        end
    end
})

local DungeonList = {"Easy","Medium","Hard","Insane","Crazy","Nightmare","Leaf"}
local SelectedDungeons = {}
local DungeonDropdown = MainTab:Dropdown({
    Title = "🎪 "..GetText("SelectDungeon"),
    Values = DungeonList,
    Multi = true,
    Callback = function(selected)
        SelectedDungeons = selected
        Config.SelectedDungeons = selected
        if #selected > 0 then
            notify(GetText("SelectDungeon"), GetText("DungeonSelected")..table.concat(selected, ", "))
        end
    end
})

local function RefreshEnemyList()
    local newList = {}
    local debris = Workspace:FindFirstChild("Debris")
    if debris then
        local monsters = debris:FindFirstChild("Monsters")
        if monsters then
            for _,m in pairs(monsters:GetChildren()) do
                local t = m:GetAttribute("Title") or m.Name
                if not table.find(newList, t) then
                    table.insert(newList, t)
                end
            end
        end
    end
    
    if #newList > 0 then
        EnemyList = newList
        EnemyDropdown:Refresh(EnemyList)
    end
end

task.spawn(function()
    while task.wait(3) do
        RefreshEnemyList()
    end
end)

MainTab:Button({Title="🔄 "..GetText("RefreshEnemyLists"), Callback=function() 
    RefreshEnemyList()
    notify(GetText("RefreshEnemyLists"), GetText("EnemyListRefreshed"))
end})

MainTab:Button({Title="❌ "..GetText("ClearSelectedEnemies"), Callback=function() 
    EnemyDropdown:Refresh(EnemyList, {})
    SelectedEnemies = {}
    Config.SelectedEnemyNames = {}
    notify(GetText("ClearSelectedEnemies"), GetText("EnemiesCleared"))
end})

MainTab:Toggle({Title="⚡ "..GetText("AutoAddStats"), Callback=function(s) 
    Config.AutoAddStats=s 
    if s then
        notify(GetText("AutoAddStats"), GetText("AutoStatsEnabled"))
    else
        notify(GetText("AutoAddStats"), GetText("AutoStatsDisabled"))
    end
end})

local StatsList = {"Damage","Energy","Coins","Luck"}
local StatsDropdown = MainTab:Dropdown({
    Title="📈 "..GetText("AutoAddStats"), 
    Values=StatsList, 
    Multi=true,
    Callback=function(selected) 
        Config.SelectedStats = selected
    end
})

MainTab:Toggle({Title="🚪 "..GetText("AutoJoinDungeon"), Callback=function(s) 
    Config.AutoJoinDungeon=s 
    if s then
        notify(GetText("AutoJoinDungeon"), GetText("AutoDungeonEnabled"))
    else
        notify(GetText("AutoJoinDungeon"), GetText("AutoDungeonDisabled"))
    end
end})

MainTab:Toggle({Title="⚔️ "..GetText("AutoFarmDungeon"), Callback=function(s) 
    Config.AutoFarmDungeon=s 
    if s then
        notify(GetText("AutoFarmDungeon"), GetText("AutoFarmDungeonEnabled"))
    else
        notify(GetText("AutoFarmDungeon"), GetText("AutoFarmDungeonDisabled"))
    end
end})

local ServerTab = Window:Tab({Title=GetText("ServerInfo"),Icon="info"})
local ServerLabels = {}
ServerLabels["ServerTime"] = ServerTab:Section({Title="🕐 Server Time: --"})
ServerLabels["Players"] = ServerTab:Section({Title="👥 Players: --"})
ServerLabels["Executor"] = ServerTab:Section({Title="⚙️ Executor: --"})
ServerLabels["User"] = ServerTab:Section({Title="👤 User: --"})
ServerLabels["Energy"] = ServerTab:Section({Title="⚡ Energy: --"})
ServerLabels["Level"] = ServerTab:Section({Title="📊 Level: --"})
ServerLabels["Coins"] = ServerTab:Section({Title="💰 Coins: --"})
ServerLabels["JobID"] = ServerTab:Section({Title="🔗 JobID: --"})

ServerTab:Button({Title=GetText("CopyJobID"), Callback=function() 
    setclipboard(game.JobId)
    notify("JobID", GetText("JobIDCopied"))
end})

ServerTab:Button({Title=GetText("JoinByJobID"), Callback=MakeJoinJobIDUI})

local function safeIdentifyExecutor()
    local ok,res = pcall(function() return identifyexecutor() end)
    if ok and res then return res end
    return "Unknown"
end

task.spawn(function()
    local startTime = tick()
    while task.wait(1) do
        local plr = Players.LocalPlayer
        pcall(function()
            ServerLabels["ServerTime"]:Set("🕐 Server Time: "..os.date("%H:%M:%S"))
            ServerLabels["Players"]:Set("👥 Players: "..#Players:GetPlayers())
            ServerLabels["Executor"]:Set("⚙️ Executor: "..safeIdentifyExecutor())
            if plr then
                ServerLabels["User"]:Set("👤 User: "..plr.Name)
                local energy = plr:FindFirstChild("Energy") and plr.Energy.Value or 0
                local level = plr:FindFirstChild("Level") and plr.Level.Value or 0
                local coins = plr:FindFirstChild("Coins") and plr.Coins.Value or 0
                ServerLabels["Energy"]:Set("⚡ Energy: "..tostring(energy))
                ServerLabels["Level"]:Set("📊 Level: "..tostring(level))
                ServerLabels["Coins"]:Set("💰 Coins: "..tostring(coins))
                ServerLabels["JobID"]:Set("🔗 JobID: "..game.JobId)
            end
        end)
    end
end)

local function Click()
    pcall(function() 
        Events:FireServer({Action = "_Mouse_Click"}) 
    end)
end

task.spawn(function()
    while task.wait(Config.ClickDelay) do
        if Config.AutoClick then
            Click()
        end
    end
end)

local function IsMonsterAlive(mon)
    if not mon or not mon.Parent then return false end
    local health = mon:GetAttribute("Health")
    local healthPercent = mon:GetAttribute("Health_Percent")
    
    if typeof(health) == "number" and typeof(healthPercent) == "number" then
        return health > 0 and healthPercent > 0
    elseif typeof(health) == "number" then
        return health > 0
    elseif typeof(healthPercent) == "number" then
        return healthPercent > 0
    end
    
    local hum = mon:FindFirstChildOfClass("Humanoid")
    if hum then return hum.Health > 0 end
    
    return false
end

local function GetMonsterPrimary(mon)
    if not mon then return nil end
    return mon:FindFirstChild("HumanoidRootPart") or mon.PrimaryPart
end

local OriginalCollides = {}
local function NoClip()
    local plr = Players.LocalPlayer
    local char = plr and plr.Character
    if not char then return end
    OriginalCollides = {}
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then 
            OriginalCollides[p] = p.CanCollide
            p.CanCollide = false 
        end
    end
end

local function Clip()
    local plr = Players.LocalPlayer
    local char = plr and plr.Character
    if not char then return end
    for p, v in pairs(OriginalCollides) do 
        if p and p:IsA("BasePart") then 
            p.CanCollide = v 
        end 
    end
    OriginalCollides = {}
end

local currentTarget = nil
local lastTeleportTime = 0
local teleportCooldown = 0.3

local function TeleportTarget(primary)
    local currentTime = tick()
    if currentTime - lastTeleportTime < teleportCooldown then
        return
    end
    lastTeleportTime = currentTime
    
    local plr = Players.LocalPlayer
    local char = plr and plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and primary then
        NoClip()
        pcall(function() 
            hrp.CFrame = CFrame.new(primary.Position) + Vector3.new(0, 2, 0) 
        end)
        task.wait(Config.InstantDelay)
        Clip()
    end
end

local function FlyTarget(primary)
    local currentTime = tick()
    if currentTime - lastTeleportTime < teleportCooldown then
        return
    end
    lastTeleportTime = currentTime
    
    local plr = Players.LocalPlayer
    local char = plr and plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and primary then
        NoClip()
        local t = TweenService:Create(hrp, TweenInfo.new(Config.TweenDelay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = CFrame.new(primary.Position) + Vector3.new(0, 2, 0)
        })
        t:Play()
        t.Completed:Wait()
        Clip()
    end
end

local function WalkTarget(pos)
    local plr = Players.LocalPlayer
    local char = plr and plr.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    
    NoClip()
    hum:MoveTo(pos)
    
    local start = tick()
    while tick() - start < 3 do
        if not char or not char.PrimaryPart then break end
        local distance = (char.PrimaryPart.Position - pos).Magnitude
        if distance < 8 then 
            Clip()
            return true 
        end
        task.wait(0.05)
    end
    Clip()
    return false
end

local function AttackTarget(mon)
    local startTime = tick()
    while Config.AutoFarm and IsMonsterAlive(mon) and tick() - startTime < 10 do
        Click()
        task.wait(Config.ClickDelay)
    end
end

local function FindTargetsFromSelectedNames()
    local list = {}
    local debris = Workspace:FindFirstChild("Debris")
    if debris then
        local monsters = debris:FindFirstChild("Monsters")
        if monsters then
            for _, m in pairs(monsters:GetChildren()) do
                local t = m:GetAttribute("Title") or m.Name
                if table.find(Config.SelectedEnemyNames, t) and IsMonsterAlive(m) then 
                    table.insert(list, m) 
                end
            end
        end
    end
    return list
end

local function FindNearestFromList(list)
    local plr = Players.LocalPlayer
    local char = plr and plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = char.HumanoidRootPart
    local nearest = nil
    local nd = math.huge
    for _, m in pairs(list) do
        local prim = GetMonsterPrimary(m)
        if prim and IsMonsterAlive(m) then
            local d = (hrp.Position - prim.Position).Magnitude
            if d < nd then 
                nd = d
                nearest = m 
            end
        end
    end
    return nearest
end

local function FindAllNearbyEnemies()
    local list = {}
    local debris = Workspace:FindFirstChild("Debris")
    if debris then
        local monsters = debris:FindFirstChild("Monsters")
        if monsters then
            for _, m in pairs(monsters:GetChildren()) do
                if IsMonsterAlive(m) then 
                    table.insert(list, m) 
                end
            end
        end
    end
    return list
end

task.spawn(function()
    while task.wait(0.05) do
        if Config.AutoFarm then
            if currentTarget and not IsMonsterAlive(currentTarget) then
                currentTarget = nil
            end
            
            if not currentTarget then
                local targets = FindTargetsFromSelectedNames()
                if #targets > 0 then
                    local target = FindNearestFromList(targets)
                    if target and IsMonsterAlive(target) then
                        currentTarget = target
                        local prim = GetMonsterPrimary(target)
                        if prim then
                            if Config.FarmMethod == "Instant" then
                                TeleportTarget(prim)
                            elseif Config.FarmMethod == "Fly" then
                                FlyTarget(prim)
                            else
                                WalkTarget(prim.Position)
                            end
                        end
                    end
                end
            else
                if not IsMonsterAlive(currentTarget) then
                    currentTarget = nil
                else
                    local prim = GetMonsterPrimary(currentTarget)
                    if prim then
                        AttackTarget(currentTarget)
                    end
                end
            end
        else
            currentTarget = nil
        end
    end
end)

task.spawn(function()
    while task.wait(0.03) do
        if Config.AutoFarmDungeon then
            if currentTarget and not IsMonsterAlive(currentTarget) then
                currentTarget = nil
            end
            
            if not currentTarget then
                local targets = FindAllNearbyEnemies()
                if #targets > 0 then
                    local target = FindNearestFromList(targets)
                    if target and IsMonsterAlive(target) then
                        currentTarget = target
                        local prim = GetMonsterPrimary(target)
                        if prim then
                            TeleportTarget(prim)
                        end
                    end
                end
            else
                if not IsMonsterAlive(currentTarget) then
                    currentTarget = nil
                else
                    AttackTarget(currentTarget)
                end
            end
        else
            currentTarget = nil
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if Config.AutoAddStats and next(Config.SelectedStats) ~= nil then
            for _, stat in ipairs(Config.SelectedStats) do
                pcall(function() 
                    Events:FireServer({
                        Name = "Primary_" .. stat,
                        Action = "Assign_Level_Stats",
                        Amount = 1
                    }) 
                end)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if Config.AutoJoinDungeon and next(Config.SelectedDungeons) ~= nil then
            for _, dungeon in ipairs(Config.SelectedDungeons) do
                pcall(function() 
                    local dungeonName
                    if dungeon == "Leaf" then
                        dungeonName = "Leaf_Raid"
                    else
                        dungeonName = "Dungeon_" .. dungeon
                    end
                    
                    local args = {
                        {
                            Action = "_Enter_Dungeon",
                            Name = dungeonName
                        }
                    }
                    Events:FireServer(unpack(args))
                end)
            end
        end
    end
end)

local AFKConnection = nil
task.spawn(function()
    while task.wait(1) do
        if Config.AntiAFK then
            if not AFKConnection then
                AFKConnection = Players.LocalPlayer.Idled:Connect(function()
                    local vu = game:GetService("VirtualUser")
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new(0, 0))
                end)
            end
        else
            if AFKConnection then 
                pcall(function() 
                    AFKConnection:Disconnect() 
                end) 
                AFKConnection = nil 
            end
        end
    end
end)

RefreshEnemyList()
notify(HubTitle, GetText("Loaded") .. " - " .. Players.LocalPlayer.Name)
