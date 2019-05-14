local play = {
    assets = {
        score = love.graphics.newFont(20),
        default = love.graphics.getFont(),
        player_eats = love.audio.newSource("/sound/player_eats.wav", "static"),
        player_death = love.audio.newSource("/sound/player_death.wav", "static")
    },
    snake_segments = {},
    X_grid_count = 40,
    Y_grid_count = 30,
    direction_queue = {},
    difficulty = 2,
    timer = 0,
    sound = true,
    food_counter_score = 0,
    difficulty_limit = 0
}

function play:toggle_sound()
    self.sound = self.sound
    return self.sound
end

function play:toggle_difficulty()
    self.difficulty = self.difficulty + 1
    if self.difficulty > 3 then
        self.difficulty = 1

        self.difficulty_limit = self.difficulty * 0.1
    end

    return self.difficulty
end

function play:entered()

    function move_food()

        local possible_food_positions = {}

        for food_X = 1, self.X_grid_count do
            for food_Y = 1, self.Y_grid_count do
                local possible = true

                for segmentIndex, segment in ipairs(self.snake_segments) do
                    if food_X == segment.x and food_Y == segment.y then
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

    function reset()
        self.snake_segments = {
            {x = 3, y = 1},
            {x = 2, y = 1},
            {x = 1, y = 1},
        }
        self.direction_queue = {'right'}
        snake_alive = true
        self.timer = 0
        self.food_counter_score = 0
        move_food()
    end

    reset()
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

    for segmentIndex, segment in ipairs(self.snake_segments) do
        if snake_alive then
            love.graphics.setColor(.6, 1, .32)
        else
            love.graphics.setColor(.5, .5, .5)
        end
        drawCell(segment.x, segment.y)
    end

    love.graphics.setColor(1, .3, .3)
    drawCell(food_position.x, food_position.y)
end

function play:update(dt)
    self.timer = self.timer + dt

    if snake_alive then
        local timerLimit = 0.1 --self.difficulty_limit
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

            local canMove = true

            for segmentIndex, segment in ipairs(self.snake_segments) do
                if segmentIndex ~= #self.snake_segments and nextXPosition == segment.x and nextYPosition == segment.y then
                    canMove = false
                end
            end

            if canMove then
                table.insert(self.snake_segments, 1, {x = nextXPosition, y = nextYPosition})
                if self.snake_segments[1].x == food_position.x and self.snake_segments[1].y == food_position.y then
                    if self.sound then
                        self.assets.player_eats:play()
                    end

                    self.food_counter_score = self.food_counter_score + 1
                    move_food()
                else
                    table.remove(self.snake_segments)
                end
            else
                snake_alive = false
                if self.sound then
                    self.assets.player_death:play()
                end
            end
        end
    elseif self.timer >= 2 then
        
        
        game.states.scoreboard:add_score(self.food_counter_score)

        game:change_state("scoreboard")
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