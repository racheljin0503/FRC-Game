
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

        display.remove(newWebView)

        function gotoMenu()
            composer.gotoScene("menu")
        end

    about1 = display.newImageRect(mainGroup, "credits.png", 600, 800)
    about1.x = display.contentCenterX 
    about1.y = display.contentCenterY 

    menu = display.newText(uiGroup, "Menu", display.contentCenterX - 200, display.contentCenterY - 440, Ubuntu, 50)

    -- inspireText = display.newText(uiGroup, '  www.firstinspires.org', display.contentCenterX + 120, display.contentCenterY - 201, Ubuntu, 26)
    -- inspireText:setFillColor(0, 0, .7)

    back = display.newText(uiGroup, 'Back', display.contentCenterX + 200, display.contentCenterY - 440, Ubuntu, 50)
    
    function createCredit() 
  

        composer.gotoScene("about")
        -- composer.removeScene("credits")
    --about1:addEventListener("tap", removeCredit)
    end


   

    back:addEventListener("tap", createCredit)



    menu:addEventListener("tap", gotoMenu)
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

        composer.removeScene("credits")

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