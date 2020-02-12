local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

math.randomseed(os.time())

composer.gotoScene("menu")



local globalData = require("globalData")
local json = require("json")



globalData.gpgs = nil
globalData.gameCenter = nil

local platform = system.getInfo( "platform" )
local env = system.getInfo( "environment" )
 
if ( platform == "android" and env ~= "simulator" ) then
    globalData.gpgs = require( "plugin.gpgs.v2" )
elseif ( platform == "ios" and env ~= "simulator" ) then
    globalData.gameCenter = require( "gameNetwork" )
end

-- Google Play Games Services initialization/login listener
local function gpgsInitListener( event )
 
    if not event.isError then
        if ( event.name == "login" ) then  -- Successful login event
            print( json.prettify(event) )
        end
    end
end
 
-- Apple Game Center initialization/login listener
local function gcInitListener( event )
 
    if event.data then  -- Successful login event
        print( json.prettify(event) )
    end
end




-- Initialize game network based on platform
if ( globalData.gpgs ) then
    -- Initialize Google Play Games Services
    globalData.gpgs.login( { userInitiated=true, listener=gpgsInitListener } )
 
elseif ( globalData.gameCenter ) then
    -- Initialize Apple Game Center
    globalData.gameCenter.init( "gamecenter", gcInitListener )
end

local function submitScoreListener( event )
 
    -- Google Play Games Services score submission
    if ( globalData.gpgs ) then
 
        if not event.isError then
            local isBest = nil
            if ( event.scores["daily"].isNewBest ) then
                isBest = "a daily"
            elseif ( event.scores["weekly"].isNewBest ) then
                isBest = "a weekly"
            elseif ( event.scores["all time"].isNewBest ) then
                isBest = "an all time"
            end
            if isBest then
                -- Congratulate player on a high score
                local message = "You set " .. isBest .. " high score!"
                native.showAlert( "Congratulations", message, { "OK" } )
            else
                -- Encourage the player to do better
                native.showAlert( "Sorry...", "Better luck next time!", { "OK" } )
            end
        end
 
    -- Apple Game Center score submission
    elseif ( globalData.gameCenter ) then
 
        if ( event.type == "setHighScore" ) then
            -- Congratulate player on a high score
            native.showAlert( "Congratulations", "You set a high score!", { "OK" } )
        else
            -- Encourage the player to do better
            native.showAlert( "Sorry...", "Better luck next time!", { "OK" } )
        end
    end
end

local function submitScoreListener( event )
 
    -- Google Play Games Services score submission
    if ( globalData.gpgs ) then
 
        if not event.isError then
            local isBest = nil
            if ( event.scores["daily"].isNewBest ) then
                isBest = "a daily"
            elseif ( event.scores["weekly"].isNewBest ) then
                isBest = "a weekly"
            elseif ( event.scores["all time"].isNewBest ) then
                isBest = "an all time"
            end
            if isBest then
                -- Congratulate player on a high score
                local message = "You set " .. isBest .. " high score!"
                native.showAlert( "Congratulations", message, { "OK" } )
            else
                -- Encourage the player to do better
                native.showAlert( "Sorry...", "Better luck next time!", { "OK" } )
            end
        end
 
    -- Apple Game Center score submission
    elseif ( globalData.gameCenter ) then
 
        if ( event.type == "setHighScore" ) then
            -- Congratulate player on a high score
            native.showAlert( "Congratulations", "You set a high score!", { "OK" } )
        else
            -- Encourage the player to do better
            native.showAlert( "Sorry...", "Better luck next time!", { "OK" } )
        end
    end
end
if ( globalData.gpgs ) then
    -- Show a Google Play Games Services leaderboard
    globalData.gpgs.leaderboards.show( "CgkA8kb12jK0onOQBg" )
 
elseif ( globalData.gameCenter ) then
    -- Show an Apple Game Center leaderboard
    globalData.gameCenter.show( "leaderboards",
    {
        leaderboard = {
            category = "com.yourdomain.yourgame.leaderboard"
        }
    })
end
