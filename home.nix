{ config, pkgs, ... }:

let vars = import ./variables.nix;
in {
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "22.11";

  imports = [ ./packages ./customization ];

  nixpkgs.config.allowUnfree = true;
  news.display = "notify";

  programs.home-manager.enable = true;
}
