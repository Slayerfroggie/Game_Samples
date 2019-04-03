local menu = {
    assets = {
        title = love.graphics.newFont(30),
        menu = love.graphics.newFont(20),
        default = love.graphics.getFont()
    },
    items = {
        "New Game",
        "Scoreboard",
        "Settings",
        "Quit"
    },
    selected_item = 1
}

function menu:entered()
    -- Reset menu to first item when state entered
    self.selected_item = 1
end 

function menu:draw()
    -- Calculate drawable position
    local window_width, window_height = love.graphics.getDimensions()
    local window_width_center, window_height_center = window_width / 2, window_height / 2

    local menu_width, menu_height = 400, 300
    local menu_width_center, menu_height_center = menu_width / 2, menu_height / 2

    local menu_x, menu_y = window_width_center - menu_width_center, window_height_center - menu_height_center

    -- set window background
    love.graphics.setBackgroundColor(14 / 255, 36 / 255, 48 / 255)

    -- draw menu background rectangle
    love.graphics.setColor(232 / 255, 213 / 255, 183 / 255)
    love.graphics.rectangle("fill", menu_x, menu_y, menu_width, menu_height)
    
    -- Draw title text
    love.graphics.setColor(252 / 255, 59 / 255, 81 / 255)
    love.graphics.setFont(self.assets.title)
    love.graphics.print("Dodge Ball", menu_x + 40, menu_y + 20)
    love.graphics.setFont(self.assets.default)

    -- Draw help text
    love.graphics.print("Movement: [W] [A] [S] [D] Select: [SPACE]", menu_x + 40, menu_y + menu_height - 30)

end

return menu