local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "YOUR_SERVICE_NAME"
Junkie.identifier = "YOUR_IDENTIFIER"
Junkie.provider = "YOUR_PROVIDER"

local key = getgenv().SCRIPT_KEY or ""

if #key == 0 then
    Library:MakeNotify({
        Title = "Lynx",
        Description = "No key provided!",
        Delay = 5,
    })
    return
end

local validation = Junkie.check_key(key)
if not validation.valid then
    Library:MakeNotify({
        Title = "Lynx",
        Description = validation.message or "Invalid key!",
        Delay = 5,
    })
    return
end

loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/016673b767b889390dcc246252ea04f16178417976023032a4601c7091dda7af/download"))()
