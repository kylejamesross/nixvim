{inputs, ...}: {
  imports = [
    ./options
    ./keymaps
    ./plugins
  ];

  _module.args = {inherit inputs;};
}
