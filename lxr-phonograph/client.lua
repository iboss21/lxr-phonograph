--[[
    🎵 LXR Phonograph - Client Side
    Multi-Framework Support System
    © 2026 iBoss21 / The Lux Empire | wolves.land
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION & INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════════════════

local Core = nil
local FrameworkName = nil
local PlayerLoaded = false

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
    
    print('^2[LXR-Phonograph]^7 Client Framework: ^3' .. FrameworkName .. '^7')
    
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
end

-- Register player loaded event based on framework
local function RegisterPlayerLoadedEvent()
    if FrameworkName == 'lxrcore' then
        RegisterNetEvent('LXR:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
            TriggerServerEvent('rs_phonograph:server:syncMusic')
        end)
    elseif FrameworkName == 'rsg-core' then
        RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
            TriggerServerEvent('rs_phonograph:server:syncMusic')
        end)
    elseif FrameworkName == 'qbr-core' then
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
            TriggerServerEvent('rs_phonograph:server:syncMusic')
        end)
    elseif FrameworkName == 'qr-core' then
        RegisterNetEvent('QR:Client:OnPlayerLoaded', function()
            PlayerLoaded = true
            TriggerServerEvent('rs_phonograph:server:syncMusic')
        end)
    elseif FrameworkName == 'vorp' then
        RegisterNetEvent("vorp:SelectedCharacter", function()
            PlayerLoaded = true
            TriggerServerEvent('rs_phonograph:server:syncMusic')
        end)
    elseif FrameworkName == 'redemrp' then
        RegisterNetEvent('RedEM:PlayerLoaded', function()
            PlayerLoaded = true
            TriggerServerEvent('rs_phonograph:server:syncMusic')
        end)
    elseif FrameworkName == 'standalone' then
        -- For standalone, consider player as always loaded
        PlayerLoaded = true
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK ABSTRACTION FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Send notification to player
local function Notify(title, message, type, duration)
    if FrameworkName == 'lxrcore' then
        Core.Functions.Notify(message, type or 'primary', duration or 3000)
    elseif FrameworkName == 'rsg-core' then
        Core.Functions.Notify(message, type or 'primary', duration or 3000)
    elseif FrameworkName == 'qbr-core' or FrameworkName == 'qr-core' then
        Core.Functions.Notify(message, type or 'primary', duration or 3000)
    elseif FrameworkName == 'vorp' then
        local notifType = type == 'success' and 'COLOR_GREEN' or (type == 'error' and 'COLOR_RED' or 'COLOR_WHITE')
        local icon = type == 'success' and 'tick' or (type == 'error' and 'cross' or 'tick')
        local texture = type == 'error' and 'menu_textures' or 'generic_textures'
        TriggerEvent("vorp:NotifyLeft", title, message, texture, icon, duration or 3000, notifType)
    elseif FrameworkName == 'redemrp' then
        TriggerEvent('redem_roleplay:Notify', message, type or 'success', duration or 3000)
    elseif FrameworkName == 'standalone' then
        -- Native notification
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(false, true)
    end
end

