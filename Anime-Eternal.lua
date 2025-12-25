local Library = loadstring(game:HttpGet("your_script_url"))()
local Window = Library.Load({
    Name = 'SindexHub',
    Icon = 14930953469,
    DiscordLink = 'discord.gg',
    Color = Color3.fromRGB(138, 43, 226),
    Key = {'alchemy'},
    KeyLink = 'https://example.com/get-key',
    Callback = function()
        print("Key verified! Loading main script...")
    end
})
