{ config, pkgs, ... }:

{
  imports = [
    ./gtk
  ];

  news.display = "notify";
  home.file.".background-image".source = ./images/geometry-dracula.png;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
