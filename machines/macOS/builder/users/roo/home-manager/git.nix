{...}: {
  programs.git = {
    enable = true;

    delta = {
      enable = true;

      # see https://dandavison.github.io/delta/configuration.html
      options = {
        decorations = {
          commit-decoration-style = "yellow box ul";
          file-decoration-style = "none";
          file-style = "yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";

        commit-decoration-style = "blue ol";
        commit-style = "raw";
        file-style = "omit";
        hunk-header-decoration-style = "blue box";
        hunk-header-file-style = "red";
        hunk-header-line-number-style = "#067a00";
        hunk-header-style = "file line-number syntax";
      };
    };
  };
}
