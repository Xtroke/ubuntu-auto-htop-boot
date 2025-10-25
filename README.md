# 🧠 Ubuntu Auto-Login & htop Boot Script

This repository contains a simple Bash script that automatically logs into your Ubuntu Server console (TTY1) and runs **htop** on boot.

Perfect for home servers, Raspberry Pi, or always-on machines where you want system stats shown instantly.

---

## 🚀 Features
- Auto-login to your chosen user account (via systemd)
- Auto-launch `htop` on the main console (TTY1)
- Safe for SSH — won’t run `htop` when connecting remotely
- Clean and reversible (just remove the systemd override if you wish)

---

## 🧩 Installation

### 1. Clone the repo
```bash
git clone https://github.com/Xtroke/ubuntu-auto-htop-boot.git
cd ubuntu-auto-htop-boot

