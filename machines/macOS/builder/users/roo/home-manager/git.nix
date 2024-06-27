{...}: {
  programs.git = {
    enable = true;

    delta = {
      enable = true;

      # see https://dandavison.github.io/delta/configuration.html
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
  };
}
