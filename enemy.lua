-- Enemy Entity
Enemy = {}
Enemy.__index = Enemy

function Enemy:Init(x, y)

  local frames = {
    _G["enemywalker1"],
    _G["enemywalker2"],
    _G["enemywalker3"],
  }

  local _enemy = CreateAnimatedEntity(x, y, frames, delay) -- our new object
  setmetatable(_enemy, Enemy) -- make Account handle lookup

  _enemy.speed = 10
  _enemy.flipH = (math.random(1, 10) > 5)
  _enemy.death = _G["enemywalker4"]
  _enemy.deathDelay = .3
  _enemy.value = 1

  return _enemy

end

function Enemy:Update(timeDelta)

  -- Look to see if entity is dying
  if(self.dying == true) then
    self.time = self.time + timeDelta

    if(self.time > self.deathDelay) then
      self.dying = false
      self.alive = false
    end

    return

  end

  -- If the entity is dead, don't update
  if(self.alive == false) then
    return
  end

  local offset = self.speed * timeDelta

  if(self.flipH == true) then
    offset = offset * - 1
  end

  self.x = self.x + offset

  local c = math.floor((self.x + ScrollPosition().x) / 8)
  local r = math.floor((self.y + ScrollPosition().y) / 8) + 1

  -- If moving to the right, need to make sure we look ahead of the sprite so add 1 tile to the value
  if(self.flipH == false) then
    c = c + 1
  end

  if(Flag(c, r) == -1) then
    self.flipH = not self.flipH
  end

  AnimateEntity(self, timeDelta)

end

function Enemy:Draw(offsetX, offsetY)

  -- If the entity is dead, don't update
  if(self.alive == false) then
    return
  end

  DrawEntity(self, offsetX, offsetY)
end

function Enemy:Collision(player)

  -- Only do collision checking if the entity is alive and not dying
  if(self.alive == false or self.dying == true and player.alive == false) then
    return
  end
  -- Test to see if there is a collision with the supplied rect
  local collision = EntityCollision(self, player)

  if(collision == true) then

    -- If the player is above the bad guy and falling down, kill the bad guy
    if(player.y < self.y and math.abs(player.dy) > 0) then

      if(player.dy > 4 or player.justKilled == true) then

        self.dying = true
        self.time = 0
        self.frame = 1
        self.spriteData = self.death

        stars = stars + self.value

        self.value = 0

        player.justKilled = true


        PlaySound(8, 3)

      end

      player.dy = -(player.jumpvel * .5)

      PlaySound(9, 3)

    else

      player.alive = false

    end

  end

end
