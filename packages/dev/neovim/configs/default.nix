let
  pkgs = import <nixpkgs> { };
  lib = pkgs.lib;
  general = import ./general;
  convertToLua = import ./convertToLua { lib = lib; };
in {
  general = general;
  convertToLua = convertToLua;
}
