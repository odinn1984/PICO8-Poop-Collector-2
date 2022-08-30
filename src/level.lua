SPR_DOOR_CLOSED = 5
SPR_DOOR_OPENED = 6

MAX_LEVEL = 2

local currentLevel = 1
local currentLevelKeyPosCells = { cx = 0, cy = 0 }
local currentLevelPlayerPosCells = { cx = 0, cy = 0, dir= DIRECTION_NONE }
local currentLevelDoorPosCells = { cx = 0, cy = 0 }
local poopTarget = 0
local keyTarget = 0
local keyPresent = false
local doorOpen = false
local levelStartTime = time()
local levelStartTimeSet = false

local function shouldClearCell(cx, cy)
    local curCell = mget(cx, cy)

    return (
        curCell == SPR_BG_1 or
        curCell == SPR_BG_2 or
        curCell == SPR_BG_3 or
        curCell == SPR_POOP or
        curCell == SPR_POOP_1 or
        curCell == SPR_KEY or
        curCell == SPR_DASH_1 or
        curCell == SPR_DASH_2 or
        curCell == SPR_SPIKE_H or
        curCell == SPR_SPIKE_H_FLIP_Y or
        curCell == SPR_SPIKE_V or
        curCell == SPR_SPIKE_V_FLIP_X or
        curCell == SPR_PLAYER_START_RIGHT or
        curCell == SPR_PLAYER_START_LEFT
    ) and fget(curCell) ~= 0x1 and curCell ~= 0
end

function LoadLevel(levelNum)
    local cxStart = ((levelNum - 1) * 16) % 128
    local cyStart = flr((levelNum - 1) / 7)

    currentLevelKeyPosCells = { cx = 0, cy = 0 }
    currentLevelPlayerPosCells = { cx = 0, cy = 0, dir= DIRECTION_NONE }
    poopTarget = 0
    keyTarget = 0
    keyPresent = false
    doorOpen = false
    levelStartTimeSet = false

    currentLevel = levelNum

    for cy=cyStart,cyStart + 16 do
		for cx=cxStart,cxStart + 16 do
            local curCell = mget(cx, cy)

			if curCell == SPR_POOP then
				AddPoop(cx, cy)

                poopTarget = poopTarget + 1
			elseif curCell == SPR_KEY then
				AddPoop(cx, cy)

                poopTarget = poopTarget + 1
                keyTarget = keyTarget + 1
                currentLevelKeyPosCells = { cx = cx, cy = cy }
			elseif curCell == SPR_DASH_1 then
				AddDash(cx, cy)
			elseif curCell == SPR_SPIKE_H or curCell == SPR_SPIKE_H_FLIP_Y then
				AddSpike(cx, cy, false, curCell == SPR_SPIKE_H_FLIP_Y, true)
			elseif curCell == SPR_SPIKE_V or curCell ==  SPR_SPIKE_V_FLIP_X then
				AddSpike(cx, cy, curCell ==  SPR_SPIKE_V_FLIP_X, false, false)
			elseif curCell == SPR_PLAYER_START_RIGHT then
                currentLevelPlayerPosCells = {
                    cx = cx,
                    cy = cy,
                    dir = DIRECTION_RIGHT
                }
			elseif curCell == SPR_PLAYER_START_LEFT then
                currentLevelPlayerPosCells = {
                    cx = cx,
                    cy = cy,
                    dir = DIRECTION_LEFT
                }
            elseif curCell == SPR_DOOR_CLOSED then
                currentLevelDoorPosCells = {
                    cx = cx,
                    cy = cy
                }
			end

			if shouldClearCell(cx, cy) then
				mset(cx, cy, rnd({SPR_BG_1, SPR_BG_2, SPR_BG_3}))
			end
		end
	end
end

function ResetCurrentLevel()
    reload(0x1000, 0x1000, 0x2000)

    FadeOut()
    Wait(15)

    Player:ResetKeys()
    Player:ResetPoops()
    Player:ResetPoints()

    ClearAllPickups()
    LoadLevel(currentLevel)

    Player:setSpawnPoint(
        currentLevelPlayerPosCells.cx * 8,
        currentLevelPlayerPosCells.cy * 8,
        currentLevelPlayerPosCells.dir
    )
    Player:respawn()

    pal()
end

function NextLevel()
    if currentLevel == MAX_LEVEL then
        return
    end

    SetCurrentLevelBestTime()

    currentLevel = currentLevel + 1
    ResetCurrentLevel()
end

function IsLastLevel()
    return currentLevel == MAX_LEVEL
end

function GetCurrentLevelCellPos()
    return {
        cx = (((currentLevel - 1) * 16) % 128),
        cy = (flr((currentLevel - 1) / 7))
    }
end

function GetCurrentLevelPos()
    return {
        x = (((currentLevel - 1) * 16) % 128) * 8,
        y = (flr((currentLevel - 1) / 7)) * 8
    }
end

function GetCurrentLevelKeyCellPos()
    return currentLevelKeyPosCells
end

function GetCurrentLevelPlayerCellPos()
    return currentLevelPlayerPosCells
end

function GetCurrentLevelDimentionCells()
    return {
        w = 16,
        h = 16
    }
end

function GetNextLevelNum()
    return min(currentLevel + 1, 32)
end

function GetPreviousLevelNum()
    return max(currentLevel - 1, 1)
end

function GetPoopTarget()
    return poopTarget
end

function GetPoopsRemaining()
    return poopTarget - Player:GetPoopsAmount()
end

function GetPoopsCollected()
    return Player:GetPoopsAmount()
end

function GetKeyTarget()
    return keyTarget
end

function CurrentLevelRevealKey()
    keyPresent = true;

    AddKey(
        GetCurrentLevelKeyCellPos().cx,
        GetCurrentLevelKeyCellPos().cy
    )
end

function GetKeysRemaining()
    return poopTarget - Player:GetKeysAmount()
end

function GetKeysCollected()
    return Player:GetKeysAmount()
end

function CurrentLevelOpenDoor()
    doorOpen = true;

    mset(
        currentLevelDoorPosCells.cx,
        currentLevelDoorPosCells.cy,
        SPR_DOOR_OPENED
    )
end

function CurrentLevelKeyPresent()
    return keyPresent
end

function CurrentLevelOpen()
    return doorOpen
end

function SetCurrentLevelStartTime(t)
    if not levelStartTimeSet then
        levelStartTime = t
        levelStartTimeSet = true
    end
end

function IsLevelStartTimeSet()
    return levelStartTimeSet
end

function GetCurrentLevelTimePassed()
    if not levelStartTimeSet then
        return 0
    end

    return time() - levelStartTime
end

function GetCurrentLevelBestTime()
    return dget(currentLevel - 1)
end

function SetCurrentLevelBestTime()
    local currentLevelTimePassed = GetCurrentLevelTimePassed()

    if currentLevelTimePassed < GetCurrentLevelBestTime() or GetCurrentLevelBestTime() == 0 then
        dset(currentLevel - 1, currentLevelTimePassed)
    end
end
