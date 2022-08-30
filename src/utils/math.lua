function Approach(val, target, amount)
    return val > target
 	    and max(val - amount, target)
 	    or min(val + amount, target)
end

function Sign(num)
	return num > 0 and 1 or
			num < 0 and -1 or 0
end

function Round(num, decimalPlaces)
    local mult = 10^(decimalPlaces or 0)
    return flr(num * mult + 0.5) / mult
end

function RectsOverlap(rect, otherRect)
	return
		rect[1].x < otherRect[2].x and
		rect[2].x > otherRect[1].x and
		rect[1].y < otherRect[2].y and
		rect[2].y > otherRect[1].y
end
