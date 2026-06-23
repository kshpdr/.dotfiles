local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Light color scheme.
-- To switch, replace the value with any of the alternatives below:
--   "Builtin Solarized Light"
--   "Github (Gogh)"
--   "GitHub Light (Gogh)"
--   "Gruvbox Light, light (base16)"
--   "One Light (base16)"
--   "ayu_light"
--   "PaperColor Light (Gogh)"
--   "Tomorrow"
--   "Catppuccin Latte"
config.color_scheme = "Builtin Solarized Light"

-- Comfort tweaks
config.font_size = 13.0
config.line_height = 1.1
config.window_padding = { left = 8, right = 8, top = 6, bottom = 6 }
config.window_background_opacity = 0.98
config.window_decorations = "RESIZE"

-- CMD+Left / CMD+Right -> jump to beginning / end of the line.
-- These send Ctrl+A / Ctrl+E, the readline shortcuts most shells understand.
config.keys = {
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "e", mods = "CTRL" }),
	},
	-- CMD+Backspace -> delete from cursor to beginning of line (readline Ctrl+U).
	{
		key = "Backspace",
		mods = "CMD",
		action = wezterm.action.SendKey({ key = "u", mods = "CTRL" }),
	},
	-- ALT+Backspace -> delete the previous word (readline Ctrl+W).
	{
		key = "Backspace",
		mods = "ALT",
		action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
	},
}

return config
