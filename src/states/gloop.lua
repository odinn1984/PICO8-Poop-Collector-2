function UpdateGameLoop()
    UpdatePickups()
	UpdateHazards()
    UpdateSceneItems()

    Player:update()

    if Player:Moved() and not IsLevelStartTimeSet() then
        SetCurrentLevelStartTime(time())
    end
end

local function drawCurrentLevel()
    local levelCellPos = GetCurrentLevelCellPos()
    local levelPos = GetCurrentLevelPos()
    local levelCellDim = GetCurrentLevelDimentionCells()

    map(
        levelCellPos.cx,
        levelCellPos.cy,
        levelPos.x,
        levelPos.y,
        levelCellDim.w,
        levelCellDim.h
    )

    UpdatePlayerHUD()

    if GetPoopsCollected() == GetPoopTarget() and not CurrentLevelKeyPresent() then
        CurrentLevelRevealKey()
    end

    if GetKeysCollected() == GetKeyTarget() and CurrentLevelKeyPresent() and not CurrentLevelOpen() then
        CurrentLevelOpenDoor()
    end
end

function DrawGameLoop()
    cls()

    drawCurrentLevel()
    DrawPickups()
	DrawHazards()
    DrawSceneItems()
    DrawPlayerHUD()

    Player:draw()

    if
        CurrentLevelOpen() and
        ObjectsOverlapping(
            Player:getCollisionData(),
            GetDoorCollisionData()
        )
    then
        if not IsLastLevel() then
            sfx(SFX_LEVEL_CLEAR)
            NextLevel()
        else
            SetCurrentLevelBestTime()
            SetGameState(STATE_GAME_WIN)
        end
    end
end
