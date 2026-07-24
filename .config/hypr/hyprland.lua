-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty fish"
local fileManager = "thunar"
-- local menu      = "wofi --show drun"
local menu         = "vicinae toggle"
local browser      = "zen"

local defaultMfact = 0.50


-------------------
---- AUTOSTART ----
-------------------

-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
-- end)
hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar & hyprpaper")
  -- debug waybar: comment the line above, uncomment below (logs -> /tmp/waybar-boot.log)
  -- hl.exec_cmd("waybar -l debug > /tmp/waybar-boot.log 2>&1 & hyprpaper")
  hl.exec_cmd("systemctl --user start vicinae.service")
  -- hl.exec_cmd("walker --gapplication-service")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


----------------------
---- LOOK AND FEEL ----
----------------------

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 2,

    -- https://wiki.hypr.land/Configuring/Basics/Variables/ for info about colors
    ["col.active_border"]   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
    ["col.inactive_border"] = "rgba(595959aa)",

    -- Set to true enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    -- layout = "dwindle",
    layout = "master",
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    rounding = 0,

    -- Change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    -- shadow = {
    --   enabled = true,
    --   range = 4,
    --   render_power = 3,
    --   color = "rgba(1a1a1aee)",
    -- },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    blur = {
      enabled = true,
      size = 3,
      passes = 1,

      vibrancy = 0.1696,
    },
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.config({ animations = { enabled = true } })

-- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/ for more
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    -- @vgavro i don't understand why it's needed, and it's off by default
    -- pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "slave",
    mfact = defaultMfact,
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
  misc = {
    force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
  },
})


-------------
--- INPUT ----
-------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    kb_layout = "us,ua,ru",
    -- kb_variant = ",qwerty",
    -- kb_model = "",
    kb_options = "grp:caps_toggle,grp:ctrls_toggle",
    -- kb_rules = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
      tap_to_click = true,
      scroll_factor = 1.0,
    },
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- `workspace_swipe` was removed in favor of the new gesture system, and was `false`
-- here anyway, so no `hl.gesture()` call is needed to reproduce it (gestures are opt-in now).

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})


--------------------
--- KEYBINDINGSS ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--CUSTOMS
-- hl.bind(mainMod .. " + RETURN", hl.dsp.layout("focusmaster"))
hl.bind(mainMod .. " + RETURN", hl.dsp.layout("swapwithmaster ignoremaster"))

hl.bind(mainMod .. " + M",         hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("removemaster"))

-- center orientation skipped
hl.bind(mainMod .. " + CTRL + M", hl.dsp.layout("orientationcycle left top right bottom"))

hl.bind(mainMod .. " + J",         hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + K",         hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("rollnext"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.layout("rollprev"))

hl.bind(mainMod .. " + H", hl.dsp.layout("mfact -0.05"), { repeating = true, locked = true })
hl.bind(mainMod .. " + L", hl.dsp.layout("mfact +0.05"), { repeating = true, locked = true })
hl.bind(mainMod .. " + G", hl.dsp.layout("mfact exact " .. defaultMfact))



hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized" }))  -- maximize (bar visible)
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" })) -- fullscreen

-- https://github.com/hyprwm/Hyprland/issues/7366
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen_state({ internal = -1, client = 2 })) -- fakefullscreen

hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | satty -f -"))
hl.bind("Print",         hl.dsp.exec_cmd('grim -g "$(slurp -w 0)" - | satty -f -'))

hl.bind("XF86AudioRaiseVolume",         hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 3 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",         hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { repeating = true, locked = true })
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { repeating = true, locked = true })
hl.bind("XF86AudioMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })


hl.bind("XF86MonBrightnessUp",         hl.dsp.exec_cmd("brightnessctl s 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown",       hl.dsp.exec_cmd("brightnessctl s 5%-"), { repeating = true, locked = true })
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%"),   { locked = true })
hl.bind("SHIFT + XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 100%"), { locked = true })
--
-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd(browser))

------------------------------
--- WINDOWS AND WORKSPACES ----
------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Example window rule
-- hl.window_rule({ match = { class = "^(kitty)$" }, float = true })

-- no border for fullscreened windows
hl.window_rule({ match = { fullscreen = true }, border_size = 0 })

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" }) -- You'll probably like this.

-- flameshot
-- hl.window_rule({ match = { class = "(flameshot)" }, move = {0, 0} })
-- hl.window_rule({ match = { class = "(flameshot)" }, pin = true })
-- hl.window_rule({ match = { class = "(flameshot)" }, no_border = true })
-- hl.window_rule({ match = { class = "(flameshot)" }, stay_focused = true })
hl.window_rule({ match = { class = "(flameshot)" }, float = true })
-- -- avoid transparency
-- hl.window_rule({ match = { class = "(flameshot)" }, opaque = true })
-- -- manually specify top-left-most monitor, if it's not the 0x0 monitor
-- -- hl.window_rule({ match = { class = "(flameshot)" }, monitor = "DP-2" })
