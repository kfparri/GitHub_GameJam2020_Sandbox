Laser = {}
Laser.__index = Laser

function Laser:Init(x, y, facing)
    local _laser = Entity:CreateEntity(x, y, "laser")
    setmetatable(_laser, Laser)

    _laser.speed = 5

    local dx = 0
    local dy = 0

    if(facing == 1) then 
        dx = _laser.speed
        dy = -_laser.speed
    elseif(facing == 2) then
        dx = _laser.speed
        dy = -_laser.speed
    elseif(facing == 3) then
        dx = _laser.speed
        dy = 0
    elseif(facing == 4) then
        dx = _laser.speed
        dy = _laser.speed
    elseif(facing == 5) then
        dx = 0
        dy = _laser.speed
    elseif(facing == 6) then
        dx = -_laser.speed
        dy = _laser.speed
    elseif(facing == 7) then
        dx = -_laser.speed
        dy = 0
    elseif(facing == 8) then
        dx = -_laser.speed
        dy = -_laser.speed
    end

    _laser.dx = dx
    _laser.dy = dy
    _laser.dead = false

    return _laser
end

function Laser:Update(timeDelta)
    local display = Display()    
    self.x = self.x + self.dx
    self.y = self.y + self.dy

    if(self.x > display.x or self.x < 0) then
        self.dead = true
    end

    if(self.y > display.y or self.y < 0) then
        self.dead = true
    end
end

function Laser:Draw(offsetX, offsetY)
    if(self.dead == false) then
        Entity:DrawEntity(self, offsetX, offsetY)
    end
end