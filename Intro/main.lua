function love.load()
	player_x = 0
	player_y = 0
	player_speed = 1000
	player_sprite = love.graphics.newImage("Stick_Buddy.png")
end

function love.draw()
	love.graphics.draw(player_sprite, player_x, player_y)
	--love.graphics.setColor(1.0, 0.0, 0.0)
	--love.graphics.rectangle("fill", player_x, player_y, 100, 100)
	--this is a comment
end

function love.update(delta_time)
	if love.keyboard.isDown("w") then
		player_y = player_y - player_speed * delta_time
	end
	
	if love.keyboard.isDown("s") then
		player_y = player_y + player_speed * delta_time
	end
	
	if love.keyboard.isDown("a") then
		player_x = player_x - player_speed * delta_time
	end
	
	if love.keyboard.isDown("d") then
		player_x = player_x + player_speed * delta_time
	end
end