{config, pkgs, ...}:
let
  justColors = (import ../../../variables.nix).justColors;
  enable = true;
  lib = pkgs.lib;
  vars = {
    "time" = {
      "visible" = "true";
    };
  };
  newRecColors = set:
    let
      recursiveNew = lib.attrsets.mapAttrsRecursive (path: value: "(defvar " + (builtins.concatStringsSep "-" path) + " \"${value}\")") set;
    in
      lib.attrsets.collect builtins.isString recursiveNew
  ; 
  newRec = set:
    let
      recursiveNew = lib.attrsets.mapAttrsRecursive (path: value: "(defvar " + (builtins.concatStringsSep "-" path) + " ${value})") set;
    in
      lib.attrsets.collect builtins.isString recursiveNew
  ; 
  formattedString = lib.strings.concatStringsSep "\n" (newRecColors justColors);
in
  {
    programs.eww = {
      enable = enable;
      configDir = ./config;
    };
    home.file."vars" = {
      enable = enable;
      target = ".vars.yuck";
      text = formattedString;
    };
}
