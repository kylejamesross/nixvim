{
  description = "Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    telescope-git-file-history-nvim = {
      url = "github:isak102/telescope-git-file-history.nvim";
      flake = false;
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      flake = {
        homeModules.default = {...}: {
          imports = [
            nixvim.homeModules.nixvim
          ];
          programs.nixvim = {
            imports = [./config];
            extraSpecialArgs = {inherit inputs;};
          };
        };

        nixosModules.default = {...}: {
          imports = [
            nixvim.nixosModules.nixvim
          ];
          programs.nixvim = {
            imports = [./config];
            extraSpecialArgs = {inherit inputs;};
          };
        };
      };

      perSystem = {system, ...}: let
        configuration = nixvim.lib.evalNixvim {
          inherit system;
          modules = [./config];
          extraSpecialArgs = {inherit inputs;};
        };
      in {
        checks.default = configuration.config.build.test;
        packages.default = configuration.config.build.package;
        apps.default = {
          type = "app";
          program = "${configuration.config.build.package}/bin/nvim";
          meta.description = "Neovim configured with nixvim";
        };
      };
    };
}
