
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	display.remove(level2)
	display.remove(button2)
	composer.gotoScene("doodtwo")
	composer.removeScene("lvlmenu2")

end

local level2
local button2

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	level2 = display.newImageRect(sceneGroup, "lvl2.png", display.actualContentWidth, display.actualContentHeight)
	level2.x = display.contentCenterX
	level2.y = display.contentCenterY

	button2 = display.newImageRect(sceneGroup, "circle button.png", 100, 107)
	button2.x = 500
	button2.y = 750
	button2:toBack()
	button2:addEventListener("tap", gotoGame)



	-- local function fitImage( displayObject, fitWidth, fitHeight, enlarge )

	-- 	-- first determine which edge is out of bounds
	-- 	local scaleFactor = fitHeight / displayObject.height 
	-- 	local newWidth = displayObject.width * scaleFactor

	-- 	if newWidth == fitWidth then
	-- 		scaleFactor = fitWidth / displayObject.width 
	-- 	end
	-- 	if not enlarge and scaleFactor > 1 then
	-- 		return
	-- 	end
	-- 	displayObject:scale( scaleFactor, scaleFactor )
	-- end

	-- fitImage( level1, 800, 1400, false )


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
		composer.removeScene("lvlmenu2")
	end
end


-- destroy()
function scene:destroy( event )
	--composer.removeScene("lvlmenu1")
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
