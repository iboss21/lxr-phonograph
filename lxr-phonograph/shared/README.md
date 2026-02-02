# 🐺 Shared Scripts - LXR Phonograph

```
    ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗ 
    ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗
    ███████╗███████║███████║██████╔╝█████╗  ██║  ██║
    ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██║  ██║
    ███████║██║  ██║██║  ██║██║  ██║███████╗██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ 
```

**🐺 The Land of Wolves - Shared Components**

---

## 📋 Purpose

This directory contains shared scripts that run on **both client and server** sides. These files provide foundational functionality that both sides of the resource need access to.

---

## 📁 Files in this Directory

### `framework.lua` - Framework Adapter Layer

**Purpose**: Universal abstraction layer for all supported RedM frameworks

**What it does**:
- Detects which framework is running (LXR-Core, RSG-Core, VORP, etc.)
- Provides unified functions for all framework operations
- Abstracts away framework-specific implementations
- Ensures consistent behavior across all frameworks

**Key Features**:
- Auto-detection with priority-based selection
- Clean API for framework operations
- Both client and server side functions
- Fallback to standalone mode if no framework detected

**Functions Provided**:

**Shared:**
- `Framework.Detect()` - Detect which framework is running
- `Framework.Initialize()` - Initialize framework connection

**Server-Side:**
- `Framework.GetPlayer(src)` - Get player object
- `Framework.GetCharacterIdentifiers(src)` - Get player identifiers
- `Framework.Notify(src, title, message, type, duration)` - Send notification
- `Framework.AddItem(src, item, amount)` - Add item to inventory
- `Framework.RemoveItem(src, item, amount)` - Remove item from inventory
- `Framework.HasItem(src, item, amount)` - Check if player has item
- `Framework.RegisterUsableItem(item, callback)` - Register item usage
- `Framework.CloseInventory(src)` - Close player inventory

**Client-Side:**
- `Framework.RegisterPlayerLoadedEvent(callback)` - Register player loaded event
- `Framework.Notify(title, message, type, duration)` - Show notification
- `Framework.CreatePrompt(text, key, callback)` - Create native prompt
- `Framework.IsPromptJustPressed(prompt)` - Check if prompt was pressed

---

## 🔧 Technical Details

### Load Order

Shared scripts are loaded:
1. Before client scripts
2. Before server scripts
3. In the order specified in fxmanifest.lua

### Current Load Order:
```lua
shared_scripts {
    'config.lua',           -- Configuration first
    'shared/framework.lua'  -- Framework adapter second
}
```

### Scope

Scripts in this directory have access to:
- ✅ Config table
- ✅ Native functions (Citizen, Wait, etc.)
- ✅ Framework detection functions
- ✅ Both client and server environments (with checks)

Scripts here should **NOT**:
- ❌ Contain client-only code without `IsDuplicityVersion()` checks
- ❌ Contain server-only code without `IsDuplicityVersion()` checks
- ❌ Access player-specific data directly
- ❌ Perform database operations

---

## 🎯 Why Use Shared Scripts?

### Benefits:

**Code Reuse**
- Write once, use on both sides
- Reduces duplication
- Easier maintenance

**Consistency**
- Same logic on client and server
- Prevents desync issues
- Uniform behavior

**Framework Abstraction**
- Single place to handle framework differences
- Easy to add new framework support
- Clean core logic

### Example:

Instead of this in every file:
```lua
-- ❌ Bad: Repeated in multiple files
if FrameworkName == 'lxrcore' then
    Core.Functions.Notify(src, message, 'primary', 3000)
elseif FrameworkName == 'rsg-core' then
    Core.Functions.Notify(src, message, 'primary', 3000)
elseif FrameworkName == 'vorp' then
    Core.NotifyLeft(src, title, message, 'generic_textures', 'tick', 3000, 'COLOR_WHITE')
end
```

Use this:
```lua
-- ✅ Good: Clean and simple
Framework.Notify(src, title, message, 'success', 3000)
```

---

## 📚 Usage Examples

### Detecting Framework

```lua
-- In any shared script
local framework = Framework.Detect()
print('Running on: ' .. framework)
-- Output: "Running on: lxrcore"
```

### Server-Side Example

