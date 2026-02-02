# 🔒 Security Guide - LXR Phonograph

```
    ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
    ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
    ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
    ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
    ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
    ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   
```

**🐺 The Land of Wolves - Security Features & Best Practices**

---

## 📋 Table of Contents

1. [Security Overview](#security-overview)
2. [Server Authority Model](#server-authority-model)
3. [Validation Systems](#validation-systems)
4. [Anti-Exploit Measures](#anti-exploit-measures)
5. [Rate Limiting & Cooldowns](#rate-limiting--cooldowns)
6. [Ownership Validation](#ownership-validation)
7. [Input Validation](#input-validation)
8. [Database Security](#database-security)
9. [Common Vulnerabilities Prevented](#common-vulnerabilities-prevented)
10. [Security Best Practices](#security-best-practices)
11. [Security Checklist](#security-checklist)

---

## 🎯 Security Overview

The LXR Phonograph system implements **multiple layers of security** to prevent exploits, cheating, and abuse. Every action is validated on the server side with proper authorization checks.

### Core Security Principles

1. **Server Authority**: All critical decisions made server-side
2. **Input Validation**: All client data validated before processing
3. **Ownership Verification**: Strict owner-only controls
4. **Rate Limiting**: Prevents spam and DoS attacks
5. **Distance Validation**: Ensures players are within range
6. **SQL Injection Protection**: Parameterized queries only
7. **Resource Name Protection**: Prevents unauthorized rebranding

### Security Layers

```
┌─────────────────────────────────────┐
│     Client Request (Untrusted)      │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 1: Server Event Validation  │  ← Event exists and properly triggered
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 2: Player Authentication    │  ← Valid player, loaded character
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 3: Rate Limiting            │  ← Cooldowns, spam prevention
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 4: Input Validation         │  ← Data format, range, type checks
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 5: Authorization            │  ← Ownership, permissions, distance
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 6: Business Logic           │  ← Safe execution of action
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│   Layer 7: Database Transaction     │  ← Atomic, parameterized queries
└──────────────┬──────────────────────┘
               ↓
         [Success/Failure]
```

---

## 🏛️ Server Authority Model

### What is Server Authority?

**Server authority** means the server makes all final decisions. Clients can request actions, but the server validates and executes them.

### Implementation

```lua
-- ❌ BAD: Client-side authority (exploitable)
RegisterNetEvent('phonograph:client:giveMoney')
AddEventHandler('phonograph:client:giveMoney', function(amount)
    -- Client can trigger this with any amount!
    Framework.AddMoney(PlayerId(), amount)
end)

-- ✅ GOOD: Server-side authority (secure)
RegisterNetEvent('phonograph:server:earnMoney')
AddEventHandler('phonograph:server:earnMoney', function()
    local src = source
    local amount = CalculateReward() -- Server decides amount
    
    if ValidatePlayer(src) then
        Framework.AddMoney(src, amount)
    end
end)
```

### Critical Server-Only Operations

The following operations are **NEVER** performed client-side:

1. ✅ Database modifications
2. ✅ Inventory changes (add/remove items)
3. ✅ Ownership assignment
4. ✅ Permission checks
5. ✅ Money transactions
6. ✅ State modifications (music playing, volume, etc.)

### Client Role

Clients are responsible for:
- 📱 Rendering (3D objects, UI)
- 🎵 Audio playback (after server authorization)
- 🎮 Input capture (sending requests to server)
- 🖼️ Visual effects

Clients **CANNOT**:
- ❌ Modify database
- ❌ Change ownership
- ❌ Give/remove items
- ❌ Bypass permissions
- ❌ Manipulate other players' phonographs

---

## ✅ Validation Systems

### 1. Player Validation

Every server event starts with player validation:

```lua
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    
    -- Validate source exists
    if not src or src == 0 then
        print("[Security] Invalid source")
        return
    end
    
    -- Validate player is connected
    if GetPlayerPing(src) <= 0 then
        print("[Security] Player not connected")
        return
    end
    
    -- Validate player data loaded
    local Player = Framework.GetPlayer(src)
    if not Player then
        Framework.Notify(src, "Error", "Player data not loaded", "error")
        return
    end
    
    -- Validate character identifiers
    local ids = Framework.GetCharacterIdentifiers(src)
    if not ids or not ids.charIdentifier then
        Framework.Notify(src, "Error", "Character data invalid", "error")
        return
    end
    
    -- Now safe to proceed
    -- ...
end)
```

### 2. Data Type Validation

```lua
-- Validate data types before using
function ValidatePhonographData(data)
    if type(data) ~= "table" then
        return false, "Data must be a table"
    end
    
    if type(data.id) ~= "number" then
        return false, "ID must be a number"
    end
    
    if type(data.x) ~= "number" or type(data.y) ~= "number" or type(data.z) ~= "number" then
        return false, "Coordinates must be numbers"
    end
    
    if type(data.heading) ~= "number" then
        return false, "Heading must be a number"
    end
    
    return true, nil
end

RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(data)
    local src = source
    
    local isValid, error = ValidatePhonographData(data)
    if not isValid then
        print(string.format("[Security] Invalid data from %s: %s", src, error))
        return
    end
    
    -- Safe to use data
end)
```

### 3. Range Validation

```lua
-- Validate numeric ranges
function ValidateVolume(volume)
    if type(volume) ~= "number" then
        return false, "Volume must be a number"
    end
    
    if volume < 0 or volume > 100 then
        return false, "Volume must be between 0 and 100"
    end
    
    return true, nil
end

RegisterNetEvent('rs_phonograph:server:setVolume')
AddEventHandler('rs_phonograph:server:setVolume', function(data)
    local src = source
    
    local isValid, error = ValidateVolume(data.volume)
    if not isValid then
        Framework.Notify(src, "Error", error, "error")
        return
    end
    
    -- Volume is valid, proceed
end)
```

### 4. Distance Validation

```lua
-- Validate player is near phonograph
function ValidateDistance(playerPos, phonographPos, maxDistance)
    local distance = #(playerPos - phonographPos)
    return distance <= maxDistance
end

RegisterNetEvent('rs_phonograph:server:pickUpByOwner')
AddEventHandler('rs_phonograph:server:pickUpByOwner', function(id)
    local src = source
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    
    local phonograph = GetPhonographFromDB(id)
    if not phonograph then
        return
    end
    
    local phonoCoords = vector3(phonograph.x, phonograph.y, phonograph.z)
    
    if not ValidateDistance(playerCoords, phonoCoords, Config.InteractionDistance) then
        print(string.format("[Security] Player %s too far from phonograph %s", src, id))
        Framework.Notify(src, "Error", "Too far away!", "error")
        return
    end
    
    -- Distance validated, proceed
end)
```

---

## 🛡️ Anti-Exploit Measures

### 1. Duplicate Placement Prevention

```lua
-- Prevent placing multiple phonographs rapidly
local placementCooldowns = {}

RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(data)
    local src = source
    local now = os.time()
    
    -- Check cooldown
    if placementCooldowns[src] and (now - placementCooldowns[src]) < Config.PlacementCooldown then
        Framework.Notify(src, "Cooldown", "Wait before placing another phonograph", "error")
        return
    end
    
    -- Validate player has item
    if not Framework.HasItem(src, Config.PhonographItem, 1) then
        print(string.format("[Security] Player %s attempted placement without item", src))
        return
    end
    
    placementCooldowns[src] = now
    -- Proceed with placement
end)
```

### 2. Ownership Bypass Prevention

```lua
-- Strict ownership validation for all operations
function ValidateOwnership(src, phonographId)
    local phonograph = GetPhonographFromDB(phonographId)
    if not phonograph then
        return false, "Phonograph not found"
    end
    
    local ids = Framework.GetCharacterIdentifiers(src)
    if not ids then
        return false, "Player data not loaded"
    end
    
    if phonograph.owner ~= ids.charIdentifier then
        print(string.format("[Security] Player %s (%s) attempted to control phonograph %s owned by %s",
            src, ids.charIdentifier, phonographId, phonograph.owner))
        return false, "Not your phonograph"
    end
    
    return true, phonograph
end

-- Use for every owner-only action
RegisterNetEvent('rs_phonograph:server:stopMusic')
AddEventHandler('rs_phonograph:server:stopMusic', function(id)
    local src = source
    local isOwner, phonographOrError = ValidateOwnership(src, id)
    
    if not isOwner then
        Framework.Notify(src, "Error", phonographOrError, "error")
        return
    end
    
    -- Owner validated, safe to proceed
end)
```

### 3. URL Injection Prevention

```lua
-- Validate YouTube URLs to prevent injection
function ValidateYouTubeURL(url)
    if type(url) ~= "string" then
        return false, "URL must be a string"
    end
    
    -- Maximum URL length
    if #url > Config.MaxURLLength then
        return false, "URL too long"
    end
    
    -- Check for allowed URL patterns
    local patterns = {
        "^https://www%.youtube%.com/watch%?v=",
        "^https://youtu%.be/",
        "^https://www%.youtube%.com/embed/",
    }
    
    local isValid = false
    for _, pattern in ipairs(patterns) do
        if string.match(url, pattern) then
            isValid = true
            break
        end
    end
    
    if not isValid then
        return false, "Invalid YouTube URL format"
    end
    
    -- Check for dangerous characters
    local dangerous = {"<", ">", "javascript:", "onerror=", "onclick="}
    for _, char in ipairs(dangerous) do
        if string.find(url:lower(), char, 1, true) then
            return false, "URL contains invalid characters"
        end
    end
    
    return true, nil
end

RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    
    if Config.AllowCustomURLs then
        local isValid, error = ValidateYouTubeURL(data.url)
        if not isValid then
            print(string.format("[Security] Invalid URL from %s: %s", src, error))
            Framework.Notify(src, "Error", error, "error")
            return
        end
    end
    
    -- URL validated, proceed
end)
```

### 4. Item Duplication Prevention

```lua
-- Ensure item is removed atomically with placement
RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(data)
    local src = source
    
    -- Check item FIRST
    if not Framework.HasItem(src, Config.PhonographItem, 1) then
        print(string.format("[Security] Player %s attempted placement without item", src))
        return
    end
    
    -- Remove item BEFORE database insert
    Framework.RemoveItem(src, Config.PhonographItem, 1)
    
    -- Then insert into database
    MySQL.Async.execute([[
        INSERT INTO phonographs (x, y, z, heading, characteridentifier, ownername)
        VALUES (@x, @y, @z, @heading, @identifier, @name)
    ]], {
        -- ...
    }, function(rowsChanged)
        if rowsChanged == 0 then
            -- Database insert failed, give item back
            Framework.AddItem(src, Config.PhonographItem, 1)
            Framework.Notify(src, "Error", "Failed to place phonograph", "error")
        end
    end)
end)
```

### 5. Music Spam Prevention

```lua
-- Prevent rapid music changes
local musicChangeCooldowns = {}

RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    local now = os.time()
    local cooldownKey = string.format("%s_%s", src, data.id)
    
    -- Check cooldown
    if musicChangeCooldowns[cooldownKey] and 
       (now - musicChangeCooldowns[cooldownKey]) < Config.MusicChangeCooldown then
        Framework.Notify(src, "Cooldown", "Wait before changing music", "error")
        return
    end
    
    musicChangeCooldowns[cooldownKey] = now
    -- Proceed with music change
end)
```

---

## ⏱️ Rate Limiting & Cooldowns

### Configuration

```lua
-- config.lua
Config.RateLimiting = {
    -- Placement cooldown (seconds)
    PlacementCooldown = 5,
    
    -- Pickup cooldown (seconds)
    PickupCooldown = 3,
    
    -- Music change cooldown (seconds)
    MusicChangeCooldown = 2,
    
    -- Volume change cooldown (seconds)
    VolumeChangeCooldown = 1,
    
    -- Maximum actions per minute
    MaxActionsPerMinute = 30,
}
```

### Implementation

```lua
-- Rate limiter class
local RateLimiter = {}
RateLimiter.__index = RateLimiter

function RateLimiter:new(maxActions, windowSeconds)
    local obj = {
        maxActions = maxActions,
        windowSeconds = windowSeconds,
        actions = {}
    }
    setmetatable(obj, self)
    return obj
end

function RateLimiter:checkLimit(identifier)
    local now = os.time()
    local windowStart = now - self.windowSeconds
    
    -- Clean old entries
    if self.actions[identifier] then
        local filtered = {}
        for _, timestamp in ipairs(self.actions[identifier]) do
            if timestamp > windowStart then
                table.insert(filtered, timestamp)
            end
        end
        self.actions[identifier] = filtered
    else
        self.actions[identifier] = {}
    end
    
    -- Check limit
    if #self.actions[identifier] >= self.maxActions then
        return false
    end
    
    -- Add new action
    table.insert(self.actions[identifier], now)
    return true
end

-- Create rate limiter instance
local phonographLimiter = RateLimiter:new(30, 60) -- 30 actions per minute

-- Use in event handlers
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    
    -- Check rate limit
    if not phonographLimiter:checkLimit(src) then
        print(string.format("[Security] Rate limit exceeded for player %s", src))
        Framework.Notify(src, "Rate Limit", "Too many actions, please slow down", "error")
        DropPlayer(src, "Rate limit exceeded")
        return
    end
    
    -- Proceed with action
end)
```

### Cooldown Cleanup

```lua
-- Clean expired cooldowns periodically
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Every minute
        
        local now = os.time()
        
        -- Clean placement cooldowns
        for player, timestamp in pairs(placementCooldowns) do
            if (now - timestamp) > 300 then -- 5 minutes
                placementCooldowns[player] = nil
            end
        end
        
        -- Clean music change cooldowns
        for key, timestamp in pairs(musicChangeCooldowns) do
            if (now - timestamp) > 300 then
                musicChangeCooldowns[key] = nil
            end
        end
    end
end)
```

---

## 👤 Ownership Validation

### Ownership Check Function

```lua
-- Comprehensive ownership validation
function ValidatePhonographOwnership(src, phonographId, requireDistance)
    requireDistance = requireDistance or true
    
    -- Get phonograph from database
    local phonograph = MySQL.Sync.fetchAll([[
        SELECT * FROM phonographs WHERE id = @id LIMIT 1
    ]], {
        ['@id'] = phonographId
    })
    
    if not phonograph or #phonograph == 0 then
        return false, "Phonograph not found"
    end
    
    phonograph = phonograph[1]
    
    -- Get player identifiers
    local ids = Framework.GetCharacterIdentifiers(src)
    if not ids or not ids.charIdentifier then
        return false, "Player data not loaded"
    end
    
    -- Check ownership
    if phonograph.characteridentifier ~= ids.charIdentifier then
        print(string.format("[Security] Ownership violation: Player %s (%s) tried to access phonograph %s owned by %s",
            src, ids.charIdentifier, phonographId, phonograph.characteridentifier))
        return false, "Not your phonograph"
    end
    
    -- Check distance if required
    if requireDistance then
        local playerPed = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(playerPed)
        local phonoCoords = vector3(phonograph.x, phonograph.y, phonograph.z)
        local distance = #(playerCoords - phonoCoords)
        
        if distance > Config.InteractionDistance then
            return false, "Too far away"
        end
    end
    
    return true, phonograph
end
```

### Usage in Events

```lua
-- Example 1: Music control (distance not required)
RegisterNetEvent('rs_phonograph:server:playMusic')
AddEventHandler('rs_phonograph:server:playMusic', function(data)
    local src = source
    local isOwner, phonograph = ValidatePhonographOwnership(src, data.id, false)
    
    if not isOwner then
        Framework.Notify(src, "Error", phonograph, "error") -- phonograph contains error msg
        return
    end
    
    -- Owner validated, proceed
end)

-- Example 2: Pickup (distance required)
RegisterNetEvent('rs_phonograph:server:pickUpByOwner')
AddEventHandler('rs_phonograph:server:pickUpByOwner', function(id)
    local src = source
    local isOwner, phonograph = ValidatePhonographOwnership(src, id, true)
    
    if not isOwner then
        Framework.Notify(src, "Error", phonograph, "error")
        return
    end
    
    -- Owner validated and nearby, proceed with pickup
end)
```

### Admin Override

```lua
-- Admin can bypass ownership for moderation
function IsAdmin(src)
    -- Check if player has admin permissions
    -- Implementation depends on your permission system
    return IsPlayerAceAllowed(src, "phonograph.admin")
end

function ValidatePhonographOwnershipOrAdmin(src, phonographId)
    if IsAdmin(src) then
        local phonograph = GetPhonographFromDB(phonographId)
        if phonograph then
            return true, phonograph, true -- true = admin override
        else
            return false, "Phonograph not found"
        end
    end
    
    return ValidatePhonographOwnership(src, phonographId)
end
```

---

## 🔍 Input Validation

### String Validation

```lua
-- Validate string inputs
function ValidateString(input, minLength, maxLength, pattern)
    if type(input) ~= "string" then
        return false, "Input must be a string"
    end
    
    if #input < minLength then
        return false, string.format("Input too short (minimum %d characters)", minLength)
    end
    
    if #input > maxLength then
        return false, string.format("Input too long (maximum %d characters)", maxLength)
    end
    
    if pattern and not string.match(input, pattern) then
        return false, "Input format invalid"
    end
    
    return true, nil
end

-- Example usage
local isValid, error = ValidateString(url, 10, 500, "^https://")
if not isValid then
    Framework.Notify(src, "Error", error, "error")
    return
end
```

### Coordinate Validation

```lua
-- Validate coordinates are reasonable
function ValidateCoordinates(x, y, z)
    if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
        return false, "Coordinates must be numbers"
    end
    
    -- RedM map bounds (approximate)
    if x < -5000 or x > 5000 then
        return false, "X coordinate out of bounds"
    end
    
    if y < -5000 or y > 5000 then
        return false, "Y coordinate out of bounds"
    end
    
    if z < -100 or z > 1000 then
        return false, "Z coordinate out of bounds"
    end
    
    return true, nil
end

RegisterNetEvent('rs_phonograph:server:saveOwner')
AddEventHandler('rs_phonograph:server:saveOwner', function(data)
    local src = source
    
    local isValid, error = ValidateCoordinates(data.x, data.y, data.z)
    if not isValid then
        print(string.format("[Security] Invalid coordinates from %s: %s", src, error))
        return
    end
    
    -- Coordinates validated
end)
```

### Sanitization

```lua
-- Sanitize text inputs
function SanitizeText(text)
    if type(text) ~= "string" then
        return ""
    end
    
    -- Remove control characters
    text = string.gsub(text, "%c", "")
    
    -- Remove HTML tags
    text = string.gsub(text, "<[^>]+>", "")
    
    -- Trim whitespace
    text = string.gsub(text, "^%s+", "")
    text = string.gsub(text, "%s+$", "")
    
    return text
end
```

---

## 🗄️ Database Security

### SQL Injection Prevention

```lua
-- ❌ BAD: SQL injection vulnerability
MySQL.Async.execute(string.format([[
    DELETE FROM phonographs WHERE id = %s
]], id)) -- If id = "1 OR 1=1", deletes all phonographs!

-- ✅ GOOD: Parameterized query
MySQL.Async.execute([[
    DELETE FROM phonographs WHERE id = @id
]], {
    ['@id'] = id
})
```

### Atomic Transactions

```lua
-- Ensure database operations are atomic
RegisterNetEvent('rs_phonograph:server:pickUpByOwner')
AddEventHandler('rs_phonograph:server:pickUpByOwner', function(id)
    local src = source
    
    -- Validate ownership first
    local isOwner, phonograph = ValidatePhonographOwnership(src, id, true)
    if not isOwner then
        return
    end
    
    -- Delete from database
    MySQL.Async.execute([[
        DELETE FROM phonographs WHERE id = @id
    ]], {
        ['@id'] = id
    }, function(rowsChanged)
        if rowsChanged > 0 then
            -- Only give item if database delete succeeded
            Framework.AddItem(src, Config.PhonographItem, 1)
            TriggerClientEvent('rs_phonograph:client:removePhonograph', -1, id)
            Framework.Notify(src, "Success", "Phonograph collected!", "success")
        else
            Framework.Notify(src, "Error", "Failed to collect phonograph", "error")
        end
    end)
end)
```

### Input Escaping

```lua
-- Always use parameterized queries
local safeQuery = [[
    INSERT INTO phonographs (ownername, characteridentifier, x, y, z)
    VALUES (@name, @identifier, @x, @y, @z)
]]

MySQL.Async.execute(safeQuery, {
    ['@name'] = GetPlayerName(src), -- Automatically escaped
    ['@identifier'] = identifier,
    ['@x'] = coords.x,
    ['@y'] = coords.y,
    ['@z'] = coords.z
})
```

---

## 🚫 Common Vulnerabilities Prevented

### 1. ✅ Item Duplication
**Prevention**: Item removed before database insert, atomic transactions

### 2. ✅ Ownership Bypass
**Prevention**: Server-side ownership validation on every action

### 3. ✅ SQL Injection
**Prevention**: Parameterized queries only, no string concatenation

### 4. ✅ Coordinate Spoofing
**Prevention**: Server validates coordinates within map bounds

### 5. ✅ Distance Exploits
**Prevention**: Server calculates distance, client cannot manipulate

### 6. ✅ URL Injection
**Prevention**: Strict URL validation, whitelist patterns only

### 7. ✅ Rate Limiting Bypass
**Prevention**: Server-side cooldowns and rate limiters

### 8. ✅ XSS in Chat/UI
**Prevention**: Input sanitization, HTML tag removal

### 9. ✅ Resource Exhaustion
**Prevention**: Maximum limits, cleanup routines, memory management

### 10. ✅ Event Spoofing
**Prevention**: Server validates all event parameters

---

## ✅ Security Best Practices

### For Developers

1. **Never Trust Client Data**
   ```lua
   -- Always validate everything from the client
   if not ValidateInput(data) then return end
   ```

2. **Server-Side Validation Always**
   ```lua
   -- Even if client validates, server must validate again
   ```

3. **Use Framework Adapter**
   ```lua
   -- Framework functions have built-in security
   Framework.AddItem(src, item, amount)
   ```

4. **Implement Rate Limiting**
   ```lua
   -- Prevent spam and DoS attacks
   if not CheckCooldown(src) then return end
   ```

5. **Log Security Events**
   ```lua
   -- Log suspicious activity
   print(string.format("[Security] Suspicious activity from %s", src))
   ```

6. **Use Parameterized Queries**
   ```lua
   -- Never concatenate SQL strings
   MySQL.Async.execute("DELETE FROM table WHERE id = @id", {['@id'] = id})
   ```

7. **Validate Ownership**
   ```lua
   -- Always check ownership before modifications
   if not IsOwner(src, id) then return end
   ```

8. **Distance Checks**
   ```lua
   -- Ensure player is near object
   if Distance > MaxDistance then return end
   ```

9. **Clean Up Resources**
   ```lua
   -- Prevent memory leaks and resource exhaustion
   DeleteObject(obj)
   ReleaseSoundId(soundId)
   ```

10. **Keep Secrets Server-Side**
    ```lua
    -- Never send sensitive data to client
    -- API keys, admin lists, etc. stay on server
    ```

### For Server Owners

1. **Keep Resources Updated**
   - Update to latest versions for security patches

2. **Monitor Logs**
   - Check for `[Security]` messages in console
   - Investigate suspicious patterns

3. **Configure Cooldowns**
   - Adjust `Config.RateLimiting` values
   - Higher values for public servers

4. **Database Backups**
   - Regular automated backups
   - Test restore procedures

5. **Use ACE Permissions**
   ```cfg
   # Server.cfg
   add_ace group.admin phonograph.admin allow
   ```

6. **Restrict Custom URLs**
   ```lua
   -- Disable if concerned about abuse
   Config.AllowCustomURLs = false
   ```

7. **Enable Debug Mode for Testing**
   ```lua
   -- Only on development/test servers
   Config.Debug = true
   ```

8. **Monitor Resource Usage**
   - Check server performance
   - Adjust `Config.MaxPhonographs` if needed

---

## 📋 Security Checklist

### Pre-Deployment

- [ ] All config values reviewed and set appropriately
- [ ] Debug mode disabled (`Config.Debug = false`)
- [ ] Rate limiting configured for your player count
- [ ] Custom URLs disabled if not needed
- [ ] Database credentials secured
- [ ] ACE permissions configured
- [ ] Resource name is `lxr-phonograph` (protection active)

### Post-Deployment

- [ ] Monitor console for security warnings
- [ ] Check database for unusual entries
- [ ] Test ownership validation
- [ ] Verify rate limiting works
- [ ] Confirm distance checks active
- [ ] Test admin commands if applicable

### Regular Maintenance

- [ ] Review security logs weekly
- [ ] Update resource when new versions available
- [ ] Backup database regularly
- [ ] Check for unusual player behavior
- [ ] Monitor resource usage (CPU/RAM)

---

## 📚 Additional Resources

### Related Documentation
- [Events & API Reference](events.md) - All events and validation examples
- [Framework Integration](frameworks.md) - Framework-specific security
- [Configuration Guide](configuration.md) - Security settings

### Support
- **Website**: [wolves.land](https://www.wolves.land)
- **Discord**: [Join Us](https://discord.gg/CrKcWdfd3A)
- **GitHub**: [@iBoss21](https://github.com/iBoss21)
- **Store**: [The Lux Empire](https://theluxempire.tebex.io)

---

## 📄 Credits

**Original Script**: riversafe (rs_phonograph V2)  
**Framework Adaptation & Security**: iBoss21 / The Lux Empire  
**For**: The Land of Wolves 🐺 (wolves.land)

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

---

**🐺 მგლების მიწა - რჩეულთა ადგილი! (The Land of Wolves - A Place for the Chosen!)**
