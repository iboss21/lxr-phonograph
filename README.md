## 🎵 LXR Phonograph V2 - Multi-Framework Edition

### Server Information
**🐺 The Land of Wolves - Where History Lives**
- **Server**: Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
- **Type**: Serious Hardcore Roleplay
- **Access**: Discord & Whitelisted
- **Website**: [wolves.land](https://www.wolves.land)
- **Discord**: [Join Us](https://discord.gg/CrKcWdfd3A)
- **GitHub**: [@iBoss21](https://github.com/iBoss21)
- **Store**: [The Lux Empire](https://theluxempire.tebex.io)

---

### About This Script

This is a complete multi-framework adaptation of rs_phonograph V2 by riversafe. The script has been enhanced to support multiple RedM frameworks while maintaining full backward compatibility with VORP.

**Original Author**: riversafe (rs_phonograph V2)  
**Framework Adaptation**: iBoss21 / The Lux Empire for The Land of Wolves

---

### Framework Support

The script automatically detects your framework and adapts accordingly:

#### Primary Support (Recommended)
- **LXRCore** - The Land of Wolves primary framework
- **RSG-Core** - Rexshack RedM Core

#### Full Support
- **QBR Core** - QB-Core for RedM
- **QR Core** - QR Core Framework
- **VORP Core** - Legacy support maintained
- **RedEM:RP** - RedEM Roleplay support
- **Standalone** - Works without any framework

---

### Features

✅ **Multi-Framework**: Automatically detects and adapts to your framework  
✅ **NUI Interface**: Modern user interface for music control  
✅ **Custom Songs**: Play YouTube URLs (can be disabled)  
✅ **Song List**: Pre-configured classical and period-appropriate music  
✅ **Rendering Distance**: Performance-optimized entity loading  
✅ **Key Locking**: Prevents conflicts with other scripts  
✅ **Loop Function**: Repeat songs automatically  
✅ **Volume Control**: Adjustable volume per phonograph  
✅ **Ownership System**: Players can place and collect their phonographs  
✅ **3D Sound**: Positional audio with distance attenuation

---

### Dependencies

**Required:**
- [xsound](https://github.com/riversafe33/xsound) - Audio system
- [oxmysql](https://github.com/overextended/oxmysql) - Database

**Framework (Auto-detected):**
- One of: lxr-core, rsg-core, qbr-core, qr-core, vorp_core, or redem_roleplay

**Optional:**
- Framework-specific inventory system
- Framework-specific input system

---

### Installation

1. **Download** the script and place it in your resources folder
2. **Rename** the folder to `lxr-phonograph` (important!)
3. **Import** the SQL file: `rs_phonograph/img and sql/sql phonograph.sql`
4. **Configure** `rs_phonograph/config.lua` to your preferences
5. **Add** to your `server.cfg`:
   ```
   ensure oxmysql
   ensure xsound
   ensure lxr-phonograph
   ```

---

### Configuration

The script includes extensive configuration options in `config.lua`:

- **Framework Settings**: Auto-detection or manual override
- **Server Branding**: Customize for your server
- **Keys & Controls**: Rebindable controls
- **Music Settings**: Custom songs, song list, volume, distance
- **Notifications**: Multi-language support
- **Song List**: Pre-configured period-appropriate music

---

### Usage

1. **Obtain** a phonograph item
2. **Use** the item from your inventory
3. **Place** the phonograph using arrow keys and controls:
   - `← ↑ ↓ →` - Move object
   - `1/2` - Rotate object
   - `7/8` - Raise/Lower height
   - `3` - Adjust placement speed
   - `ENTER` - Confirm placement
   - `G` - Cancel placement
4. **Interact** with placed phonograph:
   - `G` - Open music menu
   - `R` - Collect phonograph (owner only)
5. **Control Music**:
   - Select from song list or enter custom URL
   - Adjust volume
   - Enable/disable loop
   - Stop playback

---

### Screenshots

<img width="1337" height="969" alt="phono-1" src="https://github.com/user-attachments/assets/4600dfb4-a73e-474c-b6b6-cd7785ae5edd" />

<img width="1368" height="898" alt="phono_2" src="https://github.com/user-attachments/assets/4e69db7f-6353-4f2e-a293-696650c0f4bb" />

---

### Support & Donations

I create and share digital tools with passion and purpose.

There's absolutely no pressure to donate, but if my work has been helpful to you, any contribution is sincerely appreciated.

Your support goes directly toward upgrading my PC and developing more free scripts for everyone.

Thank you for your support! ❤️

**Original Author Support**: [riversafe33 Ko-fi](https://ko-fi.com/riversafe33)  
**Framework Adaptation Support**: [The Lux Empire Tebex](https://theluxempire.tebex.io)

---

### Credits

**Original Script**: riversafe (rs_phonograph V2)  
**Framework Adaptation**: iBoss21 / The Lux Empire  
**For**: The Land of Wolves 🐺 (wolves.land)

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

---

### Changelog

#### V2.0.0 - Multi-Framework Edition
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

#### V2.0 - Original (riversafe)
- NUI interface design
- Rendering distance optimization
- Key locking system
- Loop functionality
- Removed uiprompt dependency
