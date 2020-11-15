--[[
  Pixel Vision 8 - New Template Script
  Copyright (C) 2017, Pixel Vision 8 (@pixelvision8)
  Created by Jesse Freeman (@jessefreeman)

  This project was designed to display some basic instructions when you create
  a new game.  Simply delete the following code and implement your own Init(),
  Update() and Draw() logic.

  Learn more about making Pixel Vision 8 games at
  https://www.pixelvision8.com/getting-started
]]--

--[[
  This this is an empty game, we will the following text. We combined two sets
  of fonts into the default.font.png. Use uppercase for larger characters and
  lowercase for a smaller one.
]]--
LoadScript( "sprites" )
LoadScript( "entity" )
LoadScript( "player" )
LoadScript( "laser" )

local keys = {
  Keys.W,
  Keys.A,
  Keys.S,
  Keys.D,
  Keys.Space
}

local pressedKeys = {}

local player = {}
local laserCount = 0
local maxLaser = 2
local timeBetweenShots = 250
local shotTimer = 251 -- one frame ahead of the time between so there is no delay to shooting

local sprites = {}
local laser = nil
--[[
  The Init() method is part of the game's lifecycle and called a game starts.
  We are going to use this method to configure background color,
  ScreenBufferChip and draw a text box.
]]--
function Init()

    -- Here we are manually changing the background color
    BackgroundColor(0)

    player = Player:Init(10, 10)
    local display = Display()

    -- We are going to render the message in a box as tiles. To do this, we
    -- need to wrap the text, then split it into lines and draw each line.
    --local wrap = WordWrap(message, (display.x / 8) - 2)
    --local lines = SplitLines(wrap)
    --local total = #lines
    --local startY = ((display.y / 8) - 1) - total

    -- We want to render the text from the bottom of the screen so we offset
    -- it and loop backwards.
    --for i = total, 1, - 1 do
        --DrawText(lines[i], 1, startY + (i - 1), DrawMode.Tile, "large", 15)
    --end
    
    --player:Draw(0, 0)
end

--[[
  The Update() method is part of the game's life cycle. The engine calls
  Update() on every frame before the Draw() method. It accepts one argument,
  timeDelta, which is the difference in milliseconds since the last frame.
]]--
function Update(timeDelta)
  pressedKeys = {}
  tempSprites = {}

  for i = 1, #keys do
    if(Key(keys[i])) then
      table.insert(pressedKeys, tostring(keys[i]))
    end
  end  
    -- TODO add your own update logic here
  player:Update(timeDelta, pressedKeys)

  if(Key(Keys.Space) and (laserCount < maxLaser) and shotTimer > timeBetweenShots) then
    laser = Laser:Init(player.x, player.y, player.facing)
    table.insert(sprites, laser)
    laserCount += 1
    shotTimer = 0
    --laser = nil
  else
    shotTimer += timeDelta
  end
  
  for i = 1, #sprites do
    sprites[i]:Update(timeDelta)   

    if(sprites[i].dead) then
      --table.remove(sprites, i)
      laserCount -= 1
      if(laserCount < 0) then
        laserCount = 0
      end
    else
      table.insert(tempSprites, sprites[i])
    end
  end

  -- remove any dead sprites
  sprites = {}

  for i = 1, #tempSprites do
    table.insert(sprites, tempSprites[i])
  end

  tempSprites = {}
end

--[[
  The Draw() method is part of the game's life cycle. It is called after
  Update() and is where all of our draw calls should go. We'll be using this
  to render sprites to the display.
]]--
function Draw()

    -- We can use the RedrawDisplay() method to clear the screen and redraw
    -- the tilemap in a single call.
    RedrawDisplay()
    player:Draw(0,0)
    
    for i = 1, #sprites do
      if(sprites[i].dead == false) then
        sprites[i]:Draw(0,0)
      end
    end

    DrawText(player.facing, 1, 0, DrawMode.Tile, "large", 15)

    -- for i = 1, #pressedKeys do
    --   DrawText( pressedKeys[i], 10 + i, 20, DrawMode.Sprite, "large", 15 )
    -- end
    --DrawSprites( {0,1,16,17}, 10, 10, 2, false, false, DrawMode.Sprite, 0, false, false )
    --DrawSprite( 0, 10, 10, false, false, DrawMode.Sprite, 0 )
    --player:Draw(0, 0)
    -- TODO add your own draw logic here.

end
