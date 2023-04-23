{ pkgs
, ...
}:
with pkgs; [
  htop
  tmux
  tree
  ripgrep
  curl
  less
  unrar-wrapper
  inotify-tools
]