-- Show input dialog (for speed adjustment)
local function ShowInput(data)
    if FrameworkName == 'vorp' then
        local myInput = {
            type = "enableinput",
            inputType = "input",
            button = data.button or Config.Input.Confirm,
            placeholder = data.placeholder or Config.Input.MinMax,
            style = "block",
            attributes = {
                inputHeader = data.header or Config.Input.Speed,
                type = "text",
                pattern = "[0-9.]+",
                title = data.title or Config.Input.Change,
                style = "border-radius: 10px; background-color: ; border:none;"
            }
        }
        return exports.vorp_inputs:advancedInput(myInput)
    elseif FrameworkName == 'lxrcore' and GetResourceState('lxr-input') == 'started' then
        local result = exports['lxr-input']:ShowInput({
            header = data.header or Config.Input.Speed,
            submitText = data.button or Config.Input.Confirm,
            inputs = {
                {
                    text = data.placeholder or Config.Input.MinMax,
                    name = "value",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if result then
            return result.value
        end
    elseif FrameworkName == 'rsg-core' and GetResourceState('rsg-input') == 'started' then
        local result = exports['rsg-input']:ShowInput({
            header = data.header or Config.Input.Speed,
            submitText = data.button or Config.Input.Confirm,
            inputs = {
                {
                    text = data.placeholder or Config.Input.MinMax,
                    name = "value",
                    type = "number",
                    isRequired = true
                }
            }
        })
        if result then
            return result.value
        end
    else
        -- Fallback: use a simple hardcoded value or skip input
        return "0.05"
    end
end

-- Draw 3D text at a position in the world
local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- INITIALIZE ON RESOURCE START
-- ═══════════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    InitializeFramework()
    RegisterPlayerLoadedEvent()
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- PHONOGRAPH SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════

local volume = 0.3
local loopEnabled = false
local nuiOpen = false
local phonographEntities = {}
local closestEntity = nil
local closestId = nil
local lastPlacedPhonograph = nil
local phonographData = {}
local distance = 50.0

local function openNui()
    if nuiOpen then return end
    nuiOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "showNUI",
        allowCustom = Config.AllowCustomSongs,
        allowList = Config.AllowListSongs,
        songs = Config.SongList,
        translations = Config.MusicTranslations
    })
end

local function closeNui()
    nuiOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "hideNUI" })
end

RegisterNUICallback("playUrl", function(data, cb)
    if data.url and data.url:sub(1, 4) == "http" then
        TriggerServerEvent('rs_phonograph:server:playMusic', closestId, GetEntityCoords(closestEntity), data.url, volume)
        Notify(Config.Notify.Phono, Config.Notify.PlayMessage, "success", 1500)
    else
        Notify(Config.Notify.Phono, Config.Notify.InvalidUrlMessage, "error", 500)
    end
    cb({})
end)

RegisterNUICallback("playSelected", function(data, cb)
    if data.url then
        TriggerServerEvent('rs_phonograph:server:playMusic', closestId, GetEntityCoords(closestEntity), data.url, volume)
        Notify(Config.Notify.Phono, Config.Notify.PlaySelect, "success", 1500)
    end
    cb({})
end)

RegisterNUICallback("stopAudio", function(_, cb)
    TriggerServerEvent('rs_phonograph:server:stopMusic', closestId)
    Notify(Config.Notify.Phono, Config.Notify.StopMessage, "error", 500)
    cb({})
end)

RegisterNUICallback("setVolume", function(data, cb)
    volume = math.max(0.0, math.min(data.volume / 100, 1.0))
    TriggerServerEvent('rs_phonograph:server:setVolume', closestId, volume)
    cb({})
end)

RegisterNUICallback("toggleLoop", function(_, cb)
    loopEnabled = not loopEnabled
    TriggerServerEvent('rs_phonograph:server:toggleLoop', closestId, loopEnabled)
    cb({})
end)

RegisterNUICallback("closeNui", function(_, cb)
    closeNui()
    cb({})
end)

RegisterNetEvent('rs_phonograph:client:spawnPhonograph')
AddEventHandler('rs_phonograph:client:spawnPhonograph', function(data)
    phonographData[data.id] = data
end)

RegisterNetEvent('rs_phonograph:client:removePhonograph')
AddEventHandler('rs_phonograph:client:removePhonograph', function(uniqueId)
    local entity = phonographEntities[uniqueId]
    if entity and DoesEntityExist(entity) then
        DeleteObject(entity)
    end
    phonographEntities[uniqueId] = nil
    phonographData[uniqueId] = nil
end)

Citizen.CreateThread(function()
    TriggerServerEvent('rs_phonograph:server:requestPhonographs')
end)

