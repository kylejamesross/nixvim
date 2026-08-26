{pkgs, ...}: {
  globals = {
    mapleader = " ";
    have_nerd_font = true;
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
