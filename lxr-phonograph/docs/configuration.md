# ⚙️ Configuration Guide - LXR Phonograph

```
     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
```

**🐺 The Land of Wolves - Complete Configuration Reference**

---

## 📋 Table of Contents

1. [Configuration File Location](#configuration-file-location)
2. [Server Branding](#server-branding)
3. [Framework Settings](#framework-settings)
4. [General Phonograph Settings](#general-phonograph-settings)
5. [Controls & Keys](#controls--keys)
6. [Notifications & Messages](#notifications--messages)
7. [Music Settings](#music-settings)
8. [Database Configuration](#database-configuration)
9. [Security Settings](#security-settings)
10. [Performance Settings](#performance-settings)
11. [Debug Settings](#debug-settings)

---

## 📁 Configuration File Location

The main configuration file is located at:
```
lxr-phonograph/config.lua
```

**⚠️ Important Notes:**
- Always backup config.lua before making changes
- Server restart required for most config changes
- Invalid configurations will prevent resource from starting
- Check console for configuration errors

---

## 🏷️ Server Branding

Customize your server information displayed in the phonograph system.

### Config.ServerInfo

```lua
Config.ServerInfo = {
    name = 'The Land of Wolves 🐺',
    tagline = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type = 'Serious Hardcore Roleplay',
    access = 'Discord & Whitelisted',
    
    -- Contact & Links
    website = 'https://www.wolves.land',
    discord = 'https://discord.gg/CrKcWdfd3A',
    github = 'https://github.com/iBoss21',
    store = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    
    -- Developer Info
    developer = 'iBoss21 / The Lux Empire',
    
    -- Tags
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Phonograph', 'Music'}
}
```

**Customization Tips:**
- Update `name` with your server name
- Change `tagline` and `description` to match your theme
- Update all URLs to your server's links
- Keep `developer` to credit original work
- Add relevant tags for your server

---

## 🔧 Framework Settings

Configure which RedM framework to use.

### Config.Framework

```lua
Config.Framework = 'auto'
```

**Available Options:**
- `'auto'` - Automatic detection (recommended)
- `'lxrcore'` - LXR-Core (Primary)
- `'rsg-core'` - RSG-Core (Primary)
- `'qbr-core'` - QBR Core
- `'qr-core'` - QR Core
- `'vorp'` - VORP Core (Legacy)
- `'redemrp'` - RedEM:RP
- `'standalone'` - No framework

**Auto-Detection Priority:**
1. LXRCore
2. RSG-Core
3. QBR Core
4. QR Core
5. VORP Core
6. RedEM:RP
7. Standalone (fallback)

### Config.FrameworkSettings

Advanced framework-specific settings:

```lua
Config.FrameworkSettings = {
    lxrcore = {
        enabled = true,
        resource = 'lxr-core',
        exportName = 'lxr-core',
        playerLoaded = 'LXR:Client:OnPlayerLoaded',
        inventory = 'lxr-inventory',
        notification = 'lxr',
    },
    -- ... (other frameworks)
}
```

**When to Modify:**
- Custom framework resource names
- Modified event names
- Custom inventory systems
- Alternative notification systems

---

## 🎮 General Phonograph Settings

Core phonograph system configuration.

### Item Name

```lua
Config.PhonoItems = "lxr_phonograph"
```

**Must match your database item name.**

### Placement Keys

```lua
Config.Keys = {
    moveForward    = 0x6319DB71, -- Arrow Up
    moveBackward   = 0x05CA7C52, -- Arrow Down
    moveLeft       = 0xA65EBAB4, -- Arrow Left
    moveRight      = 0xDEB34313, -- Arrow Right
    rotateLeftZ    = 0xE6F612E4, -- 1
    rotateRightZ   = 0x1CE6D9EB, -- 2    
    speedPlace     = 0x4F49CC4C, -- 3
    moveUp         = 0xB03A913B, -- 7
    moveDown       = 0x42385422, -- 8
    cancelPlace    = 0x760A9C6F, -- G
    confirmPlace   = 0xC7B5340A, -- ENTER
}
```

**RedM Control Codes:**
Find control codes at: [RedM Controls](https://github.com/femga/rdr3_discoveries/tree/master/Controls)

### Interaction Prompts

```lua
Config.Promp = {
    openUi = 0x760A9C6F,            -- G
    collectPhonograph = 0xE30CD707, -- R
    openmanuUi = "[ G ] - Open Menu",
    Collect = "[ R ] - Collect",
}
```

---

## 🗣️ Notifications & Messages

Customize all player-facing messages.

### Config.Notify

```lua
Config.Notify = {
    Phono = "Phonograph",
    PlaySelect = "The selected song is playing",
    PlayMessage = "The music is playing",
    InvalidUrlMessage = "Invalid URL",
    InvalidSound = "Invalid song data",
    StopMessage = "The music has stopped",
    VolumeUpMessage = "Volume increased to %d%%",
    MaxVolumeMessage = "Volume is already at maximum.",
    VolumeDownMessage = "Volume decreased to %d%%",
    MinVolumeMessage = "Volume is already at minimum.",
    UnregisteredMessage = "The phonograph is not registered!",
    NoPhonographMessage = "No valid phonograph in front of you",
    Already = "You already have a phonograph placed!",
    Place = "Phonograph placed!",
    Cancel = "Placement canceled.",
    TooFar = "Too far to collect the phonograph",
    Custom = "Custom songs are disabled",
    LoopOnMessage = "Loop enabled.",
    LoopOffMessage = "Loop disabled.",
    Picked = "You have collected your phonograph",
    Dont = "This phonograph does not belong to you",
    ConfirmPlacement = "Press ENTER again to confirm or G to cancel",
    PlacementTimeout = "Placement timed out - please try again",
    PlacementCancelled = "Placement cancelled, adjust position and try again",
}
```

**Localization:**
- Translate messages to your server's language
- Keep variable placeholders like `%d` intact
- Test all messages in-game after changes

### Control Translations

```lua
Config.ControlTranslations = {
    Title   = "Controls",
    Move    = "[← ↑ ↓ →] - Move object",
    Rotate  = "[1/2]     - Rotate object",
    Height  = "[7/8]     - Raise/Lower",
    Confirm = "[ENTER]   - Confirm position",
    Cancel  = "[G]       - Cancel placement",
    Speed   = "[3]       - Adjust speed",
    PlacementText = "~o~Place Phonograph~s~~n~[ENTER] to confirm",
    VorpConfirm = "Press ENTER to confirm placement",
    VorpCancel = "Press G to cancel"
}
```

### Music UI Translations

```lua
Config.MusicTranslations = {
    Volume   = "📯 Volume",
    AudioURL = "◎ Audio URL",
    SwitchToList = "Song List",
    SelectSong = "🎵 Select a song",
    SwitchToUrl = "URL Song"
}
```

---

## 🎵 Music Settings

Control how music playback works.

### Audio Configuration

```lua
Config.SoundDistance = 10      -- Maximum audible distance for the music
Config.WithEffect = false      -- Set to true for sound effects
Config.VolumeEffect = 0.3      -- Effect volume (0.0 - 1.0)
```

**Distance Guidelines:**
- `5` - Indoor/small building
- `10` - Standard outdoor (default)
- `15` - Large area
- `20` - Very large area (performance impact)

### Custom Songs

```lua
Config.AllowCustomSongs = true  -- Allow players to enter YouTube URLs
```

**When to disable:**
- Immersion/roleplay servers
- To control content
- To prevent abuse

### Song List

```lua
Config.AllowListSongs = true    -- Show pre-configured song list
```

**Song List Configuration:**
```lua
Config.SongList = {
    { label = "Song Name", url = "https://youtube.com/..." },
    -- Add more songs here
}
```

**Adding Songs:**
1. Find period-appropriate music on YouTube
2. Copy video URL
3. Add to Config.SongList with descriptive label
4. Test in-game

**Recommended Song Types:**
- Classical music (1800s era)
- Traditional folk songs
- Period-appropriate instrumental
- Native American music
- Western themes

### Placement Settings

```lua
Config.PlacementConfirmTimeout = 5000  -- Confirmation timeout (ms)
```

---

## 🗄️ Database Configuration

Database table names (advanced users only).

```lua
Config.DatabaseTables = {
    phonographs = 'phonographs',
    items = 'items'
}
```

**⚠️ Warning:**
Only change if you have custom database structure.
Requires SQL modifications.

---

## 🔒 Security Settings

Protect against abuse and exploits.

### Config.Security

```lua
Config.Security = {
    -- Maximum distance player can be from phonograph to interact
    maxInteractionDistance = 2.5,
    
    -- Validate player ownership before actions
    validateOwnership = true,
    
    -- Maximum phonographs per player/character
    maxPhonographsPerPlayer = 1,
    
    -- Enable anti-spam protection
    antiSpam = true,
    
    -- Cooldown between placement attempts (seconds)
    placementCooldown = 5,
    
    -- URL validation for custom songs
    validateUrls = true,
    allowedDomains = {'youtube.com', 'youtu.be', 'soundcloud.com'}
}
```

**Security Recommendations:**
- Keep `validateOwnership = true` always
- Adjust `maxPhonographsPerPlayer` based on server size
- Enable `antiSpam` to prevent abuse
- Set reasonable `placementCooldown` (3-10 seconds)
- Limit `allowedDomains` to trusted sources

**Adding Allowed Domains:**
```lua
allowedDomains = {
    'youtube.com',
    'youtu.be',
    'soundcloud.com',
    'spotify.com',  -- Add more as needed
}
```

---

## ⚡ Performance Settings

Optimize for your server's needs.

### Config.Performance

```lua
Config.Performance = {
    -- Update interval for phonograph checks (ms)
    checkInterval = 1000,
    
    -- Maximum rendering distance for phonograph entities
    maxRenderDistance = 50.0,
    
    -- Cache phonograph data
    cacheEnabled = true,
    cacheDuration = 300, -- 5 minutes
    
    -- Optimize database queries
    batchDatabaseUpdates = true,
}
```

**Performance Tuning:**

**High-Population Servers:**
```lua
checkInterval = 1500,       -- Reduce checks
maxRenderDistance = 40.0,   -- Reduce render distance
cacheEnabled = true,        -- Enable caching
```

**Low-Population Servers:**
```lua
checkInterval = 500,        -- More frequent checks
maxRenderDistance = 75.0,   -- Larger render distance
cacheEnabled = false,       -- Fresh data always
```

**Performance vs Quality:**
- Lower `checkInterval` = More responsive, higher CPU usage
- Higher `maxRenderDistance` = More visible, more memory usage
- `cacheEnabled` = Faster, but delayed updates

---

## 🐛 Debug Settings

Enable debugging for troubleshooting.

### Config.Debug

```lua
Config.Debug = {
    enabled = false,
    logLevel = 'info', -- 'debug', 'info', 'warn', 'error'
    logToConsole = true,
    logToFile = false,
}
```

**Log Levels:**
- `'debug'` - Everything (very verbose)
- `'info'` - General information
- `'warn'` - Warnings only
- `'error'` - Errors only

**When to Enable:**
- Troubleshooting issues
- Testing new configurations
- Investigating bugs
- Development work

**Remember:**
- Disable debug mode in production
- Debug mode impacts performance
- Check console for debug output

---

## 💾 Example Configurations

### Strict Roleplay Server

```lua
Config.AllowCustomSongs = false
Config.AllowListSongs = true
Config.Security = {
    maxPhonographsPerPlayer = 1,
    validateOwnership = true,
    antiSpam = true,
    placementCooldown = 10,
    validateUrls = true,
}
```

### Casual/Creative Server

```lua
Config.AllowCustomSongs = true
Config.AllowListSongs = true
Config.Security = {
    maxPhonographsPerPlayer = 5,
    validateOwnership = true,
    antiSpam = false,
    placementCooldown = 2,
    validateUrls = false,
}
```

### High-Performance Server

```lua
Config.Performance = {
    checkInterval = 2000,
    maxRenderDistance = 30.0,
    cacheEnabled = true,
    cacheDuration = 600,
}
```

---

## 🔄 Applying Configuration Changes

After modifying config.lua:

1. **Save the file**
2. **Restart the resource:**
   ```
   restart lxr-phonograph
   ```
   Or full server restart for major changes

3. **Verify in console:**
   Look for the configuration loaded message

4. **Test in-game:**
   Confirm changes work as expected

---

## ⚠️ Common Configuration Mistakes

### Syntax Errors

**❌ Wrong:**
```lua
Config.SoundDistance = 10,  -- Extra comma at end of table
}
```

**✅ Correct:**
```lua
Config.SoundDistance = 10
}
```

### Invalid Key Codes

**❌ Wrong:**
```lua
Config.Keys = {
    confirmPlace = "ENTER"  -- String instead of hex code
}
```

**✅ Correct:**
```lua
Config.Keys = {
    confirmPlace = 0xC7B5340A  -- Proper hex code
}
```

### Missing Quotes

**❌ Wrong:**
```lua
Config.PhonoItems = lxr_phonograph
```

**✅ Correct:**
```lua
Config.PhonoItems = "lxr_phonograph"
```

---

## 📞 Configuration Support

If you need help with configuration:

1. **Check Syntax**: Use a Lua validator
2. **Review Console**: Look for error messages
3. **Test Changes**: One setting at a time
4. **Ask Community**: Discord support available

**Discord**: [discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A)

---

**🐺 The Land of Wolves - Where History Lives**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
