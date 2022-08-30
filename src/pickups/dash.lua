SPR_DASH_1 = 9
SPR_DASH_2 = 10

local dashesTable = {}
local animData = {
    name = "IDLE",
    sprites = {
        SPR_DASH_1,
        SPR_DASH_2
    },
    interval = 0.25
}
local previousStartSpriteIdx = 0
local lastDashId = 0

local function getDashIdx(id)
    for i=1,#dashesTable do
        if dashesTable[i].id == id then
            return i
        end
    end

    return 0
end

function GetNumOfDashes()
    return #dashesTable
end

function GetDash(id)
    for i=1,#dashesTable do
        if dashesTable[i].id == id then
            return dashesTable[i]
        end
    end

    return nil
end

function DrawAllDashes()
    for i=1,#dashesTable do
        if dashesTable[i] then
            DrawDash(dashesTable[i].id)
        end
    end
end

function UpdateAllDashes()
    for i=1,#dashesTable do
        if dashesTable[i] then
            UpdateDash(dashesTable[i].id)
        end
    end
end

function GetAllDashes()
    local dashes = {}

    for i = 1,#dashesTable do
        if dashesTable[i] then
            local dash = dashesTable[i]
            dashes[#dashes + 1] = dash
        end
    end

    return dashes
end

function AddDash(cellX, cellY)
    local dash = {
        id = 0,
        attributes = {}
    }

    dash.id = lastDashId + 1
    dash.attributes = CreatePikcup()

    dash.attributes.p.x = cellX * 8
    dash.attributes.p.y = cellY * 8
    dash.attributes.h = 8
    dash.attributes.w = 8
    dash.attributes.currentSprite = animData.sprites[1]
    dash.attributes.hitbox.x = 0
    dash.attributes.hitbox.y = 0
    dash.attributes.hitbox.w = 8
    dash.attributes.hitbox.h = 8
    dash.attributes.animationStart = time()

    dashesTable[#dashesTable + 1] = dash
    previousStartSpriteIdx = (previousStartSpriteIdx + 1) % #animData.sprites
    lastDashId = lastDashId + 1
end

function DrawDash(id)
    local dash = GetDash(id)

    if dash == nil then
        return
    end

    spr(
        dash.attributes.currentSprite,
        dash.attributes.p.x,
        dash.attributes.p.y,
        dash.attributes.w / 8,
        dash.attributes.h / 8
    )
end

local function animateDash(id)
    local dash = GetDash(id)

    if dash == nil then
        return
    end

    if time() - dash.attributes.animationStart > animData.interval then
        local nextSpriteIdx = dash.attributes.currentSprite - 9

        dash.attributes.currentSprite = animData.sprites[((nextSpriteIdx + 1) % #animData.sprites) + 1]
        dash.attributes.animationStart = time()
    end
end

function UpdateDash(id)
    local dash = GetDash(id)

    if dash == nil then
        return
    end

    animateDash(dash.id)

    if
        ObjectsOverlapping(
            dash.attributes,
            Player:getCollisionData()
        )
    then
        Player:EnableDash()
        DestroyDash(dash.id)
    end
end

function DestroyDash(id)
    local idx = getDashIdx(id)

    if idx == 0 then
        return
    end

    deli(dashesTable, idx)
end

function ClearAllDashes()
    dashesTable = {}
end
