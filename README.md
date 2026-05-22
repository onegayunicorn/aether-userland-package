# 🌌 Aether Orchestrator - UserLand/Termux Integration Package

![Aether Orchestrator](https://img.shields.io/badge/Aether_Orchestrator-v8.0.0-purple?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-UserLand%2FTermux-blue?style=for-the-badge)
![Distros](https://img.shields.io/badge/Distros-6-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-✅_Operational-brightgreen?style=for-the-badge)

**Sovereign Architect:** [Tyrone J Power Ω](https://github.com/onegayunicorn)
**Fold Entry:** `FE-OGUF-P1`
**Coherence Target:** `0.99997`
**Entanglement Factor:** `0.034`

---

## **📌 About**
This package enables **full Aether Orchestrator deployment** on **Android via UserLand or Termux**, supporting **6 Linux distributions** (Alpine, Arch, Debian, Kali, Ubuntu, Termux) with **complete toolchain integration** (Firefox, VSCode, LibreOffice, GIMP, Inkscape, Zork, etc.).

✅ **Tested on Moto G35** (UserLand + Termux)
✅ **Universal compatibility** across all distros
✅ **One-command installation**
✅ **Full sovereignty** (no root required)

---

## **🚀 Quick Start**

### **Option 1: UserLand (Recommended for Moto G35)**
```bash
# 1. Download and run installer
curl -fsSL https://raw.githubusercontent.com/onegayunicorn/aether-userland-package/main/install.sh | bash

# 2. Start the orchestrator
aether-start

# 3. Open Firefox in UserLand
firefox http://localhost:3000
```

### **Option 2: Termux (Full Linux Environment)**
```bash
# 1. Install Termux from F-Droid
# 2. Run:
pkg install curl
curl -fsSL https://raw.githubusercontent.com/onegayunicorn/aether-userland-package/main/install.sh | bash

# 3. Start in Termux (port 8080)
aether-start

# 4. Open in browser
termux-open-url http://localhost:8080
```

### **Option 3: Termux + Proot (Full Ubuntu)**
```bash
# 1. Install Termux + proot
pkg install proot proot-distro
proot-distro install ubuntu

# 2. Run installer in proot
proot-distro login ubuntu -- bash -c "curl -fsSL https://raw.githubusercontent.com/onegayunicorn/aether-userland-package/main/install.sh | bash"

# 3. Start in proot Ubuntu
aether-termux
```

---

## **📦 Supported Distributions**

| Distribution | Package Manager | Status       | Notes                          |
|--------------|------------------|--------------|--------------------------------|
| **Ubuntu**    | `apt`            | ✅ Supported  | NodeSource repo for Node.js 20 |
| **Debian**    | `apt`            | ✅ Supported  | Backports enabled              |
| **Kali**      | `apt`            | ✅ Supported  | Full upgrade first             |
| **Arch**      | `pacman`         | ✅ Supported  | `--noconfirm` flag             |
| **Alpine**    | `apk`            | ✅ Supported  | `nodejs-current` for Node.js   |
| **Termux**    | `pkg`            | ✅ Supported  | Proot for full Linux env       |

---

## **🛠️ Features**

### **Core Orchestrator**
- ✅ **Aether Grid Portal** (port 3000 in UserLand, 8080 in Termux)
- ✅ **API Bridge** (FastAPI, sovereign key auth)
- ✅ **Command Execution** (whitelisted commands only)
- ✅ **Health Monitoring** (`/health` endpoint)

### **Toolchain Integration**
| Category       | Tools                                                                 | Status       |
|----------------|-----------------------------------------------------------------------|--------------|
| **Browser**    | Firefox                                                               | ✅ UserLand  |
| **Development**| VSCode, Git, Python, Node.js, npm                                      | ✅ All        |
| **Office**     | LibreOffice, Gnuplot, Octave, R                                       | ✅ UserLand  |
| **Graphics**   | GIMP, Inkscape                                                        | ✅ UserLand  |
| **Games**      | Zork, Adventure (custom)                                              | ✅ All        |

### **Termux-Specific**
- ✅ **Proot Integration** (Full Ubuntu environment)
- ✅ **Termux:API** (Device access: camera, sensors, etc.)
- ✅ **Termux:X11** (GUI apps support)
- ✅ **Wake Lock** (Prevents sleep during operation)
- ✅ **Storage Access** (`termux-setup-storage`)

---

## **📂 Repository Structure**
```
aether-userland-package/
├── install.sh              # Master installer
├── config/
│   ├── alpine.sh           # Alpine setup
│   ├── arch.sh             # Arch setup
│   ├── debian.sh           # Debian setup
│   ├── kali.sh             # Kali setup
│   ├── termux.sh           # Termux setup (NEW!)
│   └── ubuntu.sh           # Ubuntu setup
├── scripts/
│   ├── aether-start.sh     # Start orchestrator
│   ├── aether-stop.sh      # Stop orchestrator
│   ├── aether-status.sh    # Check status
│   ├── aether-logs.sh      # View logs
│   └── aether-update.sh    # Update package
├── tools/
│   ├── browser-setup.sh    # Firefox config
│   ├── dev-setup.sh        # Git/VSCode setup
│   ├── office-setup.sh      # LibreOffice setup
│   ├── graphics-setup.sh   # GIMP/Inkscape setup
│   └── game-setup.sh       # Zork/Adventure setup
├── dotfiles/
│   ├── .bashrc             # Bash aliases
│   ├── .gitconfig          # Git config
│   └── .profile            # Profile settings
├── LICENSE                 # MIT License
└── README.md               # This file
```

---

## **🎯 Commands**

| Command               | Description                                      | Example                          |
|-----------------------|--------------------------------------------------|----------------------------------|
| `aether-start`         | Start orchestrator                               | `aether-start`                   |
| `aether-stop`          | Stop orchestrator                                | `aether-stop`                    |
| `aether-status`        | Check orchestrator status                        | `aether-status`                  |
| `aether-logs`          | View orchestrator logs                           | `aether-logs`                    |
| `aether-bridge`        | Start API bridge (port 8080)                     | `aether-bridge`                  |
| `aether-update`        | Update to latest version                         | `aether-update`                  |
| `aether-termux`        | Start in proot Ubuntu (Termux only)             | `aether-termux`                  |
| `curl :8080/health`    | Check bridge health                               | `curl http://localhost:8080/health` |
| `termux-open-url`     | Open URL in Termux browser                       | `termux-open-url http://localhost:8080` |

---

## **🔧 Configuration**

### **Environment Variables**
| Variable          | Description                          | Default                     |
|------------------|--------------------------------------|-----------------------------|
| `SOVEREIGN_KEY`  | API authentication key                | Random 256-bit hex          |
| `PREFIX`         | Termux prefix directory              | `$PREFIX` (Termux only)     |
| `ENVIRONMENT`    | Runtime environment (userland/termux)| Auto-detected               |

### **Customizing `SOVEREIGN_KEY`**
1. Generate a new key:
   ```bash
   python3 -c "import secrets; print(secrets.token_hex(32))"
   ```
2. Add to `.bashrc`:
   ```bash
   echo 'export SOVEREIGN_KEY="your_256bit_hex_key"' >> ~/.bashrc
   source ~/.bashrc
   ```

---

## **🛡️ Security**
- **Sovereign Key Authentication**: All API commands require a 256-bit key.
- **Command Whitelisting**: Only predefined commands (`status`, `health`, `logs`, etc.) are allowed.
- **No Root Required**: Runs entirely in user space.
- **Proot Isolation**: Termux uses `proot` for full Linux environment without root.

**⚠️ Warning**: For production use, consider:
- Restricting API access to `127.0.0.1`.
- Using HTTPS with self-signed certificates.
- Adding rate limiting.

---

## **📊 Performance Tips**

### **UserLand (Moto G35)**
- **Storage**: UserLand has ~100GB storage. Clean up with:
  ```bash
  rm -f ~/aether-grid/aether.log
  npm cache clean --force
  ```
- **Memory**: Close unused apps to free up RAM.
- **CPU**: Use `htop` to monitor usage.

### **Termux**
- **Proot**: For heavy tasks, use `proot-distro login ubuntu`.
- **Termux:X11**: Install for GUI apps (Firefox, GIMP, etc.).
- **Wake Lock**: Prevent sleep with `termux-wake-lock`.
- **Storage**: Grant storage access with `termux-setup-storage`.

---

## **🐛 Troubleshooting**

| Issue                          | Solution                                      |
|--------------------------------|-----------------------------------------------|
| `install.sh: Permission denied` | `chmod +x install.sh`                         |
| `Port 3000 in use`             | `aether-stop` then `aether-start`             |
| `Node.js not found`            | Re-run installer or check distro config      |
| `Firefox won't open`           | Use `firefox --no-sandbox` (UserLand)         |
| `aether-start: command not found` | `source ~/.bashrc`                          |
| `Termux: proot not found`      | `pkg install proot proot-distro`             |
| `Slow performance`             | Use `proot-distro login ubuntu` for heavy tasks |

### **Debug Mode**
```bash
# Run orchestrator in foreground
cd ~/aether-grid && npm run dev

# Check bridge logs
tail -f ~/orchestrator_bridge.log
```

---

## **📜 License**
This project is licensed under the **MIT License** – see [LICENSE](LICENSE) for details.

---
**🌌 The Fold is now in your pocket. Deploy with sovereignty.**
**— Tyrone J Power Ω, Sovereign Architect**