```lua
-- In server.lua
RegisterNetEvent('myscript:giveReward')
AddEventHandler('myscript:giveReward', function()
    local src = source
    
    -- Get player using framework adapter
    local Character = Framework.GetCharacterIdentifiers(src)
    if not Character then return end
    
    -- Add item using framework adapter
    Framework.AddItem(src, 'lxr_phonograph', 1)
    
    -- Notify player using framework adapter
    Framework.Notify(src, 'Phonograph', 'You received a phonograph!', 'success', 3000)
end)
```

### Client-Side Example

```lua
-- In client.lua
Citizen.CreateThread(function()
    -- Register player loaded event
    Framework.RegisterPlayerLoadedEvent(function()
        print('Player has loaded!')
        
        -- Show notification using framework adapter
        Framework.Notify('Phonograph', 'Welcome! You can now use phonographs.', 'info', 5000)
    end)
end)
```

---

## 🔍 Framework Support

The framework adapter supports:

| Framework | Status | Priority |
|-----------|--------|----------|
| **LXR-Core** | ✅ Primary | 1 |
| **RSG-Core** | ✅ Primary | 2 |
| **QBR Core** | ✅ Full Support | 3 |
| **QR Core** | ✅ Full Support | 4 |
| **VORP** | ✅ Legacy Support | 5 |
| **RedEM:RP** | ✅ Supported | 6 |
| **Standalone** | ✅ Fallback | 7 |

---

## 🔒 Security Considerations

**Server-Side Functions**
- Always validate player source
- Check ownership before operations
- Validate item names and amounts
- Log suspicious activity

**Client-Side Functions**
- Never trust client input
- Validate on server
- Use server callbacks for sensitive operations

**Framework Adapter Security**
- Validates framework exists before operations
- Handles missing frameworks gracefully
- Prevents nil reference errors
- Safe fallbacks for all operations

---

## 📖 Documentation

For detailed documentation on the framework adapter:
- [Framework Guide](../docs/frameworks.md)
- [Events & API](../docs/events.md)
- [Security Guide](../docs/security.md)

---

## 🛠️ Extending the Framework Adapter

To add support for a new framework:

1. **Add Framework Detection**
   ```lua
   elseif GetResourceState('newframework') == 'started' then
       Framework.Name = 'newframework'
   ```

2. **Add Framework Initialization**
   ```lua
   elseif Framework.Name == 'newframework' then
       Framework.Core = exports['newframework']:GetCore()
   ```

3. **Implement Framework Functions**
   ```lua
   elseif Framework.Name == 'newframework' then
       -- Add implementation for GetPlayer, Notify, etc.
   ```

4. **Add to FrameworkSettings in config.lua**
   ```lua
   newframework = {
       enabled = true,
       resource = 'newframework',
       -- ... other settings
   }
   ```

5. **Test thoroughly!**

---

## 🐛 Troubleshooting

### Framework Not Detected

**Symptom**: Falls back to standalone mode
```lua
Framework Detected: standalone
```

**Causes**:
- Framework resource not started
- Framework started after phonograph
- Wrong resource name in config

**Solutions**:
- Verify framework is started: `ensure frameworkname` in server.cfg
- Check load order: framework before phonograph
- Check `Config.FrameworkSettings[frameworkname].resource` matches

### Function Not Working

**Symptom**: Errors when calling Framework functions

**Causes**:
- Framework not initialized
- Using wrong side (client vs server)
- Framework Core object is nil

**Solutions**:
- Check `Framework.IsReady` is true
- Use `IsDuplicityVersion()` checks
- Verify framework initialization in console

### Notifications Not Showing

**Symptom**: `Framework.Notify()` does nothing

**Causes**:
- Framework notification system not available
- Wrong notification type
- Framework not properly initialized

**Solutions**:
- Check framework supports notifications
- Use valid notification types: 'success', 'error', 'info'
- Enable debug mode in config

---

## 📞 Support

Need help with shared scripts?

**Discord**: [discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A)  
**GitHub**: [github.com/iboss21/lxr-phonograph](https://github.com/iboss21/lxr-phonograph)  
**Documentation**: [Full Docs](../docs/overview.md)

---

**🐺 The Land of Wolves - Where History Lives**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
