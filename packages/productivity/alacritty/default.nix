{ pkgs, ... }:

let
  vars = import ../../../variables.nix;
  colors = vars.colors;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = colors.background;
          foreground = colors.foreground;
        };
        normal = {
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          cyan = colors.cyan;
        };
      };
      font = {
        normal.family = vars.font;
        size = 8;
      };
      shell = vars.shell;
    };
  };
}
      
