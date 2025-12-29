local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/MultiKeyUI.lua"))()

local Hub = Library.Load({
    Name = "Rayfield Hub",
    Color = Color3.fromRGB(198, 69, 194),
    Icon = 14930953469,
    Key = {
        "RAY-1234-ABCD-5678",
        "PREMIUM-2024-MONTHLY",
        "VIP-ACCESS-CODE"
    },
    KeyLink = "https://discord.gg/getkey",
    DiscordLink = "https://discord.gg/server",
    Callback = function()
        Hub.Notify({
            Title = "Key verified successfully",
            Icon = 14939512891,
            Color = Color3.fromRGB(76, 209, 55),
            Time = 3
        })
        
        task.wait(0.5)
        
        Hub.Notify({
            Title = "Loading main interface",
            Icon = 14939475472,
            Color = Color3.fromRGB(98, 37, 209),
            Time = 3
        })
        
        task.wait(1)
        print("Main hub loaded!")
    end
})

Hub.Notify({
    Title = "Welcome to Rayfield Hub",
    Icon = 14924054039,
    Color = Color3.fromRGB(198, 69, 194),
    Time = 4
})
