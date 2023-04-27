{ pkgs, ...}:

let
  pow = (import ../math).pow;
  hexDict = {
    "1"= 1;
    "2"= 2;
    "3"= 3;
    "4"= 4;
    "5"= 5;
    "6"= 6;
    "7"= 7;
    "8"= 8;
    "9"= 9;
    "a"= 10;
    "b"= 11;
    "c"= 12;
    "d"= 13;
    "e"= 14;
    "f" = 15;
  };

  lib = pkgs.lib;
  hexaToDecimal = s:
    let
      listOfChars = map (c: lib.strings.toLower c) (lib.strings.stringToCharacters s);
      hexToNum = c: i:
        if i == 0 then hexDict.${c}
        else hexDict.${c} * (pow 16 i);
      value = builtins.foldl' (x: l:
      let
        value = hexToNum l x.x;
      in
        {y = value + x.y; x = x.x + 1;}
        ) {y = 0; x = 0;}
        listOfChars;
    in
      value.y;
in
  hexaToDecimal
