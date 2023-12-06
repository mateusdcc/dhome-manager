with import <nixpkgs> { };

{
  gtk = {
    theme = {
      name = "Oceanic";
      package = pkgs.oceanic-theme;
    };
    icons = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursor = {
      name = "Capitaine Cursors (Nord) - White";
      package = pkgs.capitaine-cursors-themed;
    };
  };
  vscode = {
    color_theme = "Dracula"; # dnc for vscode to be honest, when I start using it again I will configure all those bruh color themes
    package = pkgs.vscode-extensions.dracula-theme.theme-dracula;
  };
  neovim = {
    name = "oceanic_material";
    package = pkgs.vimPlugins.oceanic-material;
  };
  wallpaper = {
    generate = true;
    # source = ./;
    mode = "fill";
  };
  background = "#2b3b4e";
  current_line = "#475971";
  foreground = "#C0C5CE";
  comment = "#546E7A";
  cyan = "#46D9FF";
  green = "#A2CCB6";
  orange = "#FFB07C";
  pink = "#FF75A0";
  purple = "#C3A6FF";
  red = "#FF3333";
  yellow = "#D7AC6D";
}

