#!/bin/bash
# Auto-login and auto-run htop at boot (Ubuntu Server)
# Author: Xtroke
# GitHub: https://github.com/Xtroke/ubuntu-auto-htop-boot

# --- 1. Check if running as root ---
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo bash auto-htop-boot.sh)"
  exit
fi

read -p "Enter your Ubuntu username: " USERNAME

# --- 2. Enable automatic console login ---
echo "[INFO] Enabling auto-login for $USERNAME on tty1..."
mkdir -p /etc/systemd/system/getty@tty1.service.d
cat > /etc/systemd/system/getty@tty1.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USERNAME --noclear %I \$TERM
EOF

# --- 3. Add htop autostart to .bash_profile ---
USER_HOME=$(eval echo "~$USERNAME")
BASH_PROFILE="$USER_HOME/.bash_profile"

echo "[INFO] Adding htop autostart to $BASH_PROFILE..."
cat >> "$BASH_PROFILE" <<'EOF'

# --- Auto-run htop only on tty1 ---
if [[ $(tty) == /dev/tty1 ]]; then
    clear
    echo "Starting htop automatically..."
    sleep 1
    htop
fi
EOF

# --- 4. Reload systemd ---
echo "[INFO] Reloading systemd and restarting getty..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl restart getty@tty1

echo
echo "✅ Setup complete!"
echo "Your system will now auto-login as '$USERNAME' and launch htop automatically on boot (only on TTY1)."
echo
echo "Test it by running: sudo reboot"
