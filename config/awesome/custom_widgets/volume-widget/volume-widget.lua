local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local Volume = { mt = {}, wmt = {} }
Volume.wmt.__index = Volume
Volume.__index = Volume

local function run(command)
	local prog = io.popen(command)
	local result = prog:read('*all')
	prog:close()
	return result
end

function Volume:new()
	local obj = setmetatable({}, Volume)

	-- Create imagebox widget
	obj.widget = wibox.widget{ widget = wibox.widget.imagebox() }
	obj.widget:set_resize(true)
	obj.widget:set_image(self:get_icon())
	obj.widget:connect_signal("button::press", function(c) awful.spawn("pavucontrol") end)

	-- Add a tooltip to the imagebox
	obj.tooltip = awful.tooltip({ objects = { K },
		timer_function = function() return obj:tooltipText() end } )
	obj.tooltip:add_to_object(obj.widget)

	-- obj:update()

	return obj
end

function Volume:tooltipText()
	return self:get_volume() .. "%"
end

-- function Volume:show_volume_notification(img)
-- 	return self:get_volume() .. "%"
-- end

function Volume:show_volume_notification(img)
    -- local p = self:get_volume()
	naughty.notify({
		text = "" .. self:get_volume(),
		icon = img,
	-- title = "" .. self:get_volume(),
	-- text = "puta",
		icon_size = dpi(100),
		-- width = dpi(100),
		-- height = dpi(200),
		-- widget = wibox.container.background,
		valign,
		timeout = 1,
		position = "bottom_middle",
		shape = gears.shape.rounded_rect,
		opacity = 0.9,
		replaces_id = 1
	})
end

function Volume:get_icon()
	local icon = ""
	local muted = run("pactl list sinks | grep -i silencio | cut -d ' ' -f 2")
	if (muted) ~= ("no\n") then
		icon = beautiful.audio
	else
		local vol = tonumber(self:get_volume())
		if vol <= 100 then
			icon = beautiful.audio1
		else
			icon = beautiful.audio2
		end
	end
	return icon
end

function Volume:update()
	-- self.widget:set_image(beautiful.audio)
	local img = self:get_icon()
	self.widget:set_image(img)
	self:show_volume_notification(img)
end

function Volume:up()
	run("pactl -- set-sink-volume 0 +5%")
end

function Volume:down()
	run("pactl -- set-sink-volume 0 -5%")
end

function Volume:mute()
	run("pactl set-sink-mute 0 toggle")
end

function Volume:get_volume()
	return run("pactl list sinks | grep -i 'volumen: front' | cut -d '/' -f 2 | tr -s '\n' ' ' | sed -e 's/ *//g' | sed -e 's/%//g'")
end

function Volume.mt:__call(...)
    return Volume.new(...)
end

return Volume