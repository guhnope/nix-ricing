import os
import subprocess

from libqtile import bar, hook, layout, widget qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from qtile_extras import widget as extras

# 🔑 MODIFIER KEY (Super / Windows Key)
mod = "mod4"

# 🚀 CORE APPLICATIONS
terminal = "ghostty"
launcher = "fuzzel"
file_manager = "nemo"

keys = [
    # 🖥️ WINDOW FOCUS CONTROL (Hyprland style: Vim keys or Arrow keys)
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    # 🔄 MOVING WINDOWS (Super + Shift + Direction)
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # 📏 RESIZING WINDOWS (Super + Control + Direction)
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # 🏃 APP LAUNCHERS (Matching your system packages)
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch Ghostty"),
    Key([mod], "d", lazy.spawn(launcher), desc="Launch Fuzzel Launcher"),
    Key([mod], "e", lazy.spawn(file_manager), desc="Launch Nemo File Manager"),
    # ❌ WINDOW MANAGEMENT
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod, "shift"],
        "space",
        lazy.window.toggle_floating(),
        desc="Toggle floating state",
    ),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen mode"),
    # 🔄 QTILE SESSION MANAGEMENT
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload Qtile Config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

# 🏷️ WORKSPACES (Groups 1-9)
groups = [Group("1", label=""), Group("2", label=""), ...]
for i in groups:
    keys.extend(
        [
            # Super + Number = Switch to workspace
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # Super + Shift + Number = Move focused window to workspace
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc=f"Move focused window to group {i.name}",
            ),
        ]
    )

# 🎨 WINDOW LAYOUTS (Using standard gaps to match Hyprland padding styles)
layouts = [
    layout.Columns(
        border_focus="#7fbbb3",  # Everforest/Gruvbox Accent
        border_normal="#2d353b",  # Muted Background
        border_width=2,
        margin=8,  # 🪟 Gaps between windows
    ),
    layout.Max(margin=8),
]

# 🖥️ SCREEN & STATUS BAR HOOK
# We set standard blank Screens because Waybar runs independently on top of the compositor layer.
colors = {"bg": "#282828", "fg": "#ebdbb2", "accent": "#83a598", "alt": "#3c3836"}

screens = [
    Screen(
        top=bar.Bar(
            [
                # 🚀 Launcher
                widget.TextBox(
                    "  ",
                    foreground=colors["accent"],
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(launcher)},
                ),
                # 🪟 Window Name
                widget.WindowName(foreground=colors["fg"], max_chars=40),
                # 🏷️ Workspaces (The Qtile equivalent of niri/workspaces)
                widget.GroupBox(
                    active=colors["accent"],
                    inactive=colors["alt"],
                    highlight_method="line",
                    this_current_screen_border=colors["accent"],
                    foreground=colors["fg"],
                    margin_x=5,
                ),
                widget.Spacer(),  # Pushes modules to the right
                # 📥 Tray
                widget.Systray(padding=10),
                # ⏱️ Clock
                widget.Clock(format="%H:%M | %A, %B %d", foreground=colors["accent"]),
                # 🔊 Volume
                widget.PulseVolume(foreground=colors["accent"], fmt=" 󰕾 {}"),
                # ⏻ Power
                widget.TextBox(
                    " ⏻ ",
                    foreground="#fb4934",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("wlogout")},
                ),
            ],
            32,  # Height
            background=colors["bg"],
            opacity=0.9,
            margin=[4, 8, 0, 8],  # Gaps (Top, Right, Bottom, Left)
        ),
    ),
]

# 🐭 MOUSE CONTROLS (Super + Left/Right click to drag or resize floating windows)
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


# 🚀 AUTOSTART DAEMONS (Launches Waybar automatically when Qtile initializes)
@hook.subscribe.startup_once
def autostart():
    # Spawns your bar system natively on boot
    # If your notifications daemon or authentication agents need manual kicks under Qtile:
    # subprocess.Popen(["hyprpolkitagent"])


# 🛠️ WAYLAND COMPOSITOR SETTINGS
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # git confirmation dialogs
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),  # ssh security inputs
        Match(title="branchdialog"),
        Match(title="pinentry"),  # GPG Key password entries
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = False
wl_input_rules = None
wmname = "LG3D"
