# 📡 Events & API Reference - LXR Phonograph

```
    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗     █████╗ ██████╗ ██╗
    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝    ██╔══██╗██╔══██╗██║
    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗    ███████║██████╔╝██║
    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║    ██╔══██║██╔═══╝ ██║
    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║    ██║  ██║██║     ██║
    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝     ╚═╝
```

**🐺 The Land of Wolves - Complete Event & Function Reference**

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Client Events](#client-events)
3. [Server Events](#server-events)
4. [Framework Adapter Functions](#framework-adapter-functions)
5. [Client Functions](#client-functions)
6. [Server Functions](#server-functions)
7. [Event Usage Examples](#event-usage-examples)
8. [Best Practices](#best-practices)

---

## 🎯 Overview

The LXR Phonograph system uses a comprehensive event-driven architecture with a unified Framework Adapter API. This document covers:

- **Client Events**: Events triggered on the client side
- **Server Events**: Events triggered on the server side
- **Framework Functions**: Unified adapter functions that work across all frameworks
- **Custom Functions**: Phonograph-specific utility functions

### Event Naming Convention

All phonograph events use the `rs_phonograph:` prefix (maintained for compatibility):
- `rs_phonograph:client:*` - Client-side events
- `rs_phonograph:server:*` - Server-side events

### Framework Adapter Pattern

Instead of framework-specific code, use the unified adapter:
```lua
-- ✅ Good: Framework-agnostic
Framework.Notify(src, "Title", "Message", "success")

-- ❌ Bad: Framework-specific
if Framework.Name == 'lxrcore' then
    Framework.Core.Functions.Notify(src, "Message", "success")
elseif Framework.Name == 'vorp' then
    -- Different code...
end
```

---

## 📱 Client Events

### Phonograph Management Events

#### `rs_phonograph:client:spawnPhonograph`
Spawns a phonograph object in the game world.

**Parameters**:
```lua
{
    id = number,           -- Unique phonograph ID
    x = float,            -- X coordinate
    y = float,            -- Y coordinate
    z = float,            -- Z coordinate
    heading = float,      -- Rotation heading
    owner = string,       -- Owner identifier
    ownerName = string,   -- Owner display name
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:spawnPhonograph')
AddEventHandler('rs_phonograph:client:spawnPhonograph', function(data)
    -- Spawns phonograph at coordinates
    -- Creates 3D object in world
    -- Adds to client tracking table
end)
```

**Triggered By**: Server when loading phonographs or placing new ones

---

#### `rs_phonograph:client:removePhonograph`
Removes a phonograph object from the game world.

**Parameters**:
```lua
id -- number: Phonograph ID to remove
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:removePhonograph')
AddEventHandler('rs_phonograph:client:removePhonograph', function(id)
    -- Stops any playing music
    -- Deletes 3D object
    -- Removes from tracking table
end)
```

**Triggered By**: Server when phonograph is picked up or deleted

---

#### `rs_phonograph:client:receivePhonographs`
Receives all phonographs from server and spawns them.

**Parameters**:
```lua
phonographs -- table: Array of phonograph data objects
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:receivePhonographs')
AddEventHandler('rs_phonograph:client:receivePhonographs', function(phonographs)
    for _, data in pairs(phonographs) do
        TriggerEvent('rs_phonograph:client:spawnPhonograph', data)
    end
end)
```

**Triggered By**: Server after player loads or requests refresh

---

#### `rs_phonograph:client:placePropPhonograph`
Initiates the phonograph placement mode.

**Parameters**: None

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:placePropPhonograph')
AddEventHandler('rs_phonograph:client:placePropPhonograph', function()
    -- Enters placement mode
    -- Shows ground marker
    -- Displays on-screen instructions
    -- Requires double confirmation
end)
```

**Triggered By**: Server when player uses phonograph item

**Player Controls**:
- **ENTER**: Confirm placement (twice for safety)
- **BACKSPACE**: Cancel placement
- **Arrow Keys**: Rotate phonograph
- **WASD**: Move placement position

---

### Music Control Events

#### `rs_phonograph:client:playMusic`
Plays music on a specific phonograph for the client.

**Parameters**:
```lua
{
    id = number,          -- Phonograph ID
    url = string,         -- YouTube URL or song ID
    volume = float,       -- Volume level (0.0 - 1.0)
    loop = boolean,       -- Loop enabled
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:playMusic')
AddEventHandler('rs_phonograph:client:playMusic', function(data)
    -- Validates phonograph exists
    -- Loads YouTube audio
    -- Plays with 3D positional audio
    -- Applies volume and loop settings
end)
```

**Triggered By**: Server when music is started on a phonograph

**Audio Features**:
- 3D positional audio (distance-based attenuation)
- Volume control (0-100%)
- Loop mode support
- Automatic cleanup on completion

---

#### `rs_phonograph:client:stopMusic`
Stops music playing on a phonograph.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:stopMusic')
AddEventHandler('rs_phonograph:client:stopMusic', function(id)
    -- Stops audio playback
    -- Clears sound handle
    -- Updates phonograph state
end)
```

**Triggered By**: Server when music is stopped

---

#### `rs_phonograph:client:toggleLoop`
Toggles loop mode for a phonograph.

**Parameters**:
```lua
{
    id = number,          -- Phonograph ID
    loop = boolean,       -- New loop state
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:toggleLoop')
AddEventHandler('rs_phonograph:client:toggleLoop', function(data)
    -- Updates loop state
    -- Restarts music if needed
end)
```

**Triggered By**: Server when owner toggles loop

---

#### `rs_phonograph:client:setVolume`
Sets the volume for a phonograph.

**Parameters**:
```lua
{
    id = number,          -- Phonograph ID
    volume = float,       -- Volume (0.0 - 1.0)
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:setVolume')
AddEventHandler('rs_phonograph:client:setVolume', function(data)
    -- Validates volume range
    -- Updates sound handle
    -- Syncs to all nearby players
end)
```

**Triggered By**: Server when owner changes volume

---

#### `rs_phonograph:client:notifyLoop`
Notifies the client about loop state changes.

**Parameters**:
```lua
{
    id = number,          -- Phonograph ID
    loop = boolean,       -- Loop state
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:client:notifyLoop')
AddEventHandler('rs_phonograph:client:notifyLoop', function(data)
    -- Shows notification
    -- Updates UI if open
end)
```

**Triggered By**: Server after loop toggle

---

### Framework Events

#### `LXR:Client:OnPlayerLoaded` / `RSGCore:Client:OnPlayerLoaded`
Framework-specific player loaded events.

**Usage**:
```lua
RegisterNetEvent('LXR:Client:OnPlayerLoaded')
AddEventHandler('LXR:Client:OnPlayerLoaded', function()
    Framework.PlayerLoaded = true
    -- Request phonographs from server
    TriggerServerEvent('rs_phonograph:server:requestPhonographs')
end)
```

**Triggered By**: Framework when player spawns and loads

---

## 🖥️ Server Events

### Phonograph Management Events

#### `rs_phonograph:server:requestPhonographs`
Client requests all phonographs to spawn.

**Parameters**: None

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:requestPhonographs')
AddEventHandler('rs_phonograph:server:requestPhonographs', function()
    local src = source
    -- Queries database
    -- Sends all phonographs to client
    TriggerClientEvent('rs_phonograph:client:receivePhonographs', src, phonographs)
end)
```

**Triggered By**: Client on player load or refresh

---

#### `rs_phonograph:server:saveOwner`
Saves a placed phonograph to the database.

**Parameters**:
```lua
{
    x = float,            -- X coordinate
    y = float,            -- Y coordinate
    z = float,            -- Z coordinate
    heading = float,      -- Rotation
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(data)
    local src = source
    -- Gets player identifiers
    -- Inserts into database
    -- Spawns for all clients
    -- Removes item from inventory
end)
```

**Triggered By**: Client after placement confirmation

**Security**:
- ✅ Validates player owns item
- ✅ Rate limiting (cooldown)
- ✅ Duplicate prevention
- ✅ Distance validation

---

#### `rs_phonograph:server:pickUpByOwner`
Allows owner to pick up their phonograph.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:pickUpByOwner')
AddEventHandler('rs_phonograph:server:pickUpByOwner', function(id)
    local src = source
    -- Validates ownership
    -- Stops music if playing
    -- Deletes from database
    -- Returns item to inventory
    -- Removes for all clients
end)
```

**Triggered By**: Client when owner uses collect prompt

**Security**:
- ✅ Ownership validation
- ✅ Distance check
- ✅ Cooldown protection

---

#### `rs_phonograph:givePhonograph`
Admin command to give phonograph item.

**Parameters**: None

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:givePhonograph')
AddEventHandler('rs_phonograph:givePhonograph', function()
    local src = source
    -- Adds phonograph to inventory
    Framework.AddItem(src, Config.PhonographItem, 1)
    Framework.Notify(src, "Admin", "Phonograph given!", "success")
end)
```

**Triggered By**: Admin command or server script

---

### Music Control Events

#### `rs_phonograph:server:playMusic`
Server authorizes and broadcasts music playback.

**Parameters**:
```lua
{
    id = number,          -- Phonograph ID
    url = string,         -- Music URL
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    -- Validates ownership
    -- Validates URL format
    -- Broadcasts to all clients in range
    TriggerClientEvent('rs_phonograph:client:playMusic', -1, {
        id = data.id,
        url = data.url,
        volume = phonograph.volume,
        loop = phonograph.loop
    })
end)
```

**Triggered By**: Client when owner starts music

**Security**:
- ✅ Ownership validation
- ✅ URL format validation
- ✅ Rate limiting
- ✅ Distance check

---

#### `rs_phonograph:server:stopMusic`
Server authorizes and broadcasts music stop.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:stopMusic')
AddEventHandler('rs_phonograph:server:stopMusic', function(id)
    local src = source
    -- Validates ownership
    -- Broadcasts stop to all clients
    TriggerClientEvent('rs_phonograph:client:stopMusic', -1, id)
end)
```

**Triggered By**: Client when owner stops music

---

#### `rs_phonograph:server:setVolume`
Server authorizes and broadcasts volume change.

**Parameters**:
```lua
{
    id = number,          -- Phonograph ID
    volume = number,      -- Volume (0-100)
}
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:setVolume')
AddEventHandler('rs_phonograph:server:setVolume', function(data)
    local src = source
    -- Validates ownership
    -- Validates volume range (0-100)
    -- Converts to 0.0-1.0 scale
    -- Broadcasts to all clients
end)
```

**Triggered By**: Client when owner adjusts volume

---

#### `rs_phonograph:server:toggleLoop`
Server authorizes and broadcasts loop toggle.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:toggleLoop')
AddEventHandler('rs_phonograph:server:toggleLoop', function(id)
    local src = source
    -- Validates ownership
    -- Toggles loop state
    -- Broadcasts to all clients
end)
```

**Triggered By**: Client when owner toggles loop

---

#### `rs_phonograph:server:soundEnded`
Client reports sound has finished playing.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:soundEnded')
AddEventHandler('rs_phonograph:server:soundEnded', function(id)
    -- Checks if loop is enabled
    -- Restarts music if looping
    -- Otherwise marks as stopped
end)
```

**Triggered By**: Client when audio finishes

---

#### `rs_phonograph:server:resetLoop`
Resets loop state for a phonograph.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:resetLoop')
AddEventHandler('rs_phonograph:server:resetLoop', function(id)
    -- Resets loop to false
    -- Updates database
end)
```

**Triggered By**: System cleanup or admin

---

#### `rs_phonograph:server:syncMusic`
Syncs music state to newly joined players.

**Parameters**:
```lua
id -- number: Phonograph ID
```

**Usage**:
```lua
RegisterNetEvent('rs_phonograph:server:syncMusic')
AddEventHandler('rs_phonograph:server:syncMusic', function(id)
    local src = source
    -- Gets current phonograph state
    -- Sends current music to joining player
end)
```

**Triggered By**: Client when entering range of active phonograph

---

## 🔧 Framework Adapter Functions

### Server-Side Framework Functions

#### `Framework.GetPlayer(src)`
Gets player object from any framework.

**Parameters**:
- `src` (number): Player server ID

**Returns**: Player object or nil

**Usage**:
```lua
local Player = Framework.GetPlayer(src)
if Player then
    print("Player found")
end
```

**Framework Compatibility**: All

---

#### `Framework.GetCharacterIdentifiers(src)`
Gets character identifiers from any framework.

**Parameters**:
- `src` (number): Player server ID

**Returns**:
```lua
{
    identifier = string,      -- Main identifier (citizenid/steam)
    charIdentifier = string,  -- Character-specific ID
}
```

**Usage**:
```lua
local ids = Framework.GetCharacterIdentifiers(src)
if ids then
    print("Citizen ID: " .. ids.identifier)
    print("Char ID: " .. ids.charIdentifier)
end
```

**Framework Compatibility**: All

---

#### `Framework.Notify(src, title, message, type, duration)`
Sends a notification to player (unified across all frameworks).

**Parameters**:
- `src` (number): Player server ID
- `title` (string): Notification title
- `message` (string): Notification message
- `type` (string): Type - 'success', 'error', 'info', 'warning'
- `duration` (number, optional): Duration in ms (default 3000)

**Usage**:
```lua
Framework.Notify(src, "Phonograph", "Music started!", "success", 5000)
```

**Framework Compatibility**: All (adapts to each framework's notification system)

---

#### `Framework.AddItem(src, item, amount)`
Adds item to player inventory.

**Parameters**:
- `src` (number): Player server ID
- `item` (string): Item name
- `amount` (number): Item quantity

**Usage**:
```lua
Framework.AddItem(src, "phonograph", 1)
```

**Framework Compatibility**: All (except standalone)

---

#### `Framework.RemoveItem(src, item, amount)`
Removes item from player inventory.

**Parameters**:
- `src` (number): Player server ID
- `item` (string): Item name
- `amount` (number): Item quantity

**Usage**:
```lua
Framework.RemoveItem(src, "phonograph", 1)
```

**Framework Compatibility**: All (except standalone)

---

#### `Framework.HasItem(src, item, amount)`
Checks if player has item in inventory.

**Parameters**:
- `src` (number): Player server ID
- `item` (string): Item name
- `amount` (number, optional): Required quantity (default 1)

**Returns**: boolean

**Usage**:
```lua
if Framework.HasItem(src, "phonograph", 1) then
    print("Player has phonograph")
end
```

**Framework Compatibility**: All (except standalone)

---

#### `Framework.RegisterUsableItem(item, callback)`
Registers an item as usable.

**Parameters**:
- `item` (string): Item name
- `callback` (function): Function called when item used

**Usage**:
```lua
Framework.RegisterUsableItem(Config.PhonographItem, function(source, itemData)
    TriggerClientEvent('rs_phonograph:client:placePropPhonograph', source)
end)
```

**Framework Compatibility**: All (except standalone)

---

#### `Framework.CloseInventory(src)`
Closes player inventory UI.

**Parameters**:
- `src` (number): Player server ID

**Usage**:
```lua
Framework.CloseInventory(src)
```

**Framework Compatibility**: All (except standalone)

---

### Client-Side Framework Functions

#### `Framework.Notify(title, message, type, duration)`
Shows notification to local player (client-side).

**Parameters**:
- `title` (string): Notification title
- `message` (string): Notification message
- `type` (string): Type - 'success', 'error', 'info', 'warning'
- `duration` (number, optional): Duration in ms (default 3000)

**Usage**:
```lua
Framework.Notify("Phonograph", "Placement mode activated!", "info")
```

**Framework Compatibility**: All

---

#### `Framework.RegisterPlayerLoadedEvent(callback)`
Registers callback for when player loads.

**Parameters**:
- `callback` (function): Function to call when player loads

**Usage**:
```lua
Framework.RegisterPlayerLoadedEvent(function()
    print("Player loaded!")
    TriggerServerEvent('rs_phonograph:server:requestPhonographs')
end)
```

**Framework Compatibility**: All

---

#### `Framework.CreatePrompt(text, key, callback)`
Creates a native prompt (interaction button).

**Parameters**:
- `text` (string): Prompt text
- `key` (number): Key hash (e.g., 0x760A9C6F for [G])
- `callback` (function): Function called when pressed

**Returns**: Prompt handle

**Usage**:
```lua
local prompt = Framework.CreatePrompt("Open Menu", 0x760A9C6F)
```

**Framework Compatibility**: All (uses native prompts)

---

#### `Framework.IsPromptJustPressed(prompt)`
Checks if prompt was just pressed.

**Parameters**:
- `prompt` (number): Prompt handle

**Returns**: boolean

**Usage**:
```lua
if Framework.IsPromptJustPressed(prompt) then
    print("Prompt pressed!")
end
```

**Framework Compatibility**: All

---

## 🎯 Event Usage Examples

### Example 1: Placing a Phonograph

**Flow**: Client → Server → Database → All Clients

```lua
-- CLIENT: Player uses item
RegisterNetEvent('rs_phonograph:client:placePropPhonograph')
AddEventHandler('rs_phonograph:client:placePropPhonograph', function()
    -- Show placement preview
    -- Wait for player confirmation
    -- Get final position and heading
    
    local finalData = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        heading = heading
    }
    
    -- Send to server
    TriggerServerEvent('rs_phonograph:server:saveOwner', finalData)
end)

-- SERVER: Validate and save
RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(data)
    local src = source
    
    -- Validate player has item
    if not Framework.HasItem(src, Config.PhonographItem, 1) then
        Framework.Notify(src, "Error", "You don't have a phonograph!", "error")
        return
    end
    
    -- Get player info
    local ids = Framework.GetCharacterIdentifiers(src)
    
    -- Save to database
    MySQL.Async.execute([[
        INSERT INTO phonographs (x, y, z, heading, characteridentifier, ownername)
        VALUES (@x, @y, @z, @heading, @identifier, @name)
    ]], {
        ['@x'] = data.x,
        ['@y'] = data.y,
        ['@z'] = data.z,
        ['@heading'] = data.heading,
        ['@identifier'] = ids.charIdentifier,
        ['@name'] = GetPlayerName(src)
    }, function(rowsChanged)
        local id = MySQL.Sync.fetchScalar("SELECT LAST_INSERT_ID()")
        
        -- Remove item
        Framework.RemoveItem(src, Config.PhonographItem, 1)
        
        -- Spawn for all clients
        TriggerClientEvent('rs_phonograph:client:spawnPhonograph', -1, {
            id = id,
            x = data.x,
            y = data.y,
            z = data.z,
            heading = data.heading,
            owner = ids.charIdentifier,
            ownerName = GetPlayerName(src)
        })
        
        Framework.Notify(src, "Success", "Phonograph placed!", "success")
    end)
end)
```

---

### Example 2: Playing Music

**Flow**: Client → Server (Validation) → All Clients

```lua
-- CLIENT: Request music playback
function PlayMusicOnPhonograph(id, url)
    TriggerServerEvent('rs_phonograph:server:playMusic', {
        id = id,
        url = url
    })
end

-- SERVER: Validate and broadcast
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    local phonograph = GetPhonographFromDB(data.id)
    
    -- Validate ownership
    local ids = Framework.GetCharacterIdentifiers(src)
    if phonograph.owner ~= ids.charIdentifier then
        Framework.Notify(src, "Error", "Not your phonograph!", "error")
        return
    end
    
    -- Validate URL
    if not ValidateYouTubeURL(data.url) then
        Framework.Notify(src, "Error", "Invalid URL!", "error")
        return
    end
    
    -- Broadcast to all clients
    TriggerClientEvent('rs_phonograph:client:playMusic', -1, {
        id = data.id,
        url = data.url,
        volume = phonograph.volume or 0.5,
        loop = phonograph.loop or false
    })
    
    Framework.Notify(src, "Music", "Now playing!", "success")
end)

-- CLIENT: Play music
RegisterNetEvent('rs_phonograph:client:playMusic')
AddEventHandler('rs_phonograph:client:playMusic', function(data)
    local phonograph = Phonographs[data.id]
    if not phonograph then return end
    
    -- Calculate 3D position
    local soundId = GetSoundId()
    PlayUrlPos(soundId, data.url, data.volume, 
               phonograph.x, phonograph.y, phonograph.z)
    
    phonograph.soundId = soundId
    phonograph.isPlaying = true
end)
```

---

### Example 3: Ownership Validation

```lua
-- SERVER: Validate owner before action
function ValidatePhonographOwner(src, phonographId)
    local phonograph = GetPhonographFromDB(phonographId)
    if not phonograph then
        return false, "Phonograph not found"
    end
    
    local ids = Framework.GetCharacterIdentifiers(src)
    if not ids then
        return false, "Player data not loaded"
    end
    
    if phonograph.owner ~= ids.charIdentifier then
        return false, "Not your phonograph"
    end
    
    return true, phonograph
end

-- Usage
RegisterNetEvent('rs_phonograph:server:stopMusic')
AddEventHandler('rs_phonograph:server:stopMusic', function(id)
    local src = source
    local isOwner, phonographOrError = ValidatePhonographOwner(src, id)
    
    if not isOwner then
        Framework.Notify(src, "Error", phonographOrError, "error")
        return
    end
    
    -- Owner validated, proceed
    TriggerClientEvent('rs_phonograph:client:stopMusic', -1, id)
end)
```

---

## ✅ Best Practices

### 1. Always Use Framework Adapter
```lua
-- ✅ Good: Framework-agnostic
Framework.Notify(src, "Title", "Message", "success")
Framework.AddItem(src, "item", 1)

-- ❌ Bad: Framework-specific
if Framework.Name == 'lxrcore' then
    Framework.Core.Functions.Notify(src, "Message", "success")
end
```

### 2. Validate on Server
```lua
-- ✅ Good: Server validates everything
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    -- Validate ownership
    -- Validate URL
    -- Validate distance
    -- Then broadcast
end)

-- ❌ Bad: Trusting client data
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    -- No validation
    TriggerClientEvent('rs_phonograph:client:playMusic', -1, data)
end)
```

### 3. Handle Nil Values
```lua
-- ✅ Good: Check for nil
local Player = Framework.GetPlayer(src)
if Player then
    -- Safe to use Player
else
    Framework.Notify(src, "Error", "Player data not found", "error")
    return
end

-- ❌ Bad: Assume Player exists
local Player = Framework.GetPlayer(src)
local citizenid = Player.PlayerData.citizenid -- Error if Player is nil!
```

### 4. Use Events for Communication
```lua
-- ✅ Good: Event-driven
TriggerClientEvent('rs_phonograph:client:playMusic', -1, data)

-- ❌ Bad: Direct function calls across sides
-- Cannot call server functions from client directly
```

### 5. Clean Up Resources
```lua
-- ✅ Good: Stop sound when phonograph removed
RegisterNetEvent('rs_phonograph:client:removePhonograph')
AddEventHandler('rs_phonograph:client:removePhonograph', function(id)
    local phonograph = Phonographs[id]
    if phonograph then
        if phonograph.soundId then
            StopSound(phonograph.soundId)
            ReleaseSoundId(phonograph.soundId)
        end
        DeleteObject(phonograph.object)
        Phonographs[id] = nil
    end
end)
```

### 6. Distance Validation
```lua
-- ✅ Good: Check distance on server
local function IsPlayerNearPhonograph(playerCoords, phonographCoords, maxDistance)
    local distance = #(playerCoords - phonographCoords)
    return distance <= maxDistance
end

RegisterNetEvent('rs_phonograph:server:pickUpByOwner')
AddEventHandler('rs_phonograph:server:pickUpByOwner', function(id)
    local src = source
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local phonograph = GetPhonographFromDB(id)
    local phonoCoords = vector3(phonograph.x, phonograph.y, phonograph.z)
    
    if not IsPlayerNearPhonograph(playerCoords, phonoCoords, 5.0) then
        Framework.Notify(src, "Error", "Too far away!", "error")
        return
    end
    
    -- Proceed with pickup
end)
```

### 7. Rate Limiting
```lua
-- ✅ Good: Implement cooldowns
local lastAction = {}

RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    local now = os.time()
    
    if lastAction[src] and (now - lastAction[src]) < Config.ActionCooldown then
        Framework.Notify(src, "Cooldown", "Please wait before trying again", "error")
        return
    end
    
    lastAction[src] = now
    -- Proceed with action
end)
```

---

## 📚 Additional Resources

### Related Documentation
- [Framework Integration Guide](frameworks.md) - Framework-specific details
- [Security Guide](security.md) - Security best practices
- [Configuration Guide](configuration.md) - All config options

### Support
- **Website**: [wolves.land](https://www.wolves.land)
- **Discord**: [Join Us](https://discord.gg/CrKcWdfd3A)
- **GitHub**: [@iBoss21](https://github.com/iBoss21)
- **Store**: [The Lux Empire](https://theluxempire.tebex.io)

---

## 📄 Credits

**Original Script**: riversafe (rs_phonograph V2)  
**Framework Adaptation**: iBoss21 / The Lux Empire  
**For**: The Land of Wolves 🐺 (wolves.land)

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

---

**🐺 მგლების მიწა - რჩეულთა ადგილი! (The Land of Wolves - A Place for the Chosen!)**
