local play = {
    assests = {
        score = love.graphics.newFont(20),
        default = love.graphics.getFont()
    },
    pellets = {},
    player = {
        x = 0,
        y = 0,
        width = 0,
        height = 0,
        speed = 0
    },
    difficulty = 2,
    sound = true,
    pellet_score = 0
    
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

return play