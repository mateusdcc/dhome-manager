{ pkgs, config, ... }:

let
  lib = pkgs.lib;
  vars = (import ../../../variables.nix);
  colors = vars.colors;
  polybar = (if vars.bar == "polybar" then
    "(sleep 0.5; polybar) & sleep 1; killall polybar; polybar"
  else
    "");
in {
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 2;
      window_gap = 4;
      top_padding = 0;
      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;

      normal_border_color = colors.background;
      active_border_color = colors.mix-bg-fg;
      focused_border_color = colors.foreground;
    };
    rules = {
      Eww = {
        border = false;
        state = "floating";
        focus = false;
        manage = true;
        #locked = true;
        #sticky = true;
        rectangle = "0x0+1366+60";
      };
    };
    startupPrograms = [ 
    "sxhkd" 
    ''
      bspc subscribe node_state | while read -r _ _ _ _ state flag; do
        if [[ "$state" != fullscreen ]]; then continue; fi
        if [[ "$flag" == on ]]; then
          xdotool search --class Eww windowunmap
        else
          xdotool search --class Eww windowmap
        fi
      done''
    polybar
    "sleep 5; killall polybar"
    "alacritty"
    "sleep 2; eww open bar"
    ];
    extraConfigEarly =
      "\n      bspc monitor -d 1 2 3 4 5 6 7 8 9 10\n    ";
  };

  imports = [ ../sxhkd ];
}
