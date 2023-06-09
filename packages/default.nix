{ pkgs, config, ... }:

let
  vars = import ../variables.nix;
  shellScripts = import ./shell { pkgs = pkgs; };

  # Shell packages
  shellPackages = with pkgs; [ shellScripts.organizeFiles ];

  # Fonts
  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" ]; }) ];
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
    ];
    config = import ./dev;
  };

  # Productivity Applications
  productivity = {
    packages = with pkgs; [ alacritty dmenu polybar picom pure-prompt xournal ];
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
      ffmpeg
      wget
      xorg.xev
      bc
      unzip
      keepassxc
    ];
    config = import ./utils;
  };

  # Desktop specific utils
  desktop = {
    packages = with pkgs; [ flameshot jgmenu dconf feh betterlockscreen ];
  };

  messaging = { packages = with pkgs; [ tdesktop ]; };

  media = { packages = with pkgs; [ vlc xfce.thunar ]; };

  office = {
    packages = with pkgs; [ zathura libreoffice drawing mupdf abiword sioyek ];
  };

  others = { packages = with pkgs; [ grapejuice ]; };

  essentials = {
    packages = with pkgs; [ bspwm sxhkd zsh pure-prompt firefox gcc ];
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
  home.packages = builtins.concatLists packages;
  imports = configFiles;
}
