local M = {}

return M

local globalData = require( "globalData" )
local json = require( "json" )
 
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
        if ( event.name == "login" ) then  
            print( json.prettify(event) )
        end
    end
end
 

local function gcInitListener( event )
 
    if event.data then 
        print( json.prettify(event) )
    end
end


if ( globalData.gpgs ) then
    
    globalData.gpgs.login( { userInitiated=true, listener=gpgsInitListener } )
 
elseif ( globalData.gameCenter ) then
   
    globalData.gameCenter.init( "gamecenter", gcInitListener )
end

local function submitScoreListener( event )
 
    
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
                
                local message = "You set " .. isBest .. " high score!"
                native.showAlert( "Congratulations", message, { "OK" } )
            else
              
                native.showAlert( "Sorry...", "Better luck next time!", { "OK" } )
            end
        end
 
   
    elseif ( globalData.gameCenter ) then
 
        if ( event.type == "setHighScore" ) then
            
            native.showAlert( "Congratulations", "You set a high score!", { "OK" } )
        else
           
            native.showAlert( "Sorry...", "Better luck next time!", { "OK" } )
        end
    end
end

local function submitScore( score )
 
    if ( globalData.gpgs ) then
       s
        globalData.gpgs.leaderboards.submit(
        {
            leaderboardId = "CgkA8kb12jK0onOQBg",
            score = score,
            listener = submitScoreListener
        })
 
    elseif ( globalData.gameCenter ) then
        
        globalData.gameCenter.request( "setHighScore",
        {
            localPlayerScore = {
                category = "com.yourdomain.yourgame.leaderboard",
                value = score
            },
            listener = submitScoreListener
        })
    end
end

if ( globalData.gpgs ) then

    globalData.gpgs.leaderboards.show( "CgkA8kb12jK0onOQBg" )
 
elseif ( globalData.gameCenter ) then

    globalData.gameCenter.show( "leaderboards",
    {
        leaderboard = {
            category = "com.yourdomain.yourgame.leaderboard"
        }
    })
end