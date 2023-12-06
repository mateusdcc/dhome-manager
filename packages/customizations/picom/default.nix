{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    fadeExclude = ["class_g = 'Eww'"];
    fadeSteps = [ 5.0e-2 5.0e-2 ];
    shadow = false;
    shadowOpacity = 0.2;
    shadowOffsets = [ 0 0 ];
    vSync = true;
  };
}
