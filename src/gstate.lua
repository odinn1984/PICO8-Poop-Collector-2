STATE_MAIN_MENU = 0
STATE_GAME_PAUSE = 1
STATE_GAME_LOOP = 2
STATE_GAME_DIALOG = 3
STATE_GAME_WIN = 4
STATE_GAME_OVER = 5

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
    end
end

function GameDraw()
    if currentState == STATE_GAME_LOOP then
        GameLoopDraw()
    end
end
