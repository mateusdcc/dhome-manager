{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    #fadeDelta = 20;
    fadeSteps = [ 5.0e-2 5.0e-2 ];
    shadow = false;
    shadowOpacity = 0.2;
    shadowOffsets = [ 0 0 ];
    vSync = true;
  };
}
