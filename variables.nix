rec {
  username = "pitagoras";
  wm = "bspwm";
  bar = "polybar";
  colors = import ./customization/colorschemes/palenight;
  font = "Iosevka Nerd Font";
  shell = "zsh";
  justColors = {
    background = colors.background;
    current_line = colors.current_line;
    foreground = colors.foreground;
    darker-bg = colors.darker-bg;
    lighter-bg = colors.lighter-bg;
    mix-bg-fg = colors.mix-bg-fg;
    comment = colors.comment;
    cyan = colors.cyan;
    green = colors.green;
    orange = colors.orange;
    pink = colors.pink;
    purple = colors.purple;
    red = colors.red;
    yellow = colors.yellow;
  };
}
