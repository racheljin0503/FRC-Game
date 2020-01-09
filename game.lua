
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- initialize physics
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- -- initialize platform table to organize & generate multiple platforms
-- local platformTable = {}

-- -- multiple platforms
-- local function createPlatform()

-- 	local newPlatform = display.newImageRect( mainGroup, objectSheet, 1, 102, 85 )
-- 	table.insert( asteroidsTable, newPlatform )
-- 	physics.addBody( newPlatform, "dynamic", { radius=40, bounce=0.8 } )
-- 	newPlatform.myName = "platform"

-- 	local whereFrom = math.random( 3 )

-- 	if ( whereFrom == 1 ) then
-- 		-- From the left
-- 		newPlatform.x = -60
-- 		newPlatform.y = math.random( 500 )
-- 		newPlatform:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
-- 	elseif ( whereFrom == 2 ) then
-- 		-- From the top
-- 		newPlatform.x = math.random( display.contentWidth )
-- 		newPlatform.y = -60
-- 		newPlatform:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
-- 	elseif ( whereFrom == 3 ) then
-- 		-- From the right
-- 		newPlatform.x = display.contentWidth + 60
-- 		newPlatform.y = math.random( 500 )
-- 		newPlatform:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
-- 	end

-- 	newPlatform:applyTorque( math.random( -6,6 ) )
-- end


-- local function gameLoop()

-- 	-- Create new platform
-- 	createPlatform()

-- end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group
	
	-- background png
	local background = display.newImageRect(backGroup, "background.png", 800, 1400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- platform png
	local platform = display.newImageRect(mainGroup, "platform.png", 600, 250)
	platform.x = display.contentCenterX
	platform.y = display.contentCenterY

	-- draft of boy png
	local boy = display.newImageRect(mainGroup, "draft of boy.png", 130, 85)
	boy.x = 310
	boy.y = 400

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