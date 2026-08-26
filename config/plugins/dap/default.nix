{pkgs, ...}: let
  configVitest = {
  name = "launch vitest";
  request = "launch";
  type = "pwa-node";
  cwd = ''''${workspaceFolder}'';
  program = ''''${workspaceFolder}/node_modules/vitest/vitest.mjs'';
  args = ["--threads" "false"];
  autoAttachChildProcesses = false;
  trace = true;
  console = "integratedTerminal";
  sourceMaps = true;
  smartStep = true;
  };
  configChrome = {
  name = "launch vite";
  type = "pwa-chrome";
  request = "launch";
  runtimeExecutable = "${pkgs.brave}/bin/brave";
  url = "http://localhost:5173";
  webRoot = ''''${workspaceFolder}'';
  };
in {

  plugins = {
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap = {
        enable = true;
        adapters = {
          servers = {
            pwa-node = {
              host = "localhost";
              port = ''''${port}'';
              executable = {
                command = "${pkgs.vscode-js-debug}/bin/js-debug";
                args = [
                  ''''${port}''
                ];
              };
            };
            pwa-chrome = {
              host = "localhost";
              port = ''''${port}'';
              executable = {
                command = "${pkgs.vscode-js-debug}/bin/js-debug";
                args = [
                  ''''${port}''
                ];
              };
            };
          };
          executables = {
            netcoredbg = {
              command = "${pkgs.netcoredbg}/bin/netcoredbg";
              args = ["--interpreter=vscode"];
            };
          };
        };
        configurations = {
          typescript = [
            configChrome
            configVitest
            configChrome
          ];
          javascript = [
            configChrome
            configVitest
            configChrome
          ];
          typescriptreact = [
            configChrome
            configVitest
            configChrome
          ];
          javascriptreact = [
            configChrome
            configVitest
            configChrome
          ];
          cs = [
            {
              type = "netcoredbg";
              request = "launch";
              name = "Launch DLL";
              program.__raw =
                #lua
                ''
                  function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                  end
                '';
            }
            {
              type = "netcoredbg";
              request = "attach";
              name = "Attach";
              processId.__raw =
                #lua
                ''
                  function()
                    return require('dap.utils').pick_process()
                  end
                '';
            }
          ];
        };
        signs = {
          dapBreakpoint = {
            text = "";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            text = "";
            texthl = "dapBreakpointCondition";
          };
          dapBreakpointRejected = {
            text = "";
            texthl = "DapBreakpointRejected";
          };
          dapLogPoint = {
            text = "";
            texthl = "DapLogPoint";
          };
          dapStopped = {
            text = "";
            texthl = "DapStopped";
          };
        };
      };
  };

  # extraPackages = with pkgs; [
  #   vimPlugins.nvim-nio
  # ];
  extraConfigLua = ''
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
  '';
  keymaps = [
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').continue()
            end
          '';
        key = "<leader>dc";
        options = {
          desc = "[C]ontinue";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').continue()
            end
          '';
        key = "<F5>";
        options = {
          desc = "Debug: Continue";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              local render = require("dapui.config").render
              render.max_type_length = (render.max_type_length == nil) and 0 or nil
              require("dapui").update_render(render)
            end
          '';
        key = "<leader>dy";
        options = {
          desc = " Toggle T[y]pes";
        };
        mode = ["n"];
      }
      {
        action =
          # lua
          ''
            function()
              require('dap').step_over()
            end
          '';
        key = "<leader>do";
        options = {
          desc = "Step [O]ver";
        };
        mode = ["n"];
      }
      {
        action =
          # lua
          ''
            function()
              require('dap').step_over()
            end
          '';
        key = "<F10>";
        options = {
          desc = "Debug: Step Over";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').step_into()
            end
          '';
        key = "<leader>di";
        options = {
          desc = "Step [I]nto";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').step_into()
            end
          '';
        key = "<F11>";
        options = {
          desc = "Debug: Step Into";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').step_out()
            end
          '';
        key = "<leader>dO";
        options = {
          desc = "Step [O]ut";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').step_out()
            end
          '';
        key = "<S-F12>";
        options = {
          desc = "Debug: Step Out";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').pause()
            end
          '';
        key = "<leader>dp";
        options = {
          desc = "[P]ause";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').toggle_breakpoint()
            end
          '';
        key = "<leader>db";
        options = {
          desc = "Toggle [B]reakpoint";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').toggle_breakpoint()
            end
          '';
        key = "<F9>";
        options = {
          desc = "Debug: Toggle Breakpoint";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end
          '';
        key = "<leader>dB";
        options = {
          desc = "[B]reakpoint (conditional)";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').repl.toggle()
            end
          '';
        key = "<leader>dR";
        options = {
          desc = "Toggle [R]EPL";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              local dap = require('dap')
              dap.disconnect()
              dap.close()
              dap.run_last()
            end
          '';
        key = "<leader>dr";
        options = {
          desc = "[R]estart Debugger";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').run_last()
            end
          '';
        key = "<leader>dl";
        options = {
          desc = "Run [L]ast";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').session()
            end
          '';
        key = "<leader>ds";
        options = {
          desc = "[S]ession";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').terminate()
            end
          '';
        key = "<leader>dt";
        options = {
          desc = "[T]erminate";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap.ui.widgets').hover()
            end
          '';
        key = "<leader>dw";
        options = {
          desc = "Hover [W]idget";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dap').run_to_cursor()
            end
          '';
        key = "<leader>dC";
        options = {
          desc = "Run all lines up to [c]ursor";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').eval(nil, { enter = true })
            end
          '';
        key = "<leader>d?";
        options = {
          desc = "Evaluate value under cursor";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').toggle()
            end
          '';
        key = "<leader>du";
        options = {
          desc = "Toggle [U]I";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').toggle()
            end
          '';
        key = "<leader>tu";
        options = {
          desc = "[T]oggle Debugger [U]I";
        };
        mode = ["n"];
      }
      {
        action.__raw =
          # lua
          ''
            function()
              require('dapui').eval()
            end
          '';
        key = "<leader>de";
        options = {
          desc = "[E]val";
        };
        mode = ["n"];
      }
  ];

}
