STATE_MAIN_MENU = 0
STATE_GAME_LOOP = 1
STATE_GAME_WIN = 2
STATE_GAME_LEVEL_RESET = 4

local currentState = STATE_MAIN_MENU

function GetGameState()
    return currentState
end

function SetGameState(newState)
    currentState = newState

    if
        currentState == STATE_GAME_LOOP or
        currentState == STATE_GAME_LEVEL_RESET
    then
        menuitem(MENU_ITEM_RESTART_IDX, "restart level", ResetCurrentLevel)
	    menuitem(MENU_ITEM_MAINMENU_IDX, "restart game", ChangeStateMainMenu)
    else
        menuitem(MENU_ITEM_RESTART_IDX)
	    menuitem(MENU_ITEM_MAINMENU_IDX)
    end
end

function GameUpdate()
    if currentState == STATE_GAME_LEVEL_RESET then
        UpdateGameReset()
    elseif currentState == STATE_GAME_LOOP then
        UpdateGameLoop()
    elseif currentState == STATE_GAME_WIN then
    elseif currentState == STATE_MAIN_MENU then
        UpdateMainMenu()
    end
end

function GameDraw()
    if currentState == STATE_GAME_LEVEL_RESET then
        DrawGameReset()
    elseif currentState == STATE_GAME_LOOP then
        DrawGameLoop()
    elseif currentState == STATE_GAME_WIN then
    elseif currentState == STATE_MAIN_MENU then
        DrawMainMenu()
    end
end
