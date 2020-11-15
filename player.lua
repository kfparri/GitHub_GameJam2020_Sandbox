Player = {}
Player.__index = Player

function Player:Init(x, y)
    local frames = {
        _G["stickMan"]
    }

    local _player = Entity:CreateEntity(x, y, "stickMan") -- CreateAnimatedEntity(x, y, frames) -- our new object
    setmetatable(_player, Player)

    _player.speed = 1
    -- Facing directions:
    --      1
    --    8   2
    --   7     3
    --    6   4
    --      5    
    _player.facing = 3 -- 3 faces right

    return _player
end

function Player:Update(timeDelta, pressedKeys)
    self.dx = 0
    self.dy = 0

    local keys = {
        {W = false},
        {A = false},
        {S = false},
        {D = false}
    }

    for i = 1, #pressedKeys do
        if(pressedKeys[i] == "W") then 
            keys.W = true
        end

        if(pressedKeys[i] == "A") then 
            keys.A = true
        end

        if(pressedKeys[i] == "S") then 
            keys.S = true
        end

        if(pressedKeys[i] == "D") then 
            keys.D = true
        end
    end

    -- determine movement direction
    if(keys.A) then
        self.dx += -self.speed
        self.facing = 7

        if(keys.A and keys.W) then
            self.facing = 8
        end

        if(keys.A and keys.S) then
            self.facing = 6
        end
    end

    if(keys.D) then
        self.dx += self.speed
        self.facing = 3

        if(keys.D and keys.W) then
            self.facing = 2
        end

        if(keys.A and keys.S) then
            self.facing = 6
        end
    end

    if(keys.W) then
        self.dy += -self.speed

        self.facing = 1

        if(keys.A and keys.W) then
            self.facing = 8
        end

        if(keys.W and keys.D) then
            self.facing = 2
        end
    end

    if(keys.S) then
        self.dy += self.speed

        self.facing = 5

        if(keys.A and keys.S) then
            self.facing = 6
        end

        if(keys.D and keys.S) then
            self.facing = 4
        end
    end    
    
    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Player:Draw(offsetX, offsetY)
    Entity:DrawEntity(self, offsetX, offsetY)
end