require('hitbox')

TheEnd = {}
TheEnd.__index = TheEnd
function TheEnd.new()
    local self = {}
    setmetatable(self, TheEnd)

    self.image = love.graphics.newImage("image/finjeu.jpg")
    return self
end

function TheEnd:update(dt) 
	
end

function TheEnd:event(parEventType)

end

function TheEnd:draw()
    love.graphics.draw(self.image, 0,0)
end
