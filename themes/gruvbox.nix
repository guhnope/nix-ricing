{
  # Raw variables for files that don't support native CSS variables (like configs)
  colors = {
    bg      = "#282828";
    fg      = "#ebdbb2";
    accent  = "#d65d0e";
    red     = "#fb4934";
    green   = "#b8bb26";
    yellow  = "#fabd2f";
  };

  # Direct CSS injections for Wofi & Wlogout
  gtkCss = ''
    @define-color bg_color #282828;
    @define-color fg_color #ebdbb2;
    @define-color accent_color #d65d0e;

    window {
        background-color: @bg_color;
        color: @fg_color;
        font-family: "JetBrainsMono Nerd Font";
    }
    button:hover {
        background-color: @accent_color;
    }
  '';
}
