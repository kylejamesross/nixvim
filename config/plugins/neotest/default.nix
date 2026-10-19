{pkgs, ...}: {
  plugins = {
    neotest = {
      enable = true;
      adapters = {
        vitest = {
          package = pkgs.vimPlugins.neotest-vitest;
          enable = true;
        };
        dotnet.enable = true;
      };
    };
  };

  # Neotest's subprocess starts with `-u NONE` and only adds parser dirs to rtp.
  # After neotest#606 it no longer loads nvim-treesitter, so filetype→parser
  # aliases (typescriptreact→tsx) never register and .tsx discovery fails.
  # https://github.com/nvim-neotest/neotest/issues/631
  extraConfigLua =
    # lua
    ''
      do
        local subprocess = require("neotest.lib.subprocess")
        local init = subprocess.init
        subprocess.init = function(...)
          init(...)
          if not subprocess.enabled() then
            return
          end
          local paths = {}
          for _, file in ipairs(vim.api.nvim_get_runtime_file("plugin/filetypes.lua", true)) do
            if file:find("nvim%-treesitter", 1, false) then
              paths[#paths + 1] = vim.fs.dirname(vim.fs.dirname(file))
            end
          end
          if #paths > 0 then
            pcall(subprocess.add_paths_to_rtp, paths)
          end
        end
      end
    '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua require(\"neotest\").run.run(vim.fn.expand(\"%\"))<cr>";
      options = {
        desc = "Run Tests in [F]ile";
      };
    }
    {
      mode = "n";
      key = "<leader>cl";
      action.__raw = ''
        function() require("neotest").run.run_last() end
      '';
      options = {
        desc = "Run [L]ast Test";
      };
    }
    {
      mode = "n";
      key = "<leader>ct";
      action.__raw = ''
        function() require("neotest").run.run() end
      '';
      options = {
        desc = "Run Nearest [T]est";
      };
    }
    {
      mode = "n";
      key = "<leader>tw";
      action.__raw =
        #lua
        ''
          function()
            require("neotest").watch.toggle()
          end
        '';
      options = {desc = "[T]oggle Test [W]atch";};
    }
    {
      mode = "n";
      key = "<leader>cd";
      action.__raw = ''
        function() require("neotest").run.run({ strategy='dap' }) end
      '';
      options = {
        desc = "Run Nearest Test with [D]ebugger";
      };
    }
    {
      mode = "n";
      key = "<leader>tt";
      action.__raw = ''
        function() require("neotest").output_panel.toggle() end
      '';
      options = {
        desc = "[T]oggle [T]est Panel";
      };
    }
    {
      mode = "n";
      key = "<leader>ts";
      action.__raw = ''
        function() require("neotest").summary.toggle() end
      '';
      options = {
        desc = "[T]oggle Test [S]ummary";
      };
    }
  ];
}
