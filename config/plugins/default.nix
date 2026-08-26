{...}: {
  imports = [
    ./blink-cmp
    ./colorizer
    ./conform
    ./dap
    ./gitsigns
    ./indent-blankline
    ./lint
    ./lsp
    ./mini
    ./neotest
    ./telescope
    ./treesitter
    ./which-key
  ];

  plugins = {
    guess-indent.enable = true;
    illuminate.enable = true;
    rainbow-delimiters.enable = true;
    ts-autotag.enable = true;
    markdown-preview.enable = true;
    web-devicons.enable = true;
    otter.enable = true;
    nvim-autopairs.enable = true;
  };
}
