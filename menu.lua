
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoLevels()
	composer.gotoScene("level1")
end

local function gotoGame()
	composer.gotoScene("game")
end

local function gotoHighscores()
	composer.gotoScene("highscores")
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view

	-- Code here runs when the scene is first created but has not yet appeared on screend
	
	-- backGroup = display.newGroup()  -- Display group for the background image
	-- sceneGroup:insert( backGroup )  -- Insert into the scene's view group
	
	local background = display.newImageRect(sceneGroup, "menu bg.png", display.actualContentWidth, display.actualContentHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local playButton = display.newText(sceneGroup, "PLAY", display.contentCenterX, 50, native.systemFont, 100)
	playButton:setFillColor(0, 0, .7)

	local spinnerButton = display.newText(sceneGroup, "DAILY SPINNER", display.contentCenterX, 150, native.systemFont, 50)
	spinnerButton:setFillColor(0, 0, .7)

	local highscoresButton = display.newText(sceneGroup, "HIGHSCORES", display.contentCenterX, 230, native.systemFont, 50)
	highscoresButton:setFillColor(0, 0, .7)

	playButton:addEventListener("tap", gotoLevels)
	spinnerButton:addEventListener("tap", gotoGame)
	highscoresButton:addEventListener("tap", gotoHighscores)
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
