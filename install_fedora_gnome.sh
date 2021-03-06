#!/bin/bash
#
# Script feito por Rafael TOsta com o proposito de automatizar a instalacao personalizada
# do Fedora, a partir de uma INSTALACAO MINIMA da ISO Everything:
#

#Sincronizando o repositório
# sudo dnf install git
# git clone http://github.com/rafatosta/fedora_gnome_minimal

# Desativando repositórios Modular para updates mais rápidos
dnf config-manager --disable *-modular

# Adicionando repositórios RPM Fusion, Fedora Workstation e Cisco Openh264
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install -y fedora-workstation-repositories
dnf config-manager -y --set-enabled fedora-cisco-openh264

# Github Desktop (repo quebrado)
rpm --import https://mirror.mwt.me/ghd/gpgkey
sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://mirror.mwt.me/ghd/rpm\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://mirror.mwt.me/ghd/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'

#VS Code 
 rpm --import https://packages.microsoft.com/keys/microsoft.asc
 sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#MS Edge (https://packages.microsoft.com/yumrepos/edge/)
 rpm --import https://packages.microsoft.com/keys/microsoft.asc
 dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
 
 # Flatpak
 dnf install flatpak
 flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
 
# Instalando o Xorg base (suporte para VGA intel, radeon e nouveau)
dnf install -y @base-x

# Instalando pacote básicos gnome
dnf install -y gdm gnome-shell gnome-console gnome-console-nautilus nautilus xdg-user-dirs-gtk gnome-tweaks

# Aplicativos Qt com o Adwaita
#dnf install adwaita-qt5 adwaita-qt6 

# Instalando programas pessoais
dnf install -y megasync nautilus-megasync telegram-desktop qt6-designer github-desktop microsoft-edge-stable code gnome-text-editor evince gnome-system-monitor gnome-clocks gnome-calendar gnome-calculator gnome-disk-utility

# SceneBuild
dnf install https://download2.gluonhq.com/scenebuilder/18.0.0/install/linux/SceneBuilder-18.0.0.rpm

# Apps em flatpak
flatpak install -y com.rtosta.zapzap com.mattjakeman.ExtensionManager com.stremio.Stremio org.videolan.VLC org.eclipse.Java org.gnome.Solanum org.libreoffice.LibreOffice

# Ativando o gdm e definindo como padrão
systemctl enable gdm
systemctl set-default graphical.target

 #Desativa NetworkManager-wait-online.service
 systemctl disable NetworkManager-wait-online.service
 
 # Desativa o repo intermediário do Edge
 dnf config-manager --set-disable packages.microsoft.com_yumrepos_edge

# Esconde o grub
# edite o timeout em /etc/default/grub
# execute: sudo grub2-mkconfig -o /boot/grub2/grub.cfg


 # Reinicia a máquina
 #reboot
