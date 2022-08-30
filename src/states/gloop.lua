function GameLoopUpdate()
    UpdatePickups()
	UpdateHazards()

    Player:update()

    if Player:canMove() and not IsLevelStartTimeSet() then
        SetCurrentLevelStartTime(time())
    end
end

local function drawCurrentLevel()
    local levelCellPos = GetCurrentLevelCellPos()
    local levelPos = GetCurrentLevelPos()
    local levelCellDim = GetCurrentLevelDimentionCells()

    camera(levelPos.x, levelPos.y)
    map(
        levelCellPos.cx,
        levelCellPos.cy,
        levelPos.x,
        levelPos.y,
        levelCellDim.w,
        levelCellDim.h
    )

    if mget(Player:getPosition().x / 8, Player:getPosition().y / 8) == SPR_DOOR_OPENED then
        if not IsLastLevel() then
            NextLevel()
        else
            SetCurrentLevelBestTime()
            SetGameState(STATE_GAME_WIN)
        end
    end

    UpdatePlayerHUD()
end

function GameLoopDraw()
    cls()

    drawCurrentLevel()
    DrawPickups()
	DrawHazards()

    if GetPoopsCollected() == GetPoopTarget() and not CurrentLevelKeyPresent() then
        CurrentLevelRevealKey()
    end

    if GetKeysCollected() == GetKeyTarget() and CurrentLevelKeyPresent() and not CurrentLevelOpen() then
        CurrentLevelOpenDoor()
    end

    DrawPlayerHUD()

    Player:draw()
end
