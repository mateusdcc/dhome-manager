{ pkgs, lib, ... }:

let
  inherit (builtins) concatLists concatMap attrNames hasAttr typeOf;
  isNix = path:
    let firstLine = builtins.head (builtins.split "\n" path);
    in lib.hasPrefix "--" firstLine && lib.hasSuffix ".lua" firstLine;
  isLua = path: lib.hasSuffix ".lua" path;
  isVim = path: lib.hasSuffix ".vim" path;
  toPlugin = str: pkgs.vimPlugins.${str};
  convertToLua = {
    setToOpts = set:
      let
        keys = attrNames set;
        keysEq = map (k: ''
          ${k} = ${
            if builtins.isBool set.${k} then
              lib.boolToString set.${k}
            else if builtins.isString set.${k} then
              ''"${set.${k}}"''
            else if builtins.isInt set.${k} then
              toString set.${k}
            else
              toString set.${k}
          } 
        '') keys;
      in lib.strings.concatStrings keysEq;

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
  };

  convertToRequire = { string ? "lua.file" }: "require'${string}'";

  createFiles = setList:
    let
      files = map (set:
        let
          fileName = set.filename;
          fileContent = set.config;
        in pkgs.writeText fileName fileContent) setList;
    in files;

  getAllItems = { set, key ? "configs" }:
    let
      topics = attrNames set;
      items = map (topic:
        let subdivisions = attrNames (set.${topic});
        in concatMap (subdivision:
          if hasAttr key set.${topic}.${subdivision} then
            set.${topic}.${subdivision}.${key}
          else
            [ ]) subdivisions) topics;
    in concatLists items;

  getAllSets = { set, key ? "configs" }:
    let
      topics = attrNames set;
      items = map (topic:
        let subdivisions = attrNames (set.${topic});
        in concatMap (subdivision:
          if hasAttr key set.${topic}.${subdivision} then
            [ set.${topic}.${subdivision} ]
          else
            [ ]) subdivisions) topics;
    in concatLists items;

in {
  isLua = isLua;
  isVim = isVim;
  toPlugin = toPlugin;
  getAllItems = getAllItems;
  getAllSets = getAllSets;
  convertToLua = (import ./configs).convertToLua;
  createFiles = createFiles;
  convertToRequire = convertToRequire;
}

