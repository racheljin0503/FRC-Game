-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- local composer = require("composer")

-- display.setStatusBar(display.HiddenStatusBar)

-- math.randomseed(os.time())



local composer = require( "composer" )

local scene = composer.newScene()

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Seed the random number generator
math.randomseed( os.time() )

-- Configure image sheet
local sheetOptions =
{
    frames =
    {
        {   -- 1) asteroid 1
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        {   -- 4) ship
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        {   -- 5) laser
            x = 98,
            y = 265,
            width = 14,
            height = 40
        },
    },
}
local objectSheet = graphics.newImageSheet( "gameObjects.png", sheetOptions )

-- Initialize variables
local lives = 1
local score = 0
local died = false
local width =  200
local totalEnergy = composer.getVariable("energyScore")
local energy = totalEnergy
local asteroidsTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText
local energyText

local prButton
local menu
local winText
local shoot



-- Set up display groups
local backGroup = display.newGroup()  -- Display group for the background image
local mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
local uiGroup = display.newGroup()    -- Display group for UI objects like the score

-- Load the background




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


end

-- function tapMenu (event)
--     composer.gotoScene("menu")
-- end

-- function win()

--     display.remove( ship )
--     display.remove(energyBar)
--     display.remove (prButton)
--     background:removeEventListener( "tap", fireLaser )
--     winText = display.newText("Congractulation! you unclocked level 2", 500, 300, Ubuntu, 36)
--     menu = display.newText("menu", 500, 500, Ubuntu, 36)

--     menu:addEventListener("tap", tapMenu)

-- end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()

