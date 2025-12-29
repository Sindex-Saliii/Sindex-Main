local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/MultiKeyUI.lua"))()

-- 2. สร้าง Key System UI
local Hub = Library.Load({
    Name = "Rayfield Hub",                    -- ชื่อฮับ
    Color = Color3.fromRGB(98, 37, 209),      -- สีหลัก (Rayfield Purple)
    Icon = 6031075938,                        -- Icon Asset ID
    Key = {                                   -- รายการคีย์ที่ถูกต้อง
        "RAY-1234-ABCD-5678",
        "PREMIUM-2024-MONTHLY",
        "VIP-ACCESS-CODE"
    },
    KeyLink = "https://discord.gg/getkey",    -- ลิงก์ขอคีย์
    DiscordLink = "https://discord.gg/server", -- ลิงก์ Discord
    Callback = function()                     -- ฟังก์ชันที่ทำงานเมื่อคีย์ถูกต้อง
        print("Key verified! Loading main script...")
        
        -- โหลดสคริปต์หลักของคุณที่นี่
        -- loadstring(game:HttpGet("https://raw.githubusercontent.com/.../main.lua"))()
        
        -- หรือแสดง UI หลักของฮับ
        print("Main hub UI loaded!")
    end
})

Hub.Notify({
    Title = "Key system loaded successfully",
    Icon = 6034818397,                 -- Check icon
    Time = 3
})
