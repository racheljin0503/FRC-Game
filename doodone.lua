
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require("physics")
physics.start()
physics.setGravity(0, 4)

local background
local player 
local block
-- local asteroid 
-- local redBlock

local deathLimit = 900
local scrollSpeed = 100

local total = display.actualContentHeight / 2

local backGroup
local mainGroup
local uiGroup

local msg
local blockTable = {}
local coinTable = {}
-- local astTable = {}
-- local redTable = {}

local passTimer
local gameLoopTimer
local scrollTimer
local spawnTimer


--Temporary
local winTimer


energyScore = 0
local energyText

local canJump = 5
local jumpText
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
-- local function dragPlayer(event)
--     -- sets variable as reference to the player object
--     local player = event.target
--     local phase = event.phase

--     if("began" == phase) then 
--         -- Sets touch focus on the player
--         display.currentStage:setFocus(player)
--         --[[ Stores initial offset position (dif between touch & player), 
--         (event.x is the x position of touch)]]
--         player.touchOffsetX = event.x - player.x
--     elseif("moved" == phase) then 
--         -- Moves player to new touch position 
--         player.x = event.x - player.touchOffsetX
--     elseif("ended" == phase or "cancelled" == phase) then 
--         -- Releases touch focus on player
--         display.currentStage:setFocus(nil)
--     end
-- 	return true -- Prevents touch to objects underneath
-- end

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
	if(player.y <= 0) then
		player.y = 0
	end
end


local function screenScroll()
	local dif = (background.height / 2) + (display.actualContentHeight / 1.5)

	transition.to(backGroup, {y = backGroup.y + dif, time = 70000})
end

local function updateText()
	jumpText.text = "Jumps Available: "..canJump
	energyText.text = "Energy collected: "..energyScore
end


local function death()
	if (player.y >= deathLimit) then
		display.remove(player)
		physics.pause()
		timer.cancel(passTimer)
		timer.cancel(gameLoopTimer)
		timer.cancel(scrollTimer)
		timer.cancel(spawnTimer)
		timer.cancel(winTimer)
		display.remove(msg)


		for i = #blockTable, 1, -1 do
			local thisBlock = blockTable[i]
				display.remove(thisBlock)
				table.remove(blockTable, i)
				print("block dies")
		end

		for i = #coinTable, 1, -1 do
			local thisCoin = coinTable[i]
				display.remove(thisCoin)
				table.remove(coinTable, i)
				print("coin deleted")
		end


		composer.gotoScene("menu")
	end
end

local function spawnBlock()
	local separate = 10 * math.random(3, 15)
	local separateX = 10 * math.random(5, 55)
	local spawnCoin = math.random(0, 10)
	if (spawnCoin >= 3) then
		block = display.newRect(mainGroup, separateX, 0, 100, 30)
		table.insert(blockTable, block)
		block:setFillColor(0, 1, 0)
		physics.addBody(block, "dynamic", {bounce = 0})
		block:setLinearVelocity(0, 70)
		block.gravityScale = 0
		block.collType = "pass"
		block.myName = "block"
		block.isFixedRotation = true
		block:toFront()
	else
		block = display.newRect(mainGroup, separateX, 0, 100, 30)
		table.insert(blockTable, block)
		block:setFillColor(0, 1, 0)
		physics.addBody(block, "dynamic", {bounce = 0})
		block:setLinearVelocity(0, 70)
		block.gravityScale = 0
		block.collType = "pass"
		block.myName = "block"
		block.isFixedRotation = true
		block:toFront()

		coin = display.newImageRect(mainGroup, "coinLol.png", 40, 40)
		table.insert(coinTable, coin)
		coin.x = separateX
		coin.y = 0
		physics.addBody(coin, "dynamic", {bounce = 0})
		coin.gravityScale = 0
		coin:setLinearVelocity(0, 70)
		coin.myName = "coin"
	end
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
	death()
	updateText()
	-- playerThru()
	-- changeBlock()
	-- removeBlock()
end


local function onGyroscopeUpdate( event )
	
	-- print(event.yRotation)
	local nextX = player.x + (event.yRotation * 10)
	if nextX < 0 then
		nextX = 0
	elseif nextX > display.contentWidth then
		nextX = display.contentWidth
	end

	-- if event.yRotation > 0 then
	-- 	player.x = 100
	-- else
	-- 	player.x = 500
	-- end

	player.x = nextX 

	-- Rotate the object based based on the degrees rotated around the z-axis.
	-- local deltaRadians = event.zRotation * event.deltaTime
	-- local deltaDegrees = deltaRadians * (180 / math.pi)
	-- player:rotate(deltaDegrees)
