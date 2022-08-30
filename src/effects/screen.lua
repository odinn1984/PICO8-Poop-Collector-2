function FadeOut()
	local dpal = {0,1,1,2,1,13,6,4,4,9,3,13,1,13,14}

	for i=0,40 do
		for j=1,15 do
			local col = j

			for k=1,((i+(j%5))/4) do
				col = dpal[col]
			end

			pal(j, col, 1)
		end

		flip()
	end
end
