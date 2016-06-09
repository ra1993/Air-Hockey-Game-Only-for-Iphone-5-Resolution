--Richard A
--Air Hockey Game





local physics = require("physics")
	physics.start()
	physics.setGravity( 0, 0 )
	

local bg, goal, goalLine, post1, post2
display.setStatusBar( display.HiddenStatusBar )
local w, h = display.contentWidth, display.contentHeight

bg = display.newRect( w/2, h/2, w, h )
bg:setFillColor(.2,.5,.5)




goal = display.newRect( w/2, 100, 400, 200 )          -- goal 1
	goal:setFillColor( 1, 0, 0 )
physics.addBody( goal, { isSensor = true } )
	
goalLine = display.newLine( 0, 200, w, 200 )
	goalLine.width = 6
	goalLine:setStrokeColor( 0, 0, 0)



goal2 = display.newRect (w/2, 1035, 400, 200)        -- goal 2
goal2:setFillColor(1, .7, 0)
physics.addBody(goal2, {isSensor = true})

goalLine2 = display.newLine (0, 930, w, 930)
goalLine2.width = 6
goalLine2:setStrokeColor(0, 0, 0)




-- ------------------------------------------------------------------------------------------goal 1 posts	
post1 = display.newRoundedRect( w/2 - 206, 100, 10, 230, 5)
	post1:setFillColor( 0, 0, 0 )
physics.addBody( post1, "static" )

post2 = display.newRoundedRect( w/2 + 206, 100, 10, 230, 5)
	post2:setFillColor( 0, 0, 0 )
physics.addBody( post2, "static" )
	
score = 0

goalText = display.newText("Goals: 0", w/8, h-550, Arial, 40)	
goalText:setFillColor(1, 0, 0)




-- ---------------------------------------------------------------------------------------goal 2 posts


post3 = display.newRoundedRect (w/2 - 206, 1030, 10, 230, 5)
post3: setFillColor(0, 0, 0)
physics.addBody (post3, "static")


post4 = display.newRoundedRect (w/2 - -206, 1030, 10, 230, 5)
post4: setFillColor(0, 0, 0)
physics.addBody (post4, "static")


score2 = 0

goalText2 = display.newText("Goals: 0", w/1.15, h-550, Arial, 40)	
goalText2:setFillColor(1, .7, 0)
	
local function dragBody(event)
	local body = event.target
	local phase = event.phase 
	local stage = display.getCurrentStage()

	if "began" == phase then 
		stage:setFocus(body, event.id)
		body.isFocus =true 

		body.tempJoint = physics.newJoint("touch", body, event.x, event.y)

elseif body.isFocus then 
	if "moved" == phase then
body.tempJoint:setTarget (event.x, event.y)




		elseif "ended" == phase or "cancelled" == phase then 

		stage:setFocus(body, nil)
		body.isFocus = false
		body.tempJoint:removeSelf()

	end
end 

return true
end

--   -----------------------------------------------------------------------------------------------Strikers

local striker1 = display.newImage("striker1.png", 320, 300)
physics.addBody(striker1, "dynamic", { density = 1, friction = 1, bounce = 0})


local striker2 = display.newImage("striker2.png", 320, 800)
physics.addBody(striker2, "dynamic", { density = 1, friction = 1, bounce = 0})

striker1:addEventListener("touch", dragBody)
striker2:addEventListener("touch", dragBody)




-- -------------------------------------------------------------------------------------------------Pucks
function makePuck(event)
    newPuck = display.newCircle(event.x, event.y, 30)
    newPuck:setFillColor( 0,0,0 )
    newPuck.strokeWidth =8
    newPuck:setStrokeColor(0.2,0.2,0.2)
    physics.addBody( newPuck, {density = 0.5, friction=0.1, bounce=0.2, radius=35})
    newPuck:addEventListener( "touch", dragBody )
return true
end
bg: addEventListener( "tap", makePuck)



local function onCollision(event)

	if event.phase == "began" then
		if event.object1 == goal or event.object2 == goal 
			then 
			score = score +1
			 
		end

		goalText.text = "Goals: "..score 
		
	end
	return true

end

Runtime: addEventListener("collision", onCollision)




-- -------------------------------------------------------------------
local function onCollision2(event)

	if event.phase == "began" then
		if event.object1 == goal2 or event.object2 == goal2 
			then 
			score2 = score2 +1
			 
		end

		goalText2.text = "Goals: "..score2 
		
	end
	return true

end

Runtime: addEventListener("collision", onCollision2)



-- ------------------------------------------------------------------------ reset button

local resetbutton = display.newImage("resetbutton.png", 55, 1085)
resetbutton:scale(.4, .4)

local resetbutton2 = display.newImage("resetbutton.png", 580, 60)
resetbutton2:scale(.4, .4)

local function reset(event)

score = 0
goalText.text = "Goals: "..score

score2 = 0
goalText2.text = "Goals: "..score2


	transition.to(striker1, {x = 320, y = 300})
	transition.to(striker2, {x = 320, y = 800})







end

resetbutton: addEventListener("touch", reset)
resetbutton2: addEventListener("touch", reset)



-- ----------------------------------------------------------------  board posts
-- -------------------------------------------------------------sides
rpost =  display.newRoundedRect( w/2 + 320, 100, 20, 2200, 5)
rpost: setFillColor(.2, .2, 1)
physics.addBody (rpost, "static")


lpost =  display.newRoundedRect( w/2 + -322, 100, 20, 2200, 5)
lpost: setFillColor(.2, .2, 1)
physics.addBody (lpost, "static")

-- -------------------------------------------------------------top

rminipost =  display.newRoundedRect( w/2 + -290, .5, 20, 160, 20)
rminipost: setFillColor(.2, .2, 1)
rminipost.rotation = 90
physics.addBody (rminipost, "static")


lminipost =  display.newRoundedRect( w/2 + 290, .5, 20, 160, 20)
lminipost: setFillColor(.2, .2, 1)
lminipost.rotation = 90
physics.addBody (lminipost, "static")



-- ----------------------------------------------------------------------bottom

lminipost2 =  display.newRoundedRect( w/2 + -290, 1135, 20, 160, 20)
lminipost2: setFillColor(.2, .2, 1)
lminipost2.rotation = 90
physics.addBody (lminipost2, "static")


rminipost2 =  display.newRoundedRect( w/2 + 290, 1135, 20, 160, 20)
rminipost2: setFillColor(.2, .2, 1)
rminipost2.rotation = 90
physics.addBody (rminipost2, "static")