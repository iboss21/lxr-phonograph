--[[
    ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗     ███████╗██╗██████╗ ███████╗
    ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗    ██╔════╝██║██╔══██╗██╔════╝
    ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝    ███████╗██║██║  ██║█████╗  
    ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗    ╚════██║██║██║  ██║██╔══╝  
    ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║    ███████║██║██████╔╝███████╗
    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚══════╝╚═╝╚═════╝ ╚══════╝
    
    🐺 LXR Phonograph - Server Side
    
    This is the server-side logic for the LXR Phonograph system, handling:
    - Player phonograph ownership and placement
    - Music synchronization across all clients
    - Database operations for persistent storage
    - Item registration and usage
    - Security validation and cooldowns
    
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
    
    Original:    riversafe (rs_phonograph)
    Adapted by:  iBoss21 / The Lux Empire for The Land of Wolves
    
    ═══════════════════════════════════════════════════════════════════════════════
    
    Version: 2.1.0
    Performance Target: Optimized for minimal server overhead
    
    Tags: RedM, Server, Phonograph, Music, Multiplayer
    
    Framework Support: LXR-Core, RSG-Core, VORP, QBR, QR, RedEM:RP, Standalone
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    
    Original Script: riversafe (rs_phonograph V2)
    Framework Adaptation: iBoss21 / The Lux Empire for The Land of Wolves
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ PHONOGRAPH SYSTEM ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

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
    local Character = Framework.GetCharacterIdentifiers(src)
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
    local Character = Framework.GetCharacterIdentifiers(src)
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
                                Framework.AddItem(src, Config.PhonoItems, 1)
                                Framework.Notify(src, Config.Notify.Phono, Config.Notify.Picked, 'success', 4000)
                            end
                        end
                    )
                else
                    Framework.Notify(src, Config.Notify.Phono, Config.Notify.TooFar, 'error', 3000)
                end
            else
                Framework.Notify(src, Config.Notify.Phono, Config.Notify.Dont, 'error', 3000)
            end
        end
    )
end)

-- ════════════════════════════════════════════════════════════════════════════════
-- ████████████████████████ ITEM REGISTRATION ████████████████████████████
-- ════════════════════════════════════════════════════════════════════════════════

-- Wait for Framework to be fully initialized before registering usable items
Citizen.CreateThread(function()
    -- Wait for Framework to be ready
    while not Framework.IsReady do
        Wait(100)
    end
    
    -- Additional delay to ensure framework core is fully loaded and ready to accept item registrations
    -- This prevents race conditions where the framework export is available but not yet ready
    Wait(500)
    
    if Config.Debug.enabled then
        print('^2[LXR-Phonograph]^7 Registering phonograph item: ^3' .. Config.PhonoItems .. '^7')
    end
    
    Framework.RegisterUsableItem(Config.PhonoItems, function(src, itemData)
        local Character = Framework.GetCharacterIdentifiers(src)
        if not Character then
            if Config.Debug.enabled then
                print('^1[LXR-Phonograph]^7 Failed to get character identifiers for source: ' .. src)
            end
            return
        end

        local identifier = Character.identifier
        local charid = Character.charIdentifier
        
        if Config.Debug.enabled then
            print('^2[LXR-Phonograph]^7 Player ' .. src .. ' using phonograph item')
        end
        
        -- Close inventory
        Framework.CloseInventory(src)

        exports.oxmysql:execute('SELECT id FROM phonographs WHERE owner_identifier = ? AND owner_charid = ?', {
            identifier, charid
        }, function(result)
            if result and #result > 0 then
                if Config.Debug.enabled then
                    print('^3[LXR-Phonograph]^7 Player ' .. src .. ' already has a phonograph placed')
                end
                Framework.Notify(src, Config.Notify.Phono, Config.Notify.Already, 'error', 3000)
            else
                if Config.Debug.enabled then
                    print('^2[LXR-Phonograph]^7 Triggering placement for player ' .. src)
                end
                TriggerClientEvent("rs_phonograph:client:placePropPhonograph", src)
            end
        end)
    end)
    
    print('^2[LXR-Phonograph]^7 Phonograph item registration ^2complete^7')
end)
end)

RegisterNetEvent("rs_phonograph:givePhonograph", function()
    local src = source
    Framework.RemoveItem(src, Config.PhonoItems, 1)
end)
