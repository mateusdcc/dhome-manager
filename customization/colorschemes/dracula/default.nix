with import <nixpkgs> { };

{
  gtk = {
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
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
    color_theme = "Dracula";
    package = pkgs.vscode-extensions.dracula-theme.theme-dracula;
  };
  neovim = {
    name = "dracula";
    package = pkgs.vimPlugins.dracula-nvim;
  };
  wallpaper = ./geometry-dracula.png;
  background = "#282a36";
  current_line = "#44475a";
  foreground = "#f8f8f2";
  comment = "#6272a4";
  cyan = "#8be9fd";
  green = "#50fa7b";
  orange = "#ffb86c";
  pink = "#ff79c6";
  purple = "#bd93f9";
  red = "#ff5555";
  yellow = "#f1fa8c";
}

