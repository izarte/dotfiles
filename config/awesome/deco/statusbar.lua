-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Wibox handling library
local wibox = require("wibox")
local beautiful = require("beautiful")
local volume_widget = require("custom_widgets.volume-widget.volume-widget")
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
mytextclock = wibox.widget{
  {
    widget = wibox.widget.textclock('%H:%M'),
  },
  left = dpi(6),
  right = dpi(5),
  widget = wibox.container.margin
}

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

--  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  -- Function to update the tags
  local focus_icon = gears.surface.load_uncached(beautiful.awesome_icon)
  local empty_icon = gears.surface.load_uncached(beautiful.tag1)
  local unfocus_icon = gears.surface.load_uncached(beautiful.tag2)


  local update_tags = function(self, c3)
    local tagicon = self:get_children_by_id('icon_role')[1]
    if c3.selected then
        tagicon.image = focus_icon
    elseif #c3:clients() == 0 then
        tagicon.image = empty_icon
    else
        tagicon.image = unfocus_icon
    end
  end

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    layout = {spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
    widget_template = {
      {
          {id = 'icon_role', widget = wibox.widget.imagebox},
          id = 'margin_role',
          top = dpi(5),
          bottom = dpi(5),
          left = dpi(5),
          right = dpi(5),
          widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
      create_callback = function(self, c3, index, objects)
          update_tags(self, c3)
      end,

      update_callback = function(self, c3, index, objects)
          update_tags(self, c3)
      end
    },
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
      width = s.geometry.width * 0.035,
      -- shape = gears.shape.rounded_rect(cr, 1200, 50, 10),
      height = s.geometry.height - dpi(30),
      border_width = s.geometry.width / 180,
      border_color = "#00000"
    }
  )

  -- Creating volume widget and connecting to volume change signal
  local volume = volume_widget:new({})
  awesome.connect_signal("volume_change", function () volume:update() end)

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
          -- mykeyboardlayout,
          layout = wibox.layout.fixed.horizontal
        },
        direction = 'west',
        widget = wibox.container.rotate
      },
      -- require("custom_widgets.volume-widget.volume-widget"),
      require("custom_widgets.battery-widget") {},
      mytextclock,
      volume.widget,
      wibox.widget.systray(),
    },
  }
end)
-- }}}
