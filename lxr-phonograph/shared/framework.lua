--[[
    ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗     █████╗ ██████╗  █████╗ ██████╗ ████████╗███████╗██████╗ 
    ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
    █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝     ███████║██║  ██║███████║██████╔╝   ██║   █████╗  ██████╔╝
    ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗     ██╔══██║██║  ██║██╔══██║██╔═══╝    ██║   ██╔══╝  ██╔══██╗
    ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗    ██║  ██║██████╔╝██║  ██║██║        ██║   ███████╗██║  ██║
    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝        ╚═╝   ╚══════╝╚═╝  ╚═╝
    
    🐺 LXR Phonograph - Framework Adapter Layer
    
    This module provides a unified abstraction layer for all supported RedM frameworks.
    It ensures that core game logic remains clean while maintaining true compatibility
    across multiple framework systems.
    
    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════
    
    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted
    
    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    Version: 2.1.0
    Performance Target: Minimal overhead, optimized for production environments
    
    Tags: RedM, Framework, Adapter, Multi-Framework, LXR, RSG, VORP
    
    Framework Support:
    - LXRCore (Primary)
    - RSG-Core (Primary)
    - VORP Core (Legacy)
    - QBR Core
    - QR Core
    - RedEM:RP
    - Standalone
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    
    Framework Adapter Design: iBoss21 / The Lux Empire for The Land of Wolves
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ FRAMEWORK BRIDGE OBJECT ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

Framework = {
    Name = nil,
    Core = nil,
    IsReady = false,
}

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ DETECTION & INITIALIZATION ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

function Framework.Detect()
    if Config.Framework ~= 'auto' then
        Framework.Name = Config.Framework
    else
        -- Auto-detect framework based on priority
        if GetResourceState('lxr-core') == 'started' then
            Framework.Name = 'lxrcore'
        elseif GetResourceState('rsg-core') == 'started' then
            Framework.Name = 'rsg-core'
        elseif GetResourceState('qbr-core') == 'started' then
            Framework.Name = 'qbr-core'
        elseif GetResourceState('qr-core') == 'started' then
            Framework.Name = 'qr-core'
        elseif GetResourceState('vorp_core') == 'started' then
            Framework.Name = 'vorp'
        elseif GetResourceState('redem_roleplay') == 'started' then
            Framework.Name = 'redemrp'
        else
            Framework.Name = 'standalone'
        end
    end
    
    print(string.format('^2[LXR-Phonograph]^7 Framework Detected: ^3%s^7', Framework.Name))
    return Framework.Name
end

function Framework.Initialize()
    Framework.Detect()
    
    -- Initialize Core based on framework
    local success = false
    local coreObject = nil
    
    if Framework.Name == 'lxrcore' then
        success, coreObject = pcall(function()
            return exports['lxr-core']:GetCoreObject()
        end)
        if success then Framework.Core = coreObject end
    elseif Framework.Name == 'rsg-core' then
        success, coreObject = pcall(function()
            return exports['rsg-core']:GetCoreObject()
        end)
        if success then Framework.Core = coreObject end
    elseif Framework.Name == 'qbr-core' then
        success, coreObject = pcall(function()
            return exports['qbr-core']:GetCoreObject()
        end)
        if success then Framework.Core = coreObject end
    elseif Framework.Name == 'qr-core' then
        success, coreObject = pcall(function()
            return exports['qr-core']:GetCoreObject()
        end)
        if success then Framework.Core = coreObject end
    elseif Framework.Name == 'vorp' then
        success, coreObject = pcall(function()
            return exports.vorp_core:GetCore()
        end)
        if success then Framework.Core = coreObject end
    elseif Framework.Name == 'redemrp' then
        success, coreObject = pcall(function()
            return exports.redem_roleplay:GetCoreObject()
        end)
        if success then Framework.Core = coreObject end
    elseif Framework.Name == 'standalone' then
        -- Standalone doesn't need a core object, initialize empty table
        Framework.Core = {}
        success = true
    end
    
    if not success then
        print(string.format('^1[LXR-Phonograph]^7 Framework initialization failed: %s', tostring(coreObject)))
        print(string.format('^3[LXR-Phonograph]^7 Retrying framework initialization in 2 seconds...'))
        return false
    end
    
    Framework.IsReady = true
    print(string.format('^2[LXR-Phonograph]^7 Framework Adapter: ^2Ready^7 (Framework: %s)', Framework.Name))
    return true
end

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ SERVER-SIDE FUNCTIONS ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

if IsDuplicityVersion() then -- Server-side only

    -- ═══════════════════════════════════════════════════════════════════════════════
    -- CHARACTER & PLAYER FUNCTIONS
    -- ═══════════════════════════════════════════════════════════════════════════════
    
    function Framework.GetPlayer(src)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' or Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            return Framework.Core.Functions.GetPlayer(src)
        elseif Framework.Name == 'vorp' then
            local User = Framework.Core.getUser(src)
            if User then
                return User.getUsedCharacter
            end
        elseif Framework.Name == 'redemrp' then
            return Framework.Core.GetPlayer(src)
        elseif Framework.Name == 'standalone' then
            -- For standalone, create a minimal player object
            local identifiers = GetPlayerIdentifiers(src)
            local identifier = nil
            for _, id in pairs(identifiers) do
                if string.find(id, "steam:") then
                    identifier = id
                    break
                end
            end
            return {
                source = src,
                identifier = identifier or "unknown",
            }
        end
        return nil
    end
    
    function Framework.GetCharacterIdentifiers(src)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' or Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            local Player = Framework.Core.Functions.GetPlayer(src)
            if Player then
                return {
                    identifier = Player.PlayerData.citizenid,
                    charIdentifier = Player.PlayerData.citizenid,
                }
            end
        elseif Framework.Name == 'vorp' then
            local User = Framework.Core.getUser(src)
            if User then
                local Character = User.getUsedCharacter
                if Character then
                    return {
                        identifier = Character.identifier,
                        charIdentifier = Character.charIdentifier,
                    }
                end
            end
        elseif Framework.Name == 'redemrp' then
            local Player = Framework.Core.GetPlayer(src)
            if Player then
                return {
                    identifier = Player.getIdentifier(),
                    charIdentifier = Player.getSessionVar("charid"),
                }
            end
        elseif Framework.Name == 'standalone' then
            local identifiers = GetPlayerIdentifiers(src)
            local identifier = nil
            for _, id in pairs(identifiers) do
                if string.find(id, "steam:") then
                    identifier = id
                    break
                end
            end
            return {
                identifier = identifier or "unknown",
                charIdentifier = identifier or "unknown",
            }
        end
        return nil
    end
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION FUNCTIONS
    -- ═══════════════════════════════════════════════════════════════════════════════
    
    function Framework.Notify(src, title, message, type, duration)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' then
            Framework.Core.Functions.Notify(src, message, type or 'primary', duration or 3000)
        elseif Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            TriggerClientEvent('QBCore:Notify', src, message, type or 'primary', duration or 3000)
        elseif Framework.Name == 'vorp' then
            local notifType = type == 'success' and 'COLOR_GREEN' or (type == 'error' and 'COLOR_RED' or 'COLOR_WHITE')
            local icon = type == 'success' and 'tick' or (type == 'error' and 'cross' or 'tick')
            local texture = type == 'error' and 'menu_textures' or 'generic_textures'
            Framework.Core.NotifyLeft(src, title, message, texture, icon, duration or 3000, notifType)
        elseif Framework.Name == 'redemrp' then
            TriggerClientEvent('redem_roleplay:Notify', src, message, type or 'success', duration or 3000)
        elseif Framework.Name == 'standalone' then
            TriggerClientEvent('chat:addMessage', src, {
                args = {title, message}
            })
        end
    end
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- INVENTORY FUNCTIONS
    -- ═══════════════════════════════════════════════════════════════════════════════
    
    function Framework.AddItem(src, item, amount)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' or Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            local Player = Framework.Core.Functions.GetPlayer(src)
            if Player then
                Player.Functions.AddItem(item, amount)
            end
        elseif Framework.Name == 'vorp' then
            -- VORP inventory uses a callback system
            local canCarry = exports.vorp_inventory:canCarryItem(src, item, amount)
            if canCarry then
                exports.vorp_inventory:addItem(src, item, amount)
            end
        elseif Framework.Name == 'redemrp' then
            local Player = Framework.Core.GetPlayer(src)
            if Player then
                Player.addItem(item, amount)
            end
        end
    end
    
    function Framework.RemoveItem(src, item, amount)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' or Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            local Player = Framework.Core.Functions.GetPlayer(src)
            if Player then
                Player.Functions.RemoveItem(item, amount)
            end
        elseif Framework.Name == 'vorp' then
            exports.vorp_inventory:subItem(src, item, amount)
        elseif Framework.Name == 'redemrp' then
            local Player = Framework.Core.GetPlayer(src)
            if Player then
                Player.removeItem(item, amount)
            end
        end
    end
    
    function Framework.HasItem(src, item, amount)
        amount = amount or 1
        
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' or Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            local Player = Framework.Core.Functions.GetPlayer(src)
            if Player then
                local itemData = Player.Functions.GetItemByName(item)
                if itemData and itemData.amount >= amount then
                    return true
                end
            end
        elseif Framework.Name == 'vorp' then
            local hasItem = exports.vorp_inventory:getItem(src, item)
            if hasItem and hasItem.count >= amount then
                return true
            end
        elseif Framework.Name == 'redemrp' then
            local Player = Framework.Core.GetPlayer(src)
            if Player then
                local itemCount = Player.getInventoryItem(item)
                if itemCount and itemCount >= amount then
                    return true
                end
            end
        end
        return false
    end
    
    function Framework.RegisterUsableItem(item, callback)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' or Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            Framework.Core.Functions.CreateUseableItem(item, function(source, itemData)
                callback(source, itemData)
            end)
        elseif Framework.Name == 'vorp' then
            exports.vorp_inventory:registerUsableItem(item, function(data)
                callback(data.source, data.item)
            end)
        elseif Framework.Name == 'redemrp' then
            -- RedEM:RP item usage
            Framework.Core.RegisterUseItem(item, function(source)
                callback(source, {})
            end)
        end
    end
    
    function Framework.CloseInventory(src)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' then
            TriggerClientEvent('inventory:client:closeInv', src)
        elseif Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            TriggerClientEvent('inventory:client:closeInv', src)
        elseif Framework.Name == 'vorp' then
            exports.vorp_inventory:closeInventory(src)
        elseif Framework.Name == 'redemrp' then
            TriggerClientEvent('redemrp_inventory:close', src)
        end
    end

end

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ CLIENT-SIDE FUNCTIONS ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

if not IsDuplicityVersion() then -- Client-side only

    Framework.PlayerLoaded = false
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- PLAYER LOADED EVENT REGISTRATION
    -- ═══════════════════════════════════════════════════════════════════════════════
    
    function Framework.RegisterPlayerLoadedEvent(callback)
        if Framework.Name == 'lxrcore' then
            RegisterNetEvent('LXR:Client:OnPlayerLoaded', function()
                Framework.PlayerLoaded = true
                if callback then callback() end
            end)
        elseif Framework.Name == 'rsg-core' then
            RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
                Framework.PlayerLoaded = true
                if callback then callback() end
            end)
        elseif Framework.Name == 'qbr-core' then
            RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
                Framework.PlayerLoaded = true
                if callback then callback() end
            end)
        elseif Framework.Name == 'qr-core' then
            RegisterNetEvent('QR:Client:OnPlayerLoaded', function()
                Framework.PlayerLoaded = true
                if callback then callback() end
            end)
        elseif Framework.Name == 'vorp' then
            RegisterNetEvent("vorp:SelectedCharacter", function()
                Framework.PlayerLoaded = true
                if callback then callback() end
            end)
        elseif Framework.Name == 'redemrp' then
            RegisterNetEvent('RedEM:PlayerLoaded', function()
                Framework.PlayerLoaded = true
                if callback then callback() end
            end)
        elseif Framework.Name == 'standalone' then
            -- For standalone, consider player as always loaded
            Framework.PlayerLoaded = true
            if callback then callback() end
        end
    end
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION FUNCTIONS (CLIENT)
    -- ═══════════════════════════════════════════════════════════════════════════════
    
    function Framework.Notify(title, message, type, duration)
        if Framework.Name == 'lxrcore' or Framework.Name == 'rsg-core' then
            Framework.Core.Functions.Notify(message, type or 'primary', duration or 3000)
        elseif Framework.Name == 'qbr-core' or Framework.Name == 'qr-core' then
            TriggerEvent('QBCore:Notify', message, type or 'primary', duration or 3000)
        elseif Framework.Name == 'vorp' then
            local notifType = type == 'success' and 'success' or (type == 'error' and 'error' or 'tip')
            TriggerEvent('vorp:TipRight', message, duration or 3000)
        elseif Framework.Name == 'redemrp' then
            TriggerEvent('redem_roleplay:Notify', message, type or 'success', duration or 3000)
        elseif Framework.Name == 'standalone' then
            -- Native notification for standalone
            local str = CreateVarString(10, 'LITERAL_STRING', message)
            local str2 = CreateVarString(10, 'LITERAL_STRING', title)
            Citizen.InvokeNative(0xF1A4817D, 1, str, str2, duration or 3000)
        end
    end
    
    -- ═══════════════════════════════════════════════════════════════════════════════
    -- PROMPT FUNCTIONS (CLIENT)
    -- ═══════════════════════════════════════════════════════════════════════════════
    
    function Framework.CreatePrompt(text, key, callback)
        -- Native RedM prompt creation (works for all frameworks)
        local str = CreateVarString(10, 'LITERAL_STRING', text)
        local prompt = Citizen.InvokeNative(0x04F97DE45A519419)
        
        Citizen.InvokeNative(0xB5352B7494A08258, prompt, key, str)
        Citizen.InvokeNative(0xF7AA2696A22AD8B9, prompt)
        
        return prompt
    end
    
    function Framework.IsPromptJustPressed(prompt)
        return Citizen.InvokeNative(0x0D00EDDFB58B7F28, prompt) == 1
    end

end

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ AUTO-INITIALIZATION ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    -- Retry initialization until successful
    local maxRetries = 10
    local retryCount = 0
    local retryDelay = 2000 -- 2 seconds
    
    while retryCount < maxRetries do
        if Framework.Initialize() then
            -- Success!
            break
        else
            -- Failed, retry
            retryCount = retryCount + 1
            if retryCount < maxRetries then
                Wait(retryDelay)
            else
                print('^1[LXR-Phonograph]^7 Failed to initialize framework after ' .. maxRetries .. ' attempts!')
            end
        end
    end
end)

return Framework
