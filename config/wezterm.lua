-- 配置場所: $HOME/.config/wezterm/wezterm.lua or $HOME/.wezterm.lua

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Window shape
config.font_size = 11
config.initial_rows = 60
config.initial_cols = 120
config.enable_scroll_bar = true

-- color scheme: https://wezterm.org/colorschemes/index.html
-- config.color_scheme = 'Afterglow'
config.color_scheme = 'GitHub Dark'

-- config.default_domain = 'WSL:Ubuntu' -- /mnt/c/Users/%USERNAME% を開く
config.default_prog = { "wsl.exe", "--distribution", "ubuntu", "--cd", "~" } -- $HOME を開く

config.window_close_confirmation = 'NeverPrompt' -- todo うまく効いていない
config.audible_bell = 'Disabled'
config.canonicalize_pasted_newlines = 'None'

-- デフォルトキーバインド確認: wezterm show-keys --lua
local act = wezterm.action
config.keys = {
    { key = 'c', mods = 'SHIFT|CTRL', action = act.SendKey { key = 'c', mods = 'CTRL' }},
    { key = 'c', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'f', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },

    { key = 'LeftArrow', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = 'RightArrow', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },

    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab { confirm = false }},
}

-- Down: ボタンを押す, Up: ボタンを離す
config.mouse_bindings = {
    -- URLを開くアクションを 左クリック から CTRL+左クリック に変更
    { event = { Up = { streak = 1, button = "Left" }}, mods = "NONE", action = act.DisableDefaultAssignment },
    { event = { Up = { streak = 1, button = "Left" }}, mods = "CTRL", action = act.OpenLinkAtMouseCursor },
    { event = { Down = { streak = 1, button = "Left" }}, mods = "CTRL", action = act.Nop }, 
}

-- and finally, return the configuration to wezterm
return config
