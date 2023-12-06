with import <nixpkgs> { };

{
  gtk = {
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    icons = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursor = {
      name = "Capitaine Cursors (Palenight)";
      package = pkgs.capitaine-cursors-themed;
    };
  };
  vscode = {
    color_theme = "Dracula"; # Gonna set one for palenight later
    package = pkgs.vscode-extensions.dracula-theme.theme-dracula;
  };
  neovim = {
    name = "palenight";
    package = pkgs.vimPlugins.palenight-vim;
  };
  wallpaper = {
    generate = true;
    # source = ./;
    mode = "fill";
  };
  background = "#292D3E";
  current_line = "#444267";
  foreground = "#A6ACCD";
  darker-bg = "#1E2134";
  lighter-bg = "#363A52";
  mix-bg-fg = "#697897";
  comment = "#6B7394";
  cyan = "#44B9B1";
  green = "#91B362";
  orange = "#D4A45D";
  pink = "#C678DD";
  purple = "#7E62B3";
  red = "#E95678";
  yellow = "#EFA055";
}

