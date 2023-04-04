{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    #fadeDelta = 20;
    fadeSteps = [
      0.05
      0.05
    ];
    shadow = false;
    shadowOpacity = 0.2;
    shadowOffsets = [
      0
      0
    ];
    vSync = true;
  };
}
