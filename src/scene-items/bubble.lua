SPR_BUBBLE = 27
SPR_BUBBLE2 = 28

local BUBBLE_RECREATE_DELAY = 2

local bubblesTable = {}
local bubbleDelayedCreateTable = {}
local animData = {
    name = "IDLE",
    sprites = {
        SPR_BUBBLE,
        SPR_BUBBLE2,
    },
    interval = 0.55
}
local previousStartSpriteIdx = 0
local lastBubbleId = 0

local function getBubbleIdx(id)
    for i=1,#bubblesTable do
        if bubblesTable[i].id == id then
            return i
        end
    end

    return 0
end

function GetNumOfBubbles()
    return #bubblesTable
end

function GetBubble(id)
    for i=1,#bubblesTable do
        if bubblesTable[i].id == id then
            return bubblesTable[i]
        end
    end

    return nil
end

function DrawAllBubbles()
    for i=1,#bubblesTable do
        if bubblesTable[i] then
            DrawBubble(bubblesTable[i].id)
        end
    end
end

function UpdateAllBubbles()
    for i=1,#bubblesTable do
        if bubblesTable[i] then
            UpdateBubble(bubblesTable[i].id)
        end
    end

    for i=1,#bubbleDelayedCreateTable do
        if
            bubbleDelayedCreateTable[i] and
            time() - bubbleDelayedCreateTable[i].time >= BUBBLE_RECREATE_DELAY
        then
            AddBubble(bubbleDelayedCreateTable[i].cx, bubbleDelayedCreateTable[i].cy)
            deli(bubbleDelayedCreateTable, i)
        end
    end
end

function GetAllBubbles()
    local bubbles = {}

    for i = 1,#bubblesTable do
        if bubblesTable[i] then
            local bubble = bubblesTable[i]
            bubbles[#bubbles + 1] = bubble
        end
    end

    return bubbles
end

function AddBubble(cellX, cellY)
    local bubble = {
        id = 0,
        attributes = {}
    }

    bubble.id = lastBubbleId + 1
    bubble.attributes = CreateSceneItem()

    bubble.attributes.p.x = cellX * 8
    bubble.attributes.p.y = cellY * 8
    bubble.attributes.h = 8
    bubble.attributes.w = 8
    bubble.attributes.currentSprite = animData.sprites[1]
    bubble.attributes.hitbox.x = 0
    bubble.attributes.hitbox.y = 0
    bubble.attributes.hitbox.w = 8
    bubble.attributes.hitbox.h = 8
    bubble.attributes.animationStart = time()

    bubblesTable[#bubblesTable + 1] = bubble
    previousStartSpriteIdx = (previousStartSpriteIdx + 1) % #animData.sprites
    lastBubbleId = lastBubbleId + 1
end

function DrawBubble(id)
    local bubble = GetBubble(id)

    if bubble == nil then
        return
    end

    spr(
        bubble.attributes.currentSprite,
        bubble.attributes.p.x,
        bubble.attributes.p.y,
        bubble.attributes.w / 8,
        bubble.attributes.h / 8
    )
end

local function animateBubble(id)
    local bubble = GetBubble(id)

    if bubble == nil then
        return
    end

    if time() - bubble.attributes.animationStart > animData.interval then
        local nextSpriteIdx = bubble.attributes.currentSprite - 27

        bubble.attributes.currentSprite = animData.sprites[((nextSpriteIdx + 1) % #animData.sprites) + 1]
        bubble.attributes.animationStart = time()
    end
end

function UpdateBubble(id)
    local bubble = GetBubble(id)

    if bubble == nil then
        return
    end

    animateBubble(bubble.id)

    if
        ObjectsOverlapping(
            bubble.attributes,
            Player:getCollisionData()
        )
    then
        Player:Launch()
        DestroyBubble(bubble.id)
    end
end

function DestroyBubble(id)
    local idx = getBubbleIdx(id)

    if idx == 0 then
        return
    end

    local currentBubble = GetBubble(id)

    if currentBubble then
        DelayedAddBubble(
            currentBubble.attributes.p.x / 8,
            currentBubble.attributes.p.y / 8
        )
    end

    deli(bubblesTable, idx)
end

function DelayedAddBubble(cellX, cellY)
    bubbleDelayedCreateTable[#bubbleDelayedCreateTable + 1] = {
        time = time(),
        cx = cellX,
        cy = cellY
    }
end

function ClearAllBubbles()
    bubblesTable = {}
end
