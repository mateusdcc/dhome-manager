{ pkgs, lib, ... }:

let
  vars = import ../../../variables.nix;
  configsNix = import ./configs;
  helpers = (import ./helpers.nix {
    inherit pkgs;
    inherit lib;
  });
  configs = {
    language = {
      nix = {
        plugins = [ "vim-nix" ];
        configs = [ ./lua/example.lua ];
      };
      python = { plugins = [ "coc-python" ]; };
    };
    # ui = { theme = { plugins = [ "gruvbox" ]; }; };
    general = {
      nixOptions = rec {
        filename = "lua/opts.lua";
        config = ''
          -- ${filename}
        '' + (helpers.convertToLua.setToOpts configsNix.general.options);
      };
    };
  };

  pluginsRaw = lib.flatten (helpers.getAllItems {
    set = configs;
    key = "plugins";
  });

  vimPlugins = lib.flatten (map (plugin: helpers.toPlugin plugin) (pluginsRaw));

  luaConfigs = lib.flatten (builtins.filter (path: helpers.isLua path)
    (helpers.getAllItems { set = configs; }));

  vimConfigs = lib.flatten (builtins.filter (path: helpers.isVim path)
    (helpers.getAllItems { set = configs; }));

  nixConfigs = helpers.getAllSets {
    set = configs;
    key = "filename";
  };
  createdFiles = helpers.createFiles nixConfigs;

  luaCreatedImports =
    lib.strings.concatMapStringsSep "\n" (path: "dofile('${path}')")
    createdFiles;

  luaFiles =
    lib.mapAttrs (name: config: pkgs.writeText "${name}.lua" config) nixConfigs;

  headersLuaImportingConfigsFiles =
    lib.strings.concatMapStringsSep "\n" (path: "dofile('${path}')") luaConfigs;

  headersVimImportingConfigsFiles =
    lib.strings.concatMapStringsSep "\n" (path: "source '${path}' ") vimConfigs;

in {
  programs.neovim = {
    enable = true;
    plugins = vimPlugins ++ [ vars.colors.neovim.package ];
    extraLuaConfig = ''

      ${headersLuaImportingConfigsFiles}
      ${luaCreatedImports}
    '';
    extraConfig = ''
      ${headersVimImportingConfigsFiles}
      colorscheme ${vars.colors.neovim.name}
    '';
  };
}
