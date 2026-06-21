----------------------------------------------------------------
-- Defaults
----------------------------------------------------------------
local mod = "SUPER"
local terminal = "ghostty"
local fileManager = "nemo"
local idlehandler = "hypridle"
local browser = "brave"
local launcher = "fuzzel"
local lockscreen = "hyprlock"

----------------------------------------------------------------
-- Monitor
----------------------------------------------------------------
hl.monitor({
    output = "DP-2",
    mode = "3440x1440@240Hz",
    position = "0x0",
    scale = "1",
    bitdepth = 10,
    vrr = 3,
})

----------------------------------------------------------------
-- Environment Vars
----------------------------------------------------------------
local envs = {
    QT_QPA_PLATFORMTHEME         = "qt6ct",
    QT_QPA_PLATFORM              = "wayland",
    ELECTRON_OZONE_PLATFORM_HINT = "auto",
}

for key, val in pairs(envs) do
    hl.env(key, val)
end

local home = os.getenv("HOME")
local waybar_config = home .. "/.config/waybar/hyprland.jsonc"
----------------------------------------------------------------
-- Config Table Block
----------------------------------------------------------------
hl.config({
    input = {
        follow_mouse = 1,
        float_switch_override_focus = 2,
    },

    general = {
        gaps_in = 4,
        gaps_out = 6,
        border_size = 3,
        layout = "dwindle",
        snap = {
            enabled = true,
            respect_gaps = 1,
        },
    },

    decoration = {
        rounding = 4,
        active_opacity = 1.0,
        blur = {
            enabled = true,
            size = 15,
            passes = 2,
            xray = true,
        },
        shadow = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
        bezier = {
            "overshot, 0.13, 0.99, 0.29, 1.1",
        },
        animation = {
            "windowsIn, 1, 4, overshot, slide",
            "windowsOut, 1, 5, default, popin 80%",
            "border, 1, 5, default",
            "workspacesIn, 1, 6, overshot, slide",
            "workspacesOut, 1, 6, overshot, slidefade 80%",
        },
    },

    group = {
        groupbar = {
            font_family = "Fira Sans",
        },
    },

    misc = {
        font_family = "Fira Sans",
        splash_font_family = "Fira Sans",
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_swallow = true,
        swallow_regex = "^(nautilus|nemo|thunar|btrfs-assistant.)$",
        focus_on_activate = true,
        vrr = 3,
    },

    render = {
        direct_scanout = true,
        cm_auto_hdr = true,
    },

    dwindle = {
        special_scale_factor = 0.8,
        preserve_split = true,
    },

    master = {
        new_status = "master",
        special_scale_factor = 0.8,
    },
})

----------------------------------------------------------------
-- Gestures
----------------------------------------------------------------
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left", action = "float" })

----------------------------------------------------------------
-- Keybinds
----------------------------------------------------------------

-- Core Application Launchers (Waybar / Dotfiles Profile Targets)
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + L", hl.dsp.exec_cmd(lockscreen))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("fuzzel"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("waypaper --backend hyprpaper --random"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("wlogout --protocol layer-shell --buttons-per-row 4"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("nwg-look"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SUPER + H", hl.dsp.exec_cmd("nixos-help"))

-- Applications
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + S", hl.dsp.exec_cmd("spotify"))

-- Native Hardware Audio Controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { repeating = true, locked = true })

-- Media Navigation Controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Window Actions
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + Y", hl.dsp.window.pin())

-- Tiling Layout Splitting
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))

-- Group/Tab Management
hl.bind("SUPER + Tab", hl.dsp.group.prev())

-- Focus Movement
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }))

-- Window Movement
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))

-- Relative Workspace Navigators
hl.bind("SUPER + PERIOD", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + COMMA", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + ALT + RIGHT", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + LEFT", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + slash", hl.dsp.focus({ workspace = "previous" }))

-- Special Workspaces / Scratchpads
hl.bind("SUPER + minus", hl.dsp.window.move({ workspace = "special" }))
hl.bind("SUPER + equal", hl.dsp.workspace.toggle_special("special"))
hl.bind("SUPER + F1", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + ALT + SHIFT + F1", hl.dsp.window.move({ workspace = "special:scratchpad", silent = true }))

----------------------------------------------------------------
-- Workspaces Loop
----------------------------------------------------------------
for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i), silent = true }))
    hl.bind("SUPER + CTRL + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

----------------------------------------------------------------
-- Mouse Binds
----------------------------------------------------------------
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

----------------------------------------------------------------
-- Autostart
----------------------------------------------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("waybar -c " .. waybar_config)
    hl.exec_cmd("exec waypaper --backend hyprpaper --random")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprlauncher -d")
    hl.exec_cmd("hyprpolkitagent")
end)
