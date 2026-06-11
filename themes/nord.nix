{
  colors = {
    bg      = "#2e3440";
    fg      = "#d8dee9";
    accent  = "#88c0d0";
    red     = "#bf616a";
    green   = "#a3be8c";
  };

  icons = {
    launcher   = "\\uF00a";  #  App Grid Launcher
    screenshot = "\\uF030";  #  Camera
    settings   = "\\uF013";  #  Gear
    power      = "\\uF011";  #  Power Button
  };

  gtkCss = ''
    @define-color bg_color #2e3440;
    @define-color fg_color #d8dee9;
    @define-color accent_color #88c0d0;

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