--     end
-- end
        

        background = display.newImageRect( backGroup, "levelbg.png", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

-- bird = display.newImageRect("bird.png", 500, 500)
-- bird.x = 500
-- bird.y = 500



energyBar = display.newRect(300, 70, 60, 210)
energyBar:rotate(90)
--

Bar = display.newRect(300, 70, width, 50)
Bar:setFillColor(255, 0, 0)
Bar:rotate(180)


ship = display.newImageRect( mainGroup, "bot.png", 130, 160)
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody( ship, "static", { radius=30,  isSensor=true } )
ship.myName = "ship"

-- Display lives and score
--livesText = display.newText( uiGroup, "lives: " .. lives, 100, 80, Ubuntu, 36 )
scoreText = display.newText( uiGroup, "Score: " .. score, 300, 0, Ubuntu, 36 )
energyText = display.newText( uiGroup, "" .. energy, 450, 70, Ubuntu, 36 )




--Hide the status bar
display.setStatusBar( display.HiddenStatusBar )



 function win ()
    display.remove( ship )
        display.remove(energyBar)
        --display.remove(background)
        display.remove(Bar)
        display.remove(newAsteroid)
        display.remove(energyText)
        display.remove (prButton)

        background:removeEventListener( "tap", fireLaser )
        composer.setVariable("finalScore", score)

        composer.gotoScene("menu")

end


local function updateText()
    -- livesText.text = "lives: " .. lives
    scoreText.text = "Score: " .. score
    energyText.text = " " .. energy
end


local function createAsteroid()

    local newAsteroid = display.newImageRect( mainGroup, objectSheet, 1, 102, 85 )
    table.insert( asteroidsTable, newAsteroid )
    physics.addBody( newAsteroid, "dynamic", { radius=40, bounce=0.8 } )
    newAsteroid.myName = "asteroid"


    -- if ( whereFrom > 1 ) then
        -- From the top
        newAsteroid.x = math.random(0, display.actualContentWidth)
        newAsteroid.y = -100
        newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
    
    -- end

   -- newAsteroid:applyTorque( math.random( -6,6 ) )
end

local function checkwin()
if (score >= 3000) then
win()
end
end

glt = timer.performWithDelay(100, checkwin, 10000)

function createPup()

    pup = display.newImageRect("power up.png", 500, 500)
    pup.x = 1000
    pup.y = math.random(0, 600)
    physics.addBody(pup, "dynamic",{ radius = 20, isSensor = true})
    pup.myName = "pup"

    pup:setLinearVelocity(-100, 0)
    
    
  
 end

glt1 =  timer.performWithDelay( 10000, createPup, 10 )



 function fireLaser( event )

    local newLaser = display.newImageRect( mainGroup, objectSheet, 5, 14, 40 )
    physics.addBody( newLaser, "dynamic", { isSensor=true } )
    newLaser.isBullet = true
    newLaser.myName = "laser"
    --  newLaser.xScale = 100
    --  newLaser.yScale = 100

    newLaser.x = ship.x
    newLaser.y = ship.y
    newLaser:toBack()

    transition.to( newLaser, { x=ship.x, y=-500, time=500,
        onComplete = function() display.remove( newLaser ) end
    } )

    energy = energy - 1
    energyText.text = " " .. energy


    update()

  --  or energyScore <=0

    if (energy < 0 ) then
        display.remove(ship)
        background:removeEventListener("tap", fireLaser)
        timer.cancel(gm)
        timer.cancel(gm1)
        timer.cancel(glt1)
        display.remove(obj1)
        display.remove(obj2)
        display.remove(energyBar)
        display.remove(prButton)
        display.remove(resumeButton)
        display.remove(Bar)
        display.remove(spaceGun)
        display.remove(spaceGun1)
        display.remove(pup)
        composer.removeScene("asteroid shooter 4")
       composer.gotoScene("menu")
       composer.setVariable("finalScore", score)


    end
   
end
 

function update()
    Bar.width = Bar.width - (width / totalEnergy)
    end

 background:addEventListener( "tap", fireLaser )


local function dragShip( event )

    local ship = event.target
    local phase = event.phase

    if ( "began" == phase ) then
        -- Set touch focus on the ship
        display.currentStage:setFocus( ship )
        -- Store initial offset position
        ship.touchOffsetX = event.x - ship.x
        ship.touchOffsetY = event.y - ship.y

    elseif ( "moved" == phase ) then
        -- Move the ship to the new touch position
        ship.x = event.x - ship.touchOffsetX
        ship.y = event.y - ship.touchOffsetY

    elseif ( "ended" == phase or "cancelled" == phase ) then
        -- Release touch focus on the ship
        display.currentStage:setFocus( nil )
    end

    return true  -- Prevents touch propagation to underlying objects
end

ship:addEventListener( "touch", dragShip )


local function gameLoop()

    -- Create new asteroid
    createAsteroid()

    -- Remove asteroids which have drifted off screen
    for i = #asteroidsTable, 1, -1 do
        local thisAsteroid = asteroidsTable[i]
        -- if (i > 7) then
        --     display.remove(thisAsteroid)
        --     table.remove(asteroidsTable, i)
        -- end
        if ( thisAsteroid.x < -100 or
             thisAsteroid.x > display.contentWidth + 100 or
             thisAsteroid.y < -100 or
             thisAsteroid.y > display.contentHeight + 100)
        then
            display.remove( thisAsteroid )
            table.remove( asteroidsTable, i )
        end
    end
end

gameLoopTimer = timer.performWithDelay( 500, gameLoop, 40 )


local function restoreShip()

    ship.isBodyActive = false
    ship.x = display.contentCenterX
    ship.y = display.contentHeight - 100

    -- Fade in the ship
    transition.to( ship, { alpha=1, time=4000,
        onComplete = function()
            ship.isBodyActive = true
            died = false
        end
    } )
end


local function onCollision( event )

    if ( event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or
             ( obj1.myName == "asteroid" and obj2.myName == "laser" ) )
        then
            -- Remove both the laser and asteroid
            display.remove( obj1 )
            display.remove( obj2 )

            for i = #asteroidsTable, 1, -1 do
                if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2) then
                    table.remove( asteroidsTable, i )
                    break
                end
            end

            -- Increase score
            score = score + 100
            scoreText.text = "Score: " .. score

        elseif ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
                 ( obj1.myName == "asteroid" and obj2.myName == "ship" ) )
        then
            if ( died == false ) then
                died = true

                -- Update lives
                lives = lives - 1
               -- livesText.text = "lives: " .. lives

                if ( lives == 0 )  then

                    timer.cancel(gm)
                    timer.cancel(gm1)
                   display.remove( ship )
                   display.remove (prButton)
                   display.remove (resumeButton) 
                   display.remove(energyBar)
                   display.remove(Bar)
                   display.remove(pup)
                   display.remove(spaceGun)
                   display.remove (spaceGun1)
                   timer.cancel(glt1)
                   background:removeEventListener("tap", fireLaser)
                    composer.removeScene("asteroid shooter 4")
                   composer.gotoScene("menu")
                   composer.setVariable("finalScore", score)
        
                else
                    ship.alpha = 0
                    timer.performWithDelay( 1000, restoreShip )
                 
                end
            end
        elseif (obj1.myName == "laser" and obj2.myName == "pup") or
        (obj1.myName == "pup" and obj2.myName == "laser") then

            display.remove(obj1)
            display.remove(obj2)

            energy = energy + 4
            updateText()
            Bar.width = Bar.width + 4 * (width / totalEnergy) 

         elseif (obj1.myName == "slaser" and obj2.myName == "ship") or
          (obj1.myName == "ship" and obj2.myName == "slaser")   then



            shoot = true
            display.remove(ship)
            background:removeEventListener("tap", fireLaser)
            timer.cancel(gm)
            timer.cancel(gm1)
            timer.cancel(glt1)
            display.remove(obj1)
            display.remove(obj2)
            display.remove(energyBar)
            display.remove(prButton)
            display.remove(resumeButton)
            display.remove(Bar)
            display.remove(spaceGun)
            display.remove(spaceGun1)
            display.remove(pup)
            composer.removeScene("asteroid shooter 4")
           composer.gotoScene("menu")
           composer.setVariable("finalScore", score)

            
        elseif (obj1.myName == "slaser1" and obj2.myName == "ship") or 
        (obj1.myName == "ship" and obj2.myName == "slaser1") then
            
            
            shoot = true
            display.remove(ship)
            background:removeEventListener("tap", fireLaser)
            timer.cancel(gm)
            timer.cancel(gm1)
            timer.cancel(glt1)
            display.remove(obj1)
            display.remove(obj2)
            display.remove(energyBar)
            display.remove(prButton)
            display.remove(resumeButton)
            display.remove(Bar)
            display.remove(spaceGun)
            display.remove(spaceGun1)
            display.remove(pup)
            composer.removeScene("asteroid shooter 4")
           composer.gotoScene("menu")
           composer.setVariable("finalScore", score)



        elseif (obj1.myName == "laser" and obj2.myName == "spaceGun") or (obj1.myName == "spaceGun" and obj2.myName == "laser") 
        then

            display.remove(spaceGun)
            display.remove(spaceLaser)
            timer.cancel(gm)
            score = score + 200
            
                        
            updateText()
            

        elseif (obj1.myName == "laser" and obj2.myName == "spaceGun1") or (obj1.myName == "spaceGun1" and obj2.myName == "laser") 
        then
            display.remove(spaceGun1)
            display.remove(spaceLaser1)
            timer.cancel(gm1)
            score = score + 200            
            updateText()
            
        end
    end
