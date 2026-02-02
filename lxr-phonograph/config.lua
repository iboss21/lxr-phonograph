--[[
    ██╗      █████╗ ███╗   ██╗██████╗      ██████╗ ███████╗    ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗
    ██║     ██╔══██╗████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝
    ██║     ███████║██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗
    ██║     ██╔══██║██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║
    ███████╗██║  ██║██║ ╚████║██████╔╝    ╚██████╔╝██║         ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝          ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝
                                                                                                                    
    🎵 LXR Phonograph System - Configuration
    
    This configuration file controls all aspects of the phonograph music system.
    Players can place phonographs, play music from URLs or song lists, and enjoy synchronized audio.
    
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
    
    Version: 2.0.0
    Performance Target: Optimized for minimal server overhead and client FPS impact
    
    Tags: RedM, Georgian, SeriousRP, Whitelist, Phonograph, Music, Audio, Entertainment
    
    Framework Support:
    - LXRCore (Primary)
    - RSG Core (Primary)
    - VORP Core (Legacy)
    - RedEM:RP
    - QBR Core
    - QR Core
    - Standalone
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    
    Original Script: riversafe (rs_phonograph V2)
    Framework Adaptation: iBoss21 / The Lux Empire for The Land of Wolves
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🐺 RESOURCE NAME PROTECTION - RUNTIME CHECK
-- ═══════════════════════════════════════════════════════════════════════════════
-- Additional safeguard: Verify resource name at config load time
-- This prevents the script from functioning if renamed
-- ═══════════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-phonograph"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
        
        ═══════════════════════════════════════════════════════════════════════════════
        ❌ CRITICAL ERROR: RESOURCE NAME MISMATCH ❌
        ═══════════════════════════════════════════════════════════════════════════════
        
        Expected: %s
        Got: %s
        
        This resource is branded and must maintain the correct name.
        Rename the folder to "%s" to continue.
        
        🐺 wolves.land - The Land of Wolves
        
        ═══════════════════════════════════════════════════════════════════════════════
        
    ]], REQUIRED_RESOURCE_NAME, currentResourceName, REQUIRED_RESOURCE_NAME))
end

