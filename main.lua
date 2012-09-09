-- This is a demonstration of the title screen effect in the
-- television series jPod. It uses the Love game engine.

tile_size = 100
columns = 12
rows = 6

colors = {
	{ 0x00, 0xA0, 0xB0 },
	{ 0x6A, 0x4A, 0x3C },
	{ 0xCC, 0x33, 0x3F },
	{ 0xEB, 0x68, 0x41 },
	{ 0xED, 0xC9, 0x51 }  
}

chars = {} -- All the interesting characters to display
for i = 48,57 do table.insert(chars, string.format("%c",i)) end
for i = 65,90 do table.insert(chars, string.format("%c",i)) end
for i = 97,122 do table.insert(chars, string.format("%c",i)) end

tiles = {} -- stored two-dimensionally by row and then column

function love.load()
	love.graphics.setMode(1200, 600)
	love.graphics.setFont(love.graphics.newFont("Inconsolata.otf",80))
end

function love.draw()
	for x, row in pairs(tiles) do
		for y, tile in pairs(row) do
			love.graphics.setColor(tile.color)
			love.graphics.rectangle('fill', tile.x, tile.y, tile_size, tile_size)
			love.graphics.setColor(tile.character_color)
			love.graphics.printf(tile.character, tile.x + tile_size/2, tile.y, 0, 'center')
		end
	end
end

function love.update(dt)
	for row = 1,rows do
		if tiles[row] == nil then tiles[row] = {} end

		for column = 1,columns do
			-- Expire the tile if necessary
			if tiles[row][column] ~= nil and tiles[row][column].expires < love.timer.getMicroTime() then
				tiles[row][column] = nil
			end 

			-- Calculate a new tile
			if tiles[row][column] == nil then
				local tile = {
					x               = (column-1)*tile_size,
					y               = (row-1)*tile_size,
					color           = colors[math.random(1,#colors)],
					character       = chars[math.random(1, #chars)],
					character_color = colors[math.random(1, #colors)],
					expires         = love.timer.getMicroTime() + math.random(1.0,12.0)
				}
				tiles[row][column] = tile
			end
		end
	end
end
