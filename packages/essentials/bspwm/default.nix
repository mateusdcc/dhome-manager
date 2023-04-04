{ pkgs, config, ... }:

let
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
      border_width = 1;
      window_gap = 4;
      top_padding = 0;
      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;

      normal_border_color = colors.background;
      active_border_color = colors.comment;
      focused_border_color = colors.foreground;
    };
    startupPrograms = [ "sxhkd" polybar ];
    extraConfigEarly =
      "\n      bspc monitor -d I II III IV V VI VII VIII IX X\n    ";
  };

  imports = [ ../sxhkd ];
}
