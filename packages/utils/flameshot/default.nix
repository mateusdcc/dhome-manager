{ pkgs, ... }:

{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        uploadHistoryMax = 2;
      };
    };
  };
}
