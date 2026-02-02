# 📸 Screenshot Guidelines - LXR Phonograph

```
    ███████╗ ██████╗██████╗ ███████╗███████╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗███████╗
    ██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝
    ███████╗██║     ██████╔╝█████╗  █████╗  ██╔██╗ ██║███████╗███████║██║   ██║   ██║   ███████╗
    ╚════██║██║     ██╔══██╗██╔══╝  ██╔══╝  ██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║   ╚════██║
    ███████║╚██████╗██║  ██║███████╗███████╗██║ ╚████║███████║██║  ██║╚██████╔╝   ██║   ███████║
    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝
```

**🐺 The Land of Wolves - Screenshot Documentation Guide**

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Required Screenshots](#required-screenshots)
3. [Screenshot Guidelines](#screenshot-guidelines)
4. [File Naming Conventions](#file-naming-conventions)
5. [Storage Location](#storage-location)
6. [Technical Specifications](#technical-specifications)
7. [Screenshot Descriptions](#screenshot-descriptions)
8. [Best Practices](#best-practices)
9. [Screenshot Checklist](#screenshot-checklist)

---

## 🎯 Overview

This document provides comprehensive guidelines for capturing, organizing, and storing screenshots of the LXR Phonograph system. Screenshots are essential for:

- **Documentation**: Visual guides for features
- **Marketing**: Showcase system capabilities
- **Support**: Help users troubleshoot issues
- **Development**: Track UI/UX changes
- **Quality Assurance**: Verify visual consistency

---

## 📷 Required Screenshots

### Core Functionality Screenshots

#### 1. System Startup & Console
**Filename**: `startup-console.png`  
**Description**: Server console showing successful resource start  
**Required Elements**:
- Resource name verification
- Framework detection message
- Database connection confirmation
- Adapter initialization message
- No errors visible

**Example Console Output to Capture**:
```
[LXR-Phonograph] Framework Detected: lxrcore
[LXR-Phonograph] Framework Adapter: Ready
[LXR-Phonograph] Database: Connected
[LXR-Phonograph] Resource Started Successfully
```

---

#### 2. Configuration File Overview
**Filename**: `config-overview.png`  
**Description**: Overview of main config.lua sections  
**Required Elements**:
- Server branding section
- Framework settings
- General phonograph settings
- Clear, readable code
- Syntax highlighting visible

---

#### 3. Framework Detection
**Filename**: `framework-detection-[framework].png`  
**Description**: Console showing framework auto-detection (one per supported framework)  
**Required Variations**:
- `framework-detection-lxrcore.png`
- `framework-detection-rsg-core.png`
- `framework-detection-vorp.png`
- `framework-detection-qbr-core.png`
- `framework-detection-qr-core.png`
- `framework-detection-redemrp.png`
- `framework-detection-standalone.png`

**Required Elements**:
- Framework name clearly displayed
- Successful initialization
- No errors

---

### Gameplay Screenshots

#### 4. Phonograph Item in Inventory
**Filename**: `inventory-phonograph-item.png`  
**Description**: Phonograph item visible in player inventory  
**Required Elements**:
- Clear view of phonograph item
- Item name and description visible
- Inventory UI shown
- Character name visible (if applicable)

---

#### 5. Placement Mode - Initial View
**Filename**: `placement-mode-initial.png`  
**Description**: Placement mode activated with preview object  
**Required Elements**:
- Phonograph preview object visible
- Ground marker showing
- On-screen instructions visible
- Controls displayed

---

#### 6. Placement Mode - Rotation
**Filename**: `placement-mode-rotation.png`  
**Description**: Player rotating phonograph during placement  
**Required Elements**:
- Phonograph at different angle from initial
- Rotation controls visible
- Preview object clear
- Ground marker present

---

#### 7. Placement Mode - Confirmation
**Filename**: `placement-mode-confirm.png`  
**Description**: Double confirmation prompt before final placement  
**Required Elements**:
- Confirmation message
- "Press ENTER to confirm" instruction
- Preview at final position

---

#### 8. Placed Phonograph - World View
**Filename**: `phonograph-placed-world.png`  
**Description**: Successfully placed phonograph in game world  
**Required Elements**:
- Phonograph object clearly visible
- Realistic lighting
- Environment context
- Good camera angle

---

#### 9. Phonograph Interaction Menu
**Filename**: `interaction-menu-closed.png`  
**Description**: Player near phonograph showing interaction prompts  
**Required Elements**:
- Phonograph visible in scene
- Interaction prompt visible
- Player character visible
- Distance indicator (if applicable)

---

#### 10. Music Selection UI - Closed State
**Filename**: `ui-music-selection-closed.png`  
**Description**: Music selection interface in closed state  
**Required Elements**:
- Clean UI design
- Open button visible
- Phonograph in background

---

#### 11. Music Selection UI - Song List
**Filename**: `ui-music-selection-list.png`  
**Description**: Song list interface with available songs  
**Required Elements**:
- List of period-appropriate songs
- Song titles clearly readable
- Scroll functionality visible (if applicable)
- Selection indicators
- Category/genre labels (if applicable)

---

#### 12. Music Selection UI - Custom URL
**Filename**: `ui-music-selection-custom.png`  
**Description**: Custom URL input interface  
**Required Elements**:
- URL input field
- Placeholder text visible
- Submit/Play button
- Cancel option
- Input validation hints (if any)

---

#### 13. Music Playing - Active State
**Filename**: `music-playing-active.png`  
**Description**: Phonograph actively playing music  
**Required Elements**:
- Phonograph in scene
- "Now Playing" indicator or audio visualization (if any)
- Volume controls visible
- Playback controls (play/pause/stop)
- Loop toggle visible

---

#### 14. Volume Control UI
**Filename**: `ui-volume-control.png`  
**Description**: Volume adjustment interface  
**Required Elements**:
- Volume slider
- Current volume percentage
- Mute option (if applicable)
- Volume indicators

---

#### 15. Owner Controls Menu
**Filename**: `ui-owner-controls.png`  
**Description**: Menu showing owner-only controls  
**Required Elements**:
- Play/Stop Music button
- Volume Control
- Loop Toggle
- Collect Phonograph option
- Owner name displayed

---

#### 16. Non-Owner View
**Filename**: `ui-non-owner-view.png`  
**Description**: Limited view for non-owner players  
**Required Elements**:
- "Not your phonograph" message or limited controls
- Owner name displayed
- Current song info (if playing)
- No modification controls visible

---

#### 17. Collection Prompt
**Filename**: `collection-prompt.png`  
**Description**: Owner collecting their phonograph  
**Required Elements**:
- Collection prompt visible
- Confirmation required
- Phonograph visible in scene

---

#### 18. Success Notification - Placed
**Filename**: `notification-placement-success.png`  
**Description**: Success notification after placing phonograph  
**Required Elements**:
- Notification visible
- Success message
- Green/positive indicator
- Framework-appropriate styling

---

#### 19. Success Notification - Music Started
**Filename**: `notification-music-started.png`  
**Description**: Notification when music starts playing  
**Required Elements**:
- Notification visible
- Music start confirmation
- Song name (if applicable)

---

#### 20. Error Notification - Not Owner
**Filename**: `notification-error-ownership.png`  
**Description**: Error when non-owner tries to control phonograph  
**Required Elements**:
- Error notification
- "Not your phonograph" message
- Red/error indicator
- Framework-appropriate styling

---

### Technical Screenshots

#### 21. Database Table Structure
**Filename**: `database-table-structure.png`  
**Description**: Screenshot of phonographs table structure in database  
**Required Elements**:
- Table name: `phonographs`
- All columns visible
- Data types shown
- Primary key indicated
- Indexes shown

---

#### 22. Database Sample Data
**Filename**: `database-sample-data.png`  
**Description**: Sample phonograph records in database  
**Required Elements**:
- Multiple phonograph records
- All columns populated
- Owner information visible
- Coordinates shown
- Readable formatting

---

#### 23. Performance Metrics - FPS Counter
**Filename**: `performance-fps-metrics.png`  
**Description**: FPS counter showing minimal impact  
**Required Elements**:
- FPS counter visible
- Multiple phonographs in scene
- Stable FPS shown
- System specs visible (if possible)

---

#### 24. Performance Metrics - Resource Monitor
**Filename**: `performance-resource-usage.png`  
**Description**: Server resource monitor showing phonograph usage  
**Required Elements**:
- Resource name: lxr-phonograph
- CPU usage (ms)
- Memory usage (MB)
- Thread count
- Low resource consumption evident

---

#### 25. Debug Mode Console Output
**Filename**: `debug-mode-output.png`  
**Description**: Console with debug logging enabled  
**Required Elements**:
- `Config.Debug = true` visible effect
- Debug messages showing
- Framework operations logged
- Event triggers visible
- No errors

---

#### 26. Multi-Framework Compatibility
**Filename**: `multi-framework-showcase.png`  
**Description**: Collage showing phonograph working on different frameworks  
**Required Elements**:
- Multiple framework screenshots combined
- Each framework clearly labeled
- Consistent functionality shown

---

### UI/UX Screenshots

#### 27. Mobile/Responsive UI View
**Filename**: `ui-responsive-mobile.png`  
**Description**: UI on smaller screen resolution (if responsive)  
**Required Elements**:
- UI adapted to smaller screen
- All controls accessible
- Readable text

---

#### 28. Nighttime Lighting
**Filename**: `lighting-nighttime.png`  
**Description**: Phonograph at night with atmospheric lighting  
**Required Elements**:
- Nighttime environment
- Phonograph clearly visible
- Good contrast
- Ambient lighting effects

---

#### 29. Daytime Lighting
**Filename**: `lighting-daytime.png`  
**Description**: Phonograph in daylight with clear visibility  
**Required Elements**:
- Daylight environment
- Bright, clear view
- Natural lighting
- Good color representation

---

#### 30. Multiple Phonographs - Distance View
**Filename**: `multiple-phonographs-distance.png`  
**Description**: Multiple phonographs at various distances  
**Required Elements**:
- 3+ phonographs visible
- Distance culling demonstration (if applicable)
- Render distance visible
- Performance stable

---

### Error Handling Screenshots

#### 31. Invalid URL Error
**Filename**: `error-invalid-url.png`  
**Description**: Error when invalid YouTube URL is entered  
**Required Elements**:
- Error message visible
- Invalid URL shown in input
- Clear error description
- Retry option

---

#### 32. Cooldown Error
**Filename**: `error-cooldown-active.png`  
**Description**: Error when action attempted during cooldown  
**Required Elements**:
- Cooldown message
- Time remaining (if shown)
- Reason for cooldown

---

#### 33. Distance Error
**Filename**: `error-too-far.png`  
**Description**: Error when player too far from phonograph  
**Required Elements**:
- "Too far away" message
- Player position
- Phonograph visible in distance

---

#### 34. Inventory Full Error
**Filename**: `error-inventory-full.png`  
**Description**: Error when trying to collect but inventory full  
**Required Elements**:
- Inventory full message
- Current inventory state visible
- Cannot collect notification

---

### Configuration Screenshots

#### 35. Config - Server Branding
**Filename**: `config-server-branding.png`  
**Description**: Server branding configuration section  
**Required Elements**:
- ServerInfo table visible
- Name, tagline, description
- Comments explaining options
- Proper Lua syntax

---

#### 36. Config - Framework Settings
**Filename**: `config-framework-settings.png`  
**Description**: Framework configuration section  
**Required Elements**:
- `Config.Framework` setting
- Auto-detection option
- Available framework list
- Comments explaining choices

---

#### 37. Config - Performance Settings
**Filename**: `config-performance-settings.png`  
**Description**: Performance optimization settings  
**Required Elements**:
- Render distance settings
- Culling distance
- Update intervals
- Max phonographs limit
- Comments explaining impact

---

#### 38. Config - Security Settings
**Filename**: `config-security-settings.png`  
**Description**: Security and anti-exploit settings  
**Required Elements**:
- Cooldown timers
- Rate limiting settings
- Validation toggles
- Distance checks
- Comments on security features

---

#### 39. Config - Music Settings
**Filename**: `config-music-settings.png`  
**Description**: Music and audio configuration  
**Required Elements**:
- Custom URL toggle
- Song list
- Audio range setting
- Volume defaults
- Loop settings

---

#### 40. Config - Controls Settings
**Filename**: `config-controls-settings.png`  
**Description**: Key bindings and control configuration  
**Required Elements**:
- Placement controls
- Rotation keys
- Confirmation keys
- Cancel key
- Comments showing key names

---

---

## 📏 Screenshot Guidelines

### General Guidelines

#### Resolution
- **Minimum**: 1920x1080 (Full HD)
- **Recommended**: 2560x1440 (2K)
- **Maximum**: 3840x2160 (4K)

#### Format
- **File Type**: PNG (preferred for UI/text), JPG (acceptable for scenic shots)
- **Compression**: Minimal compression for clarity
- **Color Depth**: 24-bit or higher

#### Framing
- **Center Subject**: Main focus in center third of frame
- **Rule of Thirds**: For scenic/atmospheric shots
- **Clear Focus**: No motion blur, sharp focus
- **Context**: Include enough environment for context

#### Lighting
- **In-Game Time**: Vary between day/night as specified
- **Weather**: Clear weather unless testing weather effects
- **Brightness**: Well-lit, not too dark or overexposed
- **Contrast**: Good contrast between subject and background

#### UI Elements
- **Clean**: Remove unnecessary UI elements when capturing gameplay
- **Readable**: All text must be clearly legible
- **Complete**: Don't crop important UI elements
- **Consistent**: Use same UI scaling across screenshots

---

## 📁 File Naming Conventions

### Format
```
[category]-[subject]-[variant].png
```

### Categories
- `startup-` - System initialization
- `config-` - Configuration files
- `framework-` - Framework-specific
- `inventory-` - Inventory-related
- `placement-` - Placement mode
- `phonograph-` - Phonograph objects
- `interaction-` - Interaction prompts
- `ui-` - User interface
- `music-` - Music playback
- `notification-` - Notifications
- `database-` - Database screenshots
- `performance-` - Performance metrics
- `debug-` - Debug mode
- `lighting-` - Lighting conditions
- `error-` - Error messages
- `multiple-` - Multiple objects

### Examples
```
✅ Good:
- startup-console.png
- config-framework-settings.png
- ui-music-selection-list.png
- framework-detection-lxrcore.png
- notification-error-ownership.png

❌ Bad:
- screenshot1.png
- IMG_20240101.png
- untitled.png
- photo.png
```

### Variant Naming
When capturing multiple versions of the same subject:
```
ui-music-selection-list-v1.png
ui-music-selection-list-v2.png
ui-music-selection-list-final.png
```

---

## 💾 Storage Location

### Primary Location
```
/home/runner/work/lxr-phonograph/lxr-phonograph/lxr-phonograph/docs/assets/screenshots/
```

### Directory Structure
```
lxr-phonograph/
└── docs/
    └── assets/
        └── screenshots/
            ├── startup/          # System startup screenshots
            ├── config/           # Configuration screenshots
            ├── framework/        # Framework-specific screenshots
            ├── gameplay/         # Gameplay screenshots
            ├── ui/              # UI screenshots
            ├── notifications/   # Notification screenshots
            ├── database/        # Database screenshots
            ├── performance/     # Performance screenshots
            ├── errors/          # Error screenshots
            ├── lighting/        # Lighting condition screenshots
            └── misc/            # Miscellaneous screenshots
```

### Subdirectory Organization

#### /startup/
- `startup-console.png`
- `startup-successful.png`
- `startup-errors.png` (if documenting errors)

#### /config/
- `config-overview.png`
- `config-server-branding.png`
- `config-framework-settings.png`
- `config-performance-settings.png`
- `config-security-settings.png`
- `config-music-settings.png`
- `config-controls-settings.png`

#### /framework/
- `framework-detection-lxrcore.png`
- `framework-detection-rsg-core.png`
- `framework-detection-vorp.png`
- `framework-detection-qbr-core.png`
- `framework-detection-qr-core.png`
- `framework-detection-redemrp.png`
- `framework-detection-standalone.png`

#### /gameplay/
- `inventory-phonograph-item.png`
- `placement-mode-initial.png`
- `placement-mode-rotation.png`
- `placement-mode-confirm.png`
- `phonograph-placed-world.png`
- `interaction-menu-closed.png`
- `collection-prompt.png`

#### /ui/
- `ui-music-selection-closed.png`
- `ui-music-selection-list.png`
- `ui-music-selection-custom.png`
- `ui-volume-control.png`
- `ui-owner-controls.png`
- `ui-non-owner-view.png`
- `ui-responsive-mobile.png`

#### /notifications/
- `notification-placement-success.png`
- `notification-music-started.png`
- `notification-error-ownership.png`

#### /database/
- `database-table-structure.png`
- `database-sample-data.png`

#### /performance/
- `performance-fps-metrics.png`
- `performance-resource-usage.png`
- `debug-mode-output.png`

#### /errors/
- `error-invalid-url.png`
- `error-cooldown-active.png`
- `error-too-far.png`
- `error-inventory-full.png`

#### /lighting/
- `lighting-nighttime.png`
- `lighting-daytime.png`

#### /misc/
- `multi-framework-showcase.png`
- `multiple-phonographs-distance.png`

---

## 🔧 Technical Specifications

### Image Quality

#### For UI/Text Screenshots
```
Format: PNG
Resolution: 1920x1080 minimum
Bit Depth: 24-bit color
Compression: None or lossless
File Size: < 5 MB ideal
```

#### For Scenic/Gameplay Screenshots
```
Format: PNG or JPG
Resolution: 1920x1080 minimum
Bit Depth: 24-bit color
Compression: Minimal (90-95% quality for JPG)
File Size: < 10 MB
```

#### For Console/Code Screenshots
```
Format: PNG
Resolution: Native (don't scale)
Bit Depth: 24-bit color
Compression: None
Font: Ensure monospace fonts are readable
File Size: < 2 MB
```

### Capture Tools

#### Recommended
- **Windows**: Windows Game Bar (Win + G), ShareX, Greenshot
- **Mac**: Cmd + Shift + 4
- **Linux**: Spectacle, Flameshot
- **In-Game**: F12 (Steam), built-in screenshot tools

#### Settings
- **Anti-Aliasing**: High
- **Texture Quality**: High
- **Shadow Quality**: Medium or High
- **Post-Processing**: Enable
- **Motion Blur**: Disable for clarity

---

## 📝 Screenshot Descriptions

Each screenshot should be accompanied by:

### Metadata File
Create a `[screenshot-name].txt` file with:
```
Filename: startup-console.png
Date: 2026-01-15
Captured By: iBoss21
Framework: LXR-Core
Server: The Land of Wolves
Resolution: 1920x1080
Description: Server console showing successful LXR Phonograph resource start with framework detection.
Notes: Captured during fresh server start with clean database.
```

### In Documentation
When referencing in markdown:
```markdown
![Startup Console](screenshots/startup/startup-console.png)
*Figure 1: Server console showing successful resource initialization*
```

---

## ✅ Best Practices

### Before Capturing

1. **Clean Environment**
   - Remove test objects
   - Clear chat/console clutter
   - Reset to default state

2. **Optimal Settings**
   - Set graphics to high
   - Disable motion blur
   - Enable anti-aliasing
   - Full resolution

3. **Character Position**
   - Good camera angle
   - Character visible when relevant
   - Clear line of sight

### During Capture

1. **Timing**
   - Wait for full load
   - Capture at correct moment
   - No animations mid-frame

2. **Framing**
   - Center subject
   - Include context
   - No cutoff elements

3. **UI State**
   - All menus fully loaded
   - Text fully rendered
   - No loading indicators

### After Capture

1. **Review Quality**
   - Check clarity
   - Verify all elements visible
   - No artifacts or compression issues

2. **Name Properly**
   - Follow naming convention
   - Use descriptive names
   - Include variant number if needed

3. **Organize**
   - Place in correct subdirectory
   - Create metadata file
   - Update documentation

### Maintenance

1. **Regular Updates**
   - Recapture when UI changes
   - Update for new features
   - Replace outdated screenshots

2. **Version Control**
   - Keep old versions as `-old`
   - Document changes
   - Update references in docs

3. **Consistency**
   - Match existing style
   - Same resolution across set
   - Consistent framing

---

## 📋 Screenshot Checklist

### Pre-Production
- [ ] Graphics settings optimized
- [ ] Clean game environment
- [ ] No debug overlays (unless documenting debug mode)
- [ ] Correct time of day
- [ ] Stable FPS

### During Capture
- [ ] Subject in focus
- [ ] Proper framing
- [ ] All UI elements visible
- [ ] Text readable
- [ ] Good lighting

### Post-Production
- [ ] Image quality verified
- [ ] Correct format (PNG/JPG)
- [ ] Proper filename
- [ ] Placed in correct directory
- [ ] Metadata file created

### Documentation
- [ ] Screenshot referenced in docs
- [ ] Description added
- [ ] Figure caption written
- [ ] Alt text included

### Quality Assurance
- [ ] No blur or artifacts
- [ ] Correct resolution
- [ ] File size reasonable
- [ ] Consistent with other screenshots

---

## 📚 Additional Resources

### Related Documentation
- [Overview](overview.md) - System overview with screenshots
- [Installation Guide](installation.md) - Setup screenshots
- [Configuration Guide](configuration.md) - Config screenshots
- [User Guide](../README.md) - Gameplay screenshots

### Tools & Resources
- **Photoshop/GIMP**: For editing if needed
- **TinyPNG**: For compression
- **Markdown**: For documentation integration

### Support
- **Website**: [wolves.land](https://www.wolves.land)
- **Discord**: [Join Us](https://discord.gg/CrKcWdfd3A)
- **GitHub**: [@iBoss21](https://github.com/iBoss21)
- **Store**: [The Lux Empire](https://theluxempire.tebex.io)

---

## 📄 Credits

**Original Script**: riversafe (rs_phonograph V2)  
**Documentation & Guidelines**: iBoss21 / The Lux Empire  
**For**: The Land of Wolves 🐺 (wolves.land)

© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved

---

**🐺 მგლების მიწა - რჩეულთა ადგილი! (The Land of Wolves - A Place for the Chosen!)**
