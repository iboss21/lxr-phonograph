# 📦 Installation Guide - LXR Phonograph

```
    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
```

**🐺 The Land of Wolves - Installation Instructions**

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Download & Extract](#download--extract)
3. [Database Setup](#database-setup)
4. [Item Configuration](#item-configuration)
5. [Server Configuration](#server-configuration)
6. [Verification](#verification)
7. [Troubleshooting](#troubleshooting)

---

## ✅ Prerequisites

Before installing LXR Phonograph, ensure you have:

### Required Resources
- [x] **oxmysql** - Database connector
  - Download: [overextended/oxmysql](https://github.com/overextended/oxmysql)
  - Latest version recommended

- [x] **xsound** - Audio system
  - Download: [riversafe33/xsound](https://github.com/riversafe33/xsound)
  - Version 3.0+ recommended

### Framework (One of)
- [x] **LXR-Core** (Primary) - The Land of Wolves framework
- [x] **RSG-Core** (Primary) - Rexshack RedM Core
- [x] **VORP Core** - Legacy support
- [x] **QBR Core, QR Core, RedEM:RP** - Alternative frameworks
- [x] **Standalone** - No framework required

### Server Requirements
- [x] RedM Server Build 4890+
- [x] OneSync enabled
- [x] MySQL/MariaDB database

---

## 📥 Download & Extract

### Step 1: Obtain the Resource

**Option A: GitHub Release (Recommended)**
```bash
cd resources
wget https://github.com/iboss21/lxr-phonograph/archive/main.zip
unzip main.zip
mv lxr-phonograph-main lxr-phonograph
```

**Option B: Git Clone**
```bash
cd resources
git clone https://github.com/iboss21/lxr-phonograph.git
```

**Option C: Manual Download**
1. Visit [GitHub Repository](https://github.com/iboss21/lxr-phonograph)
2. Click "Code" → "Download ZIP"
3. Extract to your `resources` folder

### Step 2: Verify Folder Name

**⚠️ CRITICAL: The folder MUST be named `lxr-phonograph`**

```
resources/
└── lxr-phonograph/      # ✅ Correct
    ├── fxmanifest.lua
    ├── config.lua
    ├── server.lua
    ├── client.lua
    ├── shared/
    ├── html/
    └── docs/
```

**❌ Incorrect folder names:**
- `lxr-phonograph-main`
- `rs_phonograph`
- `phonograph`
- Any other name

The resource has a built-in name protection system that will prevent it from running if renamed.

---

## 🗄️ Database Setup

### Step 1: Import SQL File

Navigate to the SQL file:
```
lxr-phonograph/img and sql/sql phonograph.sql
```

**Import Methods:**

**Option A: phpMyAdmin**
1. Open phpMyAdmin
2. Select your database
3. Click "Import"
4. Choose `sql phonograph.sql`
5. Click "Go"

**Option B: MySQL Command Line**
```bash
mysql -u username -p database_name < "lxr-phonograph/img and sql/sql phonograph.sql"
```

**Option C: HeidiSQL**
1. Connect to your database
2. File → Run SQL file
3. Select `sql phonograph.sql`
4. Execute

### Step 2: Verify Tables Created

The SQL file creates two things:

**1. Phonographs Table**
```sql
CREATE TABLE IF NOT EXISTS `phonographs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `owner_identifier` varchar(255) DEFAULT NULL,
  `owner_charid` int(11) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `rot_x` double DEFAULT NULL,
  `rot_y` double DEFAULT NULL,
  `rot_z` double DEFAULT NULL,
  PRIMARY KEY (`id`)
);
```

**2. Item Entry**
```sql
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `metadata`, `desc`, `weight`) 
VALUES ("lxr_phonograph", "Antique Phonograph", 200, 1, "item_standard", 1, "{}", 
        "An antique phonograph used to play music. Place it on the ground to enjoy period sounds.", 15);
```

### Step 3: Verify Installation

Run this query to confirm:
```sql
-- Check phonographs table
SELECT * FROM phonographs LIMIT 1;

-- Check item exists
SELECT * FROM items WHERE item = 'lxr_phonograph';
```

---

## 🎒 Item Configuration

### For Inventory Systems

The phonograph item is automatically added to your items table by the SQL file.

**Item Details:**
- **Item Name**: `lxr_phonograph`
- **Label**: Antique Phonograph
- **Weight**: 15
- **Usable**: Yes
- **Type**: Standard item

### Adding Items to Players

**LXR-Core / RSG-Core / QBR / QR:**
```lua
-- In-game admin command or script
Player.Functions.AddItem('lxr_phonograph', 1)
```

**VORP:**
```lua
-- VORP inventory
exports.vorp_inventory:addItem(source, 'lxr_phonograph', 1)
```

**SQL Direct Method:**
```sql
-- Add item directly to player inventory (adjust to your inventory table)
INSERT INTO inventory (identifier, item, amount) VALUES ('steam:xxx', 'lxr_phonograph', 1);
```

---

## ⚙️ Server Configuration

### Step 1: Configure config.lua

Open `lxr-phonograph/config.lua` and adjust settings:

**Framework Selection:**
```lua
Config.Framework = 'auto'  -- Recommended: auto-detection
-- Or manually set: 'lxrcore', 'rsg-core', 'vorp', 'standalone'
```

**Music Settings:**
```lua
Config.AllowCustomSongs = true   -- Allow YouTube URLs
Config.AllowListSongs = true     -- Show song list
Config.SoundDistance = 10        -- Audible range in meters
```

**Security:**
```lua
Config.Security = {
    maxPhonographsPerPlayer = 1,  -- Limit per player
    validateOwnership = true,      -- Enforce ownership checks
    placementCooldown = 5,         -- Seconds between placements
}
```

### Step 2: Update server.cfg

Add to your `server.cfg` in the correct load order:

```cfg
# Database
ensure oxmysql

# Audio System
ensure xsound

# Framework (if using one)
ensure lxr-core        # or rsg-core, vorp_core, etc.

# Phonograph System
ensure lxr-phonograph
```

**Load Order is Important:**
1. Database (oxmysql)
2. Audio (xsound)
3. Framework (if applicable)
4. Phonograph (lxr-phonograph)

### Step 3: Restart Server

**Full Restart (Recommended for First Install):**
```bash
# Stop server
# Start server
```

**Refresh Resource (For Updates):**
```cfg
# In server console
refresh
ensure lxr-phonograph
```

---

## ✔️ Verification

### Step 1: Check Console Output

When the resource starts, you should see:
```
^2[LXR-Phonograph]^7 Framework Detected: ^3lxrcore^7
^2[LXR-Phonograph]^7 Framework Adapter: ^2Ready^7

    ═══════════════════════════════════════════════════════════════
    
        🎵 LXR PHONOGRAPH SYSTEM LOADED
        
        🐺 The Land of Wolves - Where History Lives
        მგლების მიწა - რჩეულთა ადგილი!
        
        Version: 2.1.0
        Framework: auto
        
        ✅ Configuration Loaded
        ✅ Framework Adapter Initialized
        ✅ Multi-Framework Support Active
        
        © 2026 iBoss21 / The Lux Empire | wolves.land
        
    ═══════════════════════════════════════════════════════════════
```

### Step 2: Test In-Game

1. **Join Server**
2. **Add Item** (use admin command or SQL)
3. **Use Phonograph** from inventory
4. **Place Phonograph** using controls
5. **Interact** with placed phonograph (G key)
6. **Play Music** from the menu

### Step 3: Check Database

After placing a phonograph, verify database entry:
```sql
SELECT * FROM phonographs;
```

You should see an entry with coordinates and owner information.

---

## 🔧 Troubleshooting

### Resource Not Starting

**Problem**: Resource doesn't appear in resources list
```
Solution:
1. Verify folder is named exactly 'lxr-phonograph'
2. Check fxmanifest.lua exists
3. Run 'refresh' in server console
```

**Problem**: Resource name mismatch error
```
Expected: lxr-phonograph
Got: [something else]
```
```
Solution:
Rename the folder to exactly 'lxr-phonograph'
```

### Database Errors

**Problem**: Table doesn't exist
```sql
Error: Table 'phonographs' doesn't exist
```
```
Solution:
1. Re-import sql phonograph.sql
2. Verify correct database selected
3. Check database name in oxmysql config
```

**Problem**: Item not found
```
Solution:
1. Check items table exists in your database
2. Verify SQL import included item entry
3. Manually add item if needed
```

### Framework Issues

**Problem**: Framework not detected
```
^2[LXR-Phonograph]^7 Detected Framework: ^3standalone^7
```
```
Solution:
1. Verify framework resource is started
2. Check framework resource name matches config
3. Manually set Config.Framework if needed
```

**Problem**: Inventory export error
```
No such export InventoryAPI in resource xxx-inventory
```
```
Solution:
This is now fixed with the framework adapter layer.
Update to latest version if still seeing this error.
```

### Audio Issues

**Problem**: No sound playing
```
Solution:
1. Verify xsound is installed and started
2. Check xsound is started BEFORE lxr-phonograph
3. Test YouTube URL in browser
4. Check client audio settings
```

**Problem**: Sound not 3D positional
```
Solution:
1. Verify xsound version 3.0+
2. Check Config.SoundDistance setting
3. Restart both xsound and lxr-phonograph
```

### Permission Issues

**Problem**: Can't place phonograph
```
Solution:
1. Verify item is in inventory
2. Check database for existing phonograph (limit 1)
3. Check security settings in config
```

**Problem**: Can't collect phonograph
```
Solution:
1. Verify ownership (only owner can collect)
2. Check distance (must be within 2.5m)
3. Review server logs for errors
```

---

## 📞 Support

If you continue to experience issues:

1. **Check Logs**: Review server console for errors
2. **Enable Debug**: Set `Config.Debug.enabled = true`
3. **Community Support**:
   - Discord: [discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A)
   - GitHub Issues: [Report a Bug](https://github.com/iboss21/lxr-phonograph/issues)

---

## 🎉 Installation Complete!

Your LXR Phonograph system is now installed and ready to use.

Next steps:
- Review [Configuration Guide](configuration.md) for customization
- Read [Framework Guide](frameworks.md) for framework-specific features
- Check [Security Guide](security.md) for best practices

---

**🐺 The Land of Wolves - Where History Lives**

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
