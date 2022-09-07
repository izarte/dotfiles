-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create wibox
  s.mywibox = awful.wibar (
    {
      position = "left",
      screen = s,
      width = dpi(40),
      height = s.geometry.height - dpi(30),
      border_width = s.geometry.width / 180,
      border_color = "#00000"
    }
  )

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.vertical,
    { -- Left widgets
      -- Rotate the widgets with the container
      RC.launcher,
      {
        s.mytaglist,
        s.mypromptbox,
        direction = 'west',
        widget = wibox.container.rotate
      },
        layout = wibox.layout.fixed.vertical,
    },

    s.mytasklist,

    { -- Right widgets
      layout  = wibox.layout.fixed.vertical,
      {
        -- Rotate the widgets with the container
        {
          require("custom_widgets.battery-widget") {},
          mykeyboardlayout,
          wibox.widget.systray(),
          mytextclock,
          layout = wibox.layout.fixed.horizontal
        },
        direction = 'west',
        widget = wibox.container.rotate
      },
      s.mylayoutbox,
    },
  }
end)
-- }}}
