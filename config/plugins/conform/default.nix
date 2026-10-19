{...}: let
  prettier = {
    __unkeyed-1 = "prettierd";
    __unkeyed-2 = "prettier";
    stop_after_first = true;
  };
in {
  extraConfigLua = ''
    vim.api.nvim_create_user_command("FormatDisable", function(args)
    	if args.bang then
    		-- FormatDisable! will disable formatting just for this buffer
    		vim.b.disable_autoformat = true
    	else
    		vim.g.disable_autoformat = true
    	end
    end, {
    	desc = "Disable autoformat-on-save",
    	bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
    	vim.b.disable_autoformat = false
    	vim.g.disable_autoformat = false
    end, {
    	desc = "Re-enable autoformat-on-save",
    })
    vim.api.nvim_create_user_command("FormatToggle", function(args)
    	if args.bang then
    		-- Toggle formatting for current buffer
    		vim.b.disable_autoformat = not vim.b.disable_autoformat
    	else
    		-- Toggle formatting globally
    		vim.g.disable_autoformat = not vim.g.disable_autoformat
    	end
    end, {
    	desc = "Toggle autoformat-on-save",
    	bang = true,
    })
  '';
  plugins.conform-nvim = {
    enable = true;

    # Install the packages for every formatter used below.
    autoInstall.enable = true;

    settings = {
      notify_on_error = false;
      format_on_save = ''
        function (bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          -- Filetypes where the LSP formatter should not be used as a fallback.
          local lsp_disabled_filetypes = { c = true, cpp = true }
          return {
            timeout_ms = 500,
            lsp_format = lsp_disabled_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback",
          }
        end
      '';
      formatters_by_ft = {
        bash = ["shfmt" "shellharden"];
        c = ["clang-format"];
        cpp = ["clang-format"];
        cs = ["csharpier"];
        css = prettier;
        fish = ["fish_indent"];
        html = prettier;
        javascript = prettier;
        javascriptreact = prettier;
        json = ["jq"];
        lua = ["stylua"];
        markdown = prettier;
        nix = ["alejandra" "injected"];
        rust = ["rustfmt"];
        scss = prettier;
        toml = ["taplo"];
        typescript = prettier;
        typescriptreact = prettier;
        vue = prettier;
        yaml = prettier;
      };
      formatters.injected.options = {
        ignore_errors = true;
        lang_to_formatters = {};
        lang_to_ext = {
          bash = "bash";
          lua = "lua";
          fish = "fish";
          css = "css";
          javascript = "js";
          typescript = "ts";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "";
      key = "<leader>rf";
      action.__raw = ''
        function()
            require('conform').format { async = true, lsp_format = "fallback" }
        end
      '';
      options = {desc = "Refactor: [F]ormat";};
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = ":FormatToggle<CR>";
      options = {
        desc = "[T]oggle [F]ormat";
        silent = true;
      };
    }
  ];
}
