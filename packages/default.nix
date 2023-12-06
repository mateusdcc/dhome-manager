{ pkgs, config, ... }:

let
  vars = import ../variables.nix;
  shellScripts = import ./shell { pkgs = pkgs; };

  # Shell packages
  shellPackages = with pkgs; [ shellScripts.organizeFiles ];

  # Node Packages
  extraNodePackages = import ./node {};

  # Fonts
  fonts = {
   packages = with pkgs;
     [ (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" "CascadiaCode" ]; }) ];
  };

  # Development Tools
  dev = {
    packages = with pkgs; [
      python3
      rustup
      vim
      git
      gh
      vscode
      projectlibre
      geogebra6 # Don't be a moron, software development is pure math.
      nixbang # Specify dependencies inside of a script
      nixfmt
      texlive.combined.scheme-full
      node2nix
      nodejs
    ];
    config = import ./dev;
  };

  # Productivity Applications
  productivity = {
    packages = with pkgs; [ alacritty dmenu polybar picom pure-prompt xournal kdenlive eww todo];
    config = import ./productivity;
  };

  # System Utilities
  utils = {
    packages = with pkgs; [
      gnome.gnome-keyring
      gnome.libgnome-keyring
      killall
      xclip
      htop
      vlc
      mpv
      ffmpeg
      wget
      xorg.xev
      xorg.xkill
      xdotool
      bc
      unzip
      keepassxc
      rclone
      anki-bin
      lame
    ];
    config = import ./utils;
  };

  # Desktop specific utils
  desktop = {
    packages = with pkgs; [ flameshot jgmenu dconf feh betterlockscreen ];
  };

  messaging = { packages = with pkgs; [ tdesktop ]; };

  media = { packages = with pkgs; [ vlc xfce.thunar transmission-gtk ]; };

  office = {
    packages = with pkgs; [ 
    zathura
    okular /* okular for epub reading */ 
    libreoffice
    drawing
    mupdf
    abiword
    sioyek
    (obsidian.overrideAttrs {version="1.4.16";})
  ];
};

  others = { packages = with pkgs; [ blender ]; };

  essentials = {
    packages = with pkgs; [ bspwm pulseaudio sxhkd zsh pure-prompt firefox gcc inotify-tools dunst libnotify];
    config = import ./essentials;
  };

  customizations = {
    packages = with pkgs; [ picom lxappearance pavucontrol ];
    config = import ./customizations;
  };

  # Combine all packages and configuration files
  packages = with pkgs; [
    shellPackages
    fonts.packages
    dev.packages
    productivity.packages
    customizations.packages
    office.packages
    others.packages
    # Utilities
    utils.packages
    desktop.packages
    media.packages
    messaging.packages
  ];

  configFiles = [
    dev.config
    productivity.config
    utils.config
    essentials.config
    customizations.config
  ];
in {
  imports = configFiles;
  home.packages = builtins.concatLists packages;
}
