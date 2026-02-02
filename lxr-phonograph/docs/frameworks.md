# 🔧 Framework Integration Guide - LXR Phonograph

```
    ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗
    ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝
    █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗
    ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║
    ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║
    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
```

**🐺 The Land of Wolves - Multi-Framework Adapter System**

---

## 📋 Table of Contents

1. [Framework Adapter Overview](#framework-adapter-overview)
2. [Supported Frameworks](#supported-frameworks)
3. [Auto-Detection System](#auto-detection-system)
4. [Framework-Specific Features](#framework-specific-features)
5. [LXR-Core Integration](#lxr-core-integration)
6. [RSG-Core Integration](#rsg-core-integration)
7. [VORP Core Integration](#vorp-core-integration)
8. [QBR-Core Integration](#qbr-core-integration)
9. [QR-Core Integration](#qr-core-integration)
10. [RedEM:RP Integration](#redemrp-integration)
11. [Standalone Mode](#standalone-mode)
12. [Configuration](#configuration)
13. [Troubleshooting](#troubleshooting)

---

## 🎯 Framework Adapter Overview

The LXR Phonograph system features a sophisticated **Framework Adapter Layer** that provides a unified abstraction for all supported RedM frameworks. This design ensures:

- **Zero Code Changes**: Core game logic remains clean and framework-agnostic
- **True Multi-Framework Support**: Not just a wrapper, but deep integration
- **Automatic Detection**: Detects and initializes the correct framework automatically
- **Graceful Fallback**: Standalone mode if no framework is detected
- **Performance Optimized**: Minimal overhead, no unnecessary framework checks

### Architecture Benefits

```lua
-- ✅ Clean, unified API across all frameworks
Framework.Notify(src, "Phonograph", "Music started!", "success")
Framework.AddItem(src, "phonograph", 1)
Framework.GetPlayer(src)

-- ❌ No messy framework-specific code in main logic
```

The adapter handles all framework differences internally, allowing developers to write code once that works everywhere.

---

## 🎮 Supported Frameworks

LXR Phonograph supports **7 different frameworks** with full feature parity:

| Framework | Status | Priority | Features |
|-----------|--------|----------|----------|
| **LXR-Core** | ✅ Fully Supported | Primary | All features, inventory, notifications |
| **RSG-Core** | ✅ Fully Supported | Primary | All features, inventory, notifications |
| **VORP Core** | ✅ Fully Supported | Legacy | All features, custom notifications |
| **QBR-Core** | ✅ Fully Supported | Secondary | All features, inventory, notifications |
| **QR-Core** | ✅ Fully Supported | Secondary | All features, inventory, notifications |
| **RedEM:RP** | ✅ Fully Supported | Legacy | All features, custom integration |
| **Standalone** | ✅ Fully Supported | Fallback | Core features, native notifications |

### Feature Matrix

| Feature | LXR/RSG/QBR/QR | VORP | RedEM:RP | Standalone |
|---------|----------------|------|----------|------------|
| Player Management | ✅ | ✅ | ✅ | ✅ |
| Inventory System | ✅ | ✅ | ✅ | ➖ |
| Notifications | ✅ | ✅ | ✅ | ✅ (Native) |
| Item Usage | ✅ | ✅ | ✅ | ➖ |
| Character IDs | ✅ | ✅ | ✅ | ✅ (Steam) |
| Player Loading | ✅ | ✅ | ✅ | ✅ (Auto) |

---

## 🔍 Auto-Detection System

### How Auto-Detection Works

The framework adapter uses a **priority-based detection system** that checks for active framework resources:

```lua
function Framework.Detect()
    if Config.Framework ~= 'auto' then
        Framework.Name = Config.Framework
    else
        -- Priority order:
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
```

### Detection Priority

1. **LXR-Core** (First priority - native integration)
2. **RSG-Core** (Second priority - close compatibility)
3. **QBR-Core** (Third priority - QB-based)
4. **QR-Core** (Fourth priority - QB-based)
5. **VORP Core** (Fifth priority - legacy support)
6. **RedEM:RP** (Sixth priority - legacy support)
7. **Standalone** (Last resort - no framework detected)

### Console Output

When the system starts, you'll see:

```
[LXR-Phonograph] Framework Detected: lxrcore
[LXR-Phonograph] Framework Adapter: Ready
```

---

## 🛠️ Framework-Specific Features

### Notification System Differences

Each framework has unique notification systems. The adapter unifies them:

#### LXR-Core / RSG-Core
```lua
-- Uses built-in notification system
Framework.Core.Functions.Notify(src, message, type, duration)
```

#### VORP Core
```lua
-- Uses NotifyLeft with custom icons and colors
Framework.Core.NotifyLeft(src, title, message, texture, icon, duration, color)
```

#### RedEM:RP
```lua
-- Uses custom event system
TriggerClientEvent('redem_roleplay:Notify', src, message, type, duration)
```

#### Standalone
```lua
-- Uses native RedM notifications
Citizen.InvokeNative(0xF1A4817D, 1, str, str2, duration)
```

### Inventory System Differences

#### QB-Based Frameworks (LXR/RSG/QBR/QR)
```lua
-- Standard QB inventory API
Player.Functions.AddItem(item, amount)
Player.Functions.RemoveItem(item, amount)
Player.Functions.GetItemByName(item)
```

#### VORP Core
```lua
-- Uses export-based inventory
exports.vorp_inventory:addItem(src, item, amount)
exports.vorp_inventory:subItem(src, item, amount)
exports.vorp_inventory:getItem(src, item)
```

#### RedEM:RP
```lua
-- Direct player object methods
Player.addItem(item, amount)
Player.removeItem(item, amount)
Player.getInventoryItem(item)
```

---

## 🎯 LXR-Core Integration

### Overview
**LXR-Core** is the primary framework for The Land of Wolves server. Full native integration with all features.

### Configuration
```lua
Config.Framework = 'lxrcore' -- or 'auto'
```

### Core Object Access
```lua
Framework.Core = exports['lxr-core']:GetCoreObject()
```

### Player Loading Event
```lua
RegisterNetEvent('LXR:Client:OnPlayerLoaded', function()
    Framework.PlayerLoaded = true
end)
```

### Features
- ✅ Full inventory integration
- ✅ Character system (citizenid)
- ✅ Built-in notifications
- ✅ Item usage callbacks
- ✅ Player data persistence

### Example Usage
```lua
-- Server-side
local Player = Framework.GetPlayer(src)
if Player then
    local citizenid = Player.PlayerData.citizenid
    Framework.Notify(src, "Phonograph", "Welcome!", "success")
end
```

### Troubleshooting
- **Issue**: Framework not detected
  - **Solution**: Ensure `lxr-core` is started before `lxr-phonograph`
  - **Check**: `ensure lxr-core` in server.cfg before phonograph

- **Issue**: Notifications not working
  - **Solution**: Verify LXR-Core version compatibility
  - **Check**: Test with `/notify` command if available

---

## 🔷 RSG-Core Integration

### Overview
**RSG-Core** is a QB-based framework with excellent RedM support. Fully compatible with all features.

### Configuration
```lua
Config.Framework = 'rsg-core' -- or 'auto'
```

### Core Object Access
```lua
Framework.Core = exports['rsg-core']:GetCoreObject()
```

### Player Loading Event
```lua
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    Framework.PlayerLoaded = true
end)
```

### Features
- ✅ QB-style inventory system
- ✅ Character management (citizenid)
- ✅ Built-in notification system
- ✅ Item registration
- ✅ Player functions

### Example Usage
```lua
-- Add phonograph to inventory
local Player = Framework.Core.Functions.GetPlayer(src)
if Player then
    Player.Functions.AddItem('phonograph', 1)
    Framework.Notify(src, "Item", "Phonograph added!", "success")
end
```

### Troubleshooting
- **Issue**: Items not appearing in inventory
  - **Solution**: Add phonograph item to `rsg-core/shared/items.lua`
  - **Example**:
    ```lua
    ['phonograph'] = {
        name = 'phonograph',
        label = 'Phonograph',
        weight = 5000,
        type = 'item',
        image = 'phonograph.png',
        unique = false,
        useable = true,
        shouldClose = true,
        description = 'A musical phonograph'
    }
    ```

---

## 🌀 VORP Core Integration

### Overview
**VORP Core** is a legacy framework with extensive RedM heritage. Full support with custom adaptations.

### Configuration
```lua
Config.Framework = 'vorp' -- or 'auto'
```

### Core Object Access
```lua
Framework.Core = exports.vorp_core:GetCore()
```

### Player Loading Event
```lua
RegisterNetEvent("vorp:SelectedCharacter", function()
    Framework.PlayerLoaded = true
end)
```

### Features
- ✅ Custom inventory system
- ✅ Character system (identifier + charIdentifier)
- ✅ NotifyLeft notifications with icons
- ✅ Export-based API
- ✅ Item registration

### Character Identification
```lua
-- VORP uses dual identifiers
local User = Framework.Core.getUser(src)
if User then
    local Character = User.getUsedCharacter
    local identifier = Character.identifier -- Steam/License ID
    local charIdentifier = Character.charIdentifier -- Character ID
end
```

### Notification System
```lua
-- VORP uses custom NotifyLeft with colors and icons
Framework.Core.NotifyLeft(
    src,
    "Phonograph",           -- title
    "Music started!",       -- message
    "generic_textures",     -- texture
    "tick",                 -- icon
    3000,                   -- duration
    "COLOR_GREEN"           -- color
)
```

### Example Usage
```lua
-- Check inventory capacity
local canCarry = exports.vorp_inventory:canCarryItem(src, 'phonograph', 1)
if canCarry then
    exports.vorp_inventory:addItem(src, 'phonograph', 1)
else
    Framework.Notify(src, "Inventory", "Cannot carry more!", "error")
end
```

### Troubleshooting
- **Issue**: VORP inventory errors
  - **Solution**: Ensure `vorp_inventory` is started
  - **Check**: Add item to VORP item database

- **Issue**: Notifications not showing
  - **Solution**: VORP uses different notification types
  - **Check**: Verify `vorp:TipRight` event is working

---

## 🔶 QBR-Core Integration

### Overview
**QBR-Core** (QBCore for RedM) is a popular QB port. Full compatibility with inventory and player systems.

### Configuration
```lua
Config.Framework = 'qbr-core' -- or 'auto'
```

### Core Object Access
```lua
Framework.Core = exports['qbr-core']:GetCoreObject()
```

### Player Loading Event
```lua
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Framework.PlayerLoaded = true
end)
```

### Features
- ✅ QB-style inventory
- ✅ citizenid system
- ✅ Event-based notifications
- ✅ Standard QB functions
- ✅ Item callbacks

### Example Usage
```lua
-- Standard QB pattern
local Player = Framework.Core.Functions.GetPlayer(src)
if Player then
    local hasItem = Player.Functions.GetItemByName('phonograph')
    if hasItem then
        print("Player has phonograph")
    end
end
```

### Troubleshooting
- **Issue**: Events not firing
  - **Solution**: Use `QBCore:Notify` instead of direct notify
  - **Example**: `TriggerClientEvent('QBCore:Notify', src, message, type)`

---

## 🔸 QR-Core Integration

### Overview
**QR-Core** is another QB variant for RedM. Similar to QBR with slight differences.

### Configuration
```lua
Config.Framework = 'qr-core' -- or 'auto'
```

### Core Object Access
```lua
Framework.Core = exports['qr-core']:GetCoreObject()
```

### Player Loading Event
```lua
RegisterNetEvent('QR:Client:OnPlayerLoaded', function()
    Framework.PlayerLoaded = true
end)
```

### Features
- ✅ QB-compatible inventory
- ✅ Character system
- ✅ Notification events
- ✅ Player functions
- ✅ Item registration

### Troubleshooting
Similar to QBR-Core troubleshooting steps.

---

## 🏛️ RedEM:RP Integration

### Overview
**RedEM:RP** is a legacy roleplay framework. Custom integration with player and inventory systems.

### Configuration
```lua
Config.Framework = 'redemrp' -- or 'auto'
```

### Core Object Access
```lua
Framework.Core = exports.redem_roleplay:GetCoreObject()
```

### Player Loading Event
```lua
RegisterNetEvent('RedEM:PlayerLoaded', function()
    Framework.PlayerLoaded = true
end)
```

### Features
- ✅ Custom player object
- ✅ Character ID system
- ✅ Event-based notifications
- ✅ Item management
- ✅ Identifier system

### Player Management
```lua
local Player = Framework.Core.GetPlayer(src)
if Player then
    local identifier = Player.getIdentifier()
    local charid = Player.getSessionVar("charid")
end
```

### Troubleshooting
- **Issue**: Player data not loading
  - **Solution**: Ensure RedEM:RP character system is loaded
  - **Check**: Wait for `RedEM:PlayerLoaded` event

---

## ⚙️ Standalone Mode

### Overview
**Standalone mode** runs without any framework. Uses native RedM functions and Steam identifiers.

### When Used
- No framework detected
- Testing environment
- Minimal setup required
- Quick deployment

### Features
- ✅ Steam-based identification
- ✅ Native notifications
- ✅ Basic player management
- ⚠️ No inventory system
- ⚠️ No item usage callbacks

### Identification
```lua
-- Uses Steam ID as identifier
local identifiers = GetPlayerIdentifiers(src)
local identifier = nil
for _, id in pairs(identifiers) do
    if string.find(id, "steam:") then
        identifier = id
        break
    end
end
```

### Notifications
```lua
-- Native RedM notification system
local str = CreateVarString(10, 'LITERAL_STRING', message)
local str2 = CreateVarString(10, 'LITERAL_STRING', title)
Citizen.InvokeNative(0xF1A4817D, 1, str, str2, duration)
```

### Limitations
- No inventory integration (phonograph must be given manually)
- No item usage callbacks
- Basic player identification only
- Chat-based notifications as fallback

### Troubleshooting
- **Issue**: Phonographs not saving
  - **Solution**: Check database identifiers match Steam IDs
  - **Check**: Verify `characteridentifier` in database

---

## ⚙️ Configuration

### config.lua Settings

```lua
-- ═══════════════════════════════════════════════════════════════════════════════
-- FRAMEWORK CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════════

Config.Framework = 'auto' -- Options: 'auto', 'lxrcore', 'rsg-core', 'qbr-core', 
                          --          'qr-core', 'vorp', 'redemrp', 'standalone'
```

### Automatic Detection (Recommended)
```lua
Config.Framework = 'auto'
```
- System detects framework automatically
- Priority-based selection
- Fallback to standalone
- No configuration needed

### Manual Selection
```lua
Config.Framework = 'lxrcore'
```
- Forces specific framework
- Useful for testing
- Overrides auto-detection
- Must match installed framework

### Framework-Specific Settings

Some frameworks may require additional configuration in their own config files:

#### For VORP:
```lua
-- Add to items.lua or database
['phonograph'] = {
    label = 'Phonograph',
    limit = 1,
    can_remove = true,
    weight = 5.0
}
```

#### For RedEM:RP:
```lua
-- Configure in RedEM item system
RegisterServerEvent("redemrp:AddItem")
```

---

## 🔧 Troubleshooting

### General Issues

#### ❌ Framework Not Detected
**Symptoms**: Console shows "Framework Detected: standalone" when you have a framework

**Solutions**:
1. Check framework resource name matches expected name
2. Ensure framework starts before phonograph
3. Verify framework is actually running: `/status` in server console
4. Check `ensure` order in server.cfg:
   ```cfg
   ensure lxr-core
   ensure lxr-phonograph
   ```

#### ❌ Player Data Not Loading
**Symptoms**: Phonographs don't save, ownership not working

**Solutions**:
1. Wait for player loaded event
2. Check character selection is complete
3. Verify database connection
4. Ensure identifiers are being captured correctly

#### ❌ Notifications Not Working
**Symptoms**: No messages appear when using phonograph

**Solutions**:
1. Check framework notification system is working
2. Test with basic framework command
3. Verify notification events are registered
4. Check for conflicting notification scripts

#### ❌ Inventory Issues
**Symptoms**: Cannot give/remove phonographs

**Solutions**:
1. Add phonograph item to framework item list
2. Check inventory resource is started
3. Verify item weight and limits
4. Ensure player has inventory space

### Framework-Specific Issues

#### LXR-Core / RSG-Core
```
Error: attempt to index a nil value (field 'Functions')
```
**Solution**: Framework not initialized yet, add `Citizen.Wait(1000)` or use proper events

#### VORP Core
```
Error: vorp_inventory not found
```
**Solution**: Start VORP inventory before phonograph:
```cfg
ensure vorp_inventory
ensure lxr-phonograph
```

#### RedEM:RP
```
Error: Player object nil
```
**Solution**: Wait for character to fully load:
```lua
RegisterNetEvent('RedEM:PlayerLoaded', function()
    Citizen.Wait(2000) -- Extra delay for RedEM
end)
```

### Debug Mode

Enable debug mode in config.lua:
```lua
Config.Debug = true
```

This will print detailed framework detection and operation logs:
```
[LXR-Phonograph] [DEBUG] Framework detection started
[LXR-Phonograph] [DEBUG] Checking for lxr-core: started
[LXR-Phonograph] [DEBUG] Framework selected: lxrcore
[LXR-Phonograph] [DEBUG] Core object initialized: table: 0x...
[LXR-Phonograph] [DEBUG] Framework adapter ready
```

### Testing Framework Detection

Run this command on server console to verify detection:
```lua
print(Framework.Name)
print(Framework.IsReady)
```

### Common Error Messages

| Error | Cause | Solution |
|-------|-------|----------|
| `Framework.Core is nil` | Framework not loaded | Check start order |
| `attempt to call nil value` | Function not available | Check framework version |
| `Player not found` | Player data not ready | Add wait or event check |
| `Item not found in inventory` | Item not registered | Add to framework items |

---

## 📚 Additional Resources

### Documentation Files
- [Installation Guide](installation.md) - Complete setup instructions
- [Configuration Guide](configuration.md) - All config options
- [Events Reference](events.md) - All events and functions
- [Security Guide](security.md) - Security features

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
