local changeGameState = false

function UpdateGameReset()
    if changeGameState then
        ResetReappearingLevelItems()
        SetGameState(STATE_GAME_LOOP)

        changeGameState = false
    end
end

function DrawGameReset()
    Wait(RESET_WAIT_TIME)
    FadeOut()

    cls()
    pal()

    changeGameState = true
end
