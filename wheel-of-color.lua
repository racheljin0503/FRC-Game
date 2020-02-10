
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require("physics")
physics.start()
physics.setGravity(0, 0)



local background
local wheel
local stopButton
local spinButton

local backGroup
local mainGroup
local uiGroup

local function gotoMenu()
	composer.gotoScene("menu")
end

local function addSpin()
	wheel:applyTorque(5000)
end

local function removeSpin()
	display.remove(spinButton)
end

local function stop()
	wheel:applyTorque(-2500)
end

local function addStop()
	timer.performWithDelay(500, stop, 10)
end

local function spin()
	timer.performWithDelay(500, addSpin, 5)
	timer.performWithDelay(3000, addStop)
	timer.performWithDelay(1500, removeSpin)
	-- timer.performWithDelay(6000, addStop)
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	backGroup = display.newGroup() 
	sceneGroup:insert(backGroup) 

	mainGroup = display.newGroup() 
	sceneGroup:insert(mainGroup)

	uiGroup = display.newGroup()
	sceneGroup:insert(uiGroup)

	background = display.newImageRect(backGroup, "background STR.png", display.actualContentWidth, display.actualContentHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	wheel = display.newImageRect(mainGroup, "ColorWheel.png", 300, 300)
	physics.addBody(wheel, "dynamic")
	wheel.x = display.contentCenterX
	wheel.y = display.contentCenterY

	local menuButton = display.newText(uiGroup, "Menu", display.contentCenterX, display.contentCenterY, native.systemFont, 50)
	menuButton.x = display.contentCenterX - 80
	menuButton.y = 25
	menuButton:setFillColor(0, 0, .7)
	menuButton:addEventListener("tap", gotoMenu)

	spinButton = display.newText(uiGroup, "Spin", display.contentCenterX, display.contentCenterY + 200, native.systemFont, 50)
	spinButton:addEventListener("tap", spin)
	spinButton:setFillColor(0, .45, 0)


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
		physics.pause()
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
