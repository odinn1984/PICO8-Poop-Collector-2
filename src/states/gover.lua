function UpdateGameOver()
end

function DrawGameOver()
    cls()

    camera(0, 0)

    rectfill(0, 0, 128, 10, 1)
    rectfill(0, 118, 128, 128, 1)

    PrintCenter("you have been flushed", 3, 9)

    spr(70, 6, 52, 2, 2)
    PrintMiddle("reached level "..GetCurrentLevelNumber(), 4)
    spr(70, 105, 52, 2, 2, true)

    PrintCenter("press enter for menu", 121, 8)
end
