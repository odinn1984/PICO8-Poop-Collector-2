STATE_MAIN_MENU = 0
STATE_GAME_LOOP = 1
STATE_GAME_WIN = 2
STATE_GAME_LEVEL_RESET = 4

local currentState = STATE_GAME_LOOP

function GetGameState()
    return currentState
end

function SetGameState(newState)
    currentState = newState
end

function GameUpdate()
    if currentState == STATE_GAME_LOOP then
        GameLoopUpdate()
    elseif currentState == STATE_GAME_WIN then
    elseif currentState == STATE_MAIN_MENU then
    end
end

function GameDraw()
    if currentState == STATE_GAME_LOOP then
        GameLoopDraw()
    elseif currentState == STATE_GAME_LEVEL_RESET then
        ResetReappearingSceneItems()
        ResetReappearingHazards()
        SetGameState(STATE_GAME_LOOP)
    elseif currentState == STATE_GAME_WIN then
    elseif currentState == STATE_MAIN_MENU then
    end
end
