local function shouldTrim(char)
	return
		char == "\n" or
		char == "\r" or
		char == "\b" or
		char == "\t" or
		char == " "
end

function TrimLeft(text)
	local start = 1
	local trimming = true

	while trimming do
		if not shouldTrim(chr(ord(text, start))) then
			trimming = false
		end

		start = start + 1
	end

	return sub(text, start)
end

function TrimRight(text)
	local strend = #text
	local trimming = true

	while trimming do
		if not shouldTrim(chr(ord(text, strend))) then
			trimming = false
		end

		strend = strend - 1
	end

	return sub(text, 1, strend)
end

function Trim(text)
	return TrimRight(TrimLeft(text))
end
