local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service    = "LynxKey"
Junkie.identifier = "1169210"
Junkie.provider   = "lynxx"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/habibrodriguez7-art/MainLib/refs/heads/main/Main.lua"))()
local MainWindow = Library:Window({ Title = "Lynx", Footer = "License" })
local KeyTab     = MainWindow:AddTab({ Name = "Key", Icon = "scan" })
local KeySection = KeyTab:AddSection("License", true)

local statusParagraph = KeySection:AddParagraph({
    Title   = "Status",
    Content = "Masukkan key kamu di bawah.",
})

local savedKey = ""

KeySection:AddInput({
    Title    = "License Key",
    Default  = "",
    NoSave   = true,
    Callback = function(val)
        savedKey = val
    end,
})

KeySection:AddButton({
    Title    = "Get Key",
    Callback = function()
        local link = Junkie.get_key_link()
        if link then
            if setclipboard then
                setclipboard(link)
            end
            Library:MakeNotify({
                Title       = "Link Disalin",
                Description = "Buka di browser untuk dapat key.",
                Delay       = 4,
            })
        else
            Library:MakeNotify({
                Title       = "Cooldown",
                Description = "Tunggu 5 menit sebelum generate link baru.",
                Color       = Color3.fromRGB(255, 80, 80),
                Delay       = 4,
            })
        end
    end,
})

KeySection:AddButton({
    Title    = "Validate Key",
    Callback = function()
        if not savedKey or #savedKey == 0 then
            Library:MakeNotify({
                Title       = "Kosong",
                Description = "Input key dulu sebelum validasi.",
                Color       = Color3.fromRGB(255, 80, 80),
                Delay       = 3,
            })
            return
        end

        statusParagraph:SetContent("Validating...")

        local ok, validation = pcall(function()
            return Junkie.check_key(savedKey)
        end)

        if ok and validation and validation.valid then
            getgenv().SCRIPT_KEY = savedKey
            statusParagraph:SetTitle("Valid")
            statusParagraph:SetContent("Key diterima. Memuat Lynx...")
            Library:MakeNotify({
                Title       = "Access Granted",
                Description = "Memuat Lynx...",
                Color       = Color3.fromRGB(50, 200, 100),
                Delay       = 3,
            })
            task.wait(1.5)
            loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/059ada0f7145c09bb71b53e71591f42299ab7ffd86b544758bc659b37a9e7169/download"))()
        else
            local errMsg = "Key tidak valid."
            if validation and validation.message then
                if validation.message == "KEY_EXPIRED" then
                    errMsg = "Key sudah expired. Hubungi admin."
                elseif validation.message == "HWID_BANNED" then
                    errMsg = "Hardware kamu di-ban."
                elseif validation.message == "SERVICE_MISMATCH" then
                    errMsg = "Key bukan untuk script ini."
                elseif validation.message == "HWID_MISMATCH" then
                    errMsg = "Key sudah dipakai di device lain."
                end
            end
            statusParagraph:SetTitle("Ditolak")
            statusParagraph:SetContent(errMsg)
            Library:MakeNotify({
                Title       = "Access Denied",
                Description = errMsg,
                Color       = Color3.fromRGB(255, 60, 60),
                Delay       = 4,
            })
        end
    end,
})
