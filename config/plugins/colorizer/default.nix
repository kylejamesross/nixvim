{...}: {

  plugins = {
      colorizer = {
        enable = true;
        settings = {
          user_default_options = {
            RGB = true;
            RRGGBB = true;
            names = true;
            RRGGBBAA = true;
            AARRGGBB = true;
            HSL = true;
            rgb_fn = true;
            hsl_fn = true;
            css = true;
            css_fn = true;
            tailwind = true;
            mode = "background";
            always_update = true;
          };
        };
      };
  };

}
