{ lib }:

let
  inherit (builtins) isBool isInt isString attrNames;
  setToOpts = set:
    let
      keys = attrNames set;
      keysEq = map (k: ''
        ${k} = ${
          if isBool set.${k} then
            lib.boolToString set.${k}
          else if isString set.${k} then
            ''"${set.${k}}"''
          else if isInt set.${k} then
            toString set.${k}
          else
            toString set.${k}
        } 
      '') keys;
    in lib.strings.concatStrings keysEq;
in setToOpts
