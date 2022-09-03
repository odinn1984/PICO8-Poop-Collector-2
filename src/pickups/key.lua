SPR_KEY = 14

local keysTable = {}
local animData = {
    name = "IDLE",
    sprites = {
        SPR_KEY
    },
    interval = 0.5
}
local previousStartSpriteIdx = 0
local lastKeyId = 0

local function getKeyIdx(id)
    for i=1,#keysTable do
        if keysTable[i].id == id then
            return i
        end
    end

    return 0
end

function GetNumOfKeys()
    return #keysTable
end

function GetKey(id)
    for i=1,#keysTable do
        if keysTable[i].id == id then
            return keysTable[i]
        end
    end

    return nil
end

function DrawAllKeys()
    for i=1,#keysTable do
        if keysTable[i] then
            DrawKey(keysTable[i].id)
        end
    end
end

function UpdateAllKeys()
    for i=1,#keysTable do
        if keysTable[i] then
            UpdateKey(keysTable[i].id)
        end
    end
end

function GetAllKeys()
    local keys = {}

    for i = 1,#keysTable do
        if keysTable[i] then
            local key = keysTable[i]
            keys[#keys + 1] = key
        end
    end

    return keys
end

function AddKey(cellX, cellY)
    local key = {
        id = 0,
        attributes = {}
    }

    key.id = lastKeyId + 1
    key.attributes = CreatePikcup()

    key.attributes.p.x = cellX * 8
    key.attributes.p.y = cellY * 8
    key.attributes.h = 8
    key.attributes.w = 8
    key.attributes.currentSprite = animData.sprites[1]
    key.attributes.hitbox.x = 0
    key.attributes.hitbox.y = 0
    key.attributes.hitbox.w = 8
    key.attributes.hitbox.h = 8
    key.attributes.animationStart = time()

    keysTable[#keysTable + 1] = key
    previousStartSpriteIdx = (previousStartSpriteIdx + 1) % #animData.sprites
    lastKeyId = lastKeyId + 1
end

function DrawKey(id)
    local key = GetKey(id)

    if key == nil then
        return
    end

    spr(
        key.attributes.currentSprite,
        key.attributes.p.x,
        key.attributes.p.y,
        key.attributes.w / 8,
        key.attributes.h / 8
    )
end

local function animateKey(id)
    local key = GetKey(id)

    if key == nil then
        return
    end

    if time() - key.attributes.animationStart > animData.interval then
        local nextSpriteIdx = key.attributes.currentSprite - 14

        key.attributes.currentSprite = animData.sprites[((nextSpriteIdx + 1) % #animData.sprites) + 1]
        key.attributes.animationStart = time()
    end
end

function UpdateKey(id)
    local key = GetKey(id)

    if key == nil then
        return
    end

    animateKey(key.id)

    if
        ObjectsOverlapping(
            key.attributes,
            Player:getCollisionData()
        )
    then
        Player:incrementKeys(1)
        DestroyKey(key.id)
    end
end

function DestroyKey(id)
    local idx = getKeyIdx(id)

    if idx == 0 then
        return
    end

    deli(keysTable, idx)
end

function ClearAllKeys()
    keysTable = {}
end
