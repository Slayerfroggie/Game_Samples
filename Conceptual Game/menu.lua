local menu = {
    assets = {
        title = love.graphics.newFont(40),
        menu = love.graphics.newFont(30),
        default = love.graphics.getFont()
    },
    items = {
        "New Game",
        "Scoreboard",
        "Quit"

        -- "Settings"
    },
    selected_item = 1
}

function menu:entered()
    -- Resetting to first item when menu state entered
    self.selected_item = 1
end

function menu:draw()
    -- Calculate drawable position
    local window_width, window_height = love.graphics.getDimensions()
    local window_width_center, window_height_center = window_width / 2, window_height / 2

    local menu_width, menu_height = 500, 500
    local menu_width_center, menu_height_center = menu_width / 2, menu_height / 2

    local menu_x, menu_y = window_width_center - menu_width_center, window_height_center - menu_height_center

    -- set window background
    love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)

    -- draw menu background rectangle
    love.graphics.setColor(62 / 255, 190 / 255, 155 / 255)
    love.graphics.rectangle("fill", menu_x, menu_y, menu_width, menu_height)
    
    -- Draw title text
    love.graphics.setColor(227 /255, 219 / 255, 64 / 255)
    love.graphics.setFont(self.assets.title)
    love.graphics.print("Psycho Python", menu_x + 40, menu_y + 20)
    love.graphics.setFont(self.assets.default)

    -- Draw help text
    love.graphics.print("Movement: [W] [A] [S] [D] Select: [SPACE]", menu_x + 40, menu_y + menu_height - 30)

    love.graphics.setFont(self.assets.menu)
    for i, item in ipairs(self.items) do
        local item_x, item_y = menu_x + 40, menu_y + 50

        if i == self.selected_item then
            love.graphics.setColor(161 / 255, 209 / 255, 98 / 255)
        else
            love.graphics.setColor(25 / 255, 158 / 255, 123 / 255)
        end
        
        love.graphics.print(item, item_x, 30 * i + item_y)
    end
    love.graphics.setFont(self.assets.default)
end

function menu:keypressed(key)
    if key == "w" or key == "up" then
        self.selected_item = self.selected_item - 1

        if self.selected_item < 1 then
            self.selected_item = #self.items
        end
    end

    if key == "s" or key == "down" then
        self.selected_item = self.selected_item + 1

        if self.selected_item > #self.items then
            self.selected_item = 1
        end
    end

    if key == "space" or key == "return" then
        if self.selected_item == 1 then
            game:change_state("play")
        elseif self.selected_item == 2 then
            game:change_state("scoreboard")
        elseif self.selected_item == 3 then
            love.event.quit(0)
        end
    end
end

return menu