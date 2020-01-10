local delay=0
local delayTime=2
local totalSprites=200
local char=nil
local charX=10
local charY=96
local scrWidth=0
local scrHeight=0

local maxSpd=1
local horMovCnt=0
local charSpdX=0
local charSpdY=0
local charSize=8
local deltaSpd=0.25
local jumpHeight=20
local jumpCur=0
local jumpDir=0

function Init()
  local displaySize=Display()
  scrWidth=displaySize.x
  scrHeight=displaySize.y  
end

function Update(timeDelta)
  CharMovement();
end

function Draw()
  RedrawDisplay()
  DrawSprite(0,charX,charY)
  DrawDebug()
end

function DrawDebug()
  local str = "x:" .. charX .. ",y:" .. charY
  DrawText(str,0,0,4,"medium",15)

end

function CharMovement()

  -- going left
  if Button(Buttons.Left,InputState.Down,0) then
    if (charSpdX > -maxSpd) then
      charSpdX = charSpdX-deltaSpd
    end

  -- going right
  elseif Button(Buttons.Right,InputState.Down,0) then
    if (charSpdX < maxSpd) then
      charSpdX = charSpdX+deltaSpd
    end

  else

    -- decelerate
    if (charSpdX < 0) then 
      charSpdX = charSpdX+deltaSpd
    elseif (charSpdX > 0) then
      charSpdX = charSpdX-deltaSpd
    end

  end

  charX = charX + charSpdX

  -- a (jump)
  if Button(Buttons.A,InputState.Down,0) then
    if (jumpDir == 0) then
      jumpDir = -1
    end
  end


  if (jumpDir == -1) then
    jumpCur = jumpCur-1

    if (jumpCur <= -jumpHeight) then
      jumpDir = 1
      jumpCur = -jumpHeight
    end

  elseif (jumpDir == 1) then
    jumpCur = jumpCur+1
    if (jumpCur >= 0) then
      jumpCur = 0
      jumpDir = 0
    end
  end

  charY = 96 + jumpCur
end

