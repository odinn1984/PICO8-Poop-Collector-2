function CreatePikcup()
    return {
        p = {
            x = 0,
            y = 0
        },
        w = 8,
        h = 8,
        hitbox = {
            x = 0,
            y = 0,
            w = 8,
            h = 8
        },
        currentSprite = 0
    }
end

function DrawPickups()
    DrawAllPoops()
    DrawAllDashes()
    DrawAllKeys()
end

function UpdatePickups()
    UpdateAllPoops()
    UpdateAllDashes()
    UpdateAllKeys()
end

function ClearAllPickups()
    ClearAllPoops()
    ClearAllDashes()
    ClearAllKeys()
end
