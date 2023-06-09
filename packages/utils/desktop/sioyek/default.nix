{ pkgs, lib, ... }:

let
  colors = (import ../../../../variables.nix).colors;
  helpers = import ../../../../helpers;
  hexaToDecimal = helpers.string.hexaToDecimal;
  spitHex = h:
    let
      hexWithoutHash = builtins.substring 1 (builtins.stringLength h) h;
      hexChars = lib.strings.stringToCharacters hexWithoutHash;
    in lib.lists.remove null (map (v:
      if lib.trivial.mod v 2 == 1 then
        null
      else
        (builtins.elemAt hexChars v) + (builtins.elemAt hexChars (v + 1)))
      (lib.lists.range 0 (builtins.length hexChars - 1)));

  convertToSioyek = v:
    builtins.concatStringsSep " "
    (map (h: builtins.toString (hexaToDecimal h / 255.0)) (spitHex v));
in {
  programs.sioyek = {
    enable = true;
    config = {
      "background_color" = convertToSioyek colors.background;
      "dark_mode_background_color" = convertToSioyek colors.background;
      "text_hightlight_color" = convertToSioyek colors.current_line;
      "default_dark_mode" = "1";
      "create_table_of_contents_if_not_exists" = "1";
      "max_created_toc_size" = "5000";
      "single_click_selects_words" = "1";
    };
  };
}

