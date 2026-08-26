{...}: {
  imports = [
  ./servers/ts_ls
  ./servers/omnisharp
  ./servers/lua_ls
  ];

  plugins = {
      fidget.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          eslint.enable = true;
          cssls.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          astro.enable = true;
          emmet_ls = {
            enable = true;
            filetypes = [
              "html"
              "css"
              "scss"
              "javascriptreact"
              "typescriptreact"
              "javascript"
              "typescript"
            ];
          };
        };

        keymaps = {
          diagnostic = {
            "<leader>q" = {
              action = "setloclist";
              desc = "Open diagnostic [Q]uickfix list";
            };
          };

          extra = [
            {
              mode = "n";
              key = "gl";
              action.__raw = "vim.diagnostic.open_float";
              options = {
                desc = "[L]ine diagnostics";
              };
            }
            {
              mode = "n";
              key = "gd";
              action.__raw = "require('telescope.builtin').lsp_definitions";
              options = {
                desc = "LSP: [G]oto [D]efinition";
              };
            }
            {
              mode = "n";
              key = "grr";
              action.__raw = "require('telescope.builtin').lsp_references";
              options = {
                desc = "LSP: [G]o to [R]eferences";
              };
            }
            {
              mode = "n";
              key = "gri";
              action.__raw = "require('telescope.builtin').lsp_implementations";
              options = {
                desc = "LSP: [G]o to [I]mplementation";
              };
            }
            {
              mode = "n";
              key = "grt";
              action.__raw = "require('telescope.builtin').lsp_type_definitions";
              options = {
                desc = "Type [D]efinition";
              };
            }
            {
              mode = "n";
              key = "gO";
              action.__raw = "require('telescope.builtin').lsp_document_symbols";
              options = {
                desc = "Document [S]ymbols";
              };
            }
            {
              mode = "n";
              key = "gW";
              action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
              options = {
                desc = "[W]orkspace Symbols";
              };
            }
          ];

          lspBuf = {
            "grn" = {
              action = "rename";
              desc = "LSP: [R]e[n]ame";
            };
            "gra" = {
              mode = [
                "n"
                "x"
              ];
              action = "code_action";
              desc = "LSP: [G]oto Code [A]ction";
            };
            "grD" = {
              action = "declaration";
              desc = "LSP: [G]oto [D]eclaration";
            };
          };
        };

        onAttach =
          #lua
          ''
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
            end

            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
              })
            end

            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
              end, "[T]oggle Inlay [H]ints")
            end
          '';
      };
  };
  autoGroups = {
      "kickstart-lsp-attach" = {
        clear = true;
      };
  };
  extraConfigLua = ''
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
          },
        },
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })
  '';

}