Config = {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SERVER BRANDING & INFO ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

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
    tags = {'RedM', 'Georgian', 'SeriousRP', 'Whitelist', 'Phonograph', 'Music', 'Audio', 'Entertainment'}
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK CONFIGURATION ███████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

--[[
    Framework Priority (in order):
    1. LXRCore (Primary) - https://github.com/lxrcore - The Land of Wolves
    2. RSG-Core (Primary) - https://github.com/Rexshack-RedM
    3. QBR Core - QB-Core for RedM
    4. QR Core - QR Core Framework
    5. VORP Core (Legacy Support)
    6. RedEM:RP (Legacy Support)
    7. Standalone (No Framework)
    
    The script will auto-detect which framework is running.
    Set Config.Framework to override auto-detection.
]]

Config.Framework = 'auto' -- Options: 'auto', 'lxrcore', 'rsg-core', 'qbr-core', 'qr-core', 'vorp', 'redemrp', 'standalone'

-- Framework-specific resource names and triggers
Config.FrameworkSettings = {
    lxrcore = {
        enabled = true,
        resource = 'lxr-core',
        exportName = 'lxr-core',
        getSharedObject = 'lxr-core:getSharedObject',
        playerLoaded = 'LXR:Client:OnPlayerLoaded',
        playerUnloaded = 'LXR:Client:OnPlayerUnload',
        jobUpdate = 'LXR:Client:OnJobUpdate',
        notification = 'lxr', -- 'lxr', 'vorp', 'native'
        inventory = 'lxr-inventory',
        inputResource = 'lxr-input',
    },
    ['rsg-core'] = {
        enabled = true,
        resource = 'rsg-core',
        exportName = 'rsg-core',
        getSharedObject = 'rsg-core:getSharedObject',
        playerLoaded = 'RSGCore:Client:OnPlayerLoaded',
        playerUnloaded = 'RSGCore:Client:OnPlayerUnload',
        jobUpdate = 'RSGCore:Client:OnJobUpdate',
        notification = 'rsg',
        inventory = 'rsg-inventory',
        inputResource = 'rsg-input',
    },
    ['qbr-core'] = {
        enabled = true,
        resource = 'qbr-core',
        exportName = 'qbr-core',
        getSharedObject = 'qbr-core:getSharedObject',
        playerLoaded = 'QBCore:Client:OnPlayerLoaded',
        playerUnloaded = 'QBCore:Client:OnPlayerUnload',
        jobUpdate = 'QBCore:Client:OnJobUpdate',
        notification = 'qb',
        inventory = 'qbr-inventory',
        inputResource = 'qb-input',
    },
    ['qr-core'] = {
        enabled = true,
        resource = 'qr-core',
        exportName = 'qr-core',
        getSharedObject = 'qr-core:getSharedObject',
        playerLoaded = 'QR:Client:OnPlayerLoaded',
        playerUnloaded = 'QR:Client:OnPlayerUnload',
        jobUpdate = 'QR:Client:OnJobUpdate',
        notification = 'qr',
        inventory = 'qr-inventory',
        inputResource = 'qr-input',
    },
    vorp = {
        enabled = true,
        resource = 'vorp_core',
        exportName = 'vorp_core',
        getSharedObject = 'vorp:getSharedObject',
        playerLoaded = 'vorp:SelectedCharacter',
        playerUnloaded = 'vorp:PlayerLogout',
        jobUpdate = 'vorp:updateJob',
        notification = 'vorp',
        inventory = 'vorp_inventory',
        inputResource = 'vorp_inputs',
    },
    redemrp = {
        enabled = true,
        resource = 'redem_roleplay',
        exportName = 'redem_roleplay',
        getSharedObject = 'redem:getSharedObject',
        playerLoaded = 'RedEM:PlayerLoaded',
        playerUnloaded = 'RedEM:PlayerUnload',
        jobUpdate = 'RedEM:JobUpdate',
        notification = 'redemrp',
        inventory = 'redemrp_inventory',
        inputResource = 'redemrp_input',
    },
    standalone = {
        enabled = true,
        resource = nil,
        exportName = nil,
        notification = 'native',
        inventory = nil,
        inputResource = nil,
    }
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ GENERAL PHONOGRAPH SETTINGS ███████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.PhonoItems = "lxr_phonograph"

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

Config.Promp = {
    openUi = 0x760A9C6F,            -- G
    collectPhonograph = 0xE30CD707, -- R
    openmanuUi = "[ G ] - Open Menu",
    Collect = "[ R ] - Collect",
}

Config.Input = {
    Confirm = "Confirm",
    MinMax = "0.01 to 5",
    Change = "Only numbers between 0.01 and 5 are allowed",
    Speed = "Change Speed",
}

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

Config.MusicTranslations = {
    Volume   = "📯 Volume",
    AudioURL = "◎ Audio URL",
    SwitchToList = "Song List",
    SelectSong = "🎵 Select a song",
    SwitchToUrl = "URL Sond"
}

Config.SoundDistance = 10      -- Maximum audible distance for the music
Config.WithEffect = false      -- Set to true if you want the sound effect to play
Config.VolumeEffect = 0.3      -- Change the effect volume here
Config.AllowCustomSongs = true -- If set to false, people will not be able to play their own songs, only those from the Choose a Song list
Config.AllowListSongs = true   -- if set to true, the list of songs from Config.SongList will appear in the menu; if set to false, the option to choose a song will not be shown
Config.PlacementConfirmTimeout = 5000  -- Time in milliseconds to wait for placement confirmation (5 seconds)

Config.SongList = {
    { label = "Émile Waldteufel - Estudiantina", url = "https://youtu.be/q6R5M52lqlw?list=PLJe4EftqVf-ujHNCbcZBwRvwkYuiuHuGl" },
    { label = "Johann Strauss - The Bat Waltz", url = "https://www.youtube.com/watch?v=QVC1jMRVNAw" },
    { label = "Johann Strauss - Voices of Spring", url = "https://www.youtube.com/watch?v=Vh0KkW42iiY" },
    { label = "Johann Strauss - The Blue Danube", url = "https://www.youtube.com/watch?v=o915AjZtZy4" },
    { label = "Johann Strauss - Tales from the Woods", url = "https://www.youtube.com/watch?v=yZGfZDyHkM0" },
    { label = "Johann Strauss - Accelerations", url = "https://www.youtube.com/watch?v=PscKxtzI3Ok" },
    { label = "Johann Strauss - Artist's Life", url = "https://www.youtube.com/watch?v=AQWkpwE2lqA" },
    { label = "Johann Strauss - Eat, Drink and Be Merry", url = "https://www.youtube.com/watch?v=_YRAIphouQY" },
    { label = "Johann Strauss - Emperor Waltz", url = "https://www.youtube.com/watch?v=f91F2RKO7fQ" },
    { label = "Amazing Grace", url = "https://www.youtube.com/watch?v=QJSIlhxksAQ" },
    { label = "Red River Valley", url = "https://www.youtube.com/watch?v=YdussoFmKC0" },
    { label = "I Wish I Was In Dixie Land", url = "https://youtu.be/5OKdbc0DYpM?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Oh! Susanna", url = "https://youtu.be/-9qRad6pWQI?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Little Brown Jug", url = "https://youtu.be/07T7rREzYMc?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Take Me Home", url = "https://youtu.be/DOo-qDb_me0?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "The Rose of Alabama", url = "https://youtu.be/Pr1QnXGTk-o?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Oh! Dem Golden Slippers!", url = "https://youtu.be/cUZ5XzsHN-c?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Camptown Races", url = "https://youtu.be/49_QHBR4OxE?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "In The Garden", url = "https://www.youtube.com/watch?v=ob3P0odQ7Ic" },
    { label = "Yellow Rose of Texas", url = "https://youtu.be/6HgMXpYYUjo?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Carry Me Back to Old Virginny", url = "https://youtu.be/PyhQYOxTHaw?list=PLCyUlNkbObRZ4k-tEvaLwrNmjUcsQPhfE" },
    { label = "Shall We Gather at the River", url = "https://www.youtube.com/watch?v=JfUYN0F5jEI" },
    { label = "Gerardo Nuñez - Remache", url = "https://www.youtube.com/watch?v=HgR_jvjPkAo" },
    { label = "Under the Stars", url = "https://www.youtube.com/watch?v=v4Heu4XMN-g" },
    { label = "Cherokee Morning Song - Walela", url = "https://www.youtube.com/watch?v=96sU0HW8JrE" },
    { label = "Chant of Happiness & Hope", url = "https://www.youtube.com/watch?v=6nOPPuuWBec" },
    { label = "Lakota National Anthem", url = "https://www.youtube.com/watch?v=T-0vfrxkrxg" },
    { label = "Zuni Sunrise", url = "https://www.youtube.com/watch?v=UWcqYlzMg0g" },
    { label = "Lakota Love Song", url = "https://www.youtube.com/watch?v=bUHJ9dxM9_g" },   
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DATABASE CONFIGURATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.DatabaseTables = {
    phonographs = 'phonographs',
    items = 'items'
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SECURITY & VALIDATION ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

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

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ PERFORMANCE SETTINGS ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

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

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ DEBUG & LOGGING ████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

Config.Debug = {
    enabled = false,
    logLevel = 'info', -- 'debug', 'info', 'warn', 'error'
    logToConsole = true,
    logToFile = false,
}

-- ════════════════════════════════════════════════════════════════════════════════
-- ███████╗███╗   ██╗██████╗      ██████╗ ███████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
-- ██╔════╝████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
-- █████╗  ██╔██╗ ██║██║  ██║    ██║   ██║█████╗      ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██╔══╝  ██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ███████╗██║ ╚████║██████╔╝    ╚██████╔╝██║         ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
-- ╚══════╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝          ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 
-- ════════════════════════════════════════════════════════════════════════════════

print([[
^3
    ═══════════════════════════════════════════════════════════════════════════════
    
        🎵 LXR PHONOGRAPH SYSTEM LOADED
        
        🐺 The Land of Wolves - Where History Lives
        მგლების მიწა - რჩეულთა ადგილი!
        
        Version: 2.1.0
        Framework: ]] .. Config.Framework .. [[
        
        ✅ Configuration Loaded
        ✅ Framework Adapter Initialized
        ✅ Multi-Framework Support Active
        
        © 2026 iBoss21 / The Lux Empire | wolves.land
        
    ═══════════════════════════════════════════════════════════════════════════════
^0
]])
