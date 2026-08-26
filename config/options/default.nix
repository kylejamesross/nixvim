{pkgs, ...}: {
  globals = {
    mapleader = " ";
    have_nerd_font = true;

    clipboard.__raw =
      #lua
      ''
        (function()
        	local function file_has(path, pattern)
        		local f = io.open(path, "r")
        		if not f then
        			return false
        		end
        		local content = f:read("*a")
        		f:close()
        		return content:lower():match(pattern) ~= nil
        	end

        	local is_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
        	local is_wsl = file_has("/proc/version", "microsoft")

        	if is_ssh then
        		-- Remote box: only OSC52 can reach back through the terminal
        		return {
        			name = "OSC 52",
        			copy = {
        				["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        				["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        			},
        			paste = {
        				["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        				["*"] = require("vim.ui.clipboard.osc52").paste("*"),
        			},
        		}
        	elseif vim.fn.executable("wl-copy") == 1 then
        		-- Native Wayland desktop
        		return {
        			name = "wl-clipboard",
        			copy = {
        				["+"] = { "wl-copy", "--type", "text/plain" },
        				["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
        			},
        			paste = {
        				["+"] = { "wl-paste", "--no-newline", "--type", "text/plain" },
        				["*"] = { "wl-paste", "--no-newline", "--primary", "--type", "text/plain" },
        			},
        			cache_enabled = 1,
        		}
        	else
        		-- Fallback: let Neovim auto-detect xclip/xsel, or OSC52 as last resort
        		if vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1 then
        			return nil
        		end
        		return {
        			name = "OSC 52",
        			copy = {
        				["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        				["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        			},
        			paste = {
        				["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        				["*"] = require("vim.ui.clipboard.osc52").paste("*"),
        			},
        		}
        	end
        end)()
      '';
  };

  clipboard = {
    providers.wl-copy.enable = true; # installs wl-clipboard package where relevant; harmless elsewhere
    register = "unnamedplus";
  };

  opts = {
    number = true;
    relativenumber = true;
    mouse = "a";
    shiftwidth = 2;
    tabstop = 2;
    hlsearch = true;
    ignorecase = true;
    smartcase = true;
    breakindent = true;
    undofile = true;
    scrolloff = 10;
    signcolumn = "yes";
    incsearch = true;
    smartindent = true;
    updatetime = 250;
    timeoutlen = 500;
    splitright = true;
    splitbelow = true;
    cursorline = true;
    termguicolors = true;
    list = true;
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
  };

  autoGroups = {
    kickstart-highlight-yank = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = ["TextYankPost"];
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      callback.__raw = ''
        function()
        vim.hl.on_yank()
        end
      '';
    }
  ];

  extraConfigLua = ''
    vim.env.PATH = "${pkgs.nodejs_22}/bin:" .. vim.env.PATH
  '';
}
