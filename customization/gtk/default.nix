{ configs, pkgs, ... }:

let
  vars = import ../../variables.nix;
  vgtk = vars.colors.gtk;
  gtkFilePrefix = "file:///home/${vars.username}/";
  bookmarks = [ "/Downloads" "/Documents" "/Projects" "/Books" "/.config" ];
in
{
  gtk = {
    enable = true;
    font = {
      name = vars.font;
      size = 8;
    };
    iconTheme = {
      name = vgtk.icons.name;
      package = vgtk.icons.package;
    };
    theme = {
      name = vgtk.theme.name;
      package = vgtk.theme.package;
    };
    cursorTheme = {
      name = vgtk.cursor.name;
      package = vgtk.cursor.package;
    };
    gtk3 = {
      bookmarks = map (b: "${gtkFilePrefix}${b}") bookmarks;
    };
  };
}
        
