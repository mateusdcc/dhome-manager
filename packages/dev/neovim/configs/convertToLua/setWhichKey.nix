{ lib }:

let
  inherit (builtins) typeOf;
  setWhichKey = set:
    let
      mains = builtins.attrNames set;
      toAppend = map (x:
        let
          mainName = ''
            [${x}] = {
          '';

          isSet = typeOf set.${x} == "set";
          toAppend = if isSet then
            map (z:
              let
                submainName = ''
                  ${z} = {
                '';
                toAppend = map (y:
                  let
                    key = "${y} = ";
                    value = set.${x}.${z}.${y};
                  in if (typeOf value == "string") then
                    ''${y} = "${value}"''
                  else if (typeOf value == "list") then
                    "${y} = { ${
                      lib.concatMapStringsSep "," (a: ''"'' + a + ''"'') value
                    } }"
                  else
                    "${y} = ${value}") (builtins.attrNames set.${x}.${z});
              in "${submainName} ${builtins.concatStringsSep "," toAppend} }")
            (builtins.attrNames set.${x})
          else
            "${lib.concatMapStringsSep "," (l: ''"'' + l + ''"'') set.${x}}}";
        in if isSet then
          "${mainName} ${builtins.concatStringsSep " " toAppend} }"
        else
          "${mainName} ${toAppend}") mains;

      finalString = "${builtins.concatStringsSep "," toAppend}";
    in finalString;
in setWhichKey
