with import <nixpkgs> {};

{
  gtk = {
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    icons = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    cursor = {
      name = "ComixCursors-Opaque-Slim-Black";
      package = pkgs.comixcursors.Opaque_Slim_Black;
    };
  };
  vscode = {
    color_theme = "Gruvbox";
    package = pkgs.vscode-extensions.jdinhlife.gruvbox;
  };
  neovim = {
    name = "gruvbox";
    package = pkgs.vimPlugins.gruvbox-nvim;
  };
  wallpaper = ./gruvbox.png;
  background = "#282828";
  current_line = "#3c3836";
  foreground = "#ebdbb2";
  comment = "#928374";
  cyan = "#8ec07c";
  green = "#b8bb26";
  orange = "#fe8019";
  pink = "#d3869b";
  purple = "#b16286";
  red = "#fb4934";
  yellow = "#fabd2f";
}


