from libqtile import bar, layout, widget

from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from libqtile.config import Click, Drag, Group, Key, Match, Screen

from volume import VolumeControl

import os

mod = "mod4"
terminal = guess_terminal()

QTILE_SCALE = os.getenv('QTILE_SCALE')
QTILE_SCALE = int(QTILE_SCALE) if QTILE_SCALE else 1

# Key Bindings
keys = [
    Key([mod], "h", lazy.layout.left(),  desc = "Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc = "Move focus to right"),
    Key([mod], "j", lazy.layout.down(),  desc = "Move focus down"),
    Key([mod], "k", lazy.layout.up(),    desc = "Move focus up"),

    Key([mod], "space", lazy.layout.next(), desc = "Move window focus to other window"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),  desc = "Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc = "Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),  desc = "Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),    desc = "Move window up"),

    Key([mod, "control"], "h", lazy.layout.grow_left(),  desc = "Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc = "Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),  desc = "Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),    desc = "Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc = "Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    Key([mod], "Tab", lazy.next_layout(), desc = "Toggle between layouts"),

    Key([mod, "shift"], "q", lazy.window.kill(), desc = "Kill focused window"),

    Key([mod, "control"], "q", lazy.shutdown(),      desc = "Shutdown Qtile"),
    Key([mod, "control"], "r", lazy.reload_config(), desc = "Reload the config"),

    Key([mod], "Return", lazy.spawn(terminal), desc = "Launch terminal"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc = "Spawn a command using a prompt widget"),

    Key([], "XF86AudioRaiseVolume", lazy.widget["volumecontrol"].increase_vol(), desc = "Raise Volume by 5%"),
    Key([], "XF86AudioLowerVolume", lazy.widget["volumecontrol"].decrease_vol(), desc = "Lower Volume by 5%"),

    #Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5"), desc = "Raise Volume by 5%"),
    #Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5"), desc = "Lower Volume by 5%"),
]   

# Groups
groups = [Group(f"{i+1}", label = "") for i in range(9)]

for group in groups:
    keys.extend(
        [
            Key(
                [mod],
                group.name,
                lazy.group[group.name].toscreen(),
                desc = f"Switch to group {group.name}",
            ),

            Key(
                [mod, "shift"],
                group.name,
                lazy.window.togroup(group.name, switch_group = True),
                desc = f"Switch to & move focused window to group {group}",
            ),
        ]
    )

# Layouts
layouts = [
    layout.MonadTall(
        margin = QTILE_SCALE * 8,
        border_focus = '#1F1D2E',
        border_normal = '#1F1D2E',
        border_width = QTILE_SCALE * 4,
    ),
    
    layout.Max(
        margin = QTILE_SCALE * 8,
        border_focus = '#1F1D2E',
        border_normal = '#1F1D2E',
        border_width = 0,
    ),
    
    layout.Floating(
        border_focus = '#1F1D2E',
        border_normal = '#1F1D2E',
        border_width = 0,
    ),
]

widget_defaults = dict(
    font = "Hack Nerd Font Bold",
    fontsize = QTILE_SCALE * 12,
    padding = QTILE_SCALE * 3,
)

extension_defaults = [ widget_defaults.copy()]

black = "#000000"
clear = "#00000000"

left  = '~/.config/qtile/Assets/left.png'
right = '~/.config/qtile/Assets/right.png'

# Bar
screens = [
    Screen(
        wallpaper = '~/.config/qtile/Assets/wallpaper.jpg',
        wallpaper_mode = 'stretch',

        top = bar.Bar(
            [
                widget.Spacer(
                    length = QTILE_SCALE * 20,
                    background = black,
                ),
                
                widget.Image(
                    filename = '~/.config/qtile/Assets/icon.png',
                    background = black,
                ),

                widget.Image(
                    filename = right,
                    background = clear,
                ),

                widget.Image(
                    filename = left,
                    background = clear,
                ),

                widget.GroupBox(
                    fontsize = QTILE_SCALE * 16,

                    highlight_method = 'border',
                    borderwidth = 0,
                    spacing = QTILE_SCALE * 6,

                    active = '#696969',
                    inactive = '#323232',

                    block_highlight_text_color = "#FFFFFF",

                    background = black,

                    rounded = False,
                    disable_drag = True,
                    use_mouse_wheel = False,
                ),

                widget.Image(
                    filename = right,
                    background = clear,
                ),

                widget.Image(
                    filename = left,
                    background = clear,
                ),

                widget.CurrentLayoutIcon(
                    scale = 0.5,
                    padding = 0,
                    background = black,
                ),

                widget.CurrentLayout(
                    background = black,
                ),

                widget.Image(
                    filename = right,
                    background = clear,
                ),

                widget.Image(
                    filename = left,
                    background = clear,
                ),

                widget.WindowName(
                    format = "{name}",
                    background = black,
                    empty_group_string = 'Desktop',
                ),

                widget.Image(
                    filename = right,
                    background = clear,
                ),

                widget.Image(
                    filename = left,
                    background = clear,
                ),

                widget.Battery(
                    format = "{char} {percent:2.0%} ({hour:d}:{min:02d})",
                    charge_char = "Charging",
                    discharge_char = "Discharging",
                    background = black,
                ),

                widget.Image(
                    filename = right,
                    background = clear,
                ),

                widget.Image(
                    filename = left,
                    background = clear,
                ),

                widget.TextBox(
                    text = "",
                    fontsize = QTILE_SCALE * 16,
                    padding = QTILE_SCALE * 8,
                    background = black,
                ),

                VolumeControl(
                    padding = QTILE_SCALE * 8,
                    background = black,
                ),
                
                #widget.PulseVolume(
                #    padding = QTILE_SCALE * 8,
                #    background = black,
                #),

                widget.Image(
                    filename = right,
                    background = clear,
                ),

                widget.Image(
                    filename = left,
                    background = clear,
                ),

                widget.Clock(
                    format = '%a %b %d %I:%M',
                    background = black,
                ),

                widget.Spacer(
                    length = QTILE_SCALE * 20,
                    background = black,
                ),
            ],

            QTILE_SCALE * 30,
            background = "#00000000",
            margin = [QTILE_SCALE * 6] * 4
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start = lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start = lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus = '#1F1D2E',
    border_normal = '#1F1D2E',
    border_width = 0,
    float_rules = [
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class = "confirmreset"),  # gitk
        Match(wm_class = "makebranch"),  # gitk
        Match(wm_class = "maketag"),  # gitk
        Match(wm_class = "ssh-askpass"),  # ssh-askpass
        Match(title = "branchdialog"),  # gitk
        Match(title = "pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
