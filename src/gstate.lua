STATE_MAIN_MENU = 0
STATE_GAME_LOOP = 1
STATE_GAME_WIN = 2
STATE_GAME_LEVEL_RESET = 4
STATE_GAME_INSTRUCTIONS = 5
STATE_GAME_OVER = 6
STATE_GAME_HIGHSCORE = 7

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
        music(MUSIC_NONE)

        if currentState == STATE_GAME_LOOP and GetCurrentLevelNumber() > FINAL_LEVEL then
            music(MUSIC_WIN)
        end

        menuitem(MENU_ITEM_NEWGAME_IDX)
        menuitem(MENU_ITEM_RESTART_IDX, "restart level", ResetCurrentLevel)
	    menuitem(MENU_ITEM_MAINMENU_IDX, "restart game", ChangeStateMainMenu)
    elseif currentState == STATE_GAME_OVER then
        music(MUSIC_OVER)
        menuitem(MENU_ITEM_RESTART_IDX)
        menuitem(MENU_ITEM_NEWGAME_IDX, "try again", StartGameInChallengeMode)
        menuitem(MENU_ITEM_MAINMENU_IDX, "restart game", ChangeStateMainMenu)
    else
        if currentState == STATE_MAIN_MENU then
            music(MUSIC_MENU)
        else
            music(MUSIC_NONE)
        end

        menuitem(MENU_ITEM_NEWGAME_IDX)
        menuitem(MENU_ITEM_RESTART_IDX)
	    menuitem(MENU_ITEM_MAINMENU_IDX)
    end
end

function GameUpdate()
    if currentState == STATE_GAME_LEVEL_RESET then
        UpdateGameReset()
    elseif currentState == STATE_GAME_LOOP then
        UpdateGameLoop()
    elseif currentState == STATE_GAME_OVER then
        UpdateGameOver()
    elseif currentState == STATE_MAIN_MENU then
        UpdateMainMenu()
    elseif currentState == STATE_GAME_INSTRUCTIONS then
        UpdateGameInstructions()
    elseif currentState == STATE_GAME_HIGHSCORE then
        UpdateHighScores()
    end
end

function GameDraw()
    if currentState == STATE_GAME_LEVEL_RESET then
        DrawGameReset()
    elseif currentState == STATE_GAME_LOOP then
        DrawGameLoop()
    elseif currentState == STATE_GAME_OVER then
        DrawGameOver()
    elseif currentState == STATE_MAIN_MENU then
        DrawMainMenu()
    elseif currentState == STATE_GAME_INSTRUCTIONS then
        DrawGameInstructions()
    elseif currentState == STATE_GAME_HIGHSCORE then
        DrawHighScores()
    end
end
