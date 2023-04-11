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
            offset.x + 23,
            offset.y + 3,
            txtColor
        )
    end

    spr(
        curSpr,
        offset.x + 13,
        offset.y + 1
    )
end

local function drawDashState()
    local offset = GetCurrentLevelPos()

    if Player and Player:DashEnabled() then
        spr(
            SPR_DASH_1,
            offset.x + 3,
            offset.y + 1
        )
    else
        palt(CLR_BLACK, false)
        spr(
            SPR_DASH_DISABLED,
            offset.x + 3,
            offset.y + 1
        )
        palt(CLR_BLACK, true)
    end
end

local function drawCurrentLevel()
    if (GetCurrentLevelNumber() > FINAL_LEVEL) then
        return;
    end

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

local function promptPlayerMove()
    if Player and Player:canMove() and not Player:Moved() then
        local msg =
            CHAR_BUTTON_LEFT .. '/' ..
            CHAR_BUTTON_RIGHT .. '/' ..
            CHAR_BUTTON_X .. '/' ..
            CHAR_BUTTON_O
        local offset = GetCurrentLevelPos()

        local rectStartXOffset = offset.x + 56 - (#msg * 2) - 4
        local rectEndXOffset = offset.x + 56 + (#msg * 2) + 18
        local rectStartYOffset = offset.y + 56
        local rectEndYOffset = offset.y + 68

        rectfill(rectStartXOffset, rectStartYOffset, rectEndXOffset, rectEndYOffset, CLR_DARK_BLUE)
        rect(rectStartXOffset, rectStartYOffset, rectEndXOffset, rectEndYOffset, CLR_ORANGE)

        print(msg, offset.x + 56 - (#msg * 2), offset.y + 60, CLR_WHITE)
    end
end

function DrawPlayerHUD()
    drawPlayerTarget()
    drawDashState()
    drawCurrentLevel()
    drawTimer()
    promptPlayerMove()
end

function UpdatePlayerHUD()
end
