{pkgs, ...}: {

  plugins.lint = {
      enable = true;

      lintersByFt = {
        lua = ["luacheck"];
        markdownlint = ["markdownlint"];
        sh = ["shellcheck"];
        yaml = ["yamllint"];
      };

      autoCmd = {
        group = "lint";
        event = ["BufEnter" "BufWritePost" "InsertLeave"];
        callback.__raw = ''
          function()
            if vim.opt_local.modifiable:get() then
              require("lint").try_lint()
            end
          end
        '';
      };
  };

  autoGroups = {
      lint = {
        clear = true;
      };
  };

  extraPackages = with pkgs; [
      markdownlint-cli
      shellcheck
      yamllint
      luajitPackages.luacheck
  ];

}