end

local function checkGyro()
	if not system.hasEventSource("gyroscope") then
		msg = display.newText( "Gyroscope events not supported on this device", 0, display.contentCenterY, UbuntuBold, 20 )
		msg.x = display.contentWidth/2		-- center title
		msg:setFillColor( 1,1,1 )
	end
end


local function pushPlayer()
	local jumpx, jumpy = player:getLinearVelocity()
	if (canJump > 0 and jumpy > 150) then
		player:applyLinearImpulse(0, -1.2, player.x, player.y)
		canJump = canJump - 1
	elseif (canJump > 0 and jumpy > 0) then
		player:applyLinearImpulse(0, -.75, player.x, player.y)
		canJump = canJump - 1
	elseif (canJump > 0 and jumpy > -150) then
		player:applyLinearImpulse(0, -.4, player.x, player.y)
		canJump = canJump - 1
	elseif (canJump > 0) then
		player:applyLinearImpulse(0, -.3, player.x, player.y)
		canJump = canJump - 1
	end
end

local function uwu()

	display.remove(player)
	display.remove(msg)
	physics.pause()
	timer.cancel(passTimer)
	timer.cancel(gameLoopTimer)
	timer.cancel(scrollTimer)
	timer.cancel(spawnTimer)
	timer.cancel(winTimer)
	composer.setVariable("energyScore", energyScore)


	for i = #blockTable, 1, -1 do
		local thisBlock = blockTable[i]
			display.remove(thisBlock)
			table.remove(blockTable, i)
			print("block dies")
	end

	for i = #coinTable, 1, -1 do
		local thisCoin = coinTable[i]
			display.remove(thisCoin)
			table.remove(coinTable, i)
			print("coin deleted")
	end

	print("won")
	composer.gotoScene("asteroid shooter 1")
end



local function onCollision(event)
    if (event.phase == "began") then 

        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "player" and obj2.myName == "block") or 
        (obj1.myName == "block" and obj2.myName == "player"))
		then 
			canJump = 5
		end

		if(obj1.myName == "player" and obj2.myName == "coin") then
			display.remove(obj2)
			energyScore = energyScore + 1
			for i = #coinTable, 1, -1 do
                if (coinTable[i] == obj2) then 
                    table.remove(coinTable, i)
                    break
                end
            end
		elseif (obj1.myName == "coin" and obj2.myName == "player") then
			display.remove(obj1)
			energyScore = energyScore + 1
			for i = #coinTable, 1, -1 do
                if (coinTable[i] == obj1) then 
                    table.remove(coinTable, i)
                    break
                end
            end
		end

	end
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

	energyText = display.newText(uiGroup, "Energy Collected: "..energyScore, 150, 50, Ubuntu, 30)
	energyText:setFillColor(0, .1, 0)

	jumpText = display.newText(uiGroup, "Jumps Available: "..canJump, 150, 100, Ubuntu, 30)
	jumpText:setFillColor(0, .1, 0)
	
	player = display.newImageRect(mainGroup, "bot.png", 50, 80)
	player.x = display.contentCenterX
	player.y = display.contentCenterY
	player.xScale = 1.6
	player.yScale = 1.6
	player:toFront()
	physics.addBody(player, "dynamic", {bounce = 0, radius = 55})



	block = display.newRect(mainGroup, display.contentCenterX, player.y + 150, 100, 30)
	block:setFillColor(0, 1, 0)
	physics.addBody(block, "dynamic", {bounce = 0})

	block.collType = "pass"
	block:setLinearVelocity(0, 10)
	block.gravityScale = 0
	block.isFixedRotation = true
	block.myName = "block"


	-- player:addEventListener("touch", dragPlayer)
	backGroup:addEventListener("tap", pushPlayer)

	player.myName = "player"

	checkGyro()

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
		gameLoopTimer = timer.performWithDelay(10, gameLoop, 0)
		passTimer = timer.performWithDelay(10, playerThru, 0)
		scrollTimer = timer.performWithDelay(100, screenScroll, 1)
		spawnTimer = timer.performWithDelay(850, spawnBlock, 0)
		winTimer = timer.performWithDelay(50100,uwu , 1)
		Runtime:addEventListener("collision", onCollision)
		Runtime:addEventListener("gyroscope", onGyroscopeUpdate)

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
		timer.cancel(scrollTimer)
		timer.cancel(spawnTimer)
		Runtime:removeEventListener("collision", onCollision)
		Runtime:removeEventListener("gyroscope", onGyroscopeUpdate)

		composer.removeScene("doodone")

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