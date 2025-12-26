local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/MultiKeyUI.lua"))()

local SaliiiHub = Library.Load({
    Name = "SindexHub", -- ชื่อฮับ
    Color = Color3.fromRGB(138, 43, 226), -- สีหลัก
    Icon = 14501439493, -- Icon ID (Lucide icon)
    Key = { -- รายการคีย์ที่ถูกต้อง
        "ABCD-1234-EFGH-5678",
        "WXYZ-9876-TUVS-5432"
    },
    KeyLink = "https://example.com/get-key", -- ลิงก์ขอคีย์ (ถ้ามี)
    DiscordLink = "https://discord.gg/invite", -- ลิงก์ Discord
    Callback = function() -- ฟังก์ชันที่ทำงานเมื่อใส่คีย์ถูกต้อง
        print("Key verified! Loading main script...")
        -- โหลดสคริปต์หลักของคุณที่นี่
    end
})
