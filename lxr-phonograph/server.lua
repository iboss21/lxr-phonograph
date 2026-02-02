--[[
    🎵 LXR Phonograph - Server Side
    Multi-Framework Support System
    © 2026 iBoss21 / The Lux Empire | wolves.land
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Core = nil
local FrameworkName = nil
local InventoryAPI = nil

-- Detect and initialize the framework
local function InitializeFramework()
    if Config.Framework ~= 'auto' then
        FrameworkName = Config.Framework
    else
        -- Auto-detect framework based on priority
        if GetResourceState('lxr-core') == 'started' then
            FrameworkName = 'lxrcore'
        elseif GetResourceState('rsg-core') == 'started' then
            FrameworkName = 'rsg-core'
        elseif GetResourceState('qbr-core') == 'started' then
            FrameworkName = 'qbr-core'
        elseif GetResourceState('qr-core') == 'started' then
            FrameworkName = 'qr-core'
        elseif GetResourceState('vorp_core') == 'started' then
            FrameworkName = 'vorp'
        elseif GetResourceState('redem_roleplay') == 'started' then
            FrameworkName = 'redemrp'
        else
            FrameworkName = 'standalone'
        end
    end
    
    print('^2[LXR-Phonograph]^7 Detected Framework: ^3' .. FrameworkName .. '^7')
    
    -- Initialize Core based on framework
    if FrameworkName == 'lxrcore' then
        Core = exports['lxr-core']:GetCoreObject()
    elseif FrameworkName == 'rsg-core' then
        Core = exports['rsg-core']:GetCoreObject()
    elseif FrameworkName == 'qbr-core' then
        Core = exports['qbr-core']:GetCoreObject()
    elseif FrameworkName == 'qr-core' then
        Core = exports['qr-core']:GetCoreObject()
    elseif FrameworkName == 'vorp' then
        Core = exports.vorp_core:GetCore()
    elseif FrameworkName == 'redemrp' then
        Core = exports.redem_roleplay:GetCoreObject()
    end
    
    -- Initialize Inventory API
    if FrameworkName == 'lxrcore' and GetResourceState('lxr-inventory') == 'started' then
        InventoryAPI = exports['lxr-inventory']:InventoryAPI()
    elseif FrameworkName == 'rsg-core' and GetResourceState('rsg-inventory') == 'started' then
        InventoryAPI = exports['rsg-inventory']:InventoryAPI()
    elseif FrameworkName == 'qbr-core' and GetResourceState('qbr-inventory') == 'started' then
        InventoryAPI = exports['qbr-inventory']:InventoryAPI()
    elseif FrameworkName == 'qr-core' and GetResourceState('qr-inventory') == 'started' then
        InventoryAPI = exports['qr-inventory']:InventoryAPI()
    elseif FrameworkName == 'vorp' and GetResourceState('vorp_inventory') == 'started' then
        InventoryAPI = exports.vorp_inventory:vorp_inventoryApi()
    elseif FrameworkName == 'redemrp' and GetResourceState('redemrp_inventory') == 'started' then
        InventoryAPI = exports.redemrp_inventory:InventoryAPI()
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK ABSTRACTION FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Get player character data
local function GetCharacter(src)
    if FrameworkName == 'lxrcore' or FrameworkName == 'rsg-core' or FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
        local Player = Core.Functions.GetPlayer(src)
        if Player then
            return {
                identifier = Player.PlayerData.citizenid,
                charIdentifier = Player.PlayerData.citizenid,
            }
        end
    elseif FrameworkName == 'vorp' then
        local User = Core.getUser(src)
        if User then
            local Character = User.getUsedCharacter
            if Character then
                return {
                    identifier = Character.identifier,
                    charIdentifier = Character.charIdentifier,
                }
            end
        end
    elseif FrameworkName == 'redemrp' then
        local Player = Core.GetPlayer(src)
        if Player then
            return {
                identifier = Player.getIdentifier(),
                charIdentifier = Player.getSessionVar("charid"),
            }
        end
    elseif FrameworkName == 'standalone' then
        -- For standalone, use steam identifier
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

-- Send notification to player
local function Notify(src, title, message, type, duration)
    if FrameworkName == 'lxrcore' then
        Core.Functions.Notify(src, message, type or 'primary', duration or 3000)
    elseif FrameworkName == 'rsg-core' then
        Core.Functions.Notify(src, message, type or 'primary', duration or 3000)
    elseif FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
        TriggerClientEvent('QBCore:Notify', src, message, type or 'primary', duration or 3000)
    elseif FrameworkName == 'vorp' then
        local notifType = type == 'success' and 'COLOR_GREEN' or (type == 'error' and 'COLOR_RED' or 'COLOR_WHITE')
        local icon = type == 'success' and 'tick' or (type == 'error' and 'cross' or 'tick')
        local texture = type == 'error' and 'menu_textures' or 'generic_textures'
        Core.NotifyLeft(src, title, message, texture, icon, duration or 3000, notifType)
    elseif FrameworkName == 'redemrp' then
        TriggerClientEvent('redem_roleplay:Notify', src, message, type or 'success', duration or 3000)
    elseif FrameworkName == 'standalone' then
        TriggerClientEvent('chat:addMessage', src, {
            args = {title, message}
        })
    end
end

-- Add item to player inventory
local function AddItem(src, item, amount)
    if InventoryAPI then
        if FrameworkName == 'vorp' then
            InventoryAPI.addItem(src, item, amount)
        elseif FrameworkName == 'lxrcore' or FrameworkName == 'rsg-core' or FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
            local Player = Core.Functions.GetPlayer(src)
            if Player then
                Player.Functions.AddItem(item, amount)
            end
        elseif FrameworkName == 'redemrp' then
            local Player = Core.GetPlayer(src)
            if Player then
                Player.addItem(item, amount)
            end
        end
    end
end

-- Remove item from player inventory
local function RemoveItem(src, item, amount)
    if InventoryAPI then
        if FrameworkName == 'vorp' then
            InventoryAPI.subItem(src, item, amount)
        elseif FrameworkName == 'lxrcore' or FrameworkName == 'rsg-core' or FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
            local Player = Core.Functions.GetPlayer(src)
            if Player then
                Player.Functions.RemoveItem(item, amount)
            end
        elseif FrameworkName == 'redemrp' then
            local Player = Core.GetPlayer(src)
            if Player then
                Player.removeItem(item, amount)
            end
        end
    end
end

-- Register usable item
local function RegisterUsableItem(item, callback)
    if InventoryAPI then
        if FrameworkName == 'vorp' then
            InventoryAPI.RegisterUsableItem(item, callback)
        elseif FrameworkName == 'lxrcore' or FrameworkName == 'rsg-core' or FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
            Core.Functions.CreateUseableItem(item, function(source)
                callback({source = source})
            end)
        elseif FrameworkName == 'redemrp' then
            -- RedEM:RP item usage
            Core.RegisterUseItem(item, function(source)
                callback({source = source})
            end)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- INITIALIZE ON RESOURCE START
-- ═══════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    InitializeFramework()
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- PHONOGRAPH SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local currentlyPlaying = {}

RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(uniqueId, coords, url, volume, loop)
    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId] = nil
        TriggerClientEvent('rs_phonograph:client:stopMusic', -1, uniqueId)
    end

    currentlyPlaying[uniqueId] = {
        url = url,
        volume = volume,
        coords = coords,
        loop = loop or false,
        startTime = os.time()
    }

    TriggerClientEvent('rs_phonograph:client:playMusic', -1, uniqueId, coords, url, volume, loop or false, 0)
end)

