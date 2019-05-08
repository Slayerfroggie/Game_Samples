local settings = {
    assets = {
        title = love.graphics.newFont(30),
        help_text = love.graphics.newFont(20),
        menu = love.graphics.newFont(20),
        default = love.graphics.getFont(),
        selection_change = love.audio.newSource("selection_changed.wav", "static"),
        selection_confirmed = love.audio.newSource("selection_confirmed.wav", "static")
    },
    settings = {
        "Sound [on]",
        "Difficulty [normal]",
        "Clear scoreboard",
        "Return to menu"
    },
    selected_item = 1,
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

function settings:keypressed(key)
    if key == "w" or key == "up" then
        if self.sound then
            self.assets.selection_change:play()
        end

      self.selected_item = self.selected_item - 1
  
      if self.selected_item < 1 then
        self.selected_item = #self.settings
      end
    end
  
    if key == "s" or key == "down" then
        if self.sound then
            self.assets.selection_change:play()
        end

      self.selected_item = self.selected_item + 1
  
      if self.selected_item > #self.settings then
        self.selected_item = 1
      end
    end
  
    if key == "return" or key == "space" then
        if self.sound then
            self.assets.selection_confirmed:play()
        end

      if self.selected_item == 1 then
        if game.states.settings:toggle_sound() then
          self.settings[1] = "Sound [On]"
        else 
          self.settings[1] = "Sound [Off]"
        end
      elseif self.selected_item == 2 then
        local difficulty = game.states.play:toggle_difficulty()

        if difficulty == 1 then
          self.settings[2] = "Difficulty [Easy]"
        elseif difficulty == 2 then
          self.settings[2] = "Difficulty [Normal]"
        elseif difficulty == 3 then
          self.settings[2] = "Difficulty [Hard]"
        end
      elseif self.selected_item == 3 then
        game.states.scoreboard:clear_scores()
      elseif self.selected_item == 4 then
        game:change_state("menu")
      end
    end
  end
  
-- sound methods when disabling sound
-- game.states.play:toggle_sound() and game.states.menu:toggle_sound() and 

return settings 