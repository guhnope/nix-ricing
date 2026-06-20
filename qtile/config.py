import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"

terminal = "ghostty"
launcher = "fuzzel"
file_manager = "caja"
wlogout = "wlogout  --protocol layer-shell --buttons-per-row 4"

keys = [
    # 🖥️ WINDOW FOCUS CONTROL (Hyprland style: Vim keys or Arrow keys)
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    # 🔄 MOVING WINDOWS (Super + Shift + Direction)
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    # 📏 RESIZING WINDOWS (Super + Control + Direction)
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # 🏃 APP LAUNCHERS (Matching your system packages)
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch Ghostty"),
    Key([mod], "Space", lazy.spawn(launcher), desc="Launch Fuzzel Launcher"),
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
    Key([mod], "x", lazy.spawn(wlogout), desc="Launch WLogout"),
]

# 🏷️ WORKSPACES (Groups 1-9)
groups = [
    Group("1", label=""),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label=""),
    Group("6", label=""),
    Group("7", label=""),
    Group("8", label=""),
    Group("9", label=""),
]
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

# 🖥️ SCREEN SETTINGS
# Empty screens allow external bars (Waybar) to take control of the Layer-Shell
screens = [
    Screen(
        top=None,
        bottom=None,
        left=None,
        right=None,
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


@hook.subscribe.startup_once
def autostart():
    # Kill existing Waybar instance to prevent double-stacking on config reload
    subprocess.Popen(["pkill", "waybar"])
    # Launch Waybar
    subprocess.Popen(["waybar"])


# Optional: Ensure Waybar restarts on config reload
@hook.subscribe.restart
def restart_waybar():
    subprocess.Popen(["pkill", "waybar"])
    subprocess.Popen(["waybar"])


@hook.subscribe.setgroup
@hook.subscribe.group_window_add
def update_waybar_workspaces(*args):
    # Get all group names and identify the current active one
    groups = [g.name for g in qtile.groups]
    active = qtile.current_group.name

    # Write to a file Waybar can read (e.g., /tmp/qtile-workspaces.txt)
    # You can format this as simple text or JSON
    with open("/tmp/qtile-workspaces.txt", "w") as f:
        f.write(f"{active} | {' '.join(groups)}")

    # Optional: trigger a signal if you want instant updates
    # subprocess.run(["pkill", "-RTMIN+7", "waybar"])
    #


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
