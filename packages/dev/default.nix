{ pkgs, ... }:

let vars = import ../variables.nix;
in { imports = [ ./git ./vscode ]; }

