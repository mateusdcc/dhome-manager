{pkgs, ...}:

let
  colors = (import ../../../../variables.nix).colors;
in
{
  xdg.configFile."jgmenu/jgmenurc".text = ''
    stay_alive           = 1
    tint2_look           = 0
    position_mode        = fixed
    terminal_exec        = termite
    terminal_args        = -e
    menu_width           = 200
    menu_padding_top     = 10
    menu_padding_right   = 2
    menu_padding_bottom  = 5
    menu_padding_left    = 2
    menu_radius          = 0
    menu_border          = 1
    menu_halign          = left
    sub_hover_action     = 1
    item_margin_y        = 5
    item_height          = 30
    item_padding_x       = 8
    item_radius          = 0
    item_border          = 0
    sep_height           = 5
    font                 = Ubuntu 12px
    icon_size            = 24
    color_menu_bg        = ${colors.background} 100
    color_norm_bg        = ${colors.comment}b 0
    color_norm_fg        = ${colors.foreground} 100
    color_sel_bg         = ${colors.current_line} 60
    color_sel_fg         = ${colors.foreground} 100
    color_sep_fg         = ${colors.comment} 40
  '';
}

