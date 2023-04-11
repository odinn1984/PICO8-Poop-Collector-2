SPR_GAME_TITLE = 72
SPR_GAME_TITLE_POOP = 70

local currentColorIdx = 0
local promptColors = {8, 14, 9, 15, 9, 14}
local colorChangeStart = time()
local colorChangeInterval = 0.05
local currentMenuItem = -1
local menuItems = {
    { title = "continue", active = false },
    { title = "new game", active = true },
    { title = "challenge mode", active = true },
    { title = "instructions", active = true },
    { title = "best times", active = true },
}

function UpdateInitialMenuSelection()
    local savedLevelNum = dget(DATA_LEVEL_REACHED_IDX)

    if currentMenuItem == -1 and savedLevelNum > 0 then
        currentMenuItem = 0
    elseif currentMenuItem == -1 then
        currentMenuItem = 1
    end
end

local function startGame(levelNum, resetLevelProgress, challengeMode)
    sfx(SFX_MENU_ACCEPT)

    SetGameState(STATE_GAME_LEVEL_RESET)
    LoadLevel(levelNum)

    if resetLevelProgress then
        dset(DATA_LEVEL_REACHED_IDX, 0)
    end

    Player:init({
        celX = GetCurrentLevelPlayerCellPos().cx,
        celY = GetCurrentLevelPlayerCellPos().cy
    }, GetCurrentLevelPlayerCellPos().dir, challengeMode)

    ResetCurrentLevel()
end

function UpdateMainMenu()
    local savedLevelNum = dget(DATA_LEVEL_REACHED_IDX)

    if savedLevelNum > 0 then
        menuItems[1].active = true
    end

    if btnp(BUTTON_O) or btnp(BUTTON_X) then
        if currentMenuItem == 0 then
            if not menuItems[1].active then
                sfx(SFX_MENU_ERROR)
            else
                startGame(savedLevelNum, false, false)
            end
        elseif currentMenuItem == 1 then
            startGame(STARTING_LEVEL_NUM, true, false)
        elseif currentMenuItem == 2 then
            startGame(STARTING_LEVEL_NUM, false, true)
        elseif currentMenuItem == 3 then
            sfx(SFX_MENU_ACCEPT)
            SetGameState(STATE_GAME_INSTRUCTIONS)
        elseif currentMenuItem == 4 then
            sfx(SFX_MENU_ACCEPT)
            SetGameState(STATE_GAME_HIGHSCORE)
        end
    end

    if time() - colorChangeStart >= colorChangeInterval then
        colorChangeStart = time()
        currentColorIdx = (currentColorIdx + 1) % #promptColors
    end

    if btnp(BUTTON_DOWN) then
        sfx(SFX_MENU_OPT_SELECT)
        currentMenuItem = (currentMenuItem + 1) % (#menuItems)
    elseif btnp(BUTTON_UP) then
        sfx(SFX_MENU_OPT_SELECT)
        currentMenuItem = (currentMenuItem - 1) % (#menuItems)
    end
end

function DrawMainMenu()
    cls()

    rect(0, 0, 127, 127, CLR_DARK_BLUE)
    rect(1, 1, 126, 126, CLR_DARK_BLUE)

    spr(
        SPR_GAME_TITLE_POOP,
        32,
        10,
        2,
        2
    )

    spr(
        SPR_GAME_TITLE_POOP,
        80,
        10,
        2,
        2,
        true
    )

    spr(
        SPR_GAME_TITLE,
        32,
        16,
        8,
        4
    )


    local menuOffset = 60
    local menuSpacing = 8

    rectfill(
        0,
        menuOffset + (currentMenuItem * menuSpacing) - 2,
        128,
        menuOffset + (currentMenuItem * menuSpacing) + menuSpacing - 2
    )

    for i=1,#menuItems do
        local color = menuItems[i].active and CLR_WHITE or CLR_DARK_GREY

        if currentMenuItem + 1 == i and menuItems[i].active then
            color = promptColors[currentColorIdx + 1]
        end

        PrintCenter(menuItems[i].title, menuOffset + (menuSpacing * (i - 1)), color)
    end

    local prompt = "press " .. CHAR_BUTTON_O .. " or " .. CHAR_BUTTON_X .. " to confirm"

    rectfill(0, 114, 128, 128, CLR_DARK_BLUE)
    print(prompt, 60 - (#prompt * 2), 118, CLR_WHITE)
end
