require('hitbox')
require('soundmanager')
TheEnd = {}
TheEnd.__index = TheEnd
function TheEnd.new()
    local self = {}
    setmetatable(self, TheEnd)

    self.image = love.graphics.newImage("image/finjeu.jpg")
    self.isOk = false
    return self
end

function TheEnd:update(dt) 
	if self.isOk then 
	else
		s_soundManager:playSound(sounds.final)
		self.Ok = true
	end
end

function TheEnd:event(parEventType)

end

function TheEnd:draw()
    love.graphics.draw(self.image, 0,0)
end
