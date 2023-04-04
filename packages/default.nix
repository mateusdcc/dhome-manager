{ pkgs, config, ... }:

let
  vars = import ../variables.nix;
  # Fonts
  fonts = {
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" ]; }) ];
  };

  # Development Tools
  dev = {
    packages = with pkgs; [
      keepassxc
      neovim
      python3
      vim
      git
      gh
      vscode
      nixbang # Specify dependencies inside of a script
      nixfmt # Format nix files
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
      killall
      xclip
      wget
      xorg.xev
      bc
      flameshot
      jgmenu
      dconf
      appimage-run
      betterlockscreen
      unzip
      gnome.nautilus
      mupdf
      tdesktop
      zathura
    ];
    config = import ./utils;
  };

  essentials = {
    packages = with pkgs; [ bspwm sxhkd zsh pure-prompt ];
    config = import ./essentials;
  };

  customizations = {
    packages = with pkgs; [ picom ];
    config = import ./customizations;
  };

  # Combine all packages and configuration files
  packages = with pkgs; [
    fonts.packages
    dev.packages
    productivity.packages
    utils.packages
    customizations.packages
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
