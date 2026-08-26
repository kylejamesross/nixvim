{pkgs, ...}: {
  plugins = {
  treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
      };
      indent = {
        enable = true;
        disable = ["yaml"];
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        astro
        bash
        c_sharp
        css
        fish
        html
        javascript
        json
        lua
        markdown
        markdown_inline
        nix
        regex
        rust
        scss
        styled
        toml
        typescript
        tsx
        vim
        vimdoc
        vue
        yaml
      ];
  };
  treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;
          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@conditional.outer";
            "ic" = "@conditional.inner";
            "ib" = "@block.inner";
            "ab" = "@block.outer";
            "ip" = "@parameter.inner";
            "ap" = "@parameter.outer";
            "io" = "@object.outer";
            "oo" = "@object.inner";
          };
        };
      };
  };
  ts-context-commentstring.enable = true;
  ts-autotag.enable = true;
  };
  keymaps = [
  # Visual mode: keep growing/shrinking while already selecting
  {
      mode = "x";
      key = "<C-A-j>";
      action = "an";
      options = {
        remap = true;
        desc = "Grow node selection (an)";
      };
  }
  {
      mode = "x";
      key = "<C-A-k>";
      action = "in";
      options = {
        remap = true;
        desc = "Shrink node selection (in)";
      };
  }
  # Normal mode: enter visual, then trigger the same node select
  {
      mode = "n";
      key = "<C-A-j>";
      action = "van";
      options = {
        remap = true;
        desc = "Enter visual + grow node selection";
      };
  }
  {
      mode = "n";
      key = "<C-A-k>";
      action = "vin";
      options = {
        remap = true;
        desc = "Enter visual + shrink node selection";
      };
  }
  ];
}
