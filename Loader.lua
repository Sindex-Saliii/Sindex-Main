local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/KeyUI.lua"))()

local Hub = Library.Load({
    Name = "Sindex Hub",
    Color = Color3.fromRGB(216, 52, 164),
    Icon = 97856629223956,
    Key = {"HelloSaliii"},
    KeyLink = "https://discord.gg/getkey",
    DiscordLink = "https://discord.gg/server",
    Callback = function()
            Hub.Notify({
                Title = "Valid Key!",
                Icon = 6034818397,
                Time = 3,
                Color = Color3.fromRGB(216, 52, 164)
            })
            wait(0.1)
            print("\27[32m[ Whitelist ] - Authenticated ! \27[0m")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/Test.lua"))()
            
    end
})

Hub.Notify({
    Title = "Key System Loaded!",
    Icon = 6034818397,
    Time = 3,
    Color = Color3.fromRGB(216, 52, 164)
})
