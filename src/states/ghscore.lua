function UpdateHighScores()
    if btnp(BUTTON_O) or btnp(BUTTON_X) then
        sfx(SFX_MENU_ACCEPT)
        music(MUSIC_MENU)
        SetGameState(STATE_MAIN_MENU)
    end
end

local function drawBestTimesTable()
    rect(42, 0, 43, 128, CLR_DARK_BLUE)
    rect(84, 0, 85, 128, CLR_DARK_BLUE)

    for i=0,23 do
        local bestTime = dget(i) > 0 and GetFormattedTime(dget(i)) or "   " .. CHAR_TIME
        local xPos = 6 + (42 * flr( i / 11))
        local yPos = 6 + (10 * (i % 11))
        local color = (i % 11) % 2 == 1 and CLR_DARK_GREY or CLR_BLACK

        rectfill(xPos - 4, yPos - 2, xPos + 35, yPos + 6, color)
        print(bestTime, xPos, yPos, CLR_WHITE)
    end
end

function DrawHighScores()
    cls()

    rect(0, 0, 127, 127, CLR_DARK_BLUE)
    rect(1, 1, 126, 126, CLR_DARK_BLUE)

    drawBestTimesTable()

    local prompt = "press " .. CHAR_BUTTON_O .. " or " .. CHAR_BUTTON_X .. " for menu"

    rectfill(0, 114, 128, 128, CLR_DARK_BLUE)
    print(prompt, 60 - (#prompt * 2), 118, CLR_WHITE)
end
