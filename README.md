# 🎵 LXR Phonograph - Multi-Framework Edition

```
    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║  ██║██╔═══██╗████╗  ██║██╔═══██╗
    ██║      ╚███╔╝ ██████╔╝    ██████╔╝███████║██║   ██║██╔██╗ ██║██║   ██║
    ██║      ██╔██╗ ██╔══██╗    ██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║██║   ██║
    ███████╗██╔╝ ██╗██║  ██║    ██║     ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ 
```

<div align="center">

### 🐺 The Land of Wolves - Where History Lives
**Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!**

[![Discord](https://img.shields.io/badge/Discord-Join%20Us-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/CrKcWdfd3A)
[![Website](https://img.shields.io/badge/Website-wolves.land-orange?style=for-the-badge&logo=safari&logoColor=white)](https://www.wolves.land)
[![GitHub](https://img.shields.io/badge/GitHub-iBoss21-black?style=for-the-badge&logo=github)](https://github.com/iBoss21)
[![Store](https://img.shields.io/badge/Store-Tebex-blue?style=for-the-badge)](https://theluxempire.tebex.io)

**Serious Hardcore Roleplay • Discord & Whitelisted**

</div>

---

## 📋 Quick Links

- 📖 **[Complete Documentation](lxr-phonograph/docs/)** - Full guides and references
- 📦 **[Installation Guide](lxr-phonograph/docs/installation.md)** - Step-by-step setup
- ⚙️ **[Configuration](lxr-phonograph/docs/configuration.md)** - All settings explained
- 🔧 **[Framework Support](lxr-phonograph/docs/frameworks.md)** - Multi-framework details
- 🔒 **[Security](lxr-phonograph/docs/security.md)** - Best practices

---

## 🎯 About This Script

This is a complete **multi-framework adaptation** of rs_phonograph V2 by **riversafe**. The script has been enhanced to support multiple RedM frameworks while maintaining full backward compatibility with VORP.

**🔧 Original Author**: riversafe (rs_phonograph V2)  
**🎨 Framework Adaptation**: iBoss21 / The Lux Empire for The Land of Wolves

### Key Improvements in V2.1.0

✨ **NEW: Framework Adapter Layer**
- Universal abstraction for all framework operations
- Clean, maintainable code structure
- Easy to extend with new frameworks

🔧 **FIXED: Inventory Export Error**
- Resolved `No such export InventoryAPI` error
- Proper framework-specific inventory handling
- Graceful fallbacks for missing dependencies

🎨 **Enhanced Branding**
- Land of Wolves styling throughout
- Professional documentation
- Resource name protection

---

## 🌟 Features

<table>
<tr>
<td width="50%">

### 🎮 Player Features
- ✅ **Visual Placement System** - Ground marker & 3D instructions
- ✅ **Confirmation Prompt** - Double-confirm to prevent mistakes
- ✅ **Music Control** - Volume, looping, play/pause
- ✅ **Custom Songs** - Play any YouTube URL (configurable)
- ✅ **Song Library** - Pre-configured period music
- ✅ **Ownership System** - Only owners can collect
- ✅ **3D Positional Audio** - Distance-based sound

</td>
<td width="50%">

### 🔧 Technical Features
- ✅ **Multi-Framework** - Auto-detection
- ✅ **Framework Adapter** - Clean abstraction layer
- ✅ **Persistent Storage** - Database-backed
- ✅ **Music Sync** - Real-time across clients
- ✅ **Performance Optimized** - Minimal impact
- ✅ **Server Authority** - Secure validation
- ✅ **Resource Protection** - Name validation

</td>
</tr>
</table>

---

## 🛠️ Framework Support

<div align="center">

### Primary Frameworks (Recommended)

| Framework | Status | Priority |
|-----------|--------|----------|
| **LXR-Core** | 🟢 Primary | 1 |
| **RSG-Core** | 🟢 Primary | 2 |

### Full Support

| Framework | Status | Priority |
|-----------|--------|----------|
| **QBR Core** | 🟢 Supported | 3 |
| **QR Core** | 🟢 Supported | 4 |
| **VORP Core** | 🟡 Legacy | 5 |
| **RedEM:RP** | 🟢 Supported | 6 |
| **Standalone** | 🟢 Fallback | 7 |

</div>

**Auto-Detection**: The script automatically detects and adapts to your framework!

See the [Framework Guide](lxr-phonograph/docs/frameworks.md) for detailed information.

---

## 📦 Installation

### Quick Start

1. **Download** the script and place it in your resources folder
2. **Rename** the folder to `lxr-phonograph` (⚠️ **REQUIRED**)
3. **Import** the SQL file: `lxr-phonograph/img and sql/sql phonograph.sql`
4. **Configure** `lxr-phonograph/config.lua` to your preferences
5. **Add** to your `server.cfg`:
   ```cfg
   ensure oxmysql
   ensure xsound
   ensure lxr-phonograph
   ```

### Detailed Installation

For complete installation instructions, see the **[Installation Guide](lxr-phonograph/docs/installation.md)**.

---

## ⚙️ Configuration

The script includes extensive configuration options in `config.lua`:

### Key Settings

```lua
-- Framework Detection
Config.Framework = 'auto'  -- Automatic detection (recommended)

-- Music Settings
Config.AllowCustomSongs = true   -- Allow YouTube URLs
Config.SoundDistance = 10        -- Audible range (meters)

-- Security
Config.Security = {
    maxPhonographsPerPlayer = 1,  -- Limit per player
    validateOwnership = true,      -- Enforce ownership
    placementCooldown = 5,         -- Cooldown (seconds)
}
```

See the **[Configuration Guide](lxr-phonograph/docs/configuration.md)** for all options.

---

## 🎮 Usage

### For Players

1. **Obtain** a phonograph item (`lxr_phonograph`)
2. **Use** the item from your inventory
3. **Place** the phonograph using controls:
   - `← ↑ ↓ →` - Move object
   - `1/2` - Rotate object
   - `7/8` - Raise/Lower height
   - `3` - Adjust placement speed
   - `ENTER` - Confirm position (press twice)
   - `G` - Cancel placement
4. **Interact** with placed phonograph:
   - `G` - Open music menu
   - `R` - Collect phonograph (owner only)
5. **Control Music**:
   - Select from song list or enter custom URL
   - Adjust volume
   - Enable/disable loop
   - Stop playback

### Visual Placement System

- **Golden Ground Marker** shows exact placement location
- **3D Text Instructions** displayed above the phonograph
- **Confirmation Prompt** prevents accidental placement
- **Increased Visibility** during placement (alpha 200)

---

## 🔧 Dependencies

### Required
- ✅ **[oxmysql](https://github.com/overextended/oxmysql)** - Database operations
- ✅ **[xsound](https://github.com/riversafe33/xsound)** - Audio system (3D positional)

### Framework (One of)
- **LXR-Core** (Primary) - The Land of Wolves framework
- **RSG-Core** (Primary) - Rexshack RedM Core
- **VORP Core** - Legacy support maintained
- **QBR Core, QR Core, RedEM:RP** - Alternative frameworks
- **Standalone** - Works without any framework

### Optional
- Framework-specific inventory system
- Framework-specific input system

---

## 📚 Documentation

Complete documentation is available in the `docs/` directory:

| Guide | Description |
|-------|-------------|
| **[Overview](lxr-phonograph/docs/overview.md)** | System introduction and architecture |
| **[Installation](lxr-phonograph/docs/installation.md)** | Step-by-step setup guide |
| **[Configuration](lxr-phonograph/docs/configuration.md)** | All configuration options |
| **[Frameworks](lxr-phonograph/docs/frameworks.md)** | Multi-framework support details |
| **[Events & API](lxr-phonograph/docs/events.md)** | Event and function reference |
| **[Security](lxr-phonograph/docs/security.md)** | Security features and best practices |
| **[Performance](lxr-phonograph/docs/performance.md)** | Optimization guide |
| **[Screenshots](lxr-phonograph/docs/screenshots.md)** | Screenshot requirements |

**📖 [View All Documentation](lxr-phonograph/docs/)**

---

## 📸 Screenshots

<div align="center">

### Phonograph Placement System
<img width="1337" alt="Phonograph with visual placement gizmo and controls" src="https://github.com/user-attachments/assets/4600dfb4-a73e-474c-b6b6-cd7785ae5edd" />

*Visual placement system with golden ground marker and on-screen controls*

---

### Music Control Interface
<img width="1368" alt="NUI music control interface with song selection" src="https://github.com/user-attachments/assets/4e69db7f-6353-4f2e-a293-696650c0f4bb" />

*Modern NUI interface for music control with volume slider and song list*

---

For more screenshots, see **[Screenshot Requirements](lxr-phonograph/docs/screenshots.md)**

</div>

---

## 🔧 Technical Specifications

### System Architecture

```
┌─────────────────────────────────────────────────┐
│              LXR Phonograph System              │
├─────────────────────────────────────────────────┤
│  fxmanifest.lua  │  Resource Definition         │
│  config.lua      │  Centralized Configuration   │
├──────────────────┼──────────────────────────────┤
│  shared/         │                               │
│   framework.lua  │  Universal Framework Adapter  │
├──────────────────┼──────────────────────────────┤
│  client.lua      │  Player Interaction & UI     │
│  server.lua      │  Logic, Security, Database   │
├──────────────────┼──────────────────────────────┤
│  html/           │  NUI Interface               │
│  docs/           │  Complete Documentation      │
│  img and sql/    │  Assets & Database Schema    │
└─────────────────────────────────────────────────┘
```

### Framework Adapter Layer

The framework adapter (`shared/framework.lua`) provides:

**Unified API**:
- `Framework.GetPlayer(src)` - Get player object
- `Framework.Notify(...)` - Send notifications
- `Framework.AddItem(...)` - Add inventory items
- `Framework.RemoveItem(...)` - Remove inventory items
- `Framework.RegisterUsableItem(...)` - Register item usage

**Benefits**:
- Single place to handle framework differences
- Clean core logic without framework-specific code
- Easy to add new framework support
- Automatic framework detection

### Security Features

- ✅ **Server Authority** - All important actions validated server-side
- ✅ **Ownership Validation** - Players can only collect their own phonographs
- ✅ **Distance Checks** - Prevents interaction from too far away
- ✅ **Rate Limiting** - Cooldowns on placement to prevent spam
- ✅ **Input Validation** - URL and parameter validation
- ✅ **Database Security** - Parameterized queries prevent SQL injection

See **[Security Guide](lxr-phonograph/docs/security.md)** for details.

---

## 🚀 Performance

### Optimizations

**Client-Side**:
- Optimized entity rendering distance
- Efficient 3D sound management
- Minimal UI overhead
- Smart update intervals

**Server-Side**:
- Cached phonograph data
- Batch database updates
- Efficient event handling
- Minimal network traffic

**Database**:
- Indexed tables for fast queries
- Optimized SQL queries
- Connection pooling via oxmysql

### Performance Targets

| Metric | Target | Typical |
|--------|--------|---------|
| FPS Impact | < 5 FPS | 1-3 FPS |
| Server ms | < 0.5 ms | 0.1-0.3 ms |
| Memory | < 10 MB | 5-8 MB |
| DB Queries | < 5/min | 2-3/min |

See **[Performance Guide](lxr-phonograph/docs/performance.md)** for optimization tips.

---

## 🤝 Support & Donations

### Getting Support

**Before Asking for Help:**
1. ✅ Read the relevant documentation
2. ✅ Check troubleshooting sections
3. ✅ Search existing GitHub Issues
4. ✅ Enable debug mode and check logs

**Community Support:**
- 💬 **Discord**: [discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A)
- 🐛 **GitHub Issues**: [Report a Bug](https://github.com/iboss21/lxr-phonograph/issues)
- 💡 **Discussions**: [Ask Questions](https://github.com/iboss21/lxr-phonograph/discussions)

### Supporting Development

I create and share digital tools with passion and purpose.

There's absolutely no pressure to donate, but if my work has been helpful to you, any contribution is sincerely appreciated. Your support goes directly toward upgrading my PC and developing more free scripts for everyone.

Thank you for your support! ❤️

**Original Author Support**: [riversafe33 Ko-fi](https://ko-fi.com/riversafe33)  
**Framework Adaptation Support**: [The Lux Empire Tebex](https://theluxempire.tebex.io)

---

## 📝 Changelog

### V2.1.0 - Framework Adapter & Bug Fixes (Current)
- ✨ **NEW**: Framework Adapter Layer for universal framework support
- 🔧 **FIXED**: Inventory export error (`No such export InventoryAPI`)
- 🔧 **FIXED**: Proper framework-specific inventory handling
- 📚 **NEW**: Comprehensive documentation (8 guides, 18,000+ words)
- 🎨 **ENHANCED**: Full Land of Wolves branding throughout
- 🔒 **ENHANCED**: Resource name protection system
- ⚡ **IMPROVED**: Better error handling and fallbacks
- 📦 **IMPROVED**: Enhanced configuration structure

### V2.0.1 - Enhanced Placement System
- ✨ Added visual placement gizmo with ground marker
- ✨ Added 3D text instructions during placement
- ✨ Added confirmation prompt before placing phonograph
- ✨ Increased object visibility during placement (alpha 200)
- 🐛 Fixed issue where items appeared used but weren't placed
- 🔧 Improved placement UX with better visual feedback

### V2.0.0 - Multi-Framework Edition
- ✨ Added support for LXRCore (primary)
- ✨ Added support for RSG-Core (primary)
- ✨ Added support for QBR Core, QR Core
- ✨ Maintained full VORP Core compatibility (legacy)
- ✨ Added RedEM:RP support
- ✨ Added Standalone mode (no framework)
- ✨ Automatic framework detection
- ✨ Unified notification system across all frameworks
- ✨ Unified inventory system across all frameworks
- ✨ Unified input system across all frameworks
- 🎨 Rebranded with The Land of Wolves styling
- 📚 Enhanced documentation
- 🔒 Added resource name protection

### V1.0 - Original (riversafe)
- Initial rs_phonograph V2 release
- NUI interface design
- Rendering distance optimization
- Key locking system
- Loop functionality
- Removed uiprompt dependency

---

## 📄 Credits

### Original Script
**riversafe** - rs_phonograph V2
- Original concept and implementation
- NUI interface design
- Core phonograph functionality

### Framework Adaptation
**iBoss21 / The Lux Empire**
- Multi-framework support system
- Framework adapter layer
- Security enhancements
- Performance optimizations
- Complete documentation
- Land of Wolves branding

### For
**The Land of Wolves 🐺** (wolves.land)
- Georgian RP Server
- Serious Hardcore Roleplay
- Discord & Whitelisted
- მგლების მიწა - რჩეულთა ადგილი!

---

## 📜 License

This project is a derivative work based on rs_phonograph V2 by riversafe.

**Framework Adaptation & Enhancements**:
© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

**Original Script**:
© riversafe (rs_phonograph V2)

---

<div align="center">

## 🐺 მგლების მიწა - რჩეულთა ადგილი!
### The Land of Wolves - A Place for the Chosen!

**ისტორია ცოცხლდება აქ!** *(History Lives Here!)*

[![Discord](https://img.shields.io/badge/Join-Discord-7289DA?style=for-the-badge&logo=discord)](https://discord.gg/CrKcWdfd3A)
[![Website](https://img.shields.io/badge/Visit-Website-orange?style=for-the-badge)](https://www.wolves.land)
[![Server](https://img.shields.io/badge/Play-Now-red?style=for-the-badge)](https://servers.redm.net/servers/detail/8gj7eb)

**© 2026 iBoss21 / The Lux Empire | wolves.land**

Made with ❤️ for the RedM community

</div>
