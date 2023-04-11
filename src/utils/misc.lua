function Wait(t)
    for i = 1,t do flip() end
end

function NumToDoubleDigitStr(t)
    return t < 10 and "0" .. t or t
end

function GetMinutes(t)
    return flr(t / 60)
end

function GetSeconds(t)
    return flr(t % 60)
end

function GetMS(t)
    return flr(Round((t % 60) - flr(t % 60), 2) * 100)
end

function GetFormattedTime(t)
    return NumToDoubleDigitStr(GetMinutes(t)) .. ":" ..
        NumToDoubleDigitStr(GetSeconds(t)) .. ":" ..
        NumToDoubleDigitStr(GetMS(t))
end

function FindIndexFromZero(table, val)
	for i=1,#table do
		if table[i] == val then
			return i-1
		end
	end

	return -1
end

function PrintMiddle(text, color)
    print(text, 64-#text*2, 61, color)
end

function PrintCenter(text, yPos, color)
    print(text, 64 - (#text * 2), yPos, color)
end