RegisterNetEvent('rs_phonograph:client:receivePhonographs')
AddEventHandler('rs_phonograph:client:receivePhonographs', function(phonographs)
    if phonographs then
        for _, data in pairs(phonographs) do
            TriggerEvent('rs_phonograph:client:spawnPhonograph', data)
        end
    end
end)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for id, data in pairs(phonographData) do
            local pos = vector3(data.x, data.y, data.z)
            local dist = #(playerCoords - pos)

            if dist < distance and not phonographEntities[id] then
                local propModel = `p_phonograph01x`
                RequestModel(propModel)
                while not HasModelLoaded(propModel) do Wait(10) end

                local object = CreateObject(propModel, data.x, data.y, data.z, false, false, false)
                SetEntityHeading(object, tonumber(data.rotation.z or 0.0) % 360.0)
                FreezeEntityPosition(object, true)
                SetEntityAsMissionEntity(object, true)

                phonographEntities[id] = object
            end

            if dist > distance and phonographEntities[id] then
                DeleteEntity(phonographEntities[id])
                phonographEntities[id] = nil
            end
        end

        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    local showingPhonograph = false

    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local nearPhonograph = false
        closestEntity, closestId = nil, nil

        for uniqueId, entity in pairs(phonographEntities or {}) do
            if DoesEntityExist(entity) then
                local entityCoords = GetEntityCoords(entity)
                local distance = #(playerCoords - entityCoords)
                if distance < 1.5 then
                    nearPhonograph = true
                    closestEntity = entity
                    closestId = uniqueId
                    break
                end
            end
        end

        if nearPhonograph then
            if not showingPhonograph then
                SendNUIMessage({
                    type = "showPhonograph",
                    textTop = Config.Promp.openmanuUi,
                    textBottom = Config.Promp.Collect,
                })
                showingPhonograph = true
            end

            if IsControlJustReleased(0, Config.Promp.openUi) then
                if closestId then
                    openNui()
                else
                    Notify(Config.Notify.Phono, Config.Notify.UnregisteredMessage, "success", 3000)
                end
            end

            if IsControlJustReleased(0, Config.Promp.collectPhonograph) then
                if closestId then
                    TriggerServerEvent('rs_phonograph:server:pickUpByOwner', closestId)
                else
                    Notify(Config.Notify.Phono, Config.Notify.UnregisteredMessage, "success", 3000)
                end
            end
        else
            if showingPhonograph then
                SendNUIMessage({ type = "hidePhonograph" })
                showingPhonograph = false
            end
        end

        Citizen.Wait(nearPhonograph and 0 or 500)
    end
end)

