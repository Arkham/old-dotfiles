-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widgets library
require("wicked")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
theme_path = "/home/arkham/.config/awesome/themes/default/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme.lua"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["vlc"] = true,
    ["gimp"] = true,
    ["pidgin"] = true,
    ["empathy"] = true,
    -- by instance
    -- ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    ["Firefox"] = { screen = 1, tag = 2 },
    ["midori"] = { screen = 1, tag = 2 },
    ["opera"] = { screen = 1, tag = 2 },
    ["azureus"] = { screen = 1, tag = 2},
    ["xchat"] = { screen = 1, tag = 3 },
    ["weechat"] = { screen = 1, tag = 3},
    ["pidgin"] = { screen = 1, tag = 4 },
    ["empathy"] = { screen = 1, tag = 4 },
    ["skype"] = { screen = 1, tag = 4 },
    ["geany"] = { screen = 1, tag = 5 },
    ["eclipse"] = { screen = 1, tag = 5},
    ["emacs"] = { screen = 1, tag = 5},
    ["mocp"] = { screen = 1, tag = 6 },
    ["Exaile"] = { screen = 1, tag = 6 },
    ["Audacious"] = { screen = 1, tag = 6 },
    ["mplayer"] = { screen = 1, tag = 6 },
    ["vlc"] = { screen = 1, tag = 6 },
    ["thunar"] = { screen = 1, tag = 7 },
    ["soffice"] = { screen = 1, tag = 7},
    ["gimp"] = { screen = 1, tag = 7}
}

-- Define if we want to use titlebar on all applications.
use_titlebar = true
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    -- for tagnumber = 1, 9 do
        -- tags[s][tagnumber] = tag(tagnumber)
        -- Add tags to screen one by one
        -- tags[s][tagnumber].screen = s
        -- awful.layout.set(layouts[1], tags[s][tagnumber])
    -- end
    
    tags[s][1] = tag("[1] term")
    tags[s][1].screen = s
    awful.layout.set(layouts[3], tags[s][1])

    tags[s][2] = tag("[2] web")
    tags[s][2].screen = s
    awful.layout.set(layouts[4], tags[s][2])

    tags[s][3] = tag("[3] irc")
    tags[s][3].screen = s
    awful.layout.set(layouts[10], tags[s][3])

    tags[s][4] = tag("[4] chat")
    tags[s][4].screen = s
    awful.layout.set(layouts[2], tags[s][4])

    tags[s][5] = tag("[5] work")
    tags[s][5].screen = s
    awful.layout.set(layouts[3], tags[s][5])

    tags[s][6] = tag("[6] media")
    tags[s][6].screen = s
    awful.layout.set(layouts[3], tags[s][6])

    tags[s][7] = tag("[7] desk")
    tags[s][7].screen = s
    awful.layout.set(layouts[7], tags[s][7])
    
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end
-- }}}

-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> " .. awesome.release .. " </small></b>"

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
wibox_bottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 5, awful.tag.viewnext),
                    awful.button({ }, 4, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)


    --------------------
    ---Custom widgets---
    --------------------
    -- cpu
    cpuwidget = widget({
        type = 'textbox',
        name = 'cpuwidget'
    })

    function read_cpuinfo()
        local fd = io.popen('cpuinfo')
        local value = fd:read()
        fd:close()

        return {value}
    end

    wicked.register(cpuwidget, read_cpuinfo,
        ' <span color="#4C9EFF">CPU:</span> $1 ', 10)

    -- cpugraph
    cpugraphwidget = widget({
        type = 'graph',
        name = 'cpugraphwidget',
        align = 'left'
    })
    
    cpugraphwidget.height = 0.85
    cpugraphwidget.width = 45
    cpugraphwidget.bg = '#333333'
    cpugraphwidget.border_color = '#0a0a0a'
    cpugraphwidget.grow = 'left'
    
    cpugraphwidget:plot_properties_set('cpu', {
        fg = '#00FF3D',
        fg_center = '#00FF3D',
        fg_end = '#3299FE',
        vertical_gradient = false
    })
    
    wicked.register(cpugraphwidget, wicked.widgets.cpu, '$1', 1, 'cpu' )
    
    -- mem
    memwidget = widget({
        type = 'textbox',
        name = 'memwidget'
    })
    
    wicked.register(memwidget, wicked.widgets.mem,
        ' <span color="#4C9EFF"> RAM:</span> $2MB/$3MB ', 10)
    
    -- memgraph
    memgraphwidget = widget({
        type = 'graph',
        name = 'memgraphwidget',
        align = 'left'
    })
    
    memgraphwidget.height = 0.85
    memgraphwidget.width = 45
    memgraphwidget.bg = '#333333'
    memgraphwidget.border_color = '#0a0a0a'
    memgraphwidget.grow = 'left'
    
    memgraphwidget:plot_properties_set('mem', {
        fg = '#00FF3D',
        fg_center = '#00FF3D',
        fg_end = '#3299FE',
        vertical_gradient = false
    })
    
    wicked.register(memgraphwidget, wicked.widgets.mem, '$1', 1, 'mem')
 
    -- fs
    fswidget = widget({
        type = 'textbox',
        name = 'fswidget',
        align = 'left'
    })
    
    wicked.register(fswidget, wicked.widgets.fs,
        ' <span color="#4C9EFF">Root:</span> ${/ used}/${/ size} <span color="#4C9EFF">Acer:</span> ${/media/ACER used}/${/media/ACER size} ', 120)

    -- mocp
    mocpwidget = widget({
        type = 'textbox',
        name = 'mocpwidget',
        align = 'right'
    })

    wicked.register(mocpwidget, wicked.widgets.mocp, ' <span color="#4C9EFF">MOC:</span> $1', 5, nil, 65)

    -- battery
    -- function to extract charge percentage
    function read_battery_life(number)
       return function(format)
                 local fh = io.popen('acpi')
                 local output = fh:read("*a")
                 fh:close()
    
                 count = 0
                 for s in string.gmatch(output, "(%d+)%%") do
                    if number == count then
                       return {s}
                    end
                    count = count + 1
                 end
              end
    end

    -- text widget
    batterywidget = widget({
        type = 'textbox',
        name = 'batterywidget',
        align = 'right'
    })
    
    wicked.register(batterywidget, read_battery_life(0),
        ' <span color="#4C9EFF">BAT:</span> $1% ',
        10, nil, 2)

   
    -- display one vertical progressbar per battery
    batterygraphwidget = widget({ type = 'progressbar',
                                  name = 'batterygraphwidget',
                                  align = 'right' })
    batterygraphwidget.height = 0.85
    batterygraphwidget.width = 8
    batterygraphwidget.bg = '#333333'
    batterygraphwidget.border_color = '#0a0a0a'
    batterygraphwidget.vertical = true
    batterygraphwidget:bar_properties_set('battery',
                                          { fg = '#AEC6D8',
                                            fg_center = '#285577',
                                            fg_end = '#285577',
                                            fg_off = '#222222',
                                            vertical_gradient = true,
                                            horizontal_gradient = false,
                                            ticks_count = 0,
                                            ticks_gap = 0 })
  
    wicked.register(batterygraphwidget, read_battery_life(0), '$1', 10, 'battery')

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    wibox_bottom[s] = wibox({ position = "bottom", fg = beautiful.fg_normal, bg = beautiful.bg_normal })

    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mytasklist[s],
                           mypromptbox[s],
                           mytextbox,
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }

    wibox_bottom[s].widgets = { cpuwidget,
                                cpugraphwidget,
                                memwidget,
                                memgraphwidget,
                                fswidget,
                                uwidget,
                                mocpwidget,
                                batterywidget,
                                batterygraphwidget }

    mywibox[s].screen = s
    wibox_bottom[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "x",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey }, "t", awful.client.togglemarked),
    awful.key({ modkey,}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, i,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, i,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          tags[screen][i].selected = not tags[screen][i].selected
                      end
                  end),
        awful.key({ modkey, "Shift" }, i,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, i,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "F" .. i,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          for k, c in pairs(awful.client.getmarked()) do
                              awful.client.movetotag(tags[screen][i], c)
                          end
                      end
                   end))
end

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c, startup)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for filtered windows (i.e. no dock, etc).
    if not startup and awful.client.focus.filter(c) then
        c.screen = mouse.screen
    end

    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons(awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize)
    ))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] ~= nil then
        awful.client.floating.set(c, floatapps[cls])
    elseif floatapps[inst] ~= nil then
        awful.client.floating.set(c, floatapps[inst])
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
    client.focus = c

    -- Set key bindings
    c:keys(clientkeys)

    -- Set the windows at the slave
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.size_hints_honor = false
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout and beautiful["layout_" ..layout] then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)

-- Hook called every minute
awful.hooks.timer.register(60, function ()
    mytextbox.text = os.date(" %a %b %d, %H:%M ")
end)
-- }}}
