{ config, pkgs, lib, ... }:

let vars = import ./variables.nix;
in {
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  home.stateVersion = "22.11";
  #home.activation = {
  #myActivationAction = lib.hm.dag.entryBefore ["writeBoundary"] ''
  #      echo "Please enter your preference: "
  #      read preference

  #      # Use the user's input
  #      echo "You entered: $preference"
  #'';
  #};

  imports = [ ./packages ./customization ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-14.2.9" "nodejs-14.21.3"];
  news.display = "notify";

  programs.home-manager.enable = true;
}
