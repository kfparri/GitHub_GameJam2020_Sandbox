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
        --spriteData = _G[spriteName],
        drawMode = DrawMode.SpriteAbove,
        alive = true,
        dx = 0,
        dy = 0,
        speed = .5
    }

    if(spriteName == nil) then
    
        entity.spriteData = nil
    else
        entity.spriteData = _G[spriteName]
    end

    if(entity.spriteData ~= nil) then
        entity.w = entity.spriteData.width
        entity.h = math.floor(#entity.spriteData.spriteIDs / entity.spriteData.width)
    end

    return entity
end

function Entity:CreateAnimatedEntity(x, y, frames, delay)
    -- use the created entity method for getting started
    --local entity Entity:CreateEntity(x, y)
    local entity = {
        x = x,
        y = y,
        flipH = false,
        flipV = false,
        colorOffset = 0,        
        spriteData = frames[1],
        drawMode = DrawMode.SpriteAbove,
        alive = true,
        dx = 0,
        dy = 0,
        speed = .5
    }

    -- print("Inside Entity")
    -- print(frames[1].spriteIDs)

    -- for index, data in ipairs(frames) do
    --     print(index)
    
    --     for key, value in pairs(data) do
    --         if(key == "spriteIDs") then
    --             for i, v in pairs(value) do
    --                 print('\t', i, v)
    --             end
    --         else
    --             print('\t', key, value)
    --         end
    --     end
    -- end

    -- since there was no sprite name, we need to reconfigure the data by hand
    --entity.spriteData = frames[1]

    -- recalc size
    if(entity.spriteData ~= nil) then
        entity.w = entity.spriteData.width * 8
        entity.h = (math.floor(#entity.spriteData.spriteIDs / entity.spriteData.width)) * 8
    end

    -- add animation properties
    entity.time = 0
    entity.delay = delay -- .1
    entity.frame = 1
    entity.frames = frames
    entity.animate = true

    return entity
end

function Entity:AnimateEntity(entity, timeDelta)
    if(entity.animate == true) then
        -- calculate the next animation time frame
        entity.time = entity.time + timeDelta

        if(entity.time > entity.delay) then
            entity.time = 0

            -- move to the next frame
            entity.frame = entity.frame + 1

            -- if the frame is greater than the total number of frames, reset the frame counter
            if(entity.frame > #entity.frames) then
                -- reset the frame to 1 since this is the first frame id
                entity.frame = 1
            end

            entity.spriteData = entity.frames[entity.frame]
        end
    end
end

function Entity:DrawEntity(entity, offsetX, offsetY)
    offsetX = offsetX or 0
    offsetY = offsetY or 0

    if(entity.spriteData ~= nil) then
        DrawSprites( entity.spriteData.spriteIDs, entity.x + offsetX, entity.y + offsetY, entity.spriteData.width, entity.flipH, entity.flipV, entity.drawMode, entity.colorOffset, false, false )
    end
end
