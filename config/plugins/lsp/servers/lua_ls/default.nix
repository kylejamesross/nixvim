{
  plugins.lsp.servers.lua_ls = {
  enable = true;
  settings = {
      telemetry.enable = false;
      diagnostics.globals = ["vim" "require" "client" "bufnr" "event"];
  };
  };
}