end

Runtime:addEventListener( "collision", onCollision )


 
    prButton = display.newImageRect("pause button.png", 75, 80)
    prButton.x = 550
    prButton.y = 1

    

    function pause()
        
        display.remove(prButton)
        -- pause = true
       
        resumeButton = display.newImageRect("play button.png", 75, 80)
        resumeButton.x = 550
        resumeButton.y = 1
       
        physics.pause()
        transition.pause()

       background:removeEventListener( "tap", fireLaser )
        
        -- if(pause == true) then
            -- prButton:removeEventListener("tap", pause)
            resumeButton:addEventListener("tap", continue)
        -- end    
    end

    function continue()

        display.remove(resumeButton)

        prButton = display.newImageRect("pause button.png", 75, 80)
        prButton.x = 550
        prButton.y = 1

        -- pause = false

        -- resumeButton = display.newImageRect("resume.png", 75, 75)
        -- resumeButton.x = 550
        -- resumeButton.y = 10
       
        physics.start()
        transition.resume()
        background:addEventListener("tap", fireLaser )
        
        -- if(pause == false) then
        --     resumeButton = prButton
            prButton:addEventListener("tap", pause)        
        -- end    

    end
    


    prButton:addEventListener("tap", pause)

    

   -- function bangBang ()

        spaceGun = display.newImageRect("enemy.png", 120, 100)
          spaceGun.x = -600
          spaceGun.y = 80    
          physics.addBody(spaceGun, "static", { isSensor = true} )
          spaceGun.myName = "spaceGun"
  
  

     --, onComplete = function()  end
  
     -- end
  
   --gmb = timer.performWithDelay(15000, bangBang, 2)
   
   function spaceLaser ()
  
  
      spaceLaser = display.newImageRect("laser .png", 100, 50)
      spaceLaser.x = spaceGun.x
      spaceLaser.y = spaceGun.y
      physics.addBody( spaceLaser, "dynamic", { isSensor=true } )
      --spaceGun:toFront()
      spaceLaser.myName = "slaser"
  
      spaceLaser:setLinearVelocity(0, 1000)
      --transition.to( spaceLaser, { x = 500, y = 1000, time = 500} )
   
   end
  
   gm = timer.performWithDelay(500, spaceLaser, 1000)
   
   --function bangBang1 ()
  
      spaceGun1 = display.newImageRect("enemy.png", 120, 100)
        spaceGun1.x = 1000
        spaceGun1.y = 80   
        physics.addBody(spaceGun1, "static", { isSensor = true} )
        spaceGun1.myName = "spaceGun1"
  
  
  --, onComplete = function() gm1 = timer.performWithDelay(500, spaceLaser1, 1000) end
   -- end
  
   -- gmb1 = timer.performWithDelay(15000, bangBang1, 2)
  
  function spaceLaser1 ()
  
  
    spaceLaser1 = display.newImageRect("laser .png", 100, 50)
    spaceLaser1.x = spaceGun1.x
    spaceLaser1.y = spaceGun1.y
    physics.addBody( spaceLaser1, "dynamic", { isSensor=true } )
    --spaceGun:toFront()
    spaceLaser1.myName = "slaser1"
  
    spaceLaser1:setLinearVelocity(0, 1000)
    --transition.to( spaceLaser1, { x = 200, y = 1000, time = 500} )
  
  end
  gm1 = timer.performWithDelay(500, spaceLaser1, 1000)

  function rotate()

    transition.to( spaceGun, { x= 1000, y= 80, time= 20000 } )
    transition.to( spaceGun1, { x= -600, y= 80, time= 20000 } )
  end

  glt2 = timer.performWithDelay(100, rotate, 2)


        end
    end
          
    
--     end
-- end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        physics.pause()

        composer.removeScene("asteroid shooter 4")

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