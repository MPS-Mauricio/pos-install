#!/bin/bash

install() {
	echo
	echo "=============================="
	echo "		Atualizando o sistema"
	echo "=============================="
	echo

	sudo pacman -Syyu --noconfirm;

	echo
	echo "=============================="
	echo "    Instação do yay"
	echo "=============================="
	echo

	sudo pacman -S --needed git base-devel go;
	git clone https://aur.archlinux.org/yay.git;
	cd yay;
	makepkg -si;
	cd /tmp;
	rm -rf yay;

	echo
	echo "=============================="
	echo "     Instalando as fontes"
	echo "=============================="
	echo

	sudo pacman -S ttf-d2coding-nerd;

	echo
	echo "=============================="
	echo "		Instalando o Hyprland"
	echo "=============================="
	echo

	sudo pacman -S hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk;

	echo
	echo "=============================="
	echo "		Instalando o Desktop"
	echo "=============================="
	echo

	sudo pacman -S waybar rofi-wayland hyprpaper mako;

	echo
	echo "=============================="
	echo "		Instalando o Terminal"
	echo "=============================="
	echo

	sudo pacman -S alacritty;

	echo
	echo "==============================="
	echo " Instalando o sistema de áudio"
	echo "==============================="
	echo

	sudo pacman -S pipewire pipewire-audio pipewire-pulse wireplumber;

	echo
	echo "==============================="
	echo "		Instalando o Bluetooth"
	echo "==============================="
	echo

	sudo pacman -S bluez bluez-utils blueman;

	sudo systemctl enable --now bluetooth;

}

uninstall() {
	echo
	echo "=============================="
	echo "    Desabilitando Bluetooth"
	echo "=============================="
	echo

	sudo systemctl disable --now bluetooth

	echo
	echo "=============================="
	echo "      Removendo Bluetooth"
	echo "=============================="
	echo

	sudo pacman -Rns --noconfirm bluez bluez-utils blueman

	echo
	echo "==============================="
	echo "    Removendo sistema de áudio"
	echo "==============================="
	echo

	sudo pacman -Rns --noconfirm \
		pipewire \
		pipewire-audio \
		pipewire-pulse \
		wireplumber

	echo
	echo "=============================="
	echo "      Removendo Terminal"
	echo "=============================="
	echo

	sudo pacman -Rns --noconfirm alacritty

	echo
	echo "=============================="
	echo "       Removendo Desktop"
	echo "=============================="
	echo

	sudo pacman -Rns --noconfirm \
		waybar \
		rofi-wayland \
		hyprpaper \
		mako

	echo
	echo "=============================="
	echo "       Removendo Hyprland"
	echo "=============================="
	echo

	sudo pacman -Rns --noconfirm \
		hyprland \
		xdg-desktop-portal-hyprland \
		xdg-desktop-portal-gtk

	echo
	echo "=============================="
	echo "       Removendo fontes"
	echo "=============================="
	echo

	sudo pacman -Rns --noconfirm ttf-d2coding-nerd

	echo
	echo "=============================="
	echo "         Removendo yay"
	echo "=============================="
	echo

	sudo pacman -Rns --noconfirm yay
	rm -rf ~/.cache/yay

	echo
	echo "=============================="
	echo "      Desinstalação concluída"
	echo "=============================="
	echo
}

echo "=============================="
echo "     Arch Linux - Pós-Install"
echo "=============================="
echo
echo "1) Instalar"
echo "2) Desinstalar"
echo "3) Sair"
echo

read -rp "Escolha uma opção: " opcao

case "$opcao" in
    1)
        echo "Modo: Instalação"
        install
        ;;
    2)
        echo "Modo: Desinstalação"
        uninstall
        ;;
    3)
        echo "Saindo..."
        exit 0
        ;;
    *)
        echo "Opção inválida."
        exit 1
        ;;
esac
