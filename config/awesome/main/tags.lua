-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  local tags = {}

  awful.screen.connect_for_each_screen(function(s)

    tags = awful.tag.add("", {
      name = 1,
      icon = beautiful.active_tags[1],
      screen = s,
      layout = RC.layouts[1],
      selected = true,
      active = true,
    })

    tags = awful.tag.add("", {
      name = 2,
      icon = beautiful.no_active_tags[2],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

    tags = awful.tag.add("", {
      name = 3,
      icon = beautiful.no_active_tags[3],
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      name = 4,
      icon = beautiful.no_active_tags[4],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

    tags = awful.tag.add("", {
      name = 5,
      icon = beautiful.no_active_tags[5],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

    tags = awful.tag.add("", {
      name = 6,
      icon = beautiful.no_active_tags[6],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

    tags = awful.tag.add("", {
      name = 7,
      icon = beautiful.no_active_tags[7],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

    tags = awful.tag.add("", {
      name = 8,
      icon = beautiful.no_active_tags[8],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

    tags = awful.tag.add("", {
      name = 9,
      icon = beautiful.no_active_tags[9],
      screen = s,
      layout = RC.layouts[1],
      active = false,
    })

  
    -- awful.tag.add("first")
    -- {
    --   icon = beautiful.awesome_icon
    -- }
    -- Each screen has its own tag table.
    --  tags[s] = awful.tag(
    --    { "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, RC.layouts[1]
    --  )
  end)
  
  return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
