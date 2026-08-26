{
  pkgs,
  inputs,
  ...
}: {

  plugins.telescope = {
      enable = true;
      enabledExtensions = ["git_file_history"];

      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
        undo.enable = true;
      };

      keymaps = {
        "<leader>sh" = {
          mode = "n";
          action = "help_tags";
          options = {
            desc = "[H]elp";
          };
        };
        "<leader>sk" = {
          mode = "n";
          action = "keymaps";
          options = {
            desc = "[K]eymaps";
          };
        };
        "<leader>ss" = {
          mode = "n";
          action = "builtin";
          options = {
            desc = "Builtin[s]";
          };
        };
        "<leader>sw" = {
          mode = "n";
          action = "grep_string";
          options = {
            desc = "[W]ord";
          };
        };
        "<leader>sg" = {
          mode = "n";
          action = "live_grep";
          options = {
            desc = "[G]rep";
          };
        };
        "<c-t>" = {
          mode = "n";
          action = "live_grep";
          options = {
            desc = "Telescope: Grep";
          };
        };
        "<leader>sd" = {
          mode = "n";
          action = "diagnostics";
          options = {
            desc = "[D]iagnostics";
          };
        };
        "<leader>sr" = {
          mode = "n";
          action = "resume";
          options = {
            desc = "[R]esume";
          };
        };
        "<leader>sp" = {
          mode = "n";
          action = "oldfiles";
          options = {
            desc = "[P]revious Files";
          };
        };
        "<leader>sc" = {
          mode = "n";
          action = "git_file_history";
          options = {
            desc = "[C]ommit History (Current Buffer)";
          };
        };
        "<leader>sb" = {
          mode = "n";
          action = "buffers";
          options = {
            desc = "[B]uffers";
          };
        };
        "<leader>su" = {
          mode = "n";
          action = "undo";
          options = {
            desc = "[U]ndo Tree";
          };
        };
      };
      settings = {
        extensions.__raw = "{ ['ui-select'] = { require('telescope.themes').get_dropdown() } }";
      };
  };

  plugins.fugitive.enable = true;

  extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "telescope-git-file-history.nvim";
        src = inputs.telescope-git-file-history-nvim;
      })
      pkgs.ripgrep
      pkgs.vimPlugins.plenary-nvim
  ];

  keymaps = [
      {
        mode = "n";
        key = "<c-p>";
        action.__raw = ''
          function()
            require('telescope.builtin').find_files {
              hidden = true
            }
          end
        '';
        options = {
          desc = "Telscope: Search Files";
        };
      }
      {
        mode = "n";
        key = "<leader>sf";
        action.__raw = ''
              function()
              require('telescope.builtin').find_files {
                  hidden = true
              }
          end
        '';
        options = {
          desc = "[F]iles";
        };
      }
      {
        mode = "n";
        key = "<leader>s/";
        action.__raw = ''
          function()
            require('telescope.builtin').current_buffer_fuzzy_find(
              require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false
              }
            )
          end
        '';
        options = {
          desc = "Current Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>sn";
        action.__raw = ''
          function()
            require('telescope.builtin').find_files {
              cwd = vim.fn.stdpath 'config'
            }
          end
        '';
        options = {
          desc = "[F]iles";
        };
      }
  ];

}
