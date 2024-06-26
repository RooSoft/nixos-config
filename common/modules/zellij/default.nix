{
  pkgs,
  inputs,
  ...
}: {
  programs.zellij = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      theme = "tokyo-night-dark";

      simplified_ui = false;
      pane_frames = false;

      scroll_buffer_size = 10000;
    };
  };
}
