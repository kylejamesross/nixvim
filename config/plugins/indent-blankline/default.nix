{
  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "┊";
        highlight = "IblIndent";
      };
    };
  };

  extraConfigLua = ''
    local function set_ibl_transparent()
    	local indent_fg = vim.api.nvim_get_hl(0, { name = "Whitespace", link = false }).fg
    	vim.api.nvim_set_hl(0, "IblIndent", { fg = indent_fg, bg = "NONE" })
    end

    set_ibl_transparent()

    vim.api.nvim_create_autocmd("ColorScheme", {
    	callback = set_ibl_transparent,
    })
  '';
}
