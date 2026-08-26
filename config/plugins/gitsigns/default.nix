{

  plugins.gitsigns = {
      enable = true;
  };
  keymaps = [
      {
        mode = "n";
        key = "]h";
        action.__raw = ''
          function()
          if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
          else
              require('gitsigns').nav_hunk 'next'
                  end
                  end
        '';
        options = {
          desc = "Git Hunk: Jump to Next Change";
        };
      }
      {
        mode = "n";
        key = "[h";
        action.__raw = ''
          function()
          if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
          else
              require('gitsigns').nav_hunk 'prev'
                  end
                  end
        '';
        options = {
          desc = "Git Hunk: Jump to Previous Change";
        };
      }
      {
        mode = "v";
        key = "<leader>hs";
        action.__raw = ''
              function()
              require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end
        '';
        options = {
          desc = "[S]tage";
        };
      }
      {
        mode = "v";
        key = "<leader>hr";
        action.__raw = ''
              function()
              require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end
        '';
        options = {
          desc = "[R]eset";
        };
      }
      # normal mode
      {
        mode = "n";
        key = "<leader>hs";
        action.__raw = ''
          function()
          require('gitsigns').stage_hunk()
          end
        '';
        options = {
          desc = "[S]tage";
        };
      }
      {
        mode = "n";
        key = "<leader>hr";
        action.__raw = ''
          function()
          require('gitsigns').reset_hunk()
          end
        '';
        options = {
          desc = "[R]eset";
        };
      }
      {
        mode = "n";
        key = "<leader>hS";
        action.__raw = ''
          function()
          require('gitsigns').stage_buffer()
          end
        '';
        options = {
          desc = "[S]tage Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>hu";
        action.__raw = ''
          function()
          require('gitsigns').undo_stage_hunk()
          end
        '';
        options = {
          desc = "[U]ndo Stage";
        };
      }
      {
        mode = "n";
        key = "<leader>hR";
        action.__raw = ''
          function()
          require('gitsigns').reset_buffer()
          end
        '';
        options = {
          desc = "[R]eset Buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>hp";
        action.__raw = ''
          function()
          require('gitsigns').preview_hunk()
          end
        '';
        options = {
          desc = "[P]review";
        };
      }
      {
        mode = "n";
        key = "<leader>hb";
        action.__raw = ''
          function()
          require('gitsigns').blame_line()
          end
        '';
        options = {
          desc = "[B]lame";
        };
      }
      {
        mode = "n";
        key = "<leader>hd";
        action.__raw = ''
          function()
          require('gitsigns').diffthis()
          end
        '';
        options = {
          desc = "[D]iff";
        };
      }
      {
        mode = "n";
        key = "<leader>hD";
        action.__raw = ''
          function()
          require('gitsigns').diffthis '@'
          end
        '';
        options = {
          desc = "[D]iff Against Last Commit";
        };
      }
      # Toggles
      {
        mode = "n";
        key = "<leader>tb";
        action.__raw = ''
          function()
          require('gitsigns').toggle_current_line_blame()
          end
        '';
        options = {
          desc = "[T]oggle Git [B]lame";
        };
      }
      {
        mode = "n";
        key = "<leader>tD";
        action.__raw = ''
          function()
          require('gitsigns').toggle_deleted()
          end
        '';
        options = {
          desc = "[T]oggle Git [D]eleted";
        };
      }
  ];

}
