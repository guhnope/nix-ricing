{
  colors = {
    bg      = "#131a17";
    fg      = "#cddad3";
    accent  = "#4cbba1";
    red     = "#eb6f92";
    green   = "#4cbba1";
  };

  icons = {
    launcher   = "\\uF00a";  #  App Grid Launcher
    screenshot = "\\uF030";  #  Camera
    settings   = "\\uF013";  #  Gear
    power      = "\\uF011";  #  Power Button
  };

  gtkCss = ''
    @define-color bg_color #131a17;
    @define-color fg_color #cddad3;
    @define-color accent_color #4cbba1;

    window {
        background-color: @bg_color;
        color: @fg_color;
        font-family: "JetBrainsMono Nerd Font";
    }
    button {
        background-color: transparent;
        color: @fg_color;
    }
    button:hover, button:focus {
        background-color: @accent_color;
        color: @bg_color;
    }
  '';
}
