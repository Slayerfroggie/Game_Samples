local play = {
    assests = {
        score = love.graphics.newFont(20),
        default = love.graphics.getFont(),
        
    },
    difficulty = 2,
    sound = true
}
function play:toggle_sound()
    self.sound = not self.sound
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