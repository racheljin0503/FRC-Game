
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

function gotoOne()
	display.remove(level1)
	display.remove(button1)
	composer.removeScene("lvlmenu1")
	composer.gotoScene("doodone")
end

function gotoTwo()
	display.remove(level1)
	display.remove(button2)
	composer.removeScene("lvlmenu1")
	composer.gotoScene("doodtwo")
end
function gotoThree()
	display.remove(level1)
	display.remove(button3)
	composer.removeScene("lvlmenu1")
	composer.gotoScene("asteroid shooter 3")
end
function gotoFour()
	display.remove(level1)
	display.remove(button4)
	composer.removeScene("lvlmenu1")
	composer.gotoScene("doodfour")
end
function gotoFive()
	display.remove(level1)
	display.remove(button5)
	composer.removeScene("lvlmenu1")
	composer.gotoScene("doodfive")
end
local level1
local button1
local button2
local button3
local button4
local button5

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	

	level1 = display.newImageRect(sceneGroup, "levelbg.png", display.actualContentWidth, display.actualContentHeight)
	level1.x = display.contentCenterX
	level1.y = display.contentCenterY

	local chooseButton = display.newText(sceneGroup, "CLICK YOUR LEVEL", display.contentCenterX, display.contentCenterY - 400, native.systemFont, 50)
	chooseButton:setFillColor(1, 1, 1)
	
	button1 = display.newImageRect(sceneGroup, "level1.png", 400, 200)
	button1.x = 100
	button1.y = 825
	button1:toFront()
	button1:addEventListener("tap", gotoOne)

	
	button2 = display.newImageRect(sceneGroup, "level2.png", 350, 200)
	button2.x = 150
	button2.y = 500
	button2:toFront()
	button2:addEventListener("tap", gotoTwo)

	
	button3 = display.newImageRect(sceneGroup, "level3.png", 325, 210)
	button3.x = 330
	button3.y = 675
	button3:toFront()
	button3:addEventListener("tap", gotoThree)

	
	button4 = display.newImageRect(sceneGroup, "level4.png", 350, 200)
	button4.x = 450
	button4.y = 500
	button4:toFront()
	button4:addEventListener("tap", gotoFour)

	button5 = display.newImageRect(sceneGroup, "level5.png", 370, 210)
	button5.x = 550
	button5.y = 825
	button5:toFront()
	button5:addEventListener("tap", gotoFive)

	local function fitImage( displayObject, fitWidth, fitHeight, enlarge )

		-- first determine which edge is out of bounds
		local scaleFactor = fitHeight / displayObject.height 
		local newWidth = displayObject.width * scaleFactor

		if newWidth == fitWidth then
			scaleFactor = fitWidth / displayObject.width 
		end
		if not enlarge and scaleFactor > 1 then
			return
		end
		displayObject:scale( scaleFactor, scaleFactor )
	end

	fitImage( button1, 800, 1400, false )
	fitImage( button2, 800, 1400, false )
	fitImage( button3, 800, 1400, false )
	fitImage( button4, 800, 1400, false )
	fitImage( button5, 800, 1400, false )



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
		composer.removeScene("lvlmenu1")
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
