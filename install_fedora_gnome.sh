#!/bin/bash
#
# Script feito por Rafael TOsta com o proposito de automatizar a instalacao personalizada
# do Fedora, a partir de uma INSTALACAO MINIMA da ISO Everything:
#

# Desativando repositórios Modular para updates mais rápidos
dnf config-manager --disable *-modular

# Adicionando repositórios RPM Fusion, Fedora Workstation e Cisco Openh264
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y fedora-workstation-repositories
dnf config-manager -y --set-enabled fedora-cisco-openh264

# Github Desktop
rpm --import https://mirror.mwt.me/ghd/gpgkey
sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://mirror.mwt.me/ghd/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'

#VS Code 
 rpm --import https://packages.microsoft.com/keys/microsoft.asc
 sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#MS Edge (https://packages.microsoft.com/yumrepos/edge/)
 rpm --import https://packages.microsoft.com/keys/microsoft.asc
 dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
 
 # Flatpak
 flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
 
# Instalando o Xorg base (suporte para VGA intel, radeon e nouveau)
dnf install -y @base-x

# Instalando pacote basicos gnome
dnf install gdm gnome-shell gnome-terminal nautilus xdg-user-dirs-gtk gnome-tweaks

# Instalando programas pessoais
dnf install megasync nautilus-megasync telegram-desktop qt6-designer github-desktop microsoft-edge-stable code -y

# Ativando o gdm e definindo como padrão
systemctl enable gdm
systemctl set-default graphical.target

 #Desativa NetworkManager-wait-online.service
 systemctl disable NetworkManager-wait-online.service
