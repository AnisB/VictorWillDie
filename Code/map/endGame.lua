



EndGame = {}
EndGame.__index = EndGame

function EndGame.new(position, dimension, mapLoader)
    local self = {}
    setmetatable(self, EndGame)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
    return self
end

function EndGame:handleTry(tryer)
	if(self.hitbox:collision(tryer.hitbox)) then
		s_gameStateManager:changeState('TheEnd')
	end
end

function EndGame:draw()
	-- love.graphics.setColor(0,0,255,255)
	-- love.graphics.rectangle("fill",self.position.x, self.position.y, self.width, self.height)
	-- love.graphics.setColor(255,255,255,255)
end