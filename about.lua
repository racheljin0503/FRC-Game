
local composer = require( "composer" )

local scene = composer.newScene()




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

        function gotoMenu()
            composer.gotoScene("menu")
        end

    about1 = display.newImageRect("about .png", 700, 500)
    about1.x = display.contentCenterX
    about1.y = display.contentCenterY - 400

    back = display.newText("back", display.contentCenterX - 200, display.contentCenterY - 450, "Ubuntu", 50)

    inspireText = display.newText("Titan Rise was inspired", display.contentCenterX, display.contentCenterY, "Ubuntu", 36)
    print(native.getFontNames())

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

        composer.removeScene("game")

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