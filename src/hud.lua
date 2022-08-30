local function drawPlayerTarget()
    local frameClr = CLR_DARK_BLUE
    local txtColor = CLR_WHITE
    local curSpr = SPR_POOP
    local offset = GetCurrentLevelPos()

    rect(offset.x, offset.y, offset.x + 127, offset.y + 127, frameClr)
    rectfill(offset.x, offset.y, offset.x + 127, offset.y + 10, frameClr)

    if CurrentLevelKeyPresent() and not CurrentLevelOpen() then
        curSpr = SPR_KEY
    elseif CurrentLevelKeyPresent() and CurrentLevelOpen() then
        curSpr = SPR_DOOR_OPENED
    else
        print(
            GetPoopsRemaining(),
            offset.x + 14,
            offset.y + 3,
            txtColor
        )
    end

    spr(
        curSpr,
        offset.x + 4,
        offset.y + 1
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
            timerColor = CLR_GREEN
        end
    end

    print(timer, offset.x + 64 - (#timer * 2), offset.y + 3, timerColor)
end

function DrawPlayerHUD()
    drawPlayerTarget()
    drawTimer()
end

function UpdatePlayerHUD()
end
