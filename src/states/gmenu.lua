local currentColorIdx = 0
local promptColors = {8, 14, 9, 15, 9, 14}
local colorChangeStart = time()
local colorChangeInterval = 0.05

function UpdateMainMenu()
    if btnp(BUTTON_O) then
        LoadLevel(STARTING_LEVEL_NUM)

        Player:init({
            celX = GetCurrentLevelPlayerCellPos().cx,
            celY = GetCurrentLevelPlayerCellPos().cy
        }, GetCurrentLevelPlayerCellPos().dir)

        SetGameState(STATE_GAME_LOOP)
    end

    if time() - colorChangeStart >= colorChangeInterval then
        colorChangeStart = time()
        currentColorIdx = (currentColorIdx + 1) % #promptColors
    end
end

function DrawMainMenu()
    cls()

    local prompt = "press " .. CHAR_BUTTON_O .. " to start"
    local title = "poop collector: number 2"

    rect(0, 0, 127, 127, CLR_DARK_BLUE)
    rect(1, 1, 126, 126, CLR_DARK_BLUE)

    print(title, 64 - (#title * 2), 62, CLR_BROWN)
    print(prompt, 64 - (#prompt * 2), 118, promptColors[currentColorIdx + 1])
end