RegisterNetEvent('rs_phonograph:server:resetLoop')
AddEventHandler('rs_phonograph:server:resetLoop', function(uniqueId)
    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId].startTime = os.time()
    end
end)

RegisterNetEvent('rs_phonograph:server:stopMusic')
AddEventHandler('rs_phonograph:server:stopMusic', function(uniqueId)
    currentlyPlaying[uniqueId] = nil
    TriggerClientEvent('rs_phonograph:client:stopMusic', -1, uniqueId)
end)

RegisterNetEvent('rs_phonograph:server:setVolume')
AddEventHandler('rs_phonograph:server:setVolume', function(uniqueId, newVolume)
    TriggerClientEvent('rs_phonograph:client:setVolume', -1, uniqueId, newVolume)
end)

RegisterNetEvent('rs_phonograph:server:soundEnded')
AddEventHandler('rs_phonograph:server:soundEnded', function(uniqueId)
    currentlyPlaying[uniqueId] = nil
end)

RegisterNetEvent('rs_phonograph:server:toggleLoop')
AddEventHandler('rs_phonograph:server:toggleLoop', function(uniqueId, state)
    local src = source
    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId].loop = state
        currentlyPlaying[uniqueId].startTime = os.time()
    end
    TriggerClientEvent('rs_phonograph:client:toggleLoop', -1, uniqueId, state)
    TriggerClientEvent('rs_phonograph:client:notifyLoop', src, state)
end)

RegisterNetEvent('rs_phonograph:server:syncMusic')
AddEventHandler('rs_phonograph:server:syncMusic', function()
    local src = source
    for uniqueId, data in pairs(currentlyPlaying) do
        local elapsed = os.time() - data.startTime
        if elapsed < 0 then elapsed = 0 end
        TriggerClientEvent('rs_phonograph:client:playMusic', src, uniqueId, data.coords, data.url, data.volume, data.loop, elapsed)
    end
end)

