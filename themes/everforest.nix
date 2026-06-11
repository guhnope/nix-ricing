{
  colors = {
    bg      = "#2b3339";
    fg      = "#d3c6aa";
    accent  = "#a7c080";
    red     = "#e67e80";
    green   = "#a7c080";
  };

  icons = {
    launcher   = "\\uF00a";  #  App Grid Launcher
    screenshot = "\\uF030";  #  Camera
    settings   = "\\uF013";  #  Gear
    power      = "\\uF011";  #  Power Button
  };

  gtkCss = ''
    @define-color bg_color #2b3339;
    @define-color fg_color #d3c6aa;
    @define-color accent_color #a7c080;

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
