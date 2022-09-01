local function drawPlayerTarget()
    local frameClr = CLR_DARK_BLUE
    local txtColor = CLR_WHITE
    local curSpr = SPR_POOP
    local offset = GetCurrentLevelPos()

    rect(offset.x, offset.y, offset.x + 127, offset.y + 127, frameClr)
    rectfill(offset.x, offset.y, offset.x + 127, offset.y + 10, frameClr)
    rect(offset.x, offset.y, offset.x + 127, offset.y + 10, frameClr)

    if CurrentLevelKeyPresent() and not CurrentLevelOpen() then
        curSpr = SPR_KEY
    elseif CurrentLevelKeyPresent() and CurrentLevelOpen() then
        curSpr = SPR_DOOR_OPENED
    else
        print(
            GetPoopsRemaining(),
            offset.x + 13,
            offset.y + 3,
            txtColor
        )
    end

    spr(
        curSpr,
        offset.x + 3,
        offset.y + 1
    )
end

local function drawCurrentLevel()
    local offset = GetCurrentLevelPos()
    local lvlText = 'lvl ' .. GetCurrentLevelNumber()
    local lvlTextStartPosX = offset.x + 64 - (#lvlText * 2)
    local lvlTextEndPosX = offset.x + 64 + (#lvlText * 2)

    rectfill(
        lvlTextStartPosX - 4,
        offset.y + 121,
        lvlTextEndPosX + 4,
        offset.y + 127,
        CLR_DARK_BLUE
    )
    print(
        lvlText,
        lvlTextStartPosX,
        offset.y + 122,
        CLR_WHITE
    )
end

local function drawTimer()
    local levelTimePassed = GetCurrentLevelTimePassed()
    local timer = GetFormattedTime(levelTimePassed)
    local timerColor = CLR_WHITE
    local offset = GetCurrentLevelPos()

    if GetCurrentLevelBestTime() > 0 then
        if levelTimePassed > GetCurrentLevelBestTime() then
            timerColor = CLR_RED
        elseif levelTimePassed <= GetCurrentLevelBestTime() then
            timerColor = CLR_ORANGE
        end
    end

    local timerStartPosX = offset.x + 64 - (#timer * 2)
    local timerEndPosX = offset.x + 64 + (#timer * 2)

    rectfill(
        timerStartPosX - 6,
        offset.y + 0,
        timerEndPosX +6,
        offset.y + 10,
        CLR_DARK_GREY
    )

    print(timer, timerStartPosX, offset.y + 3, timerColor)
    print(
        GetFormattedTime(GetCurrentLevelBestTime()),
        offset.x + 126 - (#(GetFormattedTime(GetCurrentLevelBestTime())) * 4),
        offset.y + 3,
        CLR_GREEN
    )
end

function DrawPlayerHUD()
    drawPlayerTarget()
    drawCurrentLevel()
    drawTimer()
end

function UpdatePlayerHUD()
end
