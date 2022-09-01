APPID="01341039-e93b-435b-8829-29cb6be5e3ed"

function _init()
	cartdata(APPID)

	menuitem(1, "restart level", ResetCurrentLevel)
	menuitem(2, "reset saved time", ResetCurrentLevelBestTime)

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
