{ config, pkgs, ... }:

let vars = import ./variables.nix;
in {
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "22.11";


  imports = [ ./packages ./customization ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-14.2.9"];
  news.display = "notify";

  programs.home-manager.enable = true;
}
