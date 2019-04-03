game = {
    current_state = "menu",
    states = {
        menu = {},
        scoreboard = {},
        editor = {},
        playing = {
            player_x = 0,
            player_y = 0,
            player_speed = 15,
        },
    }
}

function love.load()
	assets = {
    }
end

function game:link_event(event)
    love[event] = function(...)
        if self.states[self.current_state] ~= nil then
            if self.states[self.current_state][event] ~= nil then
                self.states[self.current_state][event](self.states[self.current_state], ...)
            end
        end
    end
end

game:link_event("draw")
game:link_event("update")
game:link_event("keypressed")
game:link_event("load")

function game.states.menu:draw()
    local gridXCount = 50
    local gridYCount = 50
    local cellSize = 10

    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle(
        'fill',
        0,
        0,
        gridXCount * cellSize,
        gridYCount * cellSize
    )

    love.graphics.setColor(0.0, 0.8, 0.4 )
    love.graphics.print("Psycho Python\r\nThis is the menu state. Press space to start the game.", 90, 125
)
end

function game.states.menu:keypressed(key)
    if key == "space" then
        game.current_state = "playing"
    end
end