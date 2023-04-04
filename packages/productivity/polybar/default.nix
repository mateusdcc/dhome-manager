{config, pkgs, ...}:

let
  vars = import ../../../variables.nix;
  colors = vars.colors;
in
{
  services.polybar = {
    enable = true;
    script = "pkill polybar\npolybar -r main";
    #config = ./polybar.config;
    config = {
      "bar/main" = {
        height = 32;
        foreground = colors.foreground;
        background = colors.background;
        border-size = 0;
        border-color = colors.foreground;
        offset-y = 0;
        module-margin-right = 1;
        module-margin-left = 1;
        font-0 = "${vars.font}:size=8;3";
        wm-restack = (if vars.wm == "bspwm" then "bspwm" else "");
        tray-position = "center";
        tray-detached = false;
        tray-padding = 03;
        modules-left = "space bracket_left workspaces bracket_right bracket_left fs-root cpu bracket_right";
        modules-right = "bracket_left title bracket_right bracket_left audio date battery xkeyboard bracket_right space";
      };
      "module/space" = {
        type = "custom/text";
        content = " ";
      };
      "module/bracket_left" = {
        type = "custom/text";
        content = "\"[\"";
      };
      "module/bracket_right" = {
        type = "custom/text";
        content = "\"]\"";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = "0.5";
        warn-percentage = 95;
        label = "CPU: %percentage%";
      };
      "module/fs-base" = {
        type = "internal/fs";
        fixed-values = "true";
        label-mounted = "%mountpoint%: %free%";
      };
      "module/fs-root" = {
        type = "internal/fs";
        fixed-values = "true";
        mount-0 = "/";
        label-mounted = "ROOT: %free%";
      };
      "module/title" = {
        type = "internal/xwindow";
        label-maxlen = 50;
        label-empty = "Empty";
      };
      "module/battery" = {
        type = "internal/battery";
        full-at = 98;
        low-at = 15;
        battery = "BAT0";
        adapter = "ADP0";
        poll-interval = 5;
        format-charging = "<label-charging>";
        format-discharging = "<label-discharging>";
        label-charging = "%percentage%%+";
        label-discharging = "%percentage%%-";
      };
      "module/workspaces" = {
        type = "internal/xworkspaces";
        label-active = "I";
        label-active-foreground = colors.foreground;
        label-occupied = "X";
        label-occupied-foreground = colors.comment;
        label-empty = "V";
        label-empty-foreground = colors.current_line;
        label-active-padding = 1;
        label-occupied-padding = 1;
        label-empty-padding = 1;
      };
      "module/xkeyboard" = {
          type = "internal/xkeyboard";
          blacklist-0 = "num lock";
          blacklist-1 = "scroll lock";
      };
        
      "module/wireless-network" = {
        type = "internal/network";
        interface = "wlp0s20f3";
      };
        
      "module/date" = {
        type = "internal/date";
        date = "%H:%M";
      };

      "module/audio" = {
        type = "internal/alsa";
        master-mixer = "Master";
        interval = 5;
      };
    };
  };
}
