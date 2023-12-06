with import <nixpkgs> {};

{
  gtk = {
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    icons = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursor = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
    };
  };
  vscode = {
    color_theme = "Nord";
    package = pkgs.vscode-extensions.arcticicestudio.nord-visual-studio-code;
  };
  neovim = {
    name = "nord";
    package = pkgs.vimPlugins.nord-nvim;
  };
  wallpaper = {
    generate = false;
    source = ./nord.png;
    mode = "fill";
  };
  background = "#2E3440";
  current_line = "#3B4252";
  foreground = "#D8DEE9";
  comment = "#4C566A";
  cyan = "#88C0D0";
  green = "#A3BE8C";
  orange = "#D08770";
  pink = "#B48EAD";
  purple = "#5E81AC";
  red = "#BF616A";
  yellow = "#EBCB8B";
}


