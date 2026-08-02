local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "LynxKey"
Junkie.identifier = "1169210"
Junkie.provider = "lynxx"

local key = getgenv().SCRIPT_KEY or ""

if #key == 0 then
    warn("[Lynx] No key! Set getgenv().SCRIPT_KEY first.")
    return
end

local validation = Junkie.check_key(key)
if not validation.valid then
    warn("[Lynx] " .. (validation.error or "Invalid key!"))
    return
end

loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/016673b767b889390dcc246252ea04f16178417976023032a4601c7091dda7af/download"))()
