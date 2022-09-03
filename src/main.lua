APPID="01341039-e93b-435b-8829-29cb6be5e3ed"

function _init()
	cartdata(APPID)

	menuitem(1, "restart game", ChangeStateMainMenu)
	menuitem(2, "restart level", ResetCurrentLevel)

	LoadLevel(1)

	Player:init({
		celX = GetCurrentLevelPlayerCellPos().cx,
		celY = GetCurrentLevelPlayerCellPos().cy
	}, GetCurrentLevelPlayerCellPos().dir)
end

function _update60()
	GameUpdate()
end

function _draw()
	GameDraw()
end
