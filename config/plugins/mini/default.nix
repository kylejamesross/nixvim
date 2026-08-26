{...}: {

  plugins = {
      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 500;
            mappings = {
              around = "a";
              inside = "i";
              around_next = "";
              inside_next = "";
              goto_left = "g[";
              goto_right = "g]";
            };
          };
          surround = {};
          files = {};
          icons = {};
          statusline = {
            use_icons = true;
          };
        };
      };
  };

  extraConfigLua = ''
      local entire_buffer_textobject = function()
        local last_line = vim.fn.line("$")
        local last_col = math.max(vim.fn.getline(last_line):len(), 1)

        return {
          from = { line = 1, col = 1 },
          to = { line = last_line, col = last_col },
        }
      end

      MiniAi.setup({
        n_lines = 500,
        mappings = {
          around = "a",
          inside = "i",
          around_next = "",
          inside_next = "",
          goto_left = "g[",
          goto_right = "g]",
        },
        custom_textobjects = {
          e = entire_buffer_textobject,
        },
      })
  '';

  keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>lua if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end<CR>";
        options = {
          desc = "Toggle File [E]xplorer";
        };
      }
      {
        mode = "n";
        key = "<leader>te";
        action = "<CMD>lua if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end<CR>";
        options = {
          desc = "[T]oggle File [E]xplorer";
        };
      }
  ];

}
