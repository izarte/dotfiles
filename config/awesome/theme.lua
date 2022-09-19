---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local awesome_path = os.getenv("HOME") .. ("/.config/awesome/")
local icons_path = awesome_path .. "icons/"
local layouts_path = icons_path .. "layouts/"

local theme = {}

-- theme.font          = "sans 8"

theme.bg_normal     = "#1A1B26"
theme.bg_focus      = "#2c2e40"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- Fonts
theme.font_name = "Hack Nerd Font Mono "
theme.font = theme.font_name .. "9"
-- theme.icon_font_name = "Material Design Icons Desktop "
-- theme.icon_font = theme.icon_font_name .. "18"
-- theme.font_taglist = theme.icon_font_name .. "14"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(5)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
theme.notification_font = theme.font_name
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.width = dpi(20)
theme.height = dpi(20)
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- tags
theme.tag1 = icons_path .. "tags/tag1.png"
theme.tag2 = icons_path .. "tags/tag2.png"
theme.tag3 = icons_path .. "tags/tag3.png"
theme.tag4 = icons_path .. "tags/tag4.png"
theme.tag5 = icons_path .. "tags/tag5.png"
theme.tag6 = icons_path .. "tags/tag6.png"
theme.tag7 = icons_path .. "tags/tag7.png"
theme.tag8 = icons_path .. "tags/tag8.png"
theme.tag9 = icons_path .. "tags/tag9.png"
-- theme.taglist_spacing = dpi(2)

-- audio icons
theme.audio = icons_path .. "audio/audio.png"
theme.audio1 = icons_path .. "audio/audio1.png"
theme.audio2 = icons_path .. "audio/audio2.png"


-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = icons_path .. "arrow.png"
theme.menu_height = dpi(35)
theme.menu_width  = dpi(200)
theme.menu_font = theme.font_name .. "12"
theme.menu_submenu_icon_size = 0

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


-- Define the image to load
theme.titlebar_close_button_normal = icons_path .. "the_lost_head.png"
theme.titlebar_close_button_focus  = icons_path .. "isaac_head.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- theme.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
theme.layout_tile = icons_path .. "godhead.png"
theme.layout_fairh = layouts_path.."fairhw.png"
theme.layout_fairv = layouts_path.."fairvw.png"
theme.layout_floating  = layouts_path.."floatingw.png"
theme.layout_magnifier = layouts_path.."magnifierw.png"
theme.layout_max = layouts_path.."maxw.png"
theme.layout_fullscreen = layouts_path.."fullscreenw.png"
theme.layout_tilebottom = layouts_path.."tilebottomw.png"
theme.layout_tileleft   = layouts_path.."tileleftw.png"
theme.layout_tiletop = layouts_path.."tiletopw.png"
theme.layout_spiral  = layouts_path.."spiralw.png"
theme.layout_dwindle = layouts_path.."dwindlew.png"
theme.layout_cornernw = layouts_path.."cornernww.png"
theme.layout_cornerne = layouts_path.."cornernew.png"
theme.layout_cornersw = layouts_path.."cornersww.png"
theme.layout_cornerse = layouts_path.."cornersew.png"

theme.layout_list = {}
theme.layout_list["tile"] = theme.layout_tile
theme.layout_list["floating"] = theme.layout_floating
theme.layout_list["tileleft"] = theme.layout_tileleft
theme.layout_list["tilebottom"] = theme.layout_tilebottom
theme.layout_list["tiletop"] = theme.layout_tiletop
theme.layout_list["fairv"] = theme.layout_fairv
theme.layout_list["fairh"] = theme.layout_fairh
theme.layout_list["spiral"] = theme.layout_spiral
theme.layout_list["dwindle"] = theme.layout_dwindle
theme.layout_list["max"] = theme.layout_max
--
theme.layout_list["magnifier"] = theme.layout_magnifier
theme.layout_list["fullscreen"] = theme.layout_fullscreen
theme.layout_list["cornernw"] = theme.layout_cornernw
theme.layout_list["cornerne"] = theme.layout_cornerne
theme.layout_list["cornernsw"] = theme.layout_cornersw
theme.layout_list["cornerse"] = theme.layout_cornerse

-- Menu icon
theme.awesome_icon = icons_path .. "logo.png"
-- theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