local loadedPhonographs = {}

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() ~= resource then return end

    exports.oxmysql:execute('SELECT * FROM phonographs', {}, function(results)
        if results then
            loadedPhonographs = {}
            for _, row in pairs(results) do
                local phonographData = {
                    id = row.id,
                    x = row.x,
                    y = row.y,
                    z = row.z,
                    rotation = { x = row.rot_x, y = row.rot_y, z = row.rot_z }
                }
                table.insert(loadedPhonographs, phonographData)
            end
        end
    end)
end)

RegisterNetEvent('rs_phonograph:server:requestPhonographs')
AddEventHandler('rs_phonograph:server:requestPhonographs', function()
    local src = source
    TriggerClientEvent('rs_phonograph:client:receivePhonographs', src, loadedPhonographs)
end)

RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(coords, rotation)
    local src = source
    local Character = GetCharacter(src)
    if not Character then return end

    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier

    local rotX, rotY, rotZ = rotation.x, rotation.y, rotation.z

    local query = [[
        INSERT INTO phonographs (owner_identifier, owner_charid, x, y, z, rot_x, rot_y, rot_z)
        VALUES (@identifier, @charid, @x, @y, @z, @rot_x, @rot_y, @rot_z)
    ]]

    local params = {
        ['@identifier'] = u_identifier,
        ['@charid'] = u_charid,
        ['@x'] = coords.x,
        ['@y'] = coords.y,
        ['@z'] = coords.z,
        ['@rot_x'] = rotX,
        ['@rot_y'] = rotY,
        ['@rot_z'] = rotZ
    }

    exports.oxmysql:execute(query, params, function(result)
        if result and result.insertId then
            local phonographData = {
                id = result.insertId,
                x = coords.x,
                y = coords.y,
                z = coords.z,
                rotation = { x = rotX, y = rotY, z = rotZ }
            }

            table.insert(loadedPhonographs, phonographData)

            TriggerClientEvent('rs_phonograph:client:spawnPhonograph', -1, phonographData)
        end
    end)
end)

RegisterNetEvent('rs_phonograph:server:pickUpByOwner')
AddEventHandler('rs_phonograph:server:pickUpByOwner', function(uniqueId)
    local src = source
    local Character = GetCharacter(src)
    if not Character then return end

    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)

    exports.oxmysql:execute(
        'SELECT * FROM phonographs WHERE id = ? AND owner_identifier = ? AND owner_charid = ?',
        {uniqueId, u_identifier, u_charid},
        function(results)
            if results and #results > 0 then
                local row = results[1]
                local phonoCoords = vector3(row.x, row.y, row.z)
                local distance = #(playerCoords - phonoCoords)

                if distance <= 2.5 then

                    TriggerClientEvent('rs_phonograph:client:removePhonograph', -1, uniqueId)

                    TriggerEvent('rs_phonograph:server:stopMusic', uniqueId)

                    for i, phonograph in ipairs(loadedPhonographs) do
                        if phonograph.id == uniqueId then
                            table.remove(loadedPhonographs, i)
                            break
                        end
                    end

                    exports.oxmysql:execute(
                        'DELETE FROM phonographs WHERE id = ?',
                        {uniqueId},
                        function(result)
                            local affected = result and (result.affectedRows or result.affected_rows or result.changes)
                            if affected and affected > 0 then
                                AddItem(src, Config.PhonoItems, 1)
                                Notify(src, Config.Notify.Phono, Config.Notify.Picked, 'success', 4000)
                            end
                        end
                    )
                else
                    Notify(src, Config.Notify.Phono, Config.Notify.TooFar, 'error', 3000)
                end
            else
                Notify(src, Config.Notify.Phono, Config.Notify.Dont, 'error', 3000)
            end
        end
    )
end)

RegisterUsableItem(Config.PhonoItems, function(data)
    local src = data.source

    local Character = GetCharacter(src)
    if not Character then return end

    local identifier = Character.identifier
    local charid = Character.charIdentifier
    
    -- Close inventory
    if InventoryAPI and FrameworkName == 'vorp' then
        InventoryAPI.CloseInv(src)
    elseif FrameworkName == 'lxrcore' or FrameworkName == 'rsg-core' or FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
        TriggerClientEvent('inventory:client:closeInv', src)
    end

    exports.oxmysql:execute('SELECT id FROM phonographs WHERE owner_identifier = ? AND owner_charid = ?', {
        identifier, charid
    }, function(result)
        if result and #result > 0 then
            Notify(src, Config.Notify.Phono, Config.Notify.Already, 'error', 3000)
        else
            TriggerClientEvent("rs_phonograph:client:placePropPhonograph", src)
        end
    end)
end)

RegisterNetEvent("rs_phonograph:givePhonograph", function()
    local src = source
    RemoveItem(src, Config.PhonoItems, 1)
end)
