-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  local tags = {}

  awful.screen.connect_for_each_screen(function(s)

    tags = awful.tag.add("", {
      icon = beautiful.tag1,
      screen = s,
      layout = RC.layouts[1],
      selected = true,
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag2,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag3,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag4,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag5,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag6,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag7,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag8,
      screen = s,
      layout = RC.layouts[1],
    })

    tags = awful.tag.add("", {
      icon = beautiful.tag9,
      screen = s,
      layout = RC.layouts[1],
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
