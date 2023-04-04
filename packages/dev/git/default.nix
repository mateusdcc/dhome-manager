{pkgs, ...}:

{
  programs.git = {
    enable = true;
    userName = "Mateus Cavalcanti";
    userEmail = "mateusdc@proton.me";
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      df = "diff";
      lg = "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      ll = "log --pretty=format:'%C(yellow)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      ls = "ls-files";
      pl = "pull";
      ps = "push";
      rb = "rebase";
      t = "tag";
      wd = "diff --word-diff";
    };
  };
}
