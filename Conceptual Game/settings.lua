local settings = {
    assets = {
        title = love.graphics.newFont(30),
        help_text = love.graphics.newFont(20),
        menu = love.graphics.newFont(20),
        default = love.graphics.getFont(),
        selection_change = love.audio.newSource("select.wav", "static")
    },
    selected_item = 1,
    settings = {
        "Sound [on]",
        "Difficulty [normal]",
        "Clear scoreboard",
        "Return to menu"
    },
    sound = true
}

function settings:toggle_sound()
    self.sound = not self.sound
    return self.sound
end

function settings:draw()
    -- Calculate drawable positions
    local window_width, window_height = love.graphics.getDimensions()
    local window_width_center, window_height_center = window_width / 2, window_height / 2

    local settings_width, settings_height = 750, 550
    local settings_width_center, settings_height_center = settings_width / 2, settings_height / 2

    local settings_x, settings_y = window_width_center - settings_width_center, window_height_center - settings_height_center

    -- set window background
    love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)

    -- draw menu background rectangle
    love.graphics.setColor(62 / 255, 190 / 255, 155 / 255)
    love.graphics.rectangle("fill", settings_x, settings_y, settings_width, settings_height)

    -- draw title text
    love.graphics.setColor(227 /255, 219 / 255, 64 / 255)
    love.graphics.setFont(self.assets.title)
    love.graphics.print("Settings", settings_x + 40, settings_y + 20)

    -- Draw help text
    love.graphics.setFont(self.assets.help_text)
    love.graphics.print("Nagivate: [W] [S] Select: [SPACE]", settings_x + 40, settings_y + settings_height - 50)
    
    -- draw menu text
    love.graphics.setFont(self.assets.menu)
    for i, item in ipairs(self.settings) do
        local item_x, item_y = settings_x + 40, settings_y + 50

        if i == self.selected_item then
            love.graphics.setColor(161 / 255, 209 / 255, 98 / 255)
        else
            love.graphics.setColor(25 / 255, 158 / 255, 123 / 255)
        end
        
        love.graphics.print(item, item_x, 30 * i + item_y)
    end
    love.graphics.setFont(self.assets.default)

end

-- sound activator
-- if self.sound then
--    self.assets.selection_change:play()
--end

return settings 