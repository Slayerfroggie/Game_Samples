game = {
    current_state = "menu",
    states = {
        menu = require("menu"),
        play = require("play"),
        scoreboard = require("scoreboard"),
        settings = require("settings")
    }
}

function game:link_event(event)
    love[event] = function(...)
        if self.states[self.current_state] ~= nil then
            if self.states[self.current_state][event] ~= nil then
                self.states[self.current_state][event](self.states[self.current_state], ...)
            end
        end
    end
end
