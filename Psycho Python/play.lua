local play = {
    assets = {
        score = love.graphics.newFont(20),
        default = love.graphics.getFont()
    },
    snake_segments = {},
    X_grid_count = 40,
    Y_grid_count = 30,
    direction_queue = {},
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

    function move_food()
        local possible_food_positions = {}

        for food_X = 1, self.X_grid_count do
            for food_Y = 1, self.Y_grid_count do
                local possible = true

                for segmentIndex, segment in ipairs(self.snake_segments) do
                    if foodX == segment.x and food_Y == segment.y then
                        possible = false
                    end
                end

                if possible then
                    table.insert(possible_food_positions, {x = food_X, y = food_Y})
                end
            end
        end

        food_position = possible_food_positions[love.math.random(#possible_food_positions)]
    end

    self.timer = 0

    self.direction_queue = {"right"}

    move_food()
end

function play:load()
    

end

function play:draw()

    local cell_size = 20

    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle('fill', 0, 0, self.X_grid_count * cell_size, self.Y_grid_count * cell_size)

    local function drawCell(x, y)
        love.graphics.rectangle('fill', (x - 1) * cell_size, (y - 1) * cell_size, cell_size - 1, cell_size - 1)
    end

    for segmentIndex, segment in ipairs(self.snake_segments) do
        love.graphics.setColor(.6, 1, .32)
        drawCell(segment.x, segment.y)
    end

    -- Temporary
    for directionIndex, direction in ipairs(self.direction_queue) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('directionQueue['..directionIndex..']: '..direction, 15, 15 * directionIndex)
    end

    love.graphics.setColor(1, .3, .3)
    drawCell(food_position.x, food_position.y)
end

function play:update(dt)
    self.timer = self.timer + dt
    local timerLimit = 0.15

    if self.timer >= timerLimit then
        self.timer = self.timer - timerLimit

        if #self.direction_queue > 1 then
            table.remove(self.direction_queue, 1)
        end

        local nextXPosition = self.snake_segments[1].x
        local nextYPosition = self.snake_segments[1].y

        if self.direction_queue[1] == 'right' then
            nextXPosition = nextXPosition + 1
            if nextXPosition > self.X_grid_count then
                nextXPosition = 1
            end
        elseif self.direction_queue[1] == 'left' then
            nextXPosition = nextXPosition - 1
            if nextXPosition < 1 then
                nextXPosition = self.X_grid_count
            end
        elseif self.direction_queue[1] == 'down' then
            nextYPosition = nextYPosition + 1
            if nextYPosition > self.Y_grid_count then
                nextYPosition = 1
            end
        elseif self.direction_queue[1] == 'up' then
            nextYPosition = nextYPosition - 1
            if nextYPosition < 1 then
                nextYPosition = self.Y_grid_count
            end
        end

        table.insert(self.snake_segments, 1, {x = nextXPosition, y = nextYPosition})
        table.remove(self.snake_segments)

        love.graphics.setColor(232 / 255, 213 / 255, 185 / 255)

        table.insert(self.snake_segments, 1, {x = nextXPosition, y = nextYPosition})

        if self.snake_segments[1].x == food_position.x
        and self.snake_segments[1].y == food_position.y then
            move_food()
        else
            table.remove(self.snake_segments)
        end

        local canMove = true

        for segmentIndex, segment in ipairs(self.snake_segments) do
            if segmentIndex ~= #self.snake_segments and nextXPosition == segment.x and nextYPosition == segment.y then
                canMove = false
            end
        end

        if canMove then
            table.insert(self.snake_segments, 1, {x = nextXPosition, y = nextYPosition})
            if self.snake_segments[1].x == food_position.x and self.snake_segments[1].y == food_position.y then
                moveFood()
            else
                table.remove(self.snake_segments)
            end
        else
            play:entered()
        end
    end
end

function play:keypressed(key)
    if key == 'right'
    and self.direction_queue[#self.direction_queue] ~= 'right'
    and self.direction_queue[#self.direction_queue] ~= 'left' then
        table.insert(self.direction_queue, 'right')

    elseif key == 'left'
    and self.direction_queue[#self.direction_queue] ~= 'left'
    and self.direction_queue[#self.direction_queue] ~= 'right' then
        table.insert(self.direction_queue, 'left')

    elseif key == 'up'
    and self.direction_queue[#self.direction_queue] ~= 'up'
    and self.direction_queue[#self.direction_queue] ~= 'down' then
        table.insert(self.direction_queue, 'up')

    elseif key == 'down'
    and self.direction_queue[#self.direction_queue] ~= 'down'
    and self.direction_queue[#self.direction_queue] ~= 'up' then
        table.insert(self.direction_queue, 'down')
    end
end

return play