RegisterNetEvent('rs_phonograph:client:placePropPhonograph')
AddEventHandler('rs_phonograph:client:placePropPhonograph', function()
    local phonographModel = GetHashKey('p_phonograph01x')
    RequestModel(phonographModel)
    while not HasModelLoaded(phonographModel) do Wait(10) end

    local playerPed = PlayerPedId()
    local px, py, pz = table.unpack(GetEntityCoords(playerPed, true))
    local ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.5, 0.0))

    local groundSuccess, groundZ = GetGroundZFor_3dCoord(ox, oy, pz, false)
    if groundSuccess then pz = groundZ end

    local tempObject = CreateObject(phonographModel, ox, oy, pz, true, false, false)
    PlaceObjectOnGroundProperly(tempObject)

    local posX, posY, posZ = table.unpack(GetEntityCoords(tempObject))
    local heading = GetEntityHeading(tempObject)

    local moveStep = 0.05
    local isPlacing = true

    FreezeEntityPosition(tempObject, true)
    SetEntityCollision(tempObject, false, false)
    SetEntityAlpha(tempObject, 200, false)  -- Increased visibility from 150 to 200
    SendNUIMessage({ 
        action = "show",
        translations = Config.ControlTranslations
    })

    lastPlacedPhonograph = {
        entity = tempObject,
        coords = vector3(posX, posY, posZ),
        rotation = vector3(0.0, 0.0, heading)
    }

    CreateThread(function()
        while isPlacing do
            Wait(0)

            for _, keyCode in pairs(Config.Keys) do
                DisableControlAction(0, keyCode, true)
            end

            -- Draw visual gizmo: ground marker circle
            DrawMarker(
                28,  -- Cylinder marker type
                posX, posY, posZ - 0.98,  -- Position slightly below object
                0.0, 0.0, 0.0,  -- Direction
                0.0, 0.0, 0.0,  -- Rotation
                0.8, 0.8, 0.3,  -- Scale (width, width, height)
                255, 200, 0, 150,  -- Color (yellow/gold with transparency)
                false, false, 2, false, nil, nil, false
            )

            -- Draw 3D text above the object showing placement info
            local textZ = posZ + 0.5
            DrawText3D(posX, posY, textZ, "~o~Place Phonograph~s~~n~[ENTER] to confirm")

            local moved = false

            if IsDisabledControlJustPressed(0,Config.Keys.moveForward) then posY = posY + moveStep; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.moveBackward) then posY = posY - moveStep; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.moveLeft) then posX = posX - moveStep; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.moveRight) then posX = posX + moveStep; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.moveUp) then posZ = posZ + moveStep; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.moveDown) then posZ = posZ - moveStep; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.rotateLeftZ) then heading = heading + 5; moved = true end
            if IsDisabledControlJustPressed(0,Config.Keys.rotateRightZ) then heading = heading - 5; moved = true end

            if IsDisabledControlJustPressed(0,Config.Keys.speedPlace) then
                local result = ShowInput({
                    button = Config.Input.Confirm,
                    placeholder = Config.Input.MinMax,
                    header = Config.Input.Speed,
                    title = Config.Input.Change,
                })
                
                if result and result ~= "" then
                    local testint = tonumber(result)
                    if testint and testint ~= 0 then
                        moveStep = math.max(0.01, math.min(testint, 5))
                    end
                end
            end

            if moved then
                SetEntityCoords(tempObject, posX, posY, posZ, true, true, true, false)
                SetEntityHeading(tempObject, heading)
            end

            if IsDisabledControlJustPressed(0,Config.Keys.confirmPlace) then
                
                -- Show confirmation prompt
                local confirmText = "Are you sure you want to place the phonograph here?"
                local confirmed = false
                
                -- Use framework-specific confirmation dialog
                if FrameworkName == 'vorp' then
                    local promptGroup = PromptRegisterBegin()
                    local confirmPrompt = PromptRegisterBegin()
                    PromptSetControlAction(confirmPrompt, 0xC7B5340A) -- ENTER key
                    local str = CreateVarString(10, "LITERAL_STRING", "Press ENTER to confirm placement")
                    PromptSetText(confirmPrompt, str)
                    PromptSetEnabled(confirmPrompt, true)
                    PromptSetVisible(confirmPrompt, true)
                    PromptSetHoldMode(confirmPrompt, true)
                    PromptSetGroup(confirmPrompt, promptGroup)
                    PromptRegisterEnd(confirmPrompt)
                    
                    local cancelPrompt = PromptRegisterBegin()
                    PromptSetControlAction(cancelPrompt, 0x760A9C6F) -- G key
                    local cancelStr = CreateVarString(10, "LITERAL_STRING", "Press G to cancel")
                    PromptSetText(cancelPrompt, cancelStr)
                    PromptSetEnabled(cancelPrompt, true)
                    PromptSetVisible(cancelPrompt, true)
                    PromptSetHoldMode(cancelPrompt, false)
                    PromptSetGroup(cancelPrompt, promptGroup)
                    PromptRegisterEnd(cancelPrompt)
                    
                    -- Wait for confirmation or cancellation
                    local waitingForConfirm = true
                    while waitingForConfirm do
                        Wait(0)
                        if PromptHasHoldModeCompleted(confirmPrompt) then
                            confirmed = true
                            waitingForConfirm = false
                        elseif IsControlJustPressed(0, 0x760A9C6F) then
                            confirmed = false
                            waitingForConfirm = false
                        end
                    end
                    
                    PromptDelete(confirmPrompt)
                    PromptDelete(cancelPrompt)
                else
                    -- For other frameworks, show a simple notification and wait for ENTER or G
                    Notify("Confirmation", "Press ENTER again to confirm or G to cancel", "primary", 3000)
                    
                    local waitingForConfirm = true
                    local startTime = GetGameTimer()
                    while waitingForConfirm and (GetGameTimer() - startTime) < 5000 do
                        Wait(0)
                        DisableControlAction(0, Config.Keys.confirmPlace, true)
                        DisableControlAction(0, Config.Keys.cancelPlace, true)
                        
                        if IsDisabledControlJustPressed(0, Config.Keys.confirmPlace) then
                            confirmed = true
                            waitingForConfirm = false
                        elseif IsDisabledControlJustPressed(0, Config.Keys.cancelPlace) then
                            confirmed = false
                            waitingForConfirm = false
                        end
                    end
                    
                    if waitingForConfirm then
                        confirmed = false -- Timeout
                    end
                end
                
                if confirmed then
                    isPlacing = false
                    SendNUIMessage({ action = "hide" })

                    local pos = GetEntityCoords(tempObject)
                    local rot = vector3(0.0, 0.0, GetEntityHeading(tempObject))

                    DeleteObject(tempObject)
                    lastPlacedPhonograph = nil

                    Wait(1000)

                    TriggerServerEvent('rs_phonograph:server:saveOwner', pos, rot)
                    TriggerServerEvent("rs_phonograph:givePhonograph")

                    Notify(Config.Notify.Phono, Config.Notify.Place, "success", 2000)
                else
                    Notify("Phonograph", "Placement cancelled, adjust position and try again", "error", 2000)
                end
            end

            if IsDisabledControlJustPressed(0,Config.Keys.cancelPlace) then
                isPlacing = false
                SendNUIMessage({ action = "hide" })

                if DoesEntityExist(tempObject) then
                    DeleteObject(tempObject)
                end

                lastPlacedPhonograph = nil

                Notify(Config.Notify.Phono, Config.Notify.Cancel, "error", 2000)
            end
        end
    end)
