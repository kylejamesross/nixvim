{
  description = "Nixvim configuration";

  nixConfig = {
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
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
  } @ inputs: let
    configModule = {
      imports = [
        (import ./config {inherit inputs;})
      ];
    };

    mkSystemModule = baseModule: _: {
      imports = [baseModule];
      programs.nixvim.imports = [configModule];
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      flake = {
        homeModules.default = mkSystemModule nixvim.homeModules.nixvim;
        nixosModules.default = mkSystemModule nixvim.nixosModules.nixvim;
      };

      perSystem = {
        system,
        pkgs,
        ...
      }: let
        configuration = nixvim.lib.evalNixvim {
          inherit system;
          modules = [configModule];
        };
      in {
        formatter = pkgs.alejandra;

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
