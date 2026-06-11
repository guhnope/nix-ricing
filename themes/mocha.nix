{
  colors = {
    bg      = "#1e1e2e";
    fg      = "#cdd6f4";
    accent  = "#cba6f7";
    red     = "#f38ba8";
    green   = "#a6e3a1";
  };

  icons = {
    launcher   = "\\uF00a";  #  App Grid Launcher
    screenshot = "\\uF030";  #  Camera
    settings   = "\\uF013";  #  Gear
    power      = "\\uF011";  #  Power Button
  };

  gtkCss = ''
    @define-color bg_color #1e1e2e;
    @define-color fg_color #cdd6f4;
    @define-color accent_color #cba6f7;

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
