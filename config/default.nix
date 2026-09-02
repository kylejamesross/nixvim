{inputs, ...}: {
  imports = [
    ./options
    ./keymaps
    ./plugins
    ./colorschemes
  ];

  _module.args = {inherit inputs;};
}
