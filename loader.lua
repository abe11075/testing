local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service    = "LynxKey"
Junkie.identifier = "1169210"
Junkie.provider   = "lynxx"

local userKey = getgenv().LYNX_KEY

if not userKey or #userKey == 0 then
    game.Players.LocalPlayer:Kick("[Lynx] Key tidak ditemukan. Set getgenv().LYNX_KEY sebelum execute.")
    return
end

local ok, validation = pcall(function()
    return Junkie.check_key(userKey)
end)

if not ok or not validation or not validation.valid then
    local errMsg = "[Lynx] Key tidak valid."

    if validation and validation.message then
        if validation.message == "KEY_EXPIRED" then
            errMsg = "[Lynx] Key sudah expired. Hubungi admin."
        elseif validation.message == "HWID_BANNED" then
            errMsg = "[Lynx] Hardware kamu di-ban."
        elseif validation.message == "SERVICE_MISMATCH" then
            errMsg = "[Lynx] Key bukan untuk script ini."
        elseif validation.message == "HWID_MISMATCH" then
            errMsg = "[Lynx] Key sudah dipakai di device lain."
        end
    end

    game.Players.LocalPlayer:Kick(errMsg)
    return
end

getgenv().LYNX_KEY = userKey

loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/059ada0f7145c09bb71b53e71591f42299ab7ffd86b544758bc659b37a9e7169/download"))()
