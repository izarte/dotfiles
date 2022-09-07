-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful") -- for awesome.icon

local M = {}  -- menu
local _M = {} -- module

-- reading
-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- This is used later as the default terminal and editor to run.
-- local terminal = "xfce4-terminal"
local terminal = RC.vars.terminal

-- Variable definitions
-- This is used later as the default terminal and editor to run.
local editor = os.getenv("EDITOR") or "vim"
local file_explorer = RC.vars.file_explorer
local editor_cmd = terminal .. " -e " .. editor

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

M.awesome = {
  { " hotkeys", function() 
      hotkeys_popup.show_help(nil, awful.screen.focused()) 
    end },
    { " Reload wm", awesome.restart }
  }
  
  M.favorite = {
    { " Brave", "brave" },
    { " Terminal", terminal },
    { " Paint", "drawing" },
    { " Screenshot", "xfce4-screenshooter -f -s " .. os.getenv("HOME") .. "/Screenshots" },
    { " Recortes", "xfce4-screenshooter -r -s " .. os.getenv("HOME") .. "/Screenshots" },
    { " Sound", "pavucontrol" }
}

M.network_main = {
  { "wicd-curses", "wicd-curses" },
  { "wicd-gtk", "wicd-gtk" }
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()

  -- Main Menu
  local menu_items = {
    { "awesome", M.awesome, beautiful.awesome_subicon },
    { "open terminal", terminal },
    { "network", M.network_main },
    { "favorite", M.favorite }
  }
  local menu = awful.menu({
    -- Symbols are hidden
    items = {
      { " awesome",          M.awesome },
      { " favorite",         M.favorite },
      { " File explorer",    file_explorer },
      { " Color picker",     function ()
        awful.util.spawn_with_shell("colorpicker --short --one-shot | xsel -b")
      end},
      { " Log out",          function() awesome.quit() end },
      { " Reboot",           "reboot" },
      { " Shutdown",         "shutdown -h now" }
    }
  })
  return menu
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