end)

local currentlyPlaying = {}

local function getSoundName(uniqueId)
    return tostring(uniqueId)
end

RegisterNetEvent('rs_phonograph:client:playMusic')
AddEventHandler('rs_phonograph:client:playMusic', function(uniqueId, coords, url, volume, loop, timeStamp)
    local soundName = getSoundName(uniqueId)
    local effectSoundName = soundName .. "_effect"
    local looped = loop or false

    if currentlyPlaying[uniqueId] then
        if exports.xsound:soundExists(soundName) then
            pcall(function() exports.xsound:Destroy(soundName) end)
        end
        if Config.WithEffect and exports.xsound:soundExists(effectSoundName) then
            pcall(function() exports.xsound:Destroy(effectSoundName) end)
        end
    end

    currentlyPlaying[uniqueId] = {
        url = url,
        volume = volume,
        coords = coords,
        loop = looped,
        timeStamp = timeStamp or 0
    }

    exports.xsound:PlayUrlPos(soundName, url, volume, coords, looped)
    exports.xsound:Distance(soundName, Config.SoundDistance)

    if timeStamp and timeStamp > 0 then
        Citizen.CreateThread(function()
            Citizen.Wait(500)
            if exports.xsound:soundExists(soundName) then
                pcall(function()
                    exports.xsound:setTimeStamp(soundName, timeStamp)
                end)
            end
        end)
    end

    if Config.WithEffect then
        local effectVolume = volume * Config.VolumeEffect
        exports.xsound:PlayUrlPos(effectSoundName, "https://www.youtube.com/watch?v=m5Mz9Tqs9CE", effectVolume, coords, looped)
        exports.xsound:Distance(effectSoundName, Config.SoundDistance)
    end

    if exports.xsound.onPlayEnd then
        exports.xsound:onPlayEnd(soundName, function()
            local data = currentlyPlaying[uniqueId]
            if not data then return end

            if data.loop then
                TriggerServerEvent('rs_phonograph:server:resetLoop', uniqueId)
                currentlyPlaying[uniqueId].timeStamp = 0

                exports.xsound:PlayUrlPos(soundName, data.url, data.volume, data.coords, true)
                exports.xsound:Distance(soundName, Config.SoundDistance)

                if Config.WithEffect then
                    local effectVolume = data.volume * Config.VolumeEffect
                    exports.xsound:PlayUrlPos(effectSoundName, "https://www.youtube.com/watch?v=m5Mz9Tqs9CE", effectVolume, data.coords, true)
                    exports.xsound:Distance(effectSoundName, Config.SoundDistance)
                end

            else
                if Config.WithEffect and exports.xsound:soundExists(effectSoundName) then
                    pcall(function() exports.xsound:Destroy(effectSoundName) end)
                end
                if exports.xsound:soundExists(soundName) then
                    pcall(function() exports.xsound:Destroy(soundName) end)
                end
                currentlyPlaying[uniqueId] = nil
                TriggerServerEvent('rs_phonograph:server:soundEnded', uniqueId)
            end
        end)
    end
end)

