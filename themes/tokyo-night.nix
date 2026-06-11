{
  colors = {
    bg      = "#1a1b26";
    fg      = "#c0caf5";
    accent  = "#7aa2f7";
    red     = "#f7768e";
    green   = "#9ece6a";
  };

  icons = {
    launcher   = "\\uF00a";  #  App Grid Launcher
    screenshot = "\\uF030";  #  Camera
    settings   = "\\uF013";  #  Gear
    power      = "\\uF011";  #  Power Button
  };

  gtkCss = ''
    @define-color bg_color #1a1b26;
    @define-color fg_color #c0caf5;
    @define-color accent_color #7aa2f7;

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
