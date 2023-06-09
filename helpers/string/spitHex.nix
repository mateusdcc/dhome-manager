/* Spit a hex value with a par number of digits in the format: #FFFFFF, into a pair-based list value
    Type: spitHex :: a -> [b]
    Example:
      spitHex "#123456"
      => [ "12" "34" "56" ]
*/

{ pkgs }:

let
  lib = pkgs.lib;
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
in spitHex
