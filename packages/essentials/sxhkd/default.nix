{ pkgs, configs, ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "alacritty";
      "super + shift + s" = "flameshot gui";
      "super + p" = "jgmenu_run";
      "super + b" = "firefox";
      "super + l" = "firefox --private-window";
      "super + x" = "betterlockscreen -l";
      "super + v" = "(betterlockscreen -l) & (sleep 3; systemctl suspend)";
      "XF86AudioRaiseVolume" = "amixer set Master 5%+; eww update audio={}";
      "XF86AudioLowerVolume" = "amixer set Master 5%-";
      "super + shift + {e,r}" = "bspc {quit,wm -r}";
      "super + m" = "bspc desktop -l next";
      "super + {t,shift + t,s,f}" =
        "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
      "super + {_,shift +}{Left,Down,Up,Right}" =
        "bspc node -{f,s} {west,south,north,east}";
      "super + shift + {d,a}" = "bspc node -d {next,prev}";
      "super + {d,a}" = "bspc desktop --focus {next,prev}";
      "super + g" = "bspc node -s biggest.window";
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + ctrl + {Left,Down,Up,Right}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "XF86Search" = ''
        xrandr --output eDP-1 --brightness $(echo "$(xrandr --verbose | grep -m 1 'Brightness:' | cut -f2 -d ' ') + 0.1" | bc)'';
      "XF86Explorer" = ''
        xrandr --output eDP-1 --brightness $(echo "$(xrandr --verbose | grep -m 1 'Brightness:' | cut -f2 -d ' ') - 0.1" | bc)'';
      "super + shift + q" = "bspc node -c";
    };
  };
}
