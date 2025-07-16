local wezterm = require("wezterm")

-- Battery status function
local function get_battery_status()
  local status = ""
  for _, battery in ipairs(wezterm.battery_info()) do
    local charge = math.floor(battery.state_of_charge * 100)
    status = "🔋 " .. charge .. "%"
    if battery.state == "Charging" then
      status = "⚡ " .. status
    end
  end
  return status
end

-- Event handler for formatting tab titles
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  return {
    {Text = title}, -- Tab title
  }
end)

-- Event handler for setting status updates in the tab bar
wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("%Y-%m-%d %H:%M:%S") -- Current date and time
  local battery = get_battery_status() -- Battery status
  
  -- Get the URI and extract the path
  local cwd_uri = pane:get_current_working_dir()
  local cwd_path = nil
  if cwd_uri then
    cwd_path = cwd_uri:match("^file://(.+)")
  end

  -- Extract last directory from the path, fallback to Unknown
  local cwd_display = "Unknown"
  if cwd_path then
    cwd_display = cwd_path:match("([^/]+)$") or cwd_path
  end

  -- Set statuses
  window:set_left_status("")
  window:set_right_status(date .. " | " .. battery)
  window:set_center_status(cwd_display)
end)

-- Main configuration
return {
  font = wezterm.font("FiraCode Nerd Font Propo"),
  font_size = 11.0,
  line_height = 1,
  color_scheme = "Gruvbox Dark (Gogh)",
  window_background_opacity = 0.8,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true, -- Move the tab bar to the bottom
  colors = {
    tab_bar = {
      background = "rgba(0, 0, 0, 0)", -- Transparent tab bar background
      active_tab = {
        bg_color = "#98971a", -- Gruvbox Green
        fg_color = "#282828", -- Gruvbox Dark background
      },
      inactive_tab = {
        bg_color = "#3c3836", -- Gruvbox Gray
        fg_color = "#ebdbb2", -- Gruvbox Light text
      },
      inactive_tab_hover = {
        bg_color = "#d79921", -- Gruvbox Yellow
        fg_color = "#fbf1c7", -- Hover text
        italic = true, -- Italic text for hover effect
      },
      new_tab = {
        bg_color = "#458588", -- Gruvbox Aqua
        fg_color = "#282828", -- Gruvbox Dark background
      },
      new_tab_hover = {
        bg_color = "#b16286", -- Gruvbox Purple
        fg_color = "#282828", -- Gruvbox Dark background
        italic = true,
      },
    },
  }
}
