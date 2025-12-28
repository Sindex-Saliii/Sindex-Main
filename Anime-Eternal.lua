local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sindex-Saliii/Sindex-Main/refs/heads/main/MultiKeyUI.lua"))()

local Hub = Library.Load({
    Name = "Saliii Hub",                     -- ชื่อฮับของคุณ
    Color = Color3.fromRGB(180, 70, 255), -- สีหลัก (ม่วง)
    Icon = 14930953469,                  -- Asset ID ของไอคอน
    Key = {                              -- รายการคีย์ที่ถูกต้อง
        "987562",
        "TEST-9999-XXXX-YYYY",
        "PREMIUM-2024-MONTHLY"
    },
    KeyLink = "https://discord.gg/invite",   -- ลิงก์สำหรับขอคีย์ (Optional)
    DiscordLink = "https://discord.gg/server", -- ลิงก์ Discord (Optional)
    Callback = function()                   -- ฟังก์ชันที่ทำงานเมื่อคีย์ถูกต้อง
        print("Key accepted! Loading main script...")
        print("Main hub loaded successfully!")
    end
})

Hub.Notify({
    Title = "Welcome to Saliii Hub! Please enter your key.",
    Icon = 14930953469,                -- Asset ID ของไอคอน
    Color = Color3.fromRGB(40, 40, 40), -- สีพื้นหลัง
    Time = 5                           -- เวลาแสดง (วินาที)
})
