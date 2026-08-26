# nixvim

A standalone [nixvim](https://github.com/nix-community/nixvim) flake for Neovim. Configuration lives in [`config/`](config/) and is built into a self-contained Neovim package.

## Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled

If flakes are not enabled globally, you can pass `--extra-experimental-features 'nix-command flakes'` to the commands below.

## Quick start

Run Neovim without installing anything:

```bash
nix run .#
```

Open a file:

```bash
nix run .# -- path/to/file
```

## Build and install

Build the package:

```bash
nix build
```

The result is linked at `./result/bin/nvim`. Run it directly or add it to your PATH.

Install into your user profile:

```bash
nix profile install .#
```

Remove it later with:

```bash
nix profile remove .#
```

## Validate the config

Run the nixvim config check:

```bash
nix flake check
```

This builds Neovim and runs nixvim's smoke test to catch configuration errors.

## Explore flake outputs

```bash
nix flake show
```

Available outputs:

| Output | Description |
| --- | --- |
| `packages.x86_64-linux.default` | The configured Neovim package |
| `apps.x86_64-linux.default` | Runnable app (`nix run .#`) |
| `checks.x86_64-linux.default` | Config validation derivation |

## Use in NixOS or Home Manager

You can reuse this flake as a package in a larger config:

```nix
environment.systemPackages = [
  inputs.nixvim-config.packages.${pkgs.system}.default
];
```

Replace `inputs.nixvim-config` with however you reference this flake in your `flake.nix`.

## Project layout

```
config/
├── default.nix          # Entry point (imports options, keymaps, plugins)
├── options/             # Global settings, autocommands, etc.
├── keymaps/             # Custom keymaps
└── plugins/             # Plugin configuration by module
flake.nix                # Flake definition
```

Edit files under `config/`, then run `nix run .#` or `nix flake check` to try your changes.
