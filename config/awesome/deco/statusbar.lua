-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")

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

  -- Create the wibox
  s.mywibox = awful.wibar({ 
                            type = "normal", ontop = true,
                            position = "left",
                            screen = s,
                            border_width = dpi(3),
                            width = dpi(30),
                            height = s.geometry.height - dpi(30),
                            -- stretch = false,
                            -- margins = { left = 30 }
                            -- opacity = 0.1, offset = {x = 30 }
  })
  -- awful.placement.left(s.mywibar, { margins = 2 })
  -- Add widgets to the wibox
  s.mywibox:setup {
    -- layout = wibox.container.margin,
    -- margins = 5, -- margins 10 for all sides
    layout = wibox.layout.align.vertical,
    {
      -- Rotate the widgets with the container
      RC.launcher,
      {
            s.mytaglist,
            direction = 'west',
            widget = wibox.container.rotate
        },
        layout = wibox.layout.fixed.vertical,
    },
    s.mytasklist,
    {
        layout = wibox.layout.fixed.vertical,
        {
            -- Rotate the widgets with the container
            {
              require("custom_widgets.battery-widget") {},
                mykeyboardlayout,
                -- wibox.widget.systray(),
                mytextclock,
                layout = wibox.layout.fixed.horizontal
            },
            direction = 'west',
            widget = wibox.container.rotate
        }
    },
    -- layout = wibox.layout.align.vertical,
    -- -- Rotate the widgets with the container
    -- RC.launcher,
    -- { --Left widgets
    --   s.mytaglist,
    --   s.mypromptbox,
    --   direction = 'west',
    --   widget = wibox.container.rotate,
    -- },
    -- -- layout = wibox.layout.fixed.vertical,
    -- -- { -- Left widgets
    -- --   layout = wibox.layout.fixed.vertical,
    -- --   RC.launcher,
    -- --   s.mytaglist,
    -- --   direction = 'west',
    -- --   widget = wibox.container.rotate,
    --   -- s.mypromptbox,
    -- -- },
    -- s.mytasklist,
    -- {
    --     layout = wibox.layout.fixed.vertical,
    --     {
    --         -- Rotate the widgets with the container
    --         {
    --             mykeyboardlayout,
    --             mytextclock,
    --             layout = wibox.layout.fixed.horizontal
    --         },
    --         direction = 'west',
    --         widget = wibox.container.rotate
    --     }
    -- },
    -- s.mytasklist, -- Middle widget
    -- { -- Right widgets
    --   {
    --     require("custom_widgets.battery-widget") {},
    --     layout = wibox.layout.fixed.horizontal,
    --     mykeyboardlayout,
    --     wibox.widget.systray(),
        -- mytextclock,
    --     s.mylayoutbox,
    --   },
    --   direction = 'west',
    --   widget = wibox.container.rotate,
    -- },
  }
end)
-- }}}
