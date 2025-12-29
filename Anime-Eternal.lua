local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/MultiKeyUI.lua"))()

local Hub = Library.Load({
    Name = "Rayfield Hub",
    Color = Color3.fromRGB(216, 52, 164),
    Icon = 6031075938,
    Key = {"RAY-1234-ABCD-5678", "PREMIUM-2024-MONTHLY"},
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
            
    end
})

Hub.Notify({
    Title = "Key System Loaded!",
    Icon = 6034818397,
    Time = 3,
    Color = Color3.fromRGB(216, 52, 164)
})
