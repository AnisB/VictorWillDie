



Interruptor = {}
Interruptor.__index = Interruptor

function Interruptor.new(position, dimension, physics, interID, openID, closeID, duration, mapLoader)
    local self = {}
    setmetatable(self, Interruptor)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.id = interID
    self.openDoors = explode("#",openID)
    self.closeDoors = explode("#",closeID)
    self.duration = tonumber(duration)
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)

    self.sprite =        love.graphics.newImage('image/switch_left.png')
	self.sprite_pushed = love.graphics.newImage('image/switch_right.png')
    self.state = false
    self.switching = false
    self.timer = self.duration
    -- print("DURATION")
    -- print(self.timer)
    return self
end

function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

function Interruptor:handleTry(tryer)
	-- print("TRY DUD")
	if(self.hitbox:collision(tryer.hitbox)) then
		-- print("COLLISION")
		if not self.switching then
			s_soundManager:playSound(sounds.manivelle)
			self.switching =  true
		end
	end
end

function Interruptor:update(seconds)
	if self.switching then
		if self.timer>0 then
			self.timer= self.timer -seconds
		else
			self.timer = self.duration
			self.switching = false;
			self.state = not self.state
			s_soundManager:playSound(sounds.pickItem1)
			if self.state then
				-- print("CHANGING")
    			self.mapLoaders = s_gameStateManager.state['Gameplay'].mapLoaderMAP
				for i,v in pairs(self.openDoors) do
					for i, maploader in pairs (self.mapLoaders) do
						maploader:openGate(v)
						maploader:openDoor(v)
					end
				end
				for i,v in pairs(self.closeDoors) do
					for i, maploader in pairs (self.mapLoaders) do
						maploader:closeGate(v)
						maploader:closeDoor(v)
					end
				end
			else
				for i,v in pairs(self.closeDoors) do
					for i, maploader in pairs (self.mapLoaders) do
						maploader:openGate(v)
						maploader:openDoor(v)
					end
				end
				for i,v in pairs(self.openDoors) do
					for i, maploader in pairs (self.mapLoaders) do
						maploader:closeGate(v)
						maploader:closeDoor(v)
					end
				end	
			end
		end

	end
end

function Interruptor:draw()
	if self.state then
    	love.graphics.draw(self.sprite, self.position.x, self.position.y)
	else
    	love.graphics.draw(self.sprite_pushed, self.position.x, self.position.y)
	end
		
end