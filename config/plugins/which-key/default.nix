{...}: {

  plugins.which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>a";
            group = "[A]rtificial Intelligence";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "[C]ode";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "[D]ebug";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "[R]efactor";
            icon = "󰷈";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "[W]orkspace";
            icon = "";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
            icon = "󱪗";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "[L]SP";
            icon = "󰈙";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Git [H]unk";
            icon = "";
            mode = [
              "n"
              "v"
            ];
          }
        ];
      };
  };

}
