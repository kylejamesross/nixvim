{pkgs, ...}: {
  globals = {
    mapleader = " ";
    have_nerd_font = true;

    clipboard.__raw =
      #lua
      ''
        (function()
        	local function osc52_paste(reg)
        		return function()
        			local content = vim.fn.getreg(reg)
        			return vim.split(content, "\n")
        		end
        	end

        	if vim.env.SSH_TTY == nil then
        		-- Local session: WSL, Wayland, X11 handled by Neovim's
        		-- built-in provider auto-detection once clipboard=unnamedplus
        		-- is set. No manual g:clipboard needed here.
        		return nil
        	end

        	-- SSH session: OSC52 through the terminal is the only way back.
        	return {
        		name = "OSC 52",
        		copy = {
        			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        		},
        		paste = {
        			["+"] = osc52_paste("+"),
        			["*"] = osc52_paste("*"),
        		},
        		cache_enabled = 0,
        	}
        end)()
      '';
  };

  clipboard = {
    providers.wl-copy.enable = true;
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
