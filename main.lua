-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

cx=display.contentCenterX
cy=display.contentCenterY

local floor=display.newImage( "Basement08.png")
floor.x=cx
floor.y=cy

local heroFrameOpt={width=64, height=64, numFrames=36}
local heroSheet=graphics.newImageSheet( "hero-walk-sheet.png", heroFrameOpt )
local heroAnimSpeed=800
local HeroSeqData=
{
	{name="WalkLeft", start=10, count=9, time=heroAnimSpeed},
	{name="WalkRight", start=28, count=9, time=heroAnimSpeed},
	{name="WalkDown", start=19, count=9, time=heroAnimSpeed},
	{name="WalkUp", start=1, count=9, time=heroAnimSpeed},
}

local hero=display.newSprite(heroSheet,HeroSeqData)

hero:setSequence( "WalkRight")
hero.x=cx
hero.y=cy
hero:play()
hero.speed=3

target={}
target.kx=0
target.ky=0
target.x=0
target.y=0

local function onFloorTouch( event )
	  if ( event.phase == "began" ) then
		target.x=event.x
		target.y=event.y
		target.path=math.sqrt(math.pow((target.x-hero.x),2)+math.pow((target.y-hero.y),2))
		target.kx=(target.x-hero.x)/target.path
		target.ky=(target.y-hero.y)/target.path	
		
		target.angle=math.acos((target.x-hero.x)/target.path)*57.2958
		
		if target.y<hero.y then
			target.angle=target.angle*-1
		end	
		if target.angle<-45 and target.angle>-135 then
			hero:setSequence( "WalkUp")
			hero:play()
		end
		if target.angle>=-45 and target.angle<=45 then
			hero:setSequence( "WalkRight")
			hero:play()
		end
		if target.angle>45 and target.angle<=135 then
			hero:setSequence( "WalkDown")
			hero:play()
		end
		if (target.angle>=135 and target.angle<=180) or (target.angle>=-180 and target.angle<-180+45)  then
			hero:setSequence( "WalkLeft")
			hero:play()
		end
	end



end


local function onKeyEvent( event )
	if event.keyName=="space" then

	end
end



local function enterFrame(event)
	path=math.sqrt(math.pow((target.x-hero.x),2)+math.pow((target.y-hero.y),2))
	dx=hero.speed*target.kx
	dy=hero.speed*target.ky
	if path<10 then
		dx=0
		dy=0
	end
	hero.x=hero.x+dx
	hero.y=hero.y+dy
	--print( dy )
end


Runtime:addEventListener( "touch", onFloorTouch )
Runtime:addEventListener( "key", onKeyEvent )
Runtime:addEventListener("enterFrame", enterFrame)