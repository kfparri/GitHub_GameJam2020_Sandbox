Entity = {}
Entity.__index = Entity

-- Create basic entity
function Entity:CreateEntity(x, y, spriteName)
    local entity = {
        x = x,
        y = y,
        flipH = false,
        flipV = false,
        colorOffset = 0,
        spriteData = _G[spriteName],
        drawMode = DrawMode.SpriteAbove,
        alive = true,
        dx = 0,
        dy = 0,
        speed = .5
    }

    if(entity.spriteData ~= nil) then
        entity.w = entity.spriteData.width
        entity.h = math.floor(#entity.spriteData.spriteIDs / entity.spriteData.width)
    end

    return entity
end

function Entity:CreateAnimatedEntity(x, y, frames)
    -- use the created entity method for getting started
    local entity Entity:CreateEntity(x, y)

    -- since there was no sprite name, we need to reconfigure the data by hand
    entity.spriteData = frames[1]

    -- recalc size
    if(entity.spriteData ~= nil) then
        entity.w = entity.spriteData.width * 8
        entity.h = (math.floor(#entity.spriteData.spriteIDs / entity.spriteData.width)) * 8
    end

    -- add animation properties
    entity.time = 0
    entity.delay = .1
    entity.frame = 1
    entity.frames = frames
    entity.animate = true

    return entity
end

function Entity:DrawEntity(entity, offsetX, offsetY)
    offsetX = offsetX or 0
    offsetY = offsetY or 0

    if(entity.spriteData ~= nil) then
        DrawSprites( entity.spriteData.spriteIDs, entity.x + offsetX, entity.y + offsetY, entity.spriteData.width, entity.flipH, entity.flipV, entity.drawMode, entity.colorOffset, false, false )
    end
end
