local globalData = require("globalData")
local json = require("json")

local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

math.randomseed(os.time())

composer.gotoScene("menu")