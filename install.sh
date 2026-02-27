#!/bin/bash

set -e

echo "=============================="
echo " KO-IL Arch Template Installer"
echo "=============================="

# 更新系统
echo "[1/8] Updating system..."
sudo pacman -Syu --noconfirm

# 安装基础工具
echo "[2/8] Installing base tools..."
sudo pacman -S --needed base-devel git curl wget --noconfirm

# 安装官方仓库软件
echo "[3/8] Installing official packages..."
sudo pacman -S --needed - < pkglist.txt

# 安装 yay
if ! command -v yay &> /dev/null
then
    echo "[4/8] Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

# 安装 AUR 软件
echo "[5/8] Installing AUR packages..."
yay -S --needed - < aurlist.txt

# 创建配置目录
echo "[6/8] Linking dotfiles..."
mkdir -p ~/.config

ln -sf ~/hypr-dotfiles/hypr ~/.config/hypr
ln -sf ~/hypr-dotfiles/waybar ~/.config/waybar
ln -sf ~/hypr-dotfiles/rofi ~/.config/rofi
ln -sf ~/hypr-dotfiles/kitty ~/.config/kitty

# 字体刷新
echo "[7/8] Refreshing fonts..."
fc-cache -fv || true

# 启用常见 user 服务（可扩展）
echo "[8/8] Enabling user services..."
systemctl --user daemon-reload || true

echo "=============================="
echo " Setup Complete!"
echo " Reboot recommended."
echo "=============================="
