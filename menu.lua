
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	composer.gotoScene("lvlmenu1")
	composer.removeScene("menu")
end

local function gotoWheel()
	composer.gotoScene("wheel-of-color")
	composer.removeScene("menu")

end

local function gotoHighscores()
	composer.gotoScene("highscores")
	composer.removeScene("menu")

end

local function gotoAbout()
	composer.gotoScene("about")
	composer.removeScene("menu")

end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect(sceneGroup, "menu bg.png", display.pixelWidth, display.pixelHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY


	local playButton = display.newText(sceneGroup, "PLAY", display.contentCenterX, display.contentCenterY - 375, Ubuntu, 100)
	playButton:setFillColor(0, 0, .7)

	local colorWheel = display.newText(sceneGroup, "DAILY SPINNER", display.contentCenterX, display.contentCenterY - 275, Ubuntu, 50)
	colorWheel:setFillColor(0, 0, .7)
  
	local highscoresButton = display.newText(sceneGroup, "HIGHSCORE", display.contentCenterX, display.contentCenterY - 200, Ubuntu, 50)
	highscoresButton:setFillColor(0, 0, .7)

	local about = display.newText(sceneGroup, "ABOUT", display.contentCenterX, 650, Ubuntu, 50)
	about:setFillColor(0, 0, .7)

	playButton:addEventListener("tap", gotoGame)
	colorWheel:addEventListener("tap", gotoWheel)
	highscoresButton:addEventListener("tap", gotoHighscores)
	about:addEventListener("tap", gotoAbout)
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
		composer.removeScene("menu")
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
