function UpdateGameInstructions()
    if btnp(BUTTON_O) or btnp(BUTTON_X) then
        sfx(SFX_MENU_ACCEPT)
        SetGameState(STATE_MAIN_MENU)
    end
end

local function printControls()
    local startY = 70

    rectfill(2, startY - 2, 125, startY + 6, CLR_DARK_BLUE)

    cursor(4, startY, CLR_WHITE)
    print("controls")

    cursor(40, startY + 14, CLR_LIGHT_GREY)
    print(CHAR_BUTTON_LEFT .. " move left")
    print(CHAR_BUTTON_RIGHT .. " move right")
    print(CHAR_BUTTON_O .. " jump")
    print(CHAR_BUTTON_X .. " dash")
end

function DrawGameInstructions()
    cls()

    rect(0, 0, 127, 127, CLR_DARK_BLUE)
    rect(1, 1, 126, 126, CLR_DARK_BLUE)

    printControls()

    local prompt = "press " .. CHAR_BUTTON_O .. " or " .. CHAR_BUTTON_X .. " for menu"

    rectfill(0, 114, 128, 128, CLR_DARK_BLUE)
    print(prompt, 60 - (#prompt * 2), 118, CLR_WHITE)
end
