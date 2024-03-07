# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      ./home-manager/home.nix
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master") 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.udisks2.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.upower.enable = true;
  services.vscode-server.enable = true;

  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 70;

      };
}; 

  # Configure keymap in X11
  services.xserver = {
    layout = "us ru";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nothing = {
    isNormalUser = true;
    description = "nothing";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker"];
    packages = with pkgs; [];
  };

  users.extraGroups.docker.members = [ "nothing" ];

  # Enable automatic login for the user.
  services.getty.autologinUser = "nothing";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.blueman.enable = true;

#  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  services.flatpak.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  git
  kitty
  neofetch
  microsoft-edge
  #xfce.thunar
  #xfce.thunar-archive-plugin
  #vscodium
  xarchiver
  p7zip
  xorg.xhost
  python3
  jetbrains.pycharm-professional
  pulseaudioFull
  discord
  telegram-desktop  
  blueman
  grimblast
  cava
  cmatrix
  wl-clipboard
  wl-clip-persist
  cliphist
  xfce.xfce4-battery-plugin
  pipx
  upower  
  lxqt.lxqt-powermanagement
  libimobiledevice
  libsForQt5.dolphin
  libsForQt5.ark
  libsForQt5.kio-extras
  swww  
  deepin.udisks2-qt5
  libsForQt5.full
  udisks
  qt6.full
  xdg-utils
  handlr
  vscode
  codeium
  waypaper  
  wofi
  openvpn
  networkmanager
  networkmanagerapplet
  pptp
  pptpd
  ppp
  libgcc
  libstdcxx5
  networkmanager-l2tp
  flatpak
  openssl
  python311Packages.cmake
  gcc-unwrapped
  docker



  

  #conf
  # hyprland
  # pipewire
  # ripgrep
  # playerctl
  # gradience
  # adw-gtk3
  # polkit_gnome
  # swww
  # gtklock
  # pamixer
  # grimblast
  # gnome.gnome-control-center
  # gnome.file-roller
  # xdg-user-dirs
  # wf-recorder
  # python311Packages.dbus-python
  # python311Packages.pygobject3
  # python311Packages.requests_ntlm
#  python3.11-j2cli
#  python311Packages.material-color-utilities
  # gnome.zenity
  # socat
  # hyprpicker
  # eww-wayland
  # glib
  # plank

  # home-manager

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
# ya togo rot ebal

  hyprland
  waybar
  rofi
  dunst
  swaybg
  swaylock-fancy
  swayidle
  pamixer
  light
  brillo

  ];

  
  
  
 

 
#  environment.variables.XDG_DATA_DIRS = [ "${pkgs.plank}/share/gsettings-schemas/${pkgs.plank.name}" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.hyprland.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
