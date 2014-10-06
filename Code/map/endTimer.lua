



EndTimer = {}
EndTimer.__index = EndTimer

function EndTimer.new(position, dimension, closeID, mapLoader)
    local self = {}
    setmetatable(self, EndTimer)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.door = closeID
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
    self.state = true
    return self
end

function EndTimer:handleTry(tryer)
	if self.state then
		if(self.hitbox:collision(tryer.hitbox)) then
			local doors = s_gameStateManager.state['Gameplay'].mapLoader.booleanDoor
			for i, door in pairs (doors) do
				if(self.door == door.id) then
					print("JE LANCE")
					s_gameStateManager.state['Gameplay'].mapLoader:closeGate(self.door)
				end
			end
			self.state = false
		end
	end
end

function EndTimer:update(seconds)

end

function EndTimer:draw()
	-- if self.state then
 --    	love.graphics.draw(self.sprite, self.position.x, self.position.y)
	-- else
 --    	love.graphics.draw(self.sprite_pushed, self.position.x, self.position.y)
	-- end
end