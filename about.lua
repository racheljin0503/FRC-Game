
local composer = require( "composer" )

local scene = composer.newScene()


local function gotoMenu()
    composer.gotoScene("menu")
end

local back
local background

function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    backGroup = display.newGroup() 
    sceneGroup:insert(backGroup) 


    mainGroup = display.newGroup() 
    sceneGroup:insert(mainGroup)

    uiGroup = display.newGroup()
    sceneGroup:insert(uiGroup)

    background = display.newImageRect(backGroup, "background STR.png", 10000, 9000)
    background.x = display.contentCenterX
    background.y = -4500 + display.actualContentHeight


end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then


  
local function gotolink( event )
    system.openURL( "https://www.firstinspires.org/" )
end

local function gotolink1(event)
    system.openURL("https://www.technotitans.org/donate.html")
end
        function gotoMenu()
            display.remove(technotitans)
            display.remove(first)
            composer.gotoScene("menu")
        end


    about1 = display.newImageRect(mainGroup, "aboutBackground1.png", 600, 1060)
    about1.x = display.contentCenterX 
    about1.y = display.contentCenterY 

    about1 = display.newImageRect(mainGroup, "about123.png", 700, 700)
    about1.x = display.contentCenterX 
    about1.y = display.contentCenterY - 220

    back = display.newImageRect(mainGroup, "back.png", 600, 600)
    back.x = display.contentCenterX - 180
    back.y = display.contentCenterY - 245

    credits = display.newImageRect(mainGroup, "credit.png", 700, 700)
    credits.x = display.contentCenterX + 200
    credits.y = display.contentCenterY - 220
    --about1:setFillColor(0, 0, 0)
    donate = display.newImageRect(mainGroup, "donate.png", 2000, 600)
    donate.x = display.contentCenterX + 5
    donate.y = display.contentCenterY + 255

    technotitans = display.newImageRect("technoTitan.png", 290, 170)
    technotitans.x = display.contentCenterX - 140
    technotitans.y = display.contentCenterY + 400
 
    first = display.newImageRect("first.png", 150, 150)
    first.x = display.contentCenterX+160
    first.y = display.contentCenterY + 400

    text = display.newText(uiGroup, "Titan Rise was by the 2020 FIRST Robotics \n Competition. Learn more about FIRST at", display.contentCenterX, display.contentCenterY - 200, Ubuntu, 26)

    text1 = display.newText(uiGroup, "The Techno Titans strive to spread the \n message of FIRST. Thank you for \n downloading our game and we hope \nyou’re ready to RISE!", display.contentCenterX, display.contentCenterY - 30, Ubuntu, 28.5)

    text2 = display.newText(uiGroup, " Brought to you by Team 1683, \n           the Techno Titans", display.contentCenterX, display.contentCenterY + 150, Ubuntu, 35)
    text2:setFillColor(255, 0, 0)


    -- text = display.newImageRect(uiGroup, "text.png", 500, 500)
    -- text.x = display.contentCenterX 
    -- text.y = display.contentCenterY + 500
   -- The Techno Titans strive to spread the message of FIRST. Thank you for
 --downloading our game and we hope you’re ready to RISE! 

--  Brought to you by Team 1683, the techno 
-- titans 


    inspireText = display.newText(uiGroup, '  www.firstinspires.org', display.contentCenterX - 100, display.contentCenterY - 150, native.systemFont, 30)
    inspireText:setFillColor(0, 0, .7)

   -- credits = display.newText(uiGroup, 'credits', display.contentCenterX + 200, display.contentCenterY - 440, native.systemFont, 50)
    
    function createCredit( event )
        display.remove(technotitans)
        display.remove(first)
        composer.gotoScene("credits")
    end
  


    --about1:addEventListener("tap", removeCredit)
    


   

    credits:addEventListener("tap", createCredit)

    inspireText:addEventListener("tap", gotolink)

    donate:addEventListener("tap", gotolink1)

    back:addEventListener("tap", gotoMenu)
    end
end



function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        physics.pause()

        composer.removeScene("about")

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene