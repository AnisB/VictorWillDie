
-- Includes
require("const")
require("conf")

require("states.gamestatemanager")
require("inputmanager")
require("soundmanager")

function love.load()
	love.window.setIcon( love.image.newImageData("image/icon/vwd_icn.png" ))
	s_inputManager:Init()
	s_soundManager:Init()
end

function love.update(dt)
	s_gameStateManager:update(dt)
	s_inputManager:update(dt)
end	

function love.keypressed(key, isrepeat)
	s_inputManager:keypressed(key, isrepeat)
end

function love.keyreleased(key)
	s_inputManager:keyreleased(key)
end

function love.joystickpressed(joystick, button)
	s_inputManager:joystickpressed(button)
end

function love.joystickreleased(joystick, button)
	s_inputManager:joystickreleased(button)
end

function love.draw()
	s_gameStateManager:draw()
end

function love.focus(b)
end