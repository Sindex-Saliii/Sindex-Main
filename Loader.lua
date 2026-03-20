local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local PlayerGui = player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("TrigonHub") then
    PlayerGui:FindFirstChild("TrigonHub"):Destroy()
end

local Screen = Instance.new("ScreenGui")
Screen.Name = "TrigonHub"
Screen.IgnoreGuiInset = true
Screen.ResetOnSpawn = false
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.DisplayOrder = 999999
Screen.Parent = PlayerGui

local MasterHolder = Instance.new("Frame")
MasterHolder.Name = "MasterHolder"
MasterHolder.Size = UDim2.new(0, 400, 1, 0)
MasterHolder.AnchorPoint = Vector2.new(0.5, 0)
MasterHolder.Position = UDim2.new(0.5, 0, 0, 0)
MasterHolder.BackgroundTransparency = 1
MasterHolder.Parent = Screen

local UIList = Instance.new("UIListLayout")
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Top
UIList.Padding = UDim.new(0, 12)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = MasterHolder

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, UserInputService.TouchEnabled and 35 or 40)
Padding.Parent = MasterHolder

local BasePill = Instance.new("Frame")
BasePill.Name = "00_BasePill"
BasePill.Size = UDim2.new(0, 80, 0, 32)
BasePill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BasePill.BackgroundTransparency = 0.45
BasePill.BorderSizePixel = 0
BasePill.LayoutOrder = -1
BasePill.Parent = MasterHolder

local BaseCorner = Instance.new("UICorner")
BaseCorner.CornerRadius = UDim.new(1, 0)
BaseCorner.Parent = BasePill

local BaseStroke = Instance.new("UIStroke")
BaseStroke.Color = Color3.fromRGB(255, 255, 255)
BaseStroke.Transparency = 0.5
BaseStroke.Thickness = 1.8
BaseStroke.Parent = BasePill

local lastNotify = {}
local function LiquidGlassNotify(title, desc, icon, duration)
    local key = title .. desc
    if lastNotify[key] and tick() - lastNotify[key] < 3 then
        return
    end
    lastNotify[key] = tick()
    
    local dur = duration or 5
    local targetWidth = UserInputService.TouchEnabled and 310 or 360
    local targetHeight = 72

    local Card = Instance.new("Frame")
    Card.Name = "NotifyCard"
    Card.Size = UDim2.new(0, 80, 0, 0)
    Card.BackgroundTransparency = 1
    Card.ClipsDescendants = false
    Card.LayoutOrder = os.clock() * 1000
    Card.Parent = MasterHolder

    local MainBody = Instance.new("CanvasGroup")
    MainBody.Name = "MainBody"
    MainBody.Size = UDim2.new(0, 80, 0, 32)
    MainBody.Position = UDim2.new(0.5, -40, 0, -44)
    MainBody.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainBody.BackgroundTransparency = 0.35
    MainBody.GroupTransparency = 1
    MainBody.BorderSizePixel = 0
    MainBody.Parent = Card

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = MainBody

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 255, 255)
    Stroke.Transparency = 0.4
    Stroke.Thickness = 2.4
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = MainBody

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Parent = MainBody

    local IconImg = Instance.new("ImageLabel")
    IconImg.Size = UDim2.new(0, 30, 0, 30)
    IconImg.Position = UDim2.new(0, 18, 0.5, -15)
    IconImg.BackgroundTransparency = 1
    IconImg.Image = icon or "rbxassetid://6023426926"
    IconImg.ImageTransparency = 1
    IconImg.Parent = Content

    local TextHold = Instance.new("Frame")
    TextHold.Size = UDim2.new(1, -90, 1, 0)
    TextHold.Position = UDim2.new(0, 65, 0, 0)
    TextHold.BackgroundTransparency = 1
    TextHold.Parent = Content

    local Ttl = Instance.new("TextLabel")
    Ttl.Size = UDim2.new(1, 0, 0, 22)
    Ttl.Position = UDim2.new(0, 0, 0.5, -20)
    Ttl.BackgroundTransparency = 1
    Ttl.Font = Enum.Font.GothamBold
    Ttl.TextColor3 = Color3.fromRGB(15, 15, 15)
    Ttl.TextSize = 16
    Ttl.Text = title
    Ttl.TextXAlignment = Enum.TextXAlignment.Left
    Ttl.TextTransparency = 1
    Ttl.Parent = TextHold

    local Dsc = Instance.new("TextLabel")
    Dsc.Size = UDim2.new(1, 0, 0, 18)
    Dsc.Position = UDim2.new(0, 0, 0.5, 2)
    Dsc.BackgroundTransparency = 1
    Dsc.Font = Enum.Font.GothamMedium
    Dsc.TextColor3 = Color3.fromRGB(60, 60, 65)
    Dsc.TextSize = 13
    Dsc.Text = desc
    Dsc.TextXAlignment = Enum.TextXAlignment.Left
    Dsc.TextTransparency = 1
    Dsc.Parent = TextHold

    local Progress = Instance.new("Frame")
    Progress.Size = UDim2.new(0, 0, 0, 3)
    Progress.Position = UDim2.new(0, 18, 1, -8)
    Progress.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Progress.BackgroundTransparency = 0.75
    Progress.BorderSizePixel = 0
    Progress.Parent = MainBody
    Instance.new("UICorner", Progress)

    local introInfo = TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    TweenService:Create(Card, introInfo, {Size = UDim2.new(0, targetWidth, 0, targetHeight)}):Play()
    TweenService:Create(MainBody, introInfo, {Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 1, 0), GroupTransparency = 0}):Play()
    TweenService:Create(Corner, introInfo, {CornerRadius = UDim.new(0, 24)}):Play()

    task.delay(0.2, function()
        local fadeInfo = TweenInfo.new(0.4)
        TweenService:Create(IconImg, fadeInfo, {ImageTransparency = 0}):Play()
        TweenService:Create(Ttl, fadeInfo, {TextTransparency = 0}):Play()
        TweenService:Create(Dsc, fadeInfo, {TextTransparency = 0}):Play()
        TweenService:Create(Progress, TweenInfo.new(dur, Enum.EasingStyle.Linear), {Size = UDim2.new(1, -36, 0, 3)}):Play()
    end)

    task.delay(dur + 0.8, function()
        local outroInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        
        TweenService:Create(IconImg, TweenInfo.new(0.2), {ImageTransparency = 1}):Play()
        TweenService:Create(Ttl, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(Dsc, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        TweenService:Create(Progress, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        
        task.wait(0.15)
        
        TweenService:Create(MainBody, outroInfo, {Position = UDim2.new(0.5, -40, 0, -44), Size = UDim2.new(0, 80, 0, 32), GroupTransparency = 1}):Play()
        TweenService:Create(Corner, outroInfo, {CornerRadius = UDim.new(1, 0)}):Play()
        local cardTween = TweenService:Create(Card, outroInfo, {Size = UDim2.new(0, 80, 0, 0)})
        cardTween:Play()
        
        cardTween.Completed:Wait()
        Card:Destroy()
    end)
end

getgenv().LiquidGlassNotify = LiquidGlassNotify

local fileName = "TrigonHub/TotalExecution.json"
if not isfile(fileName) then
    writefile(fileName, "0")
end
local currentValue = tonumber(readfile(fileName)) or 0
currentValue = currentValue + 1
writefile(fileName, tostring(currentValue))

local tanggal = os.date("%d/%m/%Y")
local infoXXX = MarketplaceService:GetProductInfo(game.PlaceId)

local function formatNumber(n)
    n = tonumber(n) or 0
    local abs = math.abs(n)
    local function clean(num)
        local s = string.format("%.2f", num)
        return s:gsub("%.?0+$", "")
    end
    if abs >= 1e12 then
        return clean(n / 1e12) .. "T"
    elseif abs >= 1e9 then
        return clean(n / 1e9) .. "B"
    elseif abs >= 1e6 then
        return clean(n / 1e6) .. "M"
    elseif abs >= 1e3 then
        return clean(n / 1e3) .. "K"
    else
        return tostring(n)
    end
end

local function sendWebhook()
    local level = player.Data and player.Data.Level and player.Data.Level.Value or 0
    local money = player.Data and player.Data.Money and formatNumber(player.Data.Money.Value) or "0"
    local gems = player.Data and player.Data.Gems and formatNumber(player.Data.Gems.Value) or "0"
    local timeString = os.date("%H:%M:%S")
    local clientId = RbxAnalyticsService:GetClientId()
    local data = {
        ["username"] = "Trigon Hub",
        ["avatar_url"] = "https://i.imgur.com/SGVO85F.png",
        ["embeds"] = {
            {
                ["title"] = "Player Execute Data",
                ["description"] = "**Player Info**\nName: || **" .. player.Name .. "** ||\nClient ID: || **" .. clientId .. "** ||\n\n⭐ Level: **" .. level .. "**    💰 Money: **" .. money .. "**    💎 Gems: **" .. gems .. "**\n\n**Script Info**\nTotal Execute: **" .. currentValue .. "**\nStatus: **Free**\nExecutor: **" .. identifyexecutor() .. "**\nGame: **" .. infoXXX.Name .. "**\nDate: **" .. tanggal .. " " .. timeString .. "**",
                ["color"] = 16711680
            }
        }
    }
    local encoded = HttpService:JSONEncode(data)
    local requestFunc = http_request or request or syn.request
    if requestFunc then
        requestFunc({
            Url = "https://discordapp.com/api/webhooks/1484611558368612383/DePzcitftmkoICe6YAPL3hfPPDKj3d3PD2BBkG0MRWMdW9gYnA_3wtbPcHFT6o_le7Ja",
            Body = encoded,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"}
        })
    end
end

task.spawn(function()
    task.wait(2)
    sendWebhook()
end)

player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local function BoostFps()
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    for _,v in pairs(Lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e10
    Lighting.Brightness = 1
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        end
        if v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end
end

local function GetAllMonsters()
    local monsterList = {}
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, v in pairs(npcsFolder:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Name ~= "Dummy" and not table.find(monsterList, v.Name) then
                table.insert(monsterList, v.Name)
            end
        end
    end
    return monsterList
end

local function GetDungeonList()
    return {"CidDungeon", "RuneDungeon", "DoubleDungeon", "BossRush"}
end

local function GetNormalBossList()
    local bossList = {}
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, v in pairs(npcsFolder:GetChildren()) do
            if v:FindFirstChild("Humanoid") and string.find(string.upper(v.Name), "BOSS") and not string.find(v.Name, "Summon") and v.Name ~= "Dummy" then
                table.insert(bossList, v.Name)
            end
        end
    end
    return bossList
end

local function GetSummonBossList()
    return {
        "SaberBoss", "SaberAlterBoss", "QinShiBoss", "IchigoBoss", "GilgameshBoss",
        "BlessedMaidenBoss", "StrongestToday", "StrongestHistory", "RimuruBoss", "AnosBoss", "TrueAizenBoss"
    }
end

local function GetAllWeapons()
    local weapons = {"None"}
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(weapons, tool.Name)
            end
        end
    end
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and not table.find(weapons, tool.Name) then
                table.insert(weapons, tool.Name)
            end
        end
    end
    return weapons
end

local IslandPositions = {
    ["Starter"] = {Position = Vector3.new(140.463,16.020,-232.606), Distance = 300},
    ["Jungle"] = {Position = Vector3.new(-549.459,-1.637,450.971), Distance = 250},
    ["Desert"] = {Position = Vector3.new(-858.283,7.399,-423.216), Distance = 180},
    ["Snow"] = {Position = Vector3.new(-404.007,8.778,-1108.406), Distance = 350},
    ["Sailor"] = {Position = Vector3.new(241.337,58.223,878.630), Distance = 320},
    ["Shibuya"] = {Position = Vector3.new(1634.826,94.872,249.179), Distance = 700},
    ["HuecoMundo"] = {Position = Vector3.new(-548.874,0.323,1172.332), Distance = 400},
    ["Boss"] = {Position = Vector3.new(768.425,-0.666,-1087.132), Distance = 180},
    ["Shinjuku"] = {Position = Vector3.new(320.879,-4.176,-2004.636), Distance = 750},
    ["Slime"] = {Position = Vector3.new(-1183.336,44.491,212.571), Distance = 400},
    ["Academy"] = {Position = Vector3.new(963.089,2.262,1327.112), Distance = 250},
    ["Judgement"] = {Position = Vector3.new(-1244.099,77.019,-1236.863), Distance = 420},
    ["SoulSociety"] = {Position = Vector3.new(-1303.725,1624.637,1672.498), Distance = 170}
}

local function GetClosestIsland(pos)
    for name, data in pairs(IslandPositions) do
        if (pos - data.Position).Magnitude <= data.Distance then
            return name
        end
    end
    return nil
end

local TeleportRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("TeleportToPortal")
local function TeleportToIsland(islandName)
    if not islandName or not TeleportRemote then return end
    pcall(function()
        TeleportRemote:FireServer(islandName)
        LiquidGlassNotify("Teleport", "Moving to " .. islandName, "rbxassetid://82500352718600", 2)
    end)
    task.wait(2)
end

local CombatRemote = ReplicatedStorage:FindFirstChild("CombatSystem") and ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
local AbilityRemote = ReplicatedStorage:FindFirstChild("AbilitySystem") and ReplicatedStorage.AbilitySystem:FindFirstChild("Remotes") and ReplicatedStorage.AbilitySystem.Remotes:FindFirstChild("RequestAbility")
local HakiRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("HakiRemote")
local ObservationRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("ObservationHakiRemote")
local ConquerorRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("ConquerorHakiRemote")
local QuestAccept = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("QuestAccept")
local QuestAbandon = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("QuestAbandon")
local CodeRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("CodeRedeem")
local StatRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("AllocateStat")
local SummonBossRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestSummonBoss")
local SpawnStrongestRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestSpawnStrongestBoss")
local SpawnRimuruRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("RequestSpawnRimuru")
local SpawnAnosRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestSpawnAnosBoss")
local SpawnTrueAizenRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("RequestSpawnTrueAizen")
local DungeonPortalRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestDungeonPortal")
local DungeonVoteRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("DungeonWaveVote")
local DungeonReplayRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("DungeonWaveReplayVote")
local AscendRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("RequestAscend")
local LoadoutRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("LoadoutLoad")
local CodesModule = ReplicatedStorage:FindFirstChild("CodesConfig") and require(ReplicatedStorage.CodesConfig)

local function RedeemAllCodes()
    if not CodeRemote or not CodesModule then return end
    local successCount = 0
    local failCount = 0
    for codeName, data in pairs(CodesModule.Codes) do
        local success = pcall(function()
            if CodesModule.IsValid(codeName) then
                CodeRemote:InvokeServer(codeName)
                successCount = successCount + 1
            else
                failCount = failCount + 1
            end
        end)
        if not success then failCount = failCount + 1 end
        task.wait(0.3)
    end
    LiquidGlassNotify("Codes", "Success: " .. successCount .. " | Failed: " .. failCount, "rbxassetid://82500352718600", 4)
end

local function IsBusoActive()
    local char = player.Character
    if not char then return false end
    local parts = {char:FindFirstChild("Right Arm"), char:FindFirstChild("Left Arm")}
    for _, part in ipairs(parts) do
        if part and part:IsA("Part") then
            local c = part.Color
            if c.R == 0 and c.G == 0 and c.B == 0 then
                return true
            end
        end
    end
    return false
end

local function IsObservationActive()
    local dodgeUI = player.PlayerGui:FindFirstChild("DodgeCounterUI")
    return dodgeUI and dodgeUI.MainFrame and dodgeUI.MainFrame.Visible == true
end

local function EnableHaki()
    if not HakiRemote then return end
    if not IsBusoActive() then
        pcall(function() HakiRemote:FireServer("Toggle") end)
    end
end

local function EnableObservation()
    if not ObservationRemote then return end
    if not IsObservationActive() then
        pcall(function() ObservationRemote:FireServer("Toggle") end)
    end
end

local function EnableConqueror()
    if ConquerorRemote then
        pcall(function() ConquerorRemote:FireServer() end)
    end
end

local function GetCurrentQuestMob()
    local questUI = player.PlayerGui:FindFirstChild("QuestUI")
    if questUI and questUI:FindFirstChild("Quest") then
        local progressFrame = questUI.Quest:FindFirstChild("ProgressFrame")
        if progressFrame then
            for _, v in pairs(progressFrame:GetChildren()) do
                if v:IsA("Frame") and v:FindFirstChild("MobName") then
                    local mobName = v.MobName:FindFirstChild("TextLabel")
                    if mobName then
                        return mobName.Text
                    end
                end
            end
        end
    end
    return nil
end

local function GetBestQuest()
    local QuestModule = ReplicatedStorage:FindFirstChild("Modules") and require(ReplicatedStorage.Modules.QuestConfig)
    if not QuestModule or not QuestModule.RepeatableQuests then return nil end
    local level = player.Data.Level.Value
    local bestNPC = nil
    local bestLevel = -math.huge
    for npc, quest in pairs(QuestModule.RepeatableQuests) do
        if level >= quest.recommendedLevel then
            if quest.recommendedLevel > bestLevel then
                bestLevel = quest.recommendedLevel
                bestNPC = npc
            end
        end
    end
    return bestNPC
end

local function StartQuest()
    if not QuestAccept or not QuestAbandon then return end
    pcall(function() QuestAbandon:FireServer("repeatable") end)
    task.wait(0.5)
    local questNPC = GetBestQuest()
    if questNPC then
        pcall(function() QuestAccept:FireServer(questNPC) end)
        LiquidGlassNotify("Quest", "Accepted: " .. questNPC, "rbxassetid://82500352718600", 2)
        task.wait(1)
    end
end

local function GetNearestMonster()
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if not npcsFolder then return nil end
    local char = player.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local nearestMonster = nil
    local shortestDistance = math.huge
    for _, v in pairs(npcsFolder:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Dummy" then
            local monsterRoot = v:FindFirstChild("HumanoidRootPart")
            local distance = (root.Position - monsterRoot.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestMonster = v
            end
        end
    end
    return nearestMonster
end

local function FindNPC(name, mode)
    if name == "None" then return nil end
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if not npcsFolder then return nil end
    for _, npc in pairs(npcsFolder:GetChildren()) do
        local hum = npc:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local originalName = npc.Name
        if mode == "Boss" then
            if originalName == name then return npc end
        else
            local processedName = originalName:gsub("%d+", ""):match("^%s*(.-)%s*$")
            if processedName == name then return npc end
        end
    end
    return nil
end

local function IsBossAlive(bossName)
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if not npcsFolder then return false, nil end
    local searchNames = {}
    if bossName == "SaberBoss" then searchNames = {"SaberBoss"}
    elseif bossName == "SaberAlterBoss" then searchNames = {"SaberAlterBoss", "SaberAlterBoss_Normal", "SaberAlterBoss_Medium", "SaberAlterBoss_Hard", "SaberAlterBoss_Extreme"}
    elseif bossName == "StrongestToday" then searchNames = {"StrongestofTodayBoss_Normal", "StrongestofTodayBoss_Medium", "StrongestofTodayBoss_Hard", "StrongestofTodayBoss_Extreme"}
    elseif bossName == "StrongestHistory" then searchNames = {"StrongestinHistoryBoss_Normal", "StrongestinHistoryBoss_Medium", "StrongestinHistoryBoss_Hard", "StrongestinHistoryBoss_Extreme"}
    elseif bossName == "RimuruBoss" then searchNames = {"RimuruBoss_Normal", "RimuruBoss_Medium", "RimuruBoss_Hard", "RimuruBoss_Extreme"}
    elseif bossName == "AnosBoss" then searchNames = {"AnosBoss_Normal", "AnosBoss_Medium", "AnosBoss_Hard", "AnosBoss_Extreme"}
    elseif bossName == "TrueAizenBoss" then searchNames = {"TrueAizenBoss_Normal", "TrueAizenBoss_Medium", "TrueAizenBoss_Hard", "TrueAizenBoss_Extreme"}
    else searchNames = {bossName} end
    for _, name in ipairs(searchNames) do
        local boss = npcsFolder:FindFirstChild(name)
        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
            return true, boss
        end
    end
    return false, nil
end

local function SummonSelectedBoss(bossName, difficulty)
    if not bossName or bossName == "" then return end
    local alive = IsBossAlive(bossName)
    if alive then return end
    if bossName == "SaberBoss" or bossName == "QinShiBoss" or bossName == "IchigoBoss" then
        if SummonBossRemote then pcall(function() SummonBossRemote:FireServer(bossName) end) end
    elseif bossName == "SaberAlterBoss" or bossName == "GilgameshBoss" or bossName == "BlessedMaidenBoss" then
        if SummonBossRemote then pcall(function() SummonBossRemote:FireServer(bossName, difficulty or "Normal") end) end
    elseif bossName == "StrongestToday" then
        if SpawnStrongestRemote then pcall(function() SpawnStrongestRemote:FireServer("StrongestToday", difficulty or "Normal") end) end
    elseif bossName == "StrongestHistory" then
        if SpawnStrongestRemote then pcall(function() SpawnStrongestRemote:FireServer("StrongestHistory", difficulty or "Normal") end) end
    elseif bossName == "RimuruBoss" then
        if SpawnRimuruRemote then pcall(function() SpawnRimuruRemote:FireServer(difficulty or "Normal") end) end
    elseif bossName == "AnosBoss" then
        if SpawnAnosRemote then pcall(function() SpawnAnosRemote:FireServer("Anos", difficulty or "Normal") end) end
    elseif bossName == "TrueAizenBoss" then
        if SpawnTrueAizenRemote then pcall(function() SpawnTrueAizenRemote:FireServer(difficulty or "Normal") end) end
    end
    LiquidGlassNotify("Boss", "Summoning " .. bossName, "rbxassetid://82500352718600", 2)
end

local noclipConnection = nil
local function SetNoclip(state)
    if noclipConnection then noclipConnection:Disconnect() end
    if state then
        noclipConnection = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

local currentTween = nil
local isTweening = false
local function TPToPosition(pos)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local targetCF = CFrame.new(pos) * CFrame.Angles(math.rad(-90), 0, 0)
    if currentTween then currentTween:Cancel() end
    isTweening = true
    local distance = (root.Position - pos).Magnitude
    local duration = math.max(0.5, distance / 190)
    currentTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCF})
    currentTween:Play()
    currentTween.Completed:Wait()
    currentTween = nil
    isTweening = false
end

local function AttackTarget(target)
    if not target or not target:FindFirstChild("Humanoid") or target.Humanoid.Health <= 0 then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local targetRoot = target:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    local attackPos = targetRoot.CFrame * CFrame.new(0, 0, 11) * CFrame.Angles(math.rad(-90), 0, 0)
    if (root.Position - attackPos.Position).Magnitude > 5 and not isTweening then
        TPToPosition(attackPos.Position)
    end
    if CombatRemote then
        pcall(function() CombatRemote:FireServer(targetRoot.Position) end)
    end
    if getgenv().AutoZ then
        if AbilityRemote then pcall(function() AbilityRemote:FireServer(1) end) end
    end
    if getgenv().AutoX then
        if AbilityRemote then pcall(function() AbilityRemote:FireServer(2) end) end
    end
    if getgenv().AutoC then
        if AbilityRemote then pcall(function() AbilityRemote:FireServer(3) end) end
    end
    if getgenv().AutoV then
        if AbilityRemote then pcall(function() AbilityRemote:FireServer(4) end) end
    end
    if getgenv().AutoF then
        if AbilityRemote then pcall(function() AbilityRemote:FireServer(5) end) end
    end
end

local function OpenDungeon(dungeonName)
    if not dungeonName or dungeonName == "" then return end
    if DungeonPortalRemote then
        pcall(function() DungeonPortalRemote:FireServer(dungeonName) end)
        LiquidGlassNotify("Dungeon", "Opening " .. dungeonName, "rbxassetid://82500352718600", 2)
    end
end

local function VoteDifficulty(difficulty)
    if DungeonVoteRemote then
        pcall(function() DungeonVoteRemote:FireServer(difficulty) end)
    end
end

local function VoteReplay()
    if DungeonReplayRemote then
        pcall(function() DungeonReplayRemote:FireServer("sponsor") end)
    end
end

local function AutoAscend()
    if AscendRemote then
        pcall(function() AscendRemote:FireServer() end)
    end
end

local function LoadBuild(buildId)
    if LoadoutRemote then
        pcall(function() LoadoutRemote:FireServer(buildId) end)
    end
end

local function GetAllIslands()
    local PortalModule = ReplicatedStorage:FindFirstChild("PortalConfig") and require(ReplicatedStorage.PortalConfig)
    local islands = {}
    if PortalModule and PortalModule.Portals then
        for name, _ in pairs(PortalModule.Portals) do
            table.insert(islands, name)
        end
    end
    table.sort(islands)
    return islands
end

local function GetAllServiceNPCs()
    local npcFolder = Workspace:FindFirstChild("ServiceNPCs")
    local npcs = {}
    if npcFolder then
        for _, v in pairs(npcFolder:GetChildren()) do
            if v:IsA("Model") then
                table.insert(npcs, v.Name)
            end
        end
    end
    table.sort(npcs)
    return npcs
end

local function AntiAfk()
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    LiquidGlassNotify("Anti AFK", "Enabled", "rbxassetid://82500352718600", 2)
end

local function Invisible()
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.Transparency = 1
            elseif v:IsA("Decal") then
                v.Transparency = 1
            end
        end
    end
end

local function LoadConfig()
    if not isfile("Trigon_SailorPiece_Config.json") then
        getgenv().AutoFarm = false
        getgenv().AutoDungeon = false
        getgenv().AutoVoteDifficulty = false
        getgenv().SelectedDungeon = ""
        getgenv().DungeonDifficulty = "Easy"
        getgenv().AutoReplayDungeon = false
        getgenv().AutoQuest = false
        getgenv().AcceptBoss = true
        getgenv().AutoQuestForMonster = false
        getgenv().AutoBoss = false
        getgenv().AutoSummonBoss = false
        getgenv().SelectedBoss = ""
        getgenv().BossDifficulty = "Normal"
        getgenv().AutoFarmSelectedBoss = false
        getgenv().AutoHop = false
        getgenv().AutoHaki = false
        getgenv().AutoZ = false
        getgenv().AutoX = false
        getgenv().AutoC = false
        getgenv().AutoV = false
        getgenv().AutoF = false
        getgenv().AutoStat = false
        getgenv().StatPoints = 50
        getgenv().SelectedStat = "Sword"
        getgenv().SelectedMonsters = {}
        getgenv().freezeEnabled = true
        getgenv().hitboxEnabled = true
        getgenv().useRandomPos = false
        getgenv().tpX = 0
        getgenv().tpY = 9
        getgenv().tpZ = 0
        getgenv().tweenSpeed = 100
        getgenv().PrimaryWeapon = ""
        getgenv().AutoSave = false
        getgenv().WhiteScreen = false
        getgenv().AutoAscend = false
        return
    end
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile("Trigon_SailorPiece_Config.json"))
    end)
    if not success then
        getgenv().AutoFarm = false
        getgenv().AutoDungeon = false
        getgenv().AutoVoteDifficulty = false
        getgenv().SelectedDungeon = ""
        getgenv().DungeonDifficulty = "Easy"
        getgenv().AutoReplayDungeon = false
        getgenv().AutoQuest = false
        getgenv().AcceptBoss = true
        getgenv().AutoQuestForMonster = false
        getgenv().AutoBoss = false
        getgenv().AutoSummonBoss = false
        getgenv().SelectedBoss = ""
        getgenv().BossDifficulty = "Normal"
        getgenv().AutoFarmSelectedBoss = false
        getgenv().AutoHop = false
        getgenv().AutoHaki = false
        getgenv().AutoZ = false
        getgenv().AutoX = false
        getgenv().AutoC = false
        getgenv().AutoV = false
        getgenv().AutoF = false
        getgenv().AutoStat = false
        getgenv().StatPoints = 50
        getgenv().SelectedStat = "Sword"
        getgenv().SelectedMonsters = {}
        getgenv().freezeEnabled = true
        getgenv().hitboxEnabled = true
        getgenv().useRandomPos = false
        getgenv().tpX = 0
        getgenv().tpY = 9
        getgenv().tpZ = 0
        getgenv().tweenSpeed = 100
        getgenv().PrimaryWeapon = ""
        getgenv().AutoSave = false
        getgenv().WhiteScreen = false
        getgenv().AutoAscend = false
        return
    end
    getgenv().AutoFarm = data.AutoFarm or false
    getgenv().AutoDungeon = data.AutoDungeon or false
    getgenv().AutoVoteDifficulty = data.AutoVoteDifficulty or false
    getgenv().SelectedDungeon = data.SelectedDungeon or ""
    getgenv().DungeonDifficulty = data.DungeonDifficulty or "Easy"
    getgenv().AutoReplayDungeon = data.AutoReplayDungeon or false
    getgenv().AutoQuest = data.AutoQuest or false
    getgenv().AcceptBoss = data.AcceptBoss or true
    getgenv().AutoQuestForMonster = data.AutoQuestForMonster or false
    getgenv().AutoBoss = data.AutoBoss or false
    getgenv().AutoSummonBoss = data.AutoSummonBoss or false
    getgenv().SelectedBoss = data.SelectedBoss or ""
    getgenv().BossDifficulty = data.BossDifficulty or "Normal"
    getgenv().AutoFarmSelectedBoss = data.AutoFarmSelectedBoss or false
    getgenv().AutoHop = data.AutoHop or false
    getgenv().AutoHaki = data.AutoHaki or false
    getgenv().AutoZ = data.AutoZ or false
    getgenv().AutoX = data.AutoX or false
    getgenv().AutoC = data.AutoC or false
    getgenv().AutoV = data.AutoV or false
    getgenv().AutoF = data.AutoF or false
    getgenv().AutoStat = data.AutoStat or false
    getgenv().StatPoints = data.StatPoints or 50
    getgenv().SelectedStat = data.SelectedStat or "Sword"
    getgenv().SelectedMonsters = data.SelectedMonsters or {}
    getgenv().freezeEnabled = data.freezeEnabled or true
    getgenv().hitboxEnabled = data.hitboxEnabled or true
    getgenv().useRandomPos = data.useRandomPos or false
    getgenv().tpX = data.tpX or 0
    getgenv().tpY = data.tpY or 9
    getgenv().tpZ = data.tpZ or 0
    getgenv().tweenSpeed = data.tweenSpeed or 100
    getgenv().PrimaryWeapon = data.PrimaryWeapon or ""
    getgenv().AutoSave = false
    getgenv().WhiteScreen = data.WhiteScreen or false
    getgenv().AutoAscend = data.AutoAscend or false
end

LoadConfig()

local tweenSpeed = getgenv().tweenSpeed
local freezeEnabled = getgenv().freezeEnabled
local hitboxEnabled = getgenv().hitboxEnabled
local PrimaryWeapon = getgenv().PrimaryWeapon
local CurrentWeapon = nil
local CurrentTarget = nil
local lastAttackTime = 0
local lastQuestTime = 0
local questCooldown = 2
local lastStatTime = 0
local statCooldown = 1
local lastTeleportTime = 0
local teleportCooldown = 0.2
local currentMob = nil
local lastQuestNotify = 0
local lastMobNotify = ""
local attackCooldown = {}
local respawnConnection = nil
local isRespawning = false
local zigzagTimer = 0
local hasQuestOnDeath = false
local questCheckTimer = 0
local lastQuestCheck = 0
local isStartingQuest = false
local lastQuestStartAttempt = 0
local skillCooldowns = {Z = 0, X = 0, C = 0, V = 0}
local lastSkillTime = 0
local noclipConnection = nil
local antiFlingConnection = nil
local nearestScanTimer = 0
local bossSpawned = false
local lastBossCheck = 0
local lastNormalAttack = 0
local isAtBossSpawnPoint = false
local bossSpawnPoint = nil
local lastHakiCheck = 0
local hopAttempts = 0
local maxHopAttempts = 10
local hopCooldown = 0
local lastHopTime = 0
local questCompleteTime = 0
local farmingEnabled = false

local useRandomPos = getgenv().useRandomPos
local tpX = getgenv().tpX
local tpY = getgenv().tpY
local tpZ = getgenv().tpZ

local codes = {"SORRYFOR1HDELAY","HUGEUPDATEW","3SPECS","30KFOLLOWTY","30MVISITS","40KCCUWILD", "35KCCUWOW", "SORRYSUDDENRESTART", "BADISSUESSORRY", "BOSSRUSH", "VERYBIGUPDATESOON", "SINOFPRIDE", "15KFOLLOWTY", "ROGUEALLIES", "RUSHKEYCODE"}

local Accept = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("QuestAccept")
local Abandon = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("QuestAbandon")
local QuestUpdate = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("QuestUIUpdate")
local QuestConfig = ReplicatedStorage:FindFirstChild("Modules") and require(ReplicatedStorage.Modules:FindFirstChild("QuestConfig"))
local combatRemote = ReplicatedStorage:FindFirstChild("CombatSystem") and ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
local abilityRemote = ReplicatedStorage:FindFirstChild("AbilitySystem") and ReplicatedStorage.AbilitySystem:FindFirstChild("Remotes") and ReplicatedStorage.AbilitySystem.Remotes:FindFirstChild("RequestAbility")
local codeRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("CodeRedeem")
local TeleportRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("TeleportToPortal")
local SummonBossRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestSummonBoss")
local SpawnStrongestRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestSpawnStrongestBoss")
local SpawnRimuruRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("RequestSpawnRimuru")
local SpawnAnosRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestSpawnAnosBoss")
local SpawnTrueAizenRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("RequestSpawnTrueAizen")
local DungeonPortalRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("RequestDungeonPortal")
local DungeonVoteRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("DungeonWaveVote")
local DungeonReplayRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("DungeonWaveReplayVote")
local HakiRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and ReplicatedStorage.RemoteEvents:FindFirstChild("HakiRemote")

local currentTween = nil
local isTweening = false
local stablePosition = nil
local lockConnection = nil

local function SaveConfig()
    local data = {
        AutoFarm = getgenv().AutoFarm,
        AutoDungeon = getgenv().AutoDungeon,
        AutoVoteDifficulty = getgenv().AutoVoteDifficulty,
        SelectedDungeon = getgenv().SelectedDungeon,
        DungeonDifficulty = getgenv().DungeonDifficulty,
        AutoReplayDungeon = getgenv().AutoReplayDungeon,
        AutoQuest = getgenv().AutoQuest,
        AcceptBoss = getgenv().AcceptBoss,
        AutoQuestForMonster = getgenv().AutoQuestForMonster,
        AutoBoss = getgenv().AutoBoss,
        AutoSummonBoss = getgenv().AutoSummonBoss,
        SelectedBoss = getgenv().SelectedBoss,
        BossDifficulty = getgenv().BossDifficulty,
        AutoFarmSelectedBoss = getgenv().AutoFarmSelectedBoss,
        AutoHop = getgenv().AutoHop,
        AutoHaki = getgenv().AutoHaki,
        AutoZ = getgenv().AutoZ,
        AutoX = getgenv().AutoX,
        AutoC = getgenv().AutoC,
        AutoV = getgenv().AutoV,
        AutoF = getgenv().AutoF,
        AutoStat = getgenv().AutoStat,
        StatPoints = getgenv().StatPoints,
        SelectedStat = getgenv().SelectedStat,
        SelectedMonsters = getgenv().SelectedMonsters,
        freezeEnabled = freezeEnabled,
        hitboxEnabled = hitboxEnabled,
        useRandomPos = useRandomPos,
        tpX = tpX,
        tpY = tpY,
        tpZ = tpZ,
        tweenSpeed = tweenSpeed,
        PrimaryWeapon = PrimaryWeapon or "",
        WhiteScreen = getgenv().WhiteScreen,
        AutoAscend = getgenv().AutoAscend
    }
    writefile("Trigon_SailorPiece_Config.json", HttpService:JSONEncode(data))
    LiquidGlassNotify("Config", "Saved Successfully", "rbxassetid://82500352718600", 2)
end

local function AutoSave()
    if getgenv().AutoSave then
        SaveConfig()
    end
end

local function EnableAntiFling()
    if antiFlingConnection then
        antiFlingConnection:Disconnect()
    end
    antiFlingConnection = RunService.Heartbeat:Connect(function()
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")
        if root and humanoid and humanoid.Health > 0 then
            root.Velocity = Vector3.new(0, root.Velocity.Y * 0.5, 0)
            root.RotVelocity = Vector3.new(0, 0, 0)
            if stablePosition and (root.Position - stablePosition).Magnitude > 10 then
                root.CFrame = CFrame.new(stablePosition) * CFrame.Angles(math.rad(-90), 0, 0)
            end
        end
    end)
end

local function DisableAntiFling()
    if antiFlingConnection then
        antiFlingConnection:Disconnect()
        antiFlingConnection = nil
    end
    stablePosition = nil
end

local function EnableNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
    end
    noclipConnection = RunService.Heartbeat:Connect(function()
        local char = player.Character
        if not char then return end
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end)
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end

local function DisableNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end

local function StopAllTweens()
    getgenv().StopTween = true
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
    isTweening = false
    DisableNoclip()
    DisableAntiFling()
    if lockConnection then
        lockConnection:Disconnect()
        lockConnection = nil
    end
    local char = player.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CanCollide = true
        end
    end
end

local function LockPosition(position)
    stablePosition = position
    if lockConnection then
        lockConnection:Disconnect()
    end
    lockConnection = RunService.Heartbeat:Connect(function()
        local char = player.Character
        if not char or getgenv().StopTween then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and stablePosition then
            root.CFrame = CFrame.new(stablePosition) * CFrame.Angles(math.rad(-90), 0, 0)
        end
    end)
end

local function SmoothTween(targetCF)
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end
    if humanoid.Sit then 
        humanoid.Sit = false
    end
    getgenv().StopTween = false
    isTweening = true
    root.CanCollide = false
    EnableNoclip()
    EnableAntiFling()
    
    local startPos = root.Position
    local endPos = targetCF.Position
    local distance = (endPos - startPos).Magnitude
    local speed = tweenSpeed
    local duration = math.max(0.5, distance / speed)
    
    currentTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCF})
    currentTween:Play()
    currentTween.Completed:Wait()
    
    if not getgenv().StopTween then
        stablePosition = endPos
        LockPosition(endPos)
        root.CanCollide = true
        DisableNoclip()
    end
    currentTween = nil
    isTweening = false
end

local function TPToPositionManual(x, y, z)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local targetPos = Vector3.new(x, y, z)
    local targetCF = CFrame.new(targetPos) * CFrame.Angles(math.rad(-90), 0, 0)
    if (root.Position - targetPos).Magnitude > 3 then
        SmoothTween(targetCF)
    else
        root.CFrame = targetCF
        stablePosition = targetPos
        LockPosition(targetPos)
    end
end

local function Cooldown(key, t)
    t = t or 0.15
    local now = os.clock()
    local last = attackCooldown[key] or 0
    if now - last < t then
        return true
    end
    attackCooldown[key] = now
    return false
end

local function GetMonsterByName(name)
    if not name or name == "" then return nil end
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if not npcsFolder then return nil end
    for _, v in pairs(npcsFolder:GetChildren()) do
        if v.Name == name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Dummy" then
            return v
        end
    end
    return nil
end

local function GetAnySelectedMonster()
    if not getgenv().SelectedMonsters or #getgenv().SelectedMonsters == 0 then return nil end
    for _, monsterName in ipairs(getgenv().SelectedMonsters) do
        local monster = GetMonsterByName(monsterName)
        if monster then return monster end
    end
    return nil
end

local function GetQuestForMonster(monsterName)
    if not QuestConfig or not QuestConfig.RepeatableQuests then return nil end
    for npc, quest in pairs(QuestConfig.RepeatableQuests) do
        if quest.rewards and quest.rewards[monsterName] then
            return npc
        end
        for mob, _ in pairs(quest.rewards or {}) do
            if mob == monsterName then
                return npc
            end
        end
    end
    return nil
end

local function CheckQuestState()
    local questUI = player.PlayerGui:FindFirstChild("QuestUI")
    if questUI and questUI:FindFirstChild("Quest") then
        return questUI.Quest.Visible
    end
    return false
end

if QuestUpdate then
    QuestUpdate.OnClientEvent:Connect(function(state, data)
        if state == "accepted" and data and data.questType == "repeatable" then
            hasQuestOnDeath = true
            for mob, _ in pairs(data.progress or {}) do
                currentMob = mob
                if lastMobNotify ~= mob then
                    LiquidGlassNotify("Quest", "Target: " .. mob, "rbxassetid://82500352718600", 2)
                    lastMobNotify = mob
                end
            end
        elseif state == "finished" or state == "abandoned" then
            hasQuestOnDeath = false
            currentMob = nil
            questCompleteTime = tick()
        end
    end)
end

local function AbandonCurrentQuest()
    if Abandon then
        pcall(function()
            Abandon:FireServer("repeatable")
        end)
        task.wait(0.5)
        hasQuestOnDeath = false
        currentMob = nil
    end
end

local function TeleportToIslandByLevel(level)
    if not TeleportRemote then return end
    local targetIsland = nil
    if level >= 250 and level <= 749 then
        targetIsland = "Jungle"
    elseif level >= 750 and level <= 1499 then
        targetIsland = "Desert"
    elseif level >= 1500 and level <= 2999 then
        targetIsland = "Snow"
    elseif level >= 3000 and level <= 4999 then
        targetIsland = "Shibuya"
    elseif level >= 5000 and level <= 6249 then
        targetIsland = "HuecoMundo"
    elseif level >= 6250 and level <= 7999 then
        targetIsland = "Shinjuku"
    elseif level >= 8000 and level <= 8999 then
        targetIsland = "Slime"
    elseif level >= 9000 and level <= 9999 then
        targetIsland = "Academy"
    elseif level >= 10000 and level <= 10749 then
        targetIsland = "Judgement"
    elseif level >= 10750 and level <= 11449 then
        targetIsland = "SoulSociety"
    end
    if targetIsland then
        pcall(function()
            TeleportRemote:FireServer(targetIsland)
            LiquidGlassNotify("Teleport", "Moving to " .. targetIsland, "rbxassetid://82500352718600", 2)
        end)
        task.wait(2)
    end
end

local function GoToBossSpawnPoint()
    if not bossSpawnPoint then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local targetCF = CFrame.new(bossSpawnPoint) * CFrame.Angles(math.rad(-90), 0, 0)
    if (root.Position - bossSpawnPoint).Magnitude > 3 then
        SmoothTween(targetCF)
        isAtBossSpawnPoint = true
    end
end

local function HopServer()
    if not getgenv().AutoHop then return end
    local now = tick()
    if now - lastHopTime < 10 then return end
    lastHopTime = now
    hopAttempts = hopAttempts + 1
    if hopAttempts > maxHopAttempts then
        LiquidGlassNotify("Hop", "Max attempts reached", "rbxassetid://82500352718600", 3)
        return
    end
    local placeId = game.PlaceId
    local servers = {}
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"))
    end)
    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
    end
    if #servers > 0 then
        local randomServer = servers[math.random(1, #servers)]
        LiquidGlassNotify("Hop", "Moving to new server", "rbxassetid://82500352718600", 2)
        task.wait(1)
        TeleportService:TeleportToPlaceInstance(placeId, randomServer, player)
    else
        LiquidGlassNotify("Hop", "No servers found", "rbxassetid://82500352718600", 2)
    end
end

local function SummonSelectedBoss()
    if not getgenv().AutoSummonBoss or getgenv().SelectedBoss == "" then return end
    local now = tick()
    if now - lastBossCheck < 1 then return end
    lastBossCheck = now
    
    local alive, bossObj = IsBossAlive(getgenv().SelectedBoss)
    
    if alive and bossObj then
        bossSpawned = true
        CurrentTarget = bossObj
        isAtBossSpawnPoint = false
        return
    else
        bossSpawned = false
        CurrentTarget = nil
    end
    
    if getgenv().SelectedBoss == "SaberBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Boss")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SummonBossRemote then
            pcall(function()
                SummonBossRemote:FireServer("SaberBoss")
            end)
            LiquidGlassNotify("Boss", "Summoning Saber Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "SaberAlterBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Boss")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SummonBossRemote then
            pcall(function()
                SummonBossRemote:FireServer("SaberAlterBoss", getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Saber Alter Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "QinShiBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Boss")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SummonBossRemote then
            pcall(function()
                SummonBossRemote:FireServer("QinShiBoss")
            end)
            LiquidGlassNotify("Boss", "Summoning Qin Shi Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "IchigoBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Boss")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SummonBossRemote then
            pcall(function()
                SummonBossRemote:FireServer("IchigoBoss")
            end)
            LiquidGlassNotify("Boss", "Summoning Ichigo Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "GilgameshBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Boss")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SummonBossRemote then
            pcall(function()
                SummonBossRemote:FireServer("GilgameshBoss", getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Gilgamesh Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "BlessedMaidenBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Boss")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SummonBossRemote then
            pcall(function()
                SummonBossRemote:FireServer("BlessedMaidenBoss", getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Blessed Maiden Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "StrongestToday" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Shinjuku")
            end)
            task.wait(1)
        end
        bossSpawnPoint = Vector3.new(440, 2, -2178)
        GoToBossSpawnPoint()
        task.wait(2)
        if SpawnStrongestRemote then
            pcall(function()
                SpawnStrongestRemote:FireServer("StrongestToday", getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Strongest Today", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "StrongestHistory" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Shinjuku")
            end)
            task.wait(1)
        end
        bossSpawnPoint = Vector3.new(440, 2, -2178)
        GoToBossSpawnPoint()
        task.wait(2)
        if SpawnStrongestRemote then
            pcall(function()
                SpawnStrongestRemote:FireServer("StrongestHistory", getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Strongest History", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "RimuruBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Slime")
            end)
            task.wait(1)
        end
        bossSpawnPoint = Vector3.new(-1254, 17, 222)
        GoToBossSpawnPoint()
        task.wait(2)
        if SpawnRimuruRemote then
            pcall(function()
                SpawnRimuruRemote:FireServer(getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Rimuru Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "AnosBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("Academy")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SpawnAnosRemote then
            pcall(function()
                SpawnAnosRemote:FireServer("Anos", getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning Anos Boss", "rbxassetid://82500352718600", 2)
        end
        
    elseif getgenv().SelectedBoss == "TrueAizenBoss" then
        if TeleportRemote then
            pcall(function()
                TeleportRemote:FireServer("SoulSociety")
            end)
            task.wait(1)
        end
        bossSpawnPoint = nil
        if SpawnTrueAizenRemote then
            pcall(function()
                SpawnTrueAizenRemote:FireServer(getgenv().BossDifficulty)
            end)
            LiquidGlassNotify("Boss", "Summoning True Aizen Boss", "rbxassetid://82500352718600", 2)
        end
    end
    
    task.wait(2)
end

local function OpenDungeonPortal()
    if not getgenv().AutoDungeon or getgenv().SelectedDungeon == "" then return end
    if not DungeonPortalRemote then return end
    pcall(function()
        DungeonPortalRemote:FireServer(getgenv().SelectedDungeon)
        LiquidGlassNotify("Dungeon", "Opening " .. getgenv().SelectedDungeon, "rbxassetid://82500352718600", 2)
    end)
    task.wait(1)
end

local function VoteDifficulty()
    if not getgenv().AutoDungeon or not getgenv().AutoVoteDifficulty then return end
    if not DungeonVoteRemote then return end
    pcall(function()
        DungeonVoteRemote:FireServer(getgenv().DungeonDifficulty)
    end)
end

local function VoteReplay()
    if not getgenv().AutoReplayDungeon then return end
    if not DungeonReplayRemote then return end
    pcall(function()
        DungeonReplayRemote:FireServer("sponsor")
    end)
end

local function EnableHaki()
    if not getgenv().AutoHaki then return end
    if not HakiRemote then return end
    local now = tick()
    if now - lastHakiCheck < 5 then return end
    lastHakiCheck = now
    pcall(function()
        HakiRemote:FireServer("Toggle")
    end)
end

local function StartQuest()
    if not Accept or not Abandon then return end
    if isStartingQuest then return end
    local now = tick()
    if now - lastQuestStartAttempt < 3 then return end
    if isRespawning then
        return
    end
    if getgenv().AutoFarm then
        local level = player.Data.Level.Value
        TeleportToIslandByLevel(level)
    end
    isStartingQuest = true
    lastQuestStartAttempt = now
    AbandonCurrentQuest()
    task.wait(0.5)
    local questNPC = nil
    if getgenv().AutoQuestForMonster and getgenv().SelectedMonsters and #getgenv().SelectedMonsters > 0 then
        for _, monsterName in ipairs(getgenv().SelectedMonsters) do
            questNPC = GetQuestForMonster(monsterName)
            if questNPC then
                break
            end
        end
    else
        questNPC = GetBestQuest()
    end
    if questNPC then
        local success = pcall(function()
            Accept:FireServer(questNPC)
        end)
        if success then
            if now - lastQuestNotify > 5 then
                LiquidGlassNotify("Quest", "Accepted: " .. questNPC, "rbxassetid://82500352718600", 2)
                lastQuestNotify = now
            end
            task.wait(1)
        else
            LiquidGlassNotify("Quest", "Failed to accept quest", "rbxassetid://82500352718600", 2)
        end
    else
        if now - lastQuestNotify > 10 then
            LiquidGlassNotify("Quest", "No suitable quest found", "rbxassetid://82500352718600", 2)
            lastQuestNotify = now
        end
    end
    isStartingQuest = false
end

local function GetMob()
    if getgenv().AutoBoss and getgenv().SelectedBoss ~= "" and getgenv().AutoFarmSelectedBoss then
        local alive, boss = IsBossAlive(getgenv().SelectedBoss)
        if alive then
            return boss
        end
        return nil
    end
    if getgenv().AutoBoss and getgenv().SelectedBoss ~= "" then
        local alive, boss = IsBossAlive(getgenv().SelectedBoss)
        if alive then
            return boss
        end
        if getgenv().AutoHop then
            HopServer()
        end
        return nil
    end
    if getgenv().AutoDungeon then
        return GetNearestMonster()
    end
    if getgenv().AutoFarm then
        return GetNearestMonster()
    end
    if not currentMob then return nil end
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if not npcsFolder then return nil end
    for _, v in pairs(npcsFolder:GetChildren()) do
        if (v.Name == currentMob or v.Name:match(currentMob .. "%d") or v.Name:find(currentMob)) and 
           v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and 
           v:FindFirstChild("HumanoidRootPart") and v.Name ~= "Dummy" then
            return v
        end
    end
    return nil
end

local function FreezeMon(mon)
    if not freezeEnabled or not mon then return end
    local hrp = mon:FindFirstChild("HumanoidRootPart")
    local hum = mon:FindFirstChild("Humanoid")
    if hrp and hum and hum.Health > 0 then
        hrp.Anchored = true
        hum.WalkSpeed = 0
        hum.JumpPower = 0
    end
end

local function UnfreezeMon(mon)
    if not mon then return end
    local hrp = mon:FindFirstChild("HumanoidRootPart")
    local hum = mon:FindFirstChild("Humanoid")
    if hrp and hum then
        hrp.Anchored = false
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end
end

local function EnlargeHitbox(mon)
    if not hitboxEnabled or not mon then return end
    local hrp = mon:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(8, 8, 8)
        hrp.Transparency = 0.5
        hrp.Material = Enum.Material.Neon
        hrp.BrickColor = BrickColor.new("Bright red")
    end
end

local function ResetHitbox(mon)
    if not mon then return end
    local hrp = mon:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Size = Vector3.new(2, 2, 1)
        hrp.Transparency = 1
        hrp.Material = Enum.Material.Plastic
    end
end

local function TPToMonster(mon)
    if not mon then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hrp = mon:FindFirstChild("HumanoidRootPart")
    local hum = mon:FindFirstChild("Humanoid")
    if not root or not hrp or not hum or hum.Health <= 0 then return end
    if tick() - lastTeleportTime < teleportCooldown then return end
    lastTeleportTime = tick()

    local offsetX, offsetY, offsetZ
    if useRandomPos then
        zigzagTimer = zigzagTimer + 1
        offsetX = math.random(-5, 5)
        offsetY = math.random(3, 5)
        offsetZ = math.random(-5, 5)
    else
        offsetX = tpX
        offsetY = tpY
        offsetZ = tpZ
    end
    
    local targetPos = hrp.Position + Vector3.new(offsetX, offsetY + 5, offsetZ)
    local targetCF = CFrame.new(targetPos) * CFrame.Angles(math.rad(-90), 0, 0)
    
    local platform = Workspace:FindFirstChild("SafePlatform")
    if not platform then
        platform = Instance.new("Part")
        platform.Name = "SafePlatform"
        platform.Size = Vector3.new(15, 1, 15)
        platform.Anchored = true
        platform.CanCollide = true
        platform.Transparency = 1
        platform.Parent = Workspace
    end
    platform.CFrame = CFrame.new(targetPos - Vector3.new(0, 2.5, 0))
    
    if (root.Position - targetPos).Magnitude > 3 then
        SmoothTween(targetCF)
    else
        root.CFrame = targetCF
        stablePosition = targetPos
        LockPosition(targetPos)
    end
end

local function EquipWeapon(weaponName)
    if not weaponName then return false end
    local char = player.Character
    if not char then return false end
    if char:FindFirstChild(weaponName) then 
        CurrentWeapon = weaponName
        return true
    end
    local tool = player.Backpack:FindFirstChild(weaponName)
    if tool and tool:IsA("Tool") then
        pcall(function()
            tool.Parent = char
        end)
        CurrentWeapon = weaponName
        return true
    end
    return false
end

local function EnsureWeaponEquipped()
    if not PrimaryWeapon then return end
    if not CurrentWeapon or CurrentWeapon ~= PrimaryWeapon then
        local success = EquipWeapon(PrimaryWeapon)
        if not success then
            local tools = GetWeapons()
            if #tools > 0 then
                PrimaryWeapon = tools[1]
                getgenv().PrimaryWeapon = PrimaryWeapon
                EquipWeapon(PrimaryWeapon)
            end
        end
    end
    local char = player.Character
    if char and PrimaryWeapon then
        local tool = char:FindFirstChild(PrimaryWeapon)
        if not tool then
            local backpackTool = player.Backpack:FindFirstChild(PrimaryWeapon)
            if backpackTool then
                pcall(function()
                    backpackTool.Parent = char
                end)
            end
        end
    end
end

local function UseSkill(key)
    local now = tick()
    if skillCooldowns[key] and now - skillCooldowns[key] < 0.4 then return end
    skillCooldowns[key] = now
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
end

local function GetWeapons()
    local list = {}
    local char = player.Character
    if char then
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Tool") then
                table.insert(list, v.Name)
            end
        end
    end
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v:IsA("Tool") and not table.find(list, v.Name) then
            table.insert(list, v.Name)
        end
    end
    return list
end

local function IsPlayerAlive()
    local char = player.Character
    if not char then return false end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return false end
    return humanoid.Health > 0
end

local function NormalAttack()
    local now = tick()
    if now - lastNormalAttack < 0.05 then return end
    lastNormalAttack = now
    
    local combatRemote = ReplicatedStorage:FindFirstChild("CombatSystem") and ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
    if combatRemote then
        pcall(function()
            combatRemote:FireServer()
        end)
    end
    
    local abilityRemote = ReplicatedStorage:FindFirstChild("AbilitySystem") and ReplicatedStorage.AbilitySystem:FindFirstChild("Remotes") and ReplicatedStorage.AbilitySystem.Remotes:FindFirstChild("RequestAbility")
    if abilityRemote then
        pcall(function()
            abilityRemote:FireServer(1)
        end)
    end
end

local function AttackMob(mob)
    if not mob or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 then return end
    
    local startTime = tick()
    local maxAttackTime = 30
    local lastHitTime = 0
    local attackInterval = 0.05
    
    repeat
        if not IsPlayerAlive() then
            if CurrentTarget then
                UnfreezeMon(CurrentTarget)
                ResetHitbox(CurrentTarget)
                CurrentTarget = nil
            end
            return
        end
        
        task.wait()
        
        local char = player.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
        
        if not mobRoot then
            return
        end
        
        local targetPos = mobRoot.Position + Vector3.new(0, 5, 0)
        
        if getgenv().AutoDungeon then
            local nearest = GetNearestMonster()
            if nearest and nearest ~= mob then
                mob = nearest
                CurrentTarget = nearest
                mobRoot = nearest:FindFirstChild("HumanoidRootPart")
                if not mobRoot then return end
                targetPos = mobRoot.Position + Vector3.new(0, 5, 0)
            end
        end
        
        if (root.Position - targetPos).Magnitude > 5 and not isTweening then
            TPToMonster(mob)
        elseif (root.Position - targetPos).Magnitude > 2 then
            root.CFrame = CFrame.new(targetPos) * CFrame.Angles(math.rad(-90), 0, 0)
            stablePosition = targetPos
        end
        
        EnsureWeaponEquipped()
        
        local now = tick()
        if now - lastHitTime >= attackInterval then
            local combatRemote = ReplicatedStorage:FindFirstChild("CombatSystem") and ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
            if combatRemote then
                pcall(function()
                    combatRemote:FireServer()
                end)
            end
            lastHitTime = now
        end
        
        if now - lastSkillTime > 0.4 then
            if getgenv().AutoZ then UseSkill("Z") end
            if getgenv().AutoX then UseSkill("X") end
            if getgenv().AutoC then UseSkill("C") end
            if getgenv().AutoV then UseSkill("V") end
            if getgenv().AutoF then UseSkill("F") end
            lastSkillTime = now
        end
        
        if tick() - startTime > maxAttackTime then
            break
        end
        
    until not mob.Parent or mob.Humanoid.Health <= 0 or not IsPlayerAlive()
end

local function RandomizePosition()
    tpX = math.random(-5, 5)
    tpY = math.random(3, 5)
    tpZ = math.random(-5, 5)
    getgenv().tpX = tpX
    getgenv().tpY = tpY
    getgenv().tpZ = tpZ
    LiquidGlassNotify("Random Pos", "X: " .. tpX .. " Y: " .. tpY .. " Z: " .. tpZ, "rbxassetid://82500352718600", 3)
    AutoSave()
end

local function RedeemAllCodes()
    if not codeRemote then return end
    local successCount = 0
    local failCount = 0
    for _, code in ipairs(codes) do
        local success = pcall(function()
            codeRemote:InvokeServer(code)
        end)
        if success then
            successCount = successCount + 1
        else
            failCount = failCount + 1
        end
        task.wait(0.5)
    end
    LiquidGlassNotify("Codes", "Success: " .. successCount .. " | Failed: " .. failCount, "rbxassetid://82500352718600", 4)
end

local function SetupRespawnHandler()
    if respawnConnection then
        respawnConnection:Disconnect()
    end
    respawnConnection = player.CharacterAdded:Connect(function(newChar)
        character = newChar
        isRespawning = true
        if not farmingEnabled then
            StopAllTweens()
        end
        if CurrentTarget then
            UnfreezeMon(CurrentTarget)
            ResetHitbox(CurrentTarget)
            CurrentTarget = nil
        end
        task.wait(2)
        isRespawning = false
        if farmingEnabled then
            LiquidGlassNotify("Respawn", "Continuing Auto Farm", "rbxassetid://82500352718600", 2)
            task.wait(1)
            EnableHaki()
            if getgenv().AutoQuest then
                StartQuest()
            end
            hasQuestOnDeath = false
        end
    end)
end

local function StopFarming()
    farmingEnabled = false
    StopAllTweens()
    if CurrentTarget then
        UnfreezeMon(CurrentTarget)
        ResetHitbox(CurrentTarget)
        CurrentTarget = nil
    end
    if Workspace:FindFirstChild("SafePlatform") then 
        Workspace.SafePlatform:Destroy() 
    end
end

local function StartFarming()
    farmingEnabled = true
    StopAllTweens()
    hasQuestOnDeath = false
    EnableHaki()
    if getgenv().AutoQuest then
        AbandonCurrentQuest()
        task.wait(1)
        StartQuest()
    end
end

SetupRespawnHandler()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Flowerhub-Kanei/Ui/refs/heads/main/DummyFreeUI.lua"))()

local Window = Library:Window({
    Title = "Trigon Hub | Sailor Piece",
    Desc = "Best Free Script",
    Icon = "swords",
    Theme = "Galaxy",
    Config = {
        Keybind = Enum.KeyCode.RightControl,
        Size = UDim2.new(0, 550, 0, 450)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "Close UI"
    }
})

Window:SelectTab(1)

local FarmTab = Window:Tab({Title = "Auto Farm", Icon = "swords"})
local DungeonTab = Window:Tab({Title = "Auto Dungeon", Icon = "layers"})
local BossTab = Window:Tab({Title = "Auto Boss", Icon = "skull"})
local SkillTab = Window:Tab({Title = "Skills", Icon = "zap"})
local StatsTab = Window:Tab({Title = "Stats", Icon = "bar-chart-2"})
local PlayerTab = Window:Tab({Title = "Player", Icon = "user"})
local WeaponTab = Window:Tab({Title = "Weapon", Icon = "package"})
local MiscTab = Window:Tab({Title = "Misc", Icon = "settings"})
local SettingsTab = Window:Tab({Title = "Settings", Icon = "settings"})

FarmTab:Section({Title = "Farming Settings"})

FarmTab:Toggle({
    Title = "Auto Farm",
    Value = getgenv().AutoFarm,
    Callback = function(v)
        getgenv().AutoFarm = v
        LiquidGlassNotify("Auto Farm", v and "Enabled" or "Disabled", "rbxassetid://82500352718600", 2)
        if v then
            if not getgenv().AutoBoss and not getgenv().AutoDungeon then
                getgenv().AutoQuest = true
            end
            StartFarming()
        else
            getgenv().AutoQuest = false
            getgenv().AutoBoss = false
            getgenv().AutoDungeon = false
            StopFarming()
        end
        AutoSave()
    end
})

FarmTab:Toggle({
    Title = "White Screen",
    Value = getgenv().WhiteScreen,
    Callback = function(v)
        getgenv().WhiteScreen = v
        if v then
            RunService:Set3dRenderingEnabled(false)
        else
            RunService:Set3dRenderingEnabled(true)
        end
        LiquidGlassNotify("White Screen", v and "Enabled" or "Disabled", "rbxassetid://82500352718600", 2)
    end
})

local MonsterDropdown = FarmTab:Dropdown({
    Title = "Select Monsters",
    Options = GetAllMonsters(),
    Default = "None",
    Multi = true,
    Callback = function(values)
        getgenv().SelectedMonsters = values or {}
        if #getgenv().SelectedMonsters > 0 then
            LiquidGlassNotify("Selected", #getgenv().SelectedMonsters .. " monsters", "rbxassetid://82500352718600", 2)
        end
        AutoSave()
    end
})

FarmTab:Button({
    Title = "Refresh Monster List",
    Callback = function()
        local newList = GetAllMonsters()
        MonsterDropdown:SetValues(newList)
        LiquidGlassNotify("Monster List", "Refreshed", "rbxassetid://82500352718600", 2)
    end
})

FarmTab:Toggle({
    Title = "Auto Accept Quest",
    Value = getgenv().AutoQuest,
    Callback = function(v)
        getgenv().AutoQuest = v
        if v and getgenv().AutoFarm then
            AbandonCurrentQuest()
            task.wait(1)
            StartQuest()
        end
        AutoSave()
    end
})

FarmTab:Toggle({
    Title = "Accept Boss Quests",
    Value = getgenv().AcceptBoss,
    Callback = function(v)
        getgenv().AcceptBoss = v
        AutoSave()
    end
})

FarmTab:Toggle({
    Title = "Freeze Monster",
    Value = freezeEnabled,
    Callback = function(v)
        freezeEnabled = v
        getgenv().freezeEnabled = v
        AutoSave()
    end
})

FarmTab:Toggle({
    Title = "Big Hitbox",
    Value = hitboxEnabled,
    Callback = function(v)
        hitboxEnabled = v
        getgenv().hitboxEnabled = v
        AutoSave()
    end
})

DungeonTab:Section({Title = "Dungeon Settings"})

local DungeonDropdown = DungeonTab:Dropdown({
    Title = "Select Dungeon",
    Options = GetDungeonList(),
    Default = getgenv().SelectedDungeon,
    Callback = function(v)
        getgenv().SelectedDungeon = v
        LiquidGlassNotify("Dungeon Selected", v, "rbxassetid://82500352718600", 2)
        AutoSave()
    end
})

DungeonTab:Button({
    Title = "Refresh Dungeon List",
    Callback = function()
        local newList = GetDungeonList()
        DungeonDropdown:SetValues(newList)
        LiquidGlassNotify("Dungeon List", "Refreshed", "rbxassetid://82500352718600", 2)
    end
})

local DungeonDifficultyDropdown = DungeonTab:Dropdown({
    Title = "Dungeon Difficulty",
    Options = {"Easy", "Medium", "Hard", "Extreme"},
    Default = getgenv().DungeonDifficulty,
    Callback = function(v)
        getgenv().DungeonDifficulty = v
        AutoSave()
    end
})

DungeonTab:Toggle({
    Title = "Auto Vote Difficulty",
    Value = getgenv().AutoVoteDifficulty,
    Callback = function(v)
        getgenv().AutoVoteDifficulty = v
        AutoSave()
    end
})

DungeonTab:Toggle({
    Title = "Auto Dungeon",
    Value = getgenv().AutoDungeon,
    Callback = function(v)
        getgenv().AutoDungeon = v
        if v then
            getgenv().AutoBoss = false
            getgenv().AutoFarm = true
            getgenv().AutoQuest = false
            OpenDungeonPortal()
            LiquidGlassNotify("Auto Dungeon", "Enabled", "rbxassetid://82500352718600", 2)
        else
            StopAllTweens()
        end
        AutoSave()
    end
})

DungeonTab:Toggle({
    Title = "Auto Replay Dungeon",
    Value = getgenv().AutoReplayDungeon,
    Callback = function(v)
        getgenv().AutoReplayDungeon = v
        LiquidGlassNotify("Auto Replay", v and "Enabled" or "Disabled", "rbxassetid://82500352718600", 2)
        AutoSave()
    end
})

DungeonTab:Button({
    Title = "Vote Difficulty",
    Callback = function()
        if DungeonVoteRemote then
            pcall(function()
                DungeonVoteRemote:FireServer(getgenv().DungeonDifficulty)
            end)
            LiquidGlassNotify("Dungeon", "Voted " .. getgenv().DungeonDifficulty, "rbxassetid://82500352718600", 1)
        end
    end
})

DungeonTab:Button({
    Title = "Vote Replay",
    Callback = function()
        if DungeonReplayRemote then
            pcall(function()
                DungeonReplayRemote:FireServer("sponsor")
            end)
            LiquidGlassNotify("Dungeon", "Voted to replay", "rbxassetid://82500352718600", 1)
        end
    end
})

BossTab:Section({Title = "Normal Boss (No Hop)"})

local NormalBossDropdown = BossTab:Dropdown({
    Title = "Select Normal Boss",
    Options = GetNormalBossList(),
    Default = "",
    Callback = function(v)
        getgenv().SelectedBoss = v
        LiquidGlassNotify("Boss Selected", v, "rbxassetid://82500352718600", 2)
        AutoSave()
    end
})

BossTab:Button({
    Title = "Refresh Normal Boss List",
    Callback = function()
        local newList = GetNormalBossList()
        NormalBossDropdown:SetValues(newList)
        LiquidGlassNotify("Boss List", "Refreshed", "rbxassetid://82500352718600", 2)
    end
})

BossTab:Toggle({
    Title = "Auto Farm Selected Boss (No Hop)",
    Value = getgenv().AutoFarmSelectedBoss,
    Callback = function(v)
        getgenv().AutoFarmSelectedBoss = v
        if v then
            getgenv().AutoBoss = true
        end
        AutoSave()
    end
})

BossTab:Section({Title = "Summon Boss (Requires Summon)"})

local SummonBossDropdown = BossTab:Dropdown({
    Title = "Select Summon Boss",
    Options = GetSummonBossList(),
    Default = getgenv().SelectedBoss or "",
    Callback = function(v)
        getgenv().SelectedBoss = v
        LiquidGlassNotify("Summon Boss Selected", v, "rbxassetid://82500352718600", 2)
        AutoSave()
    end
})

BossTab:Button({
    Title = "Refresh Summon Boss List",
    Callback = function()
        local newList = GetSummonBossList()
        SummonBossDropdown:SetValues(newList)
        LiquidGlassNotify("Summon Boss List", "Refreshed", "rbxassetid://82500352718600", 2)
    end
})

local BossDifficultyDropdown = BossTab:Dropdown({
    Title = "Boss Difficulty",
    Options = {"Normal", "Medium", "Hard", "Extreme"},
    Default = getgenv().BossDifficulty,
    Callback = function(v)
        getgenv().BossDifficulty = v
        AutoSave()
    end
})

BossTab:Toggle({
    Title = "Auto Summon Boss",
    Value = getgenv().AutoSummonBoss,
    Callback = function(v)
        getgenv().AutoSummonBoss = v
        AutoSave()
    end
})

BossTab:Toggle({
    Title = "Auto Boss",
    Value = getgenv().AutoBoss,
    Callback = function(v)
        getgenv().AutoBoss = v
        if v then
            getgenv().AutoDungeon = false
            getgenv().AutoFarm = true
            getgenv().AutoQuest = false
            bossSpawned = false
            LiquidGlassNotify("Auto Boss", "Enabled", "rbxassetid://82500352718600", 2)
        else
            StopAllTweens()
        end
        AutoSave()
    end
})

BossTab:Toggle({
    Title = "Auto Hop",
    Value = getgenv().AutoHop,
    Callback = function(v)
        getgenv().AutoHop = v
        AutoSave()
    end
})

SkillTab:Section({Title = "Auto Skills"})

SkillTab:Toggle({
    Title = "Auto Skill Z",
    Value = getgenv().AutoZ,
    Callback = function(v)
        getgenv().AutoZ = v
        AutoSave()
    end
})

SkillTab:Toggle({
    Title = "Auto Skill X",
    Value = getgenv().AutoX,
    Callback = function(v)
        getgenv().AutoX = v
        AutoSave()
    end
})

SkillTab:Toggle({
    Title = "Auto Skill C",
    Value = getgenv().AutoC,
    Callback = function(v)
        getgenv().AutoC = v
        AutoSave()
    end
})

SkillTab:Toggle({
    Title = "Auto Skill V",
    Value = getgenv().AutoV,
    Callback = function(v)
        getgenv().AutoV = v
        AutoSave()
    end
})

SkillTab:Toggle({
    Title = "Auto Skill F",
    Value = getgenv().AutoF,
    Callback = function(v)
        getgenv().AutoF = v
        AutoSave()
    end
})

StatsTab:Section({Title = "Stat Allocation"})

local statList = {"Sword", "Power", "Defense", "Melee"}

local statDropdown = StatsTab:Dropdown({
    Title = "Select Stat",
    Options = statList,
    Default = getgenv().SelectedStat,
    Callback = function(v)
        getgenv().SelectedStat = v
        AutoSave()
    end
})

local pointsSlider = StatsTab:Slider({
    Title = "Points per Upgrade",
    Min = 1,
    Max = 100,
    Default = getgenv().StatPoints,
    Callback = function(v)
        getgenv().StatPoints = v
        AutoSave()
    end
})

StatsTab:Toggle({
    Title = "Auto Upgrade Stats",
    Value = getgenv().AutoStat,
    Callback = function(v)
        getgenv().AutoStat = v
        AutoSave()
    end
})

task.spawn(function()
    while task.wait(0.2) do
        if getgenv().AutoStat then
            pcall(function()
                local statRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and 
                                 ReplicatedStorage.RemoteEvents:FindFirstChild("AllocateStat")
                if statRemote then
                    statRemote:FireServer(getgenv().SelectedStat, getgenv().StatPoints)
                end
            end)
        end
    end
end)

WeaponTab:Section({Title = "Weapon Selection"})

local PrimaryWeaponDropdown = WeaponTab:Dropdown({
    Title = "Select Weapon",
    Options = GetWeapons(),
    Default = PrimaryWeapon or "",
    Callback = function(v)
        PrimaryWeapon = v
        getgenv().PrimaryWeapon = v
        EquipWeapon(v)
        LiquidGlassNotify("Weapon", "Selected: " .. v, "rbxassetid://82500352718600", 1)
        AutoSave()
    end
})

WeaponTab:Button({
    Title = "Refresh Weapon List",
    Callback = function()
        local newList = GetWeapons()
        PrimaryWeaponDropdown:SetValues(newList)
        if PrimaryWeapon and table.find(newList, PrimaryWeapon) then
            PrimaryWeaponDropdown:SetValue(PrimaryWeapon)
        end
        LiquidGlassNotify("Weapons", "List refreshed", "rbxassetid://82500352718600", 2)
    end
})

task.spawn(function()
    task.wait(1)
    local weapons = GetWeapons()
    PrimaryWeaponDropdown:SetValues(weapons)
    if PrimaryWeapon and table.find(weapons, PrimaryWeapon) then
        PrimaryWeaponDropdown:SetValue(PrimaryWeapon)
    end
end)

PlayerTab:Section({Title = "Teleport Settings"})

local xSlider, ySlider, zSlider, speedSlider

PlayerTab:Toggle({
    Title = "Use Zigzag Position",
    Value = useRandomPos,
    Callback = function(v)
        useRandomPos = v
        getgenv().useRandomPos = v
        if v then
            LiquidGlassNotify("Zigzag", "Enabled - Moving around", "rbxassetid://82500352718600", 2)
        end
        AutoSave()
    end
})

PlayerTab:Button({
    Title = "Randomize Base Position",
    Callback = function()
        RandomizePosition()
        if xSlider then xSlider:SetValue(tpX) end
        if ySlider then ySlider:SetValue(tpY) end
        if zSlider then zSlider:SetValue(tpZ) end
    end
})

xSlider = PlayerTab:Slider({
    Title = "Offset X",
    Min = -15,
    Max = 20,
    Default = tpX,
    Callback = function(v)
        tpX = v
        getgenv().tpX = v
        AutoSave()
    end
})

ySlider = PlayerTab:Slider({
    Title = "Offset Y",
    Min = -5,
    Max = 20,
    Default = tpY,
    Callback = function(v)
        tpY = v
        getgenv().tpY = v
        AutoSave()
    end
})

zSlider = PlayerTab:Slider({
    Title = "Offset Z",
    Min = -15,
    Max = 15,
    Default = tpZ,
    Callback = function(v)
        tpZ = v
        getgenv().tpZ = v
        AutoSave()
    end
})

speedSlider = PlayerTab:Slider({
    Title = "Tween Speed",
    Min = 50,
    Max = 500,
    Default = tweenSpeed,
    Callback = function(v)
        tweenSpeed = v
        getgenv().tweenSpeed = v
        AutoSave()
    end
})

MiscTab:Section({Title = "Miscellaneous"})

MiscTab:Toggle({
    Title = "Auto Haki",
    Value = getgenv().AutoHaki,
    Callback = function(v)
        getgenv().AutoHaki = v
        if v then
            EnableHaki()
        end
        AutoSave()
    end
})

MiscTab:Button({
    Title = "Redeem All Codes",
    Callback = function()
        RedeemAllCodes()
    end
})

MiscTab:Toggle({
    Title = "Auto Ascend",
    Value = getgenv().AutoAscend,
    Callback = function(v)
        getgenv().AutoAscend = v
        if v then
            task.spawn(function()
                while getgenv().AutoAscend do
                    AutoAscend()
                    task.wait(10)
                end
            end)
        end
        AutoSave()
    end
})

local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local function BetterFPS()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
            v.Enabled = false
        end
    end
end

MiscTab:Button({
    Title = "Better FPS",
    Callback = BetterFPS
})

local function RTXON()
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 1e6
    Lighting.Brightness = 2
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Neon
            v.Reflectance = 0.3
        end
    end
end

MiscTab:Button({
    Title = "RTX MODE",
    Callback = RTXON
})

MiscTab:Button({
    Title = "Delete Islands (Boost FPS)",
    Callback = function()
        local islandNames = {"AcademyIsland","BossIsland","DesertIsland","HuecoMundo","JudgementIsland","JungleIsland","SailorIsland","ShibuyaStation","ShinjukuIsland","SlimeIsland","SnowIsland","SoulSocietyIsland","StarterIsland"}
        for _, name in ipairs(islandNames) do
            local island = Workspace:FindFirstChild(name)
            if island then island:Destroy() end
        end
        LiquidGlassNotify("FPS", "Islands Deleted", "rbxassetid://82500352718600", 2)
    end
})

SettingsTab:Section({Title = "Settings"})

local function Invisible()
    local char = LocalPlayer.Character
    if not char then return end
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = 1
        elseif v:IsA("Decal") then
            v.Transparency = 1
        end
    end
end

SettingsTab:Button({
    Title = "I'm Invisible? Click Me!",
    Callback = Invisible
})

local function AntiAfk()
    local VirtualUser = game:GetService("VirtualUser")
    local connection
    connection = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    if connection then
        LiquidGlassNotify("Anti Afk", "Enabled", "rbxassetid://82500352718600", 2)
    else
        LiquidGlassNotify("Anti Afk", "Failed to enable", "rbxassetid://82500352718600", 2)
    end
end

SettingsTab:Button({
    Title = "Anti Afk",
    Callback = AntiAfk
})

SettingsTab:Button({
    Title = "Boost FPS",
    Callback = BoostFps
})

SettingsTab:Toggle({
    Title = "Auto Save Config",
    Value = getgenv().AutoSave,
    Callback = function(v)
        getgenv().AutoSave = v
        LiquidGlassNotify("Auto Save", v and "Enabled" or "Disabled", "rbxassetid://82500352718600", 2)
    end
})

SettingsTab:Button({
    Title = "Save Config",
    Callback = SaveConfig
})

SettingsTab:Button({
    Title = "Load Config",
    Callback = function()
        LoadConfig()
        PrimaryWeapon = getgenv().PrimaryWeapon
        freezeEnabled = getgenv().freezeEnabled
        hitboxEnabled = getgenv().hitboxEnabled
        useRandomPos = getgenv().useRandomPos
        tpX = getgenv().tpX
        tpY = getgenv().tpY
        tpZ = getgenv().tpZ
        tweenSpeed = getgenv().tweenSpeed
        Window:Destroy()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Flowerhub-Kanei/Ui/refs/heads/main/DummyFreeUI.lua"))()
    end
})

SettingsTab:Button({
    Title = "Rejoin Server",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
})

SettingsTab:Button({
    Title = "Hop Server",
    Callback = function()
        local servers = {}
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
        end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server.id)
                end
            end
        end
        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, player)
        end
    end
})

task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            if not farmingEnabled or isRespawning then
                if CurrentTarget then
                    UnfreezeMon(CurrentTarget)
                    ResetHitbox(CurrentTarget)
                    CurrentTarget = nil
                end
                if Workspace:FindFirstChild("SafePlatform") then 
                    Workspace.SafePlatform:Destroy() 
                end
                return
            end

            if not IsPlayerAlive() then
                if CurrentTarget then
                    UnfreezeMon(CurrentTarget)
                    ResetHitbox(CurrentTarget)
                    CurrentTarget = nil
                end
                return
            end

            local char = player.Character
            if not char then return end
            
            local humanoid = char:FindFirstChild("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if not humanoid or not root then return end

            EnableHaki()

            if getgenv().AutoDungeon and getgenv().SelectedDungeon ~= "" then
                if getgenv().AutoReplayDungeon then
                    VoteReplay()
                end
                if getgenv().AutoVoteDifficulty then
                    VoteDifficulty()
                end
            end

            if getgenv().AutoBoss and getgenv().SelectedBoss ~= "" then
                if getgenv().AutoSummonBoss then
                    SummonSelectedBoss()
                end
                local alive, boss = IsBossAlive(getgenv().SelectedBoss)
                if alive then
                    if CurrentTarget ~= boss then
                        if CurrentTarget then
                            UnfreezeMon(CurrentTarget)
                            ResetHitbox(CurrentTarget)
                        end
                        CurrentTarget = boss
                    end
                    TPToMonster(boss)
                    AttackMob(boss)
                    if IsPlayerAlive() and boss.Parent and boss.Humanoid and boss.Humanoid.Health > 0 then
                        FreezeMon(boss)
                        EnlargeHitbox(boss)
                    end
                    return
                end
            end

            if getgenv().AutoQuest and not hasQuestOnDeath and not isStartingQuest then
                local questVisible = CheckQuestState()
                local now = tick()
                if not questVisible or not currentMob then
                    if now - lastQuestCheck > 3 then
                        lastQuestCheck = now
                        local currentMobName = GetCurrentQuestMob()
                        if currentMobName and currentMobName ~= "" then
                            currentMob = currentMobName
                        else
                            AbandonCurrentQuest()
                            task.wait(1)
                            StartQuest()
                        end
                    end
                end
                if not questVisible and tick() - questCompleteTime > 2 then
                    StartQuest()
                end
            end

            local targetMob = nil
            if getgenv().AutoDungeon then
                targetMob = GetNearestMonster()
            elseif getgenv().AutoFarm then
                targetMob = GetNearestMonster()
            end

            if targetMob then
                if CurrentTarget ~= targetMob then
                    if CurrentTarget then
                        UnfreezeMon(CurrentTarget)
                        ResetHitbox(CurrentTarget)
                    end
                    CurrentTarget = targetMob
                end
                TPToMonster(targetMob)
                AttackMob(targetMob)
                if IsPlayerAlive() and targetMob.Parent and targetMob.Humanoid and targetMob.Humanoid.Health > 0 then
                    FreezeMon(targetMob)
                    EnlargeHitbox(targetMob)
                end
            else
                if CurrentTarget then
                    UnfreezeMon(CurrentTarget)
                    ResetHitbox(CurrentTarget)
                    CurrentTarget = nil
                end
                if getgenv().AutoQuest and not hasQuestOnDeath and not isStartingQuest then
                    local questVisible = CheckQuestState()
                    if not questVisible then
                        currentMob = nil
                        task.wait(1)
                        StartQuest()
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(5) do
        if farmingEnabled and MonsterDropdown then
            local monsters = GetAllMonsters()
            MonsterDropdown:SetValues(monsters)
        end
    end
end)

LiquidGlassNotify("Trigon Hub", "Loaded Successfully!", "rbxassetid://82500352718600", 5)

local args = {"EnableQuestRepeat", true}
pcall(function()
    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args))
end)

local args2 = {"AutoQuestRepeat", true}
pcall(function()
    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SettingsToggle"):FireServer(unpack(args2))
end)
