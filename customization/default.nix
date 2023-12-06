{ config, pkgs, ... }:


let
  lib = pkgs.lib;
  vars = import ../variables.nix;
  colors = vars.colors;
  bg = import ./wallpaper {pkgs = pkgs; type = "gradient";};
  gradient = import ./wallpaper {pkgs = pkgs; type = "gradient";};
  toCss = set:
    let
      recursiveNew = lib.attrsets.mapAttrsRecursive (path: value: "\t--" + (builtins.concatStringsSep "-" path) + ": ${value};") set;
    in
      lib.attrsets.collect builtins.isString recursiveNew
  ; 
  toSass = set:
    let
      recursiveNew = lib.attrsets.mapAttrsRecursive (path: value: "$" + (builtins.concatStringsSep "-" path) + ": ${value};") set;
    in
      lib.attrsets.collect builtins.isString recursiveNew
  ; 
  cssColors = lib.strings.concatStringsSep "\n" (toCss vars.justColors);
  scssColors = lib.strings.concatStringsSep "\n" (toSass vars.justColors);
in
{
  imports = [ ./gtk ];

  news.display = "notify";
  home.sessionVariables = { EDITOR = "nvim"; };
  nixpkgs.config.services.xserver.desktopManager.wallpaper.mode = (
    if (colors.wallpaper.generate) then "tile"
    else colors.wallpaper.mode
  );
  home.file.".background-image".source = (
    if (colors.wallpaper.generate) then
      bg.outPath + "/bg.png"
    else colors.wallpaper.source
  );
  home.file.".gradient-image".source = gradient.outPath + "/bg.png";

  home.file.".colors.css".text = ":root {\n${cssColors}\n}";
  home.file.".colors.scss".text = "${scssColors}";

  fonts.fontconfig.enable = true;
}