RegisterNetEvent('rs_phonograph:client:stopMusic')
AddEventHandler('rs_phonograph:client:stopMusic', function(uniqueId)
    local soundName = getSoundName(uniqueId)
    local effectSoundName = soundName .. "_effect"

    if exports.xsound:soundExists(soundName) then
        pcall(function() exports.xsound:Destroy(soundName) end)
    end

    if Config.WithEffect and exports.xsound:soundExists(effectSoundName) then
        pcall(function() exports.xsound:Destroy(effectSoundName) end)
    end

    currentlyPlaying[uniqueId] = nil
    TriggerServerEvent('rs_phonograph:server:soundEnded', uniqueId)
end)

RegisterNetEvent('rs_phonograph:client:toggleLoop')
AddEventHandler('rs_phonograph:client:toggleLoop', function(uniqueId, state)
    local soundName = getSoundName(uniqueId)
    local effectSoundName = soundName .. "_effect"

    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId].loop = state
    end

    if state then
        if exports.xsound:soundExists(soundName) then
            pcall(function() exports.xsound:setSoundLoop(soundName, true) end)
        else
            local data = currentlyPlaying[uniqueId]
            if data then
                exports.xsound:PlayUrlPos(soundName, data.url, data.volume, data.coords, true)
                exports.xsound:Distance(soundName, Config.SoundDistance)
                if Config.WithEffect then
                    local effectVolume = data.volume * Config.VolumeEffect
                    exports.xsound:PlayUrlPos(effectSoundName, "https://www.youtube.com/watch?v=m5Mz9Tqs9CE", effectVolume, data.coords, true)
                    exports.xsound:Distance(effectSoundName, Config.SoundDistance)
                end
            end
        end

        if Config.WithEffect and exports.xsound:soundExists(effectSoundName) then
            pcall(function() exports.xsound:setSoundLoop(effectSoundName, true) end)
        end
    else
        if exports.xsound:soundExists(soundName) then
            pcall(function() exports.xsound:Destroy(soundName) end)
        end
        if Config.WithEffect and exports.xsound:soundExists(effectSoundName) then
            pcall(function() exports.xsound:Destroy(effectSoundName) end)
        end
    end
end)

RegisterNetEvent('rs_phonograph:client:notifyLoop')
AddEventHandler('rs_phonograph:client:notifyLoop', function(state)
    if state then
        Notify(Config.Notify.Phono, Config.Notify.LoopOnMessage, "success", 3000)
    else
        Notify(Config.Notify.Phono, Config.Notify.LoopOffMessage, "error", 3000)
    end
end)

RegisterNetEvent('rs_phonograph:client:setVolume')
AddEventHandler('rs_phonograph:client:setVolume', function(uniqueId, newVolume)
    local soundName = getSoundName(uniqueId)
    local effectSoundName = soundName .. "_effect"

    if exports.xsound:soundExists(soundName) then
        pcall(function() exports.xsound:setVolume(soundName, newVolume) end)
    end

    if Config.WithEffect and exports.xsound:soundExists(effectSoundName) then
        pcall(function() exports.xsound:setVolume(effectSoundName, newVolume * Config.VolumeEffect) end)
    end

    if currentlyPlaying[uniqueId] then
        currentlyPlaying[uniqueId].volume = newVolume
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for uniqueId, entity in pairs(phonographEntities) do
            if entity and DoesEntityExist(entity) then
                DeleteObject(entity)
            end
        end
        phonographEntities = {}
        phonographData = {}
    end
end)
