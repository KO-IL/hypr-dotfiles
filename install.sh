#!/bin/bash

echo "=== Arch Hyprland Auto Setup ==="

# 更新系统
sudo pacman -Syu --noconfirm

# 安装基础开发工具
sudo pacman -S --needed base-devel git --noconfirm

# 安装 pacman 包
echo "Installing official packages..."
sudo pacman -S --needed - < pkglist.txt

# 安装 yay（如果不存在）
if ! command -v yay &> /dev/null
then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

# 安装 AUR 包
echo "Installing AUR packages..."
yay -S --needed - < aurlist.txt

# 创建配置目录
mkdir -p ~/.config

# 软链接配置
echo "Linking dotfiles..."
ln -sf ~/dotfiles/hypr ~/.config/hypr
ln -sf ~/dotfiles/waybar ~/.config/waybar
ln -sf ~/dotfiles/rofi ~/.config/rofi
ln -sf ~/dotfiles/kitty ~/.config/kitty

echo "=== Setup Complete ==="
