local play = {
    assets = {
        score = love.graphics.newFont(20),
        default = love.graphics.getFont()
    },
    snake_segments = {},
    foodPosition = {},
    X_grid_count = 40,
    Y_grid_count = 30,
    difficulty = 2,
    timer = 0,
    sound = true
}

function play:toggle_sound()
    self.sound = self.sound
    return self.sound
end

function play:toggle_difficulty()
    self.difficulty = self.difficulty + 1
    if self.difficulty > 3 then
        self.difficulty = 1
    end
    return self.difficulty
end

function play:entered()
    self.snake_segments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1},
    }

    self.timer = 0
end

function play:load()
    

end

function play:draw()
    local cell_size = 20

    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle('fill', 0, 0, self.X_grid_count * cell_size, self.Y_grid_count * cell_size)

    for segmentIndex, segment in ipairs(self.snake_segments) do
        love.graphics.setColor(.6, 1, .32)
        love.graphics.rectangle(
            'fill',
            (segment.x - 1) * cell_size,
            (segment.y - 1) * cell_size,
            cell_size - 1,
            cell_size - 1
        )
    end
end

function love.update(dt)
    self.timer = self.timer + dt
    local timerLimit = 0.15

    if self.timer >= timerLimit then
        self.timer = self.timer - timerLimit

        local nextXPosition = self.snake_segments[1].x + 1
        local nextYPosition = self.snake_segments[1].y

        table.insert(self.snake_segments, 1, {x = nextXPosition, y = nextYPosition})
        table.remove(self.snake_segments)

        love.graphics.setColor(232 / 255, 213 / 255, 185 / 255)
        love.graphics.print("Tick" .. self.timer, 50, 50)
    end
end

return play