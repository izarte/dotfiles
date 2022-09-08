local wibox = require("wibox")
local awful = require("awful")
-- local naughty = require("naughty")
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
	obj.widget:set_image(beautiful.awesome_icon)
	obj.widget:connect_signal("button::press", function(c) awful.spawn("pavucontrol") end)

	-- Add a tooltip to the imagebox
	obj.tooltip = awful.tooltip({ objects = { K },
		timer_function = function() return obj:tooltipText() end } )
	obj.tooltip:add_to_object(obj.widget)

	obj:update()

	return obj
end

function Volume:tooltipText()
	return self:get_volume() .. "%"
end

function Volume:update()
	-- self.widget:set_image(beautiful.audio)
	local v = self:get_volume()
    local muted = run("pactl list sinks | grep -i silencio | cut -d ' ' -f 2")
	local vol = tonumber(v)
    if (muted) ~= ("no\n") then
        self.widget:set_image(beautiful.audio)
    else
        if vol <= 100 then
            self.widget:set_image(beautiful.audio1)
        else
            self.widget:set_image(beautiful.audio2)
        end
    end
end

function Volume:get_volume()
	return run("pactl list sinks | grep -i 'volumen: front' | cut -d '/' -f 2 | tr -s '\n' ' ' | sed -e 's/ *//g' | sed -e 's/%//g' |/bin/cat -e")
end

function Volume.mt:__call(...)
    return Volume.new(...)
end

return Volume