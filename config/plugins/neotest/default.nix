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
