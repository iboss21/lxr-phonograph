# 🎵 LXR Phonograph - System Overview

```
    ██╗     ██╗  ██╗██████╗     ██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗    ██╔══██╗██║  ██║██╔═══██╗████╗  ██║██╔═══██╗
    ██║      ╚███╔╝ ██████╔╝    ██████╔╝███████║██║   ██║██╔██╗ ██║██║   ██║
    ██║      ██╔██╗ ██╔══██╗    ██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║██║   ██║
    ███████╗██╔╝ ██╗██║  ██║    ██║     ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ 
```

**🐺 The Land of Wolves - Multi-Framework Phonograph System**

---

## 📋 Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Architecture](#architecture)
4. [Framework Support](#framework-support)
5. [System Requirements](#system-requirements)
6. [Getting Started](#getting-started)

---

## 🎯 Introduction

LXR Phonograph is a complete multi-framework music system for RedM that allows players to:
- Place persistent phonographs in the game world
- Play music from YouTube URLs or a pre-configured song list
- Share music experiences with nearby players through 3D positional audio
- Manage their phonographs with ownership controls

This system was originally created by **riversafe** as rs_phonograph V2 and has been completely adapted and enhanced by **iBoss21 / The Lux Empire** for **The Land of Wolves 🐺** server with full multi-framework support.

---

## ✨ Features

### 🎮 Player Features
- **Easy Placement**: Visual placement system with ground marker and 3D instructions
- **Confirmation System**: Double-confirm placement to prevent accidents
- **Music Control**: Volume control, looping, and playback management
- **Custom Songs**: Play any YouTube URL (configurable)
- **Song Library**: Pre-configured period-appropriate music
- **Ownership**: Only owners can collect their phonographs
- **3D Audio**: Positional audio with distance-based attenuation

### 🔧 Technical Features
- **Multi-Framework**: Automatic framework detection and adaptation
- **Framework Adapter**: Clean abstraction layer for all framework interactions
- **Persistent Storage**: Database-backed phonograph positions and ownership
- **Music Sync**: Real-time music synchronization across all clients
- **Performance Optimized**: Minimal FPS and server impact
- **Security**: Server-side validation and ownership checks
- **Resource Protection**: Runtime resource name validation

### 🎨 Administrative Features
- **Configurable**: Extensive configuration options
- **Debug Mode**: Built-in debugging and logging
- **Security Controls**: Anti-spam, rate limiting, and validation
- **Performance Tuning**: Adjustable render distance and update intervals

---

## 🏗️ Architecture

### System Components

```
lxr-phonograph/
├── fxmanifest.lua        # Resource manifest with branding
├── config.lua            # Centralized configuration
├── shared/
│   └── framework.lua     # Framework adapter layer
├── client.lua            # Client-side logic
├── server.lua            # Server-side logic
├── html/                 # NUI interface
├── docs/                 # Documentation
└── img and sql/          # Assets and database schema
```

### Data Flow

1. **Player Places Phonograph**
   - Client sends placement request
   - Server validates ownership limit
   - Database stores phonograph data
   - All clients receive spawn event

2. **Player Plays Music**
   - Client opens NUI menu
   - Player selects song/URL
   - Server validates and broadcasts
   - Clients create 3D sound sources

3. **Player Collects Phonograph**
   - Client sends collection request
   - Server validates ownership & distance
   - Database removes phonograph
   - Item returned to inventory
   - All clients remove entity

---

## 🛠️ Framework Support

### Primary Frameworks (Best Support)
- **LXRCore** - The Land of Wolves primary framework
- **RSG-Core** - Rexshack RedM Core

### Full Support
- **VORP Core** - Legacy support maintained
- **QBR Core** - QB-Core for RedM
- **QR Core** - QR Core Framework
- **RedEM:RP** - RedEM Roleplay support

### Standalone Mode
Works without any framework using native game functions

### Auto-Detection
The system automatically detects which framework is running based on priority order:
1. LXRCore
2. RSG-Core
3. QBR Core
4. QR Core
5. VORP Core
6. RedEM:RP
7. Standalone (if none detected)

---

## 💻 System Requirements

### Required Dependencies
- **RedM Server** (Build 4890 or higher)
- **OneSync** (Required for entity synchronization)
- **oxmysql** (Database operations)
- **xsound** (Audio system for 3D positional audio)

### Optional Dependencies
- **Framework** (One of: lxr-core, rsg-core, qbr-core, qr-core, vorp_core, redem_roleplay)
- **Framework Inventory** (For item usage and management)

### Server Specifications
- **Memory**: 2GB+ RAM recommended
- **CPU**: Multi-core processor recommended
- **Storage**: 50MB+ free space
- **Network**: Stable connection with low latency

### Client Requirements
- **RedM Client** (Latest version)
- **Good Internet Connection** (For YouTube audio streaming)
- **Audio Enabled** (For music playback)

---

## 🚀 Getting Started

### Quick Start
1. Read the [Installation Guide](installation.md)
2. Configure settings in [Configuration Guide](configuration.md)
3. Learn about frameworks in [Framework Guide](frameworks.md)
4. Review security in [Security Guide](security.md)

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
