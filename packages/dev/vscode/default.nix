{ pkgs, ... }:

let
  vars = import ../../../variables.nix;
  vscode = vars.colors.vscode;
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      pkief.material-icon-theme
      matklad.rust-analyzer
      arrterian.nix-env-selector
      bbenoist.nix
      brettm12345.nixfmt-vscode
      tomoki1207.pdf
    ] ++ [ vscode.package ];
    userSettings = {
      "workbench.colorTheme" = vscode.color_theme;
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontSize" = 12;
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "window.zoomLevel" = -1;
    };
  };
}
