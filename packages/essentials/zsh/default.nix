{ pkgs, ... }:

{
  programs.command-not-found.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      export EDITOR="nvim"
      export TERMINAL="alacritty"
      export BROWSER="firefox"
      setopt histignorealldups sharehistory
      zstyle ":completion:*" menu select
      zstyle ":completion:*" list-colors ""
      zmodload zsh/complist
      bindkey '^f' autosuggest-accept
      bindkey -v
      export PATH="$HOME/.local/usr/bin:$PATH"
      export PATH="$HOME/.local/venv/bin:$PATH"
      export PATH="$HOME/.local/usr/node/bin:$PATH"
      export PATH="$HOME/.cargo/bin:$PATH"
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
      VI_MODE_SET_CURSOR=true
      MODE_INDICATOR="%F{white}+%f"
      INSERT_MODE_INDICATOR="%F{yellow}+%f"
      export HISTCONTROL=ignoredups
      setopt autocd
      autoload znt-history-widget
      zle -N znt-history-widget
      bindkey "^R" znt-history-widget
      autoload -Uz compinit && compinit
      autoload -U promptinit; promptinit
      prompt pure
    '';

    history = { save = 10000; };

    shellAliases = {
      v = "$EDITOR";
      vim = "$EDITOR";
      unziptar = "tar -xvzf";
      ls = "ls --color=auto";
    };
  };
}
