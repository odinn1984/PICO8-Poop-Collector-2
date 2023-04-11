APPID="01341039-e93b-435b-8829-29cb6be5e3ed"

function _init()
	cartdata(APPID)
	UpdateInitialMenuSelection()
	music(MUSIC_MENU)
end

function _update60()
	GameUpdate()
end

function _draw()
	GameDraw()
end
