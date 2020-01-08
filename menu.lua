
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------



local function gotoGame()
	composer.gotoScene("game")
end

local function gotoWheel()
	composer.gotoScene("wheel-of-color")
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect(sceneGroup, "background.png", display.pixelWidth, display.pixelHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local playButton = display.newText(sceneGroup, "Play", display.contentCenterX, display.contentCenterY, native.systemFont, 50)
	playButton:setFillColor(0, 0, .7)

	local colorWheel = display.newText(sceneGroup, "Daily Reward", display.contentCenterX, display.contentCenterY + 100, native.systemFont, 50)
	colorWheel:setFillColor(0, 0, .6)


	playButton:addEventListener("tap", gotoGame)
	colorWheel:addEventListener("tap", gotoWheel)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

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
