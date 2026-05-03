#!/bin/bash

set -ouex pipefail

### Install packages
# Fonts
dnf5 install -y rsms-inter-fonts fira-code-fonts

# Icons, themes, etc.
dnf5 -y install papirus-icon-theme

# Dev Tools
dnf5 -y install @virtualization
dnf5 -y install helix
dnf5 -y install podman-compose container-selinux
dnf5 -y install kitty

# System Utilities
dnf5 -y install gparted bluez fastfetch zsh

# Install Sublime HQ GPG key to facilitate install of Sublime Text, Sublime Merge.
# Enable Sublime Text and Sublime Merge repo, but do not install either by default.
wget https://download.sublimetext.com/sublimehq-rpm-pub.gpg -O /etc/pki/rpm-gpg
dnf5 -y config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# Enable Tailscale GPG key to facilitate install of Tailscale, but do not install Tailscale by default.
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# Enable RPMFusion
dnf5 -y install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf5 config-manager setopt fedora-cisco-openh264.enabled=1

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File
systemctl enable podman.socket
systemctl enable libvirtd
systemctl enable bluetooth
