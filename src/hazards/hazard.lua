function CreateHazard()
    return {
        p = {
            x = 0,
            y = 0
        },
        w = 8,
        h = 8,
        v = {
            x = 0,
            y = 0
        },
        hitbox = {
            x = 0,
            y = 0,
            w = 8,
            h = 8
        },
        currentSprite = 0,
        direction = DIRECTION_LEFT
    }
end

function DrawHazards()
    DrawAllSpikes()
end

function UpdateHazards()
    UpdateAllSpikes()
end

function ClearAllHazards()
    ClearAllSpikes()
end

function ResetReappearingHazards()
end
