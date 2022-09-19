local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local awesome_path = os.getenv("HOME")
local icon_dir = awesome_path .. "icons/layouts"

local M = {}

function M.show_layer()
    local layout = awful.layout.get(awful.screen.focused())
    local name = awful.layout.getname(layout)
    -- local idx = awful.layout.get_tag_layout_index(name)
	local img_dir = beautiful.layout_list[name]
    naughty.notify({
		icon = img_dir,
		timeout = 2,
		position = "bottom_right",
		shape = gears.shape.rounded_rect,
		opacity = 0.9,
		replaces_id = 1
	})
end

return M