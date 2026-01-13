-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

------------------------------------
-- NOTE: Configuration starts here:

-- Open PowerShell as default Shell (-NoLogo flag to avoid showing version and loading time)
config.default_prog = { "pwsh", "-NoLogo" }
-- Configure to use JetBrains Mono as default font
config.font = wezterm.font 'JetBrains Mono'
-- Change color scheme (theme) to Flexoki Dark (https://github.com/kepano/flexoki/tree/main/wezterm)
config.color_scheme = "Flexoki Dark"
config.color_scheme_dirs = { './colors/' }
-- Define the terminal opaccity
config.window_background_opacity = 0.85
-- Hide window decoration
config.window_decorations = "RESIZE"
config.default_cursor_style = "SteadyUnderline"
-- TODO: UPDATE IS REQUIRED -- config.show_close_tab_button_in_tabs = false
config.show_new_tab_button_in_tab_bar = false
-- Window Padding configuration
config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}
-- Define Inital Rows and Columns
config.initial_rows = 30
config.initial_cols = 100

-- NOTE: Keybinding configuration:
config.disable_default_key_bindings =  true

config.keys = {
  {
    -- Split pane config by @quantoganh (https://github.com/wezterm/wezterm/discussions/3779)
    key = ";",
    mods = "CTRL",
    action = wezterm.action_callback(function(_, pane)
      local tab = pane:tab()
      local panes = tab:panes_with_info()
      if #panes == 1 then
        pane:split({
          direction = "Bottom",
          size = 0.5,
        })
      elseif panes[1].is_zoomed then
        tab:set_zoomed(false)
        for _, p in ipairs(panes) do
          if p.pane:pane_id() == last_active_pane_id then
            p.pane:activate()
            return
          end
        end
      else
        last_active_pane_id = pane:pane_id()
        panes[1].pane:activate()
        tab:set_zoomed(true)
      end
    end),
  },

  -- paste from the clipboard
  { 
    key = 'V', 
    mods = 'CTRL', 
    action = act.PasteFrom 'Clipboard' 
  },
}

-- NOTE: End of configuration
return config

