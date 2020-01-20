
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require("physics")
physics.start()
physics.setGravity(0, 3)

local background
local player 
local block
local deathLimit
local scrollSpeed = 100

local total = display.actualContentHeight / 2

local backGroup
local mainGroup
local uiGroup


local passTimer
local gameLoopTimer
local scrollTimer
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function dragPlayer(event)
    -- sets variable as reference to the player object
    local player = event.target
    local phase = event.phase

    if("began" == phase) then 
        -- Sets touch focus on the player
        display.currentStage:setFocus(player)
        --[[ Stores initial offset position (dif between touch & player), 
        (event.x is the x position of touch)]]
        player.touchOffsetX = event.x - player.x
    elseif("moved" == phase) then 
        -- Moves player to new touch position 
        player.x = event.x - player.touchOffsetX
    elseif("ended" == phase or "cancelled" == phase) then 
        -- Releases touch focus on player
        display.currentStage:setFocus(nil)
    end
	return true -- Prevents touch to objects underneath
end

-- local function bound()
-- 	dif = player.x
-- 	if (player.x >= display.actualContentWidth) then 
-- end

local function switch()
	local dif = player.x - display.actualContentWidth
	if (dif > 0) then
		player.x = dif
	end
	if (dif < -1 * display.actualContentWidth) then
		player.x =  display.actualContentWidth - ((-1 * dif) - display.actualContentWidth)
	end
end

local function death()
	if (player.y >= deathLimit) then
		display.remove(player)
		physics.pause()
		timer.cancel(passTimer)
		timer.cancel(gameLoopTimer)
		composer.removeScene("game")
		print("Dead")
		composer.gotoScene("menu")
	end
end

local function screenScroll()
	local dif = 100
	deathLimit = 800
	transition.to(backGroup, {y = backGroup.y + dif, time = 1000})
	-- print("death", deathLimit)
	print(newMid, " ------------ ")
end

local function spawn()
	local separate = 10 * math.random(3, 15)
	local separateX = 10 * math.random(1, 60)
	block = display.newRect(backGroup, separateX, total, 100, 30)
	block:setFillColor(0, 1, 0)
	physics.addBody(block, "dynamic", {bounce = 0})
	block.gravityScale = 0
	
	total = total - separate
	block.collType = "pass"
end

local function playerThru()
	local jumpx, jumpy = player:getLinearVelocity()
	if (jumpy < 0) then
		player.isSensor = true
	else 
		player.isSensor = false
	end
end

local function gameLoop()
	switch()
	spawn()
	screenScroll()
	death()
	print("x: ", player.x, "y: ", player.y)
end

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

	background = display.newImageRect(backGroup, "gameBack.png", 600, 9000)
	background.x = display.contentCenterX
	background.y = -4500 + display.actualContentHeight
	
	player = display.newCircle(display.contentCenterX, display.contentCenterY, 25)
	player:setFillColor(0, .2, .9)
	player:toFront()

	block = display.newRect(backGroup, display.contentCenterX, player.y + 150, 100, 30)
	block:setFillColor(0, 1, 0)
	physics.addBody(block, "static")
	block.collType = "pass"

	physics.addBody(player, "dynamic", {bounce = 1.3})
	player:addEventListener("touch", dragPlayer)

end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		gameLoopTimer = timer.performWithDelay(500, gameLoop, 50)
		passTimer = timer.performWithDelay(10, playerThru, 0)
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
		timer.cancel(passTimer)
		timer.cancel(gameLoopTimer)
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
