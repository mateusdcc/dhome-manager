{ config, pkgs, ... }:


let
  vars = import ../variables.nix;
  colors = vars.colors;
in
{
  imports = [ ./gtk ];

  news.display = "notify";
  home.sessionVariables = { EDITOR = "nvim"; };
  home.file.".background-image".source = colors.wallpaper;
}
