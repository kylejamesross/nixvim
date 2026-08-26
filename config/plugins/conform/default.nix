{
  pkgs,
  lib,
  ...
}: {

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
      require("conform").formatters.injected = {
        -- Set the options field
        options = {
          -- Set individual option values
          ignore_errors = true,
          lang_to_formatters = {},
          lang_to_ext = {
            bash = "bash",
            lua = "lua",
            fish = "fish",
            css = "css",
            javascript = "js",
            typescript = "ts",
          },
        },
      }
  '';
  plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = false;
        format_on_save =
          /*
          lua
          */
          ''
            function (bufnr)
              local disable_filetypes = { c = true, cpp = true }
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
              }
            end
          '';
        formatters_by_ft = {
          html = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          cs = {
            __unkeyed-1 = "csharpier";
          };
          css = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          javascriptreact = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          typescriptreact = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          lua = ["stylua"];
          nix = ["alejandra" "injected"];
          markdown = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          yaml = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            stop_after_first = true;
          };
          bash = {
            __unkeyed-1 = "shellcheck";
            __unkeyed-2 = "shellharden";
            __unkeyed-3 = "shfmt";
            stop_after_first = true;
          };
          json = ["jq"];
        };

        formatters = {
          alejandra = {
            command = "${lib.getExe pkgs.alejandra}";
          };
          jq = {
            command = "${lib.getExe pkgs.jq}";
          };
          prettierd = {
            command = "${lib.getExe pkgs.prettierd}";
          };
          stylua = {
            command = "${lib.getExe pkgs.stylua}";
          };
          shellcheck = {
            command = "${lib.getExe pkgs.shellcheck}";
          };
          shfmt = {
            command = "${lib.getExe pkgs.shfmt}";
          };
          shellharden = {
            command = "${lib.getExe pkgs.shellharden}";
          };
          csharpier = {
            command = "${pkgs.csharpier}/bin/dotnet-csharpier";
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
              require('conform').format { async = true, lsp_fallback = true }
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
