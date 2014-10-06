PressurePlate = {}
PressurePlate.__index = PressurePlate

function PressurePlate.new(position, dimension, physics, interID, openID, closeID, colorCode, mapLoader)
    local self = {}
    setmetatable(self, PressurePlate)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.id = interID
    self.openDoors = explode("#",openID)
    self.closeDoors = explode("#",closeID)
    if(colorCode==nil) then
    	colorCode="255#255#255"
    end
    local colors = explode("#",colorCode)
    self.colorCorde = {r= tonumber(colors[1]), g= tonumber(colors[2]), b= tonumber(colors[3])}
    self.duration = duration
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)

    self.sprite = love.graphics.newImage('image/pressure_plate1.png')
    self.caillouSprite = love.graphics.newImage('image/pressure_plate2.png')
    self.state = false
    self.mapLoader = mapLoader
	
	self.caillou = nil
    return self
end

function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') or (str=='')  then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

function PressurePlate:handleTry(tryer)
	if(self.hitbox:collision(tryer.hitbox)) then
		if not self.state then
			if tryer.caillou then
				self.caillou = tryer.caillou
				s_soundManager:playSound(sounds.metal,0.4)
				tryer.caillou = nil
				self.state = true
				self:refresh()
			end
		else 
			if not tryer.caillou then
				tryer.caillou = self.caillou
				s_soundManager:playSound(sounds.pickItem2)
				self.caillou = nil
				self.state = false
				self:refresh()
			end
		end
	end
end

function PressurePlate:refresh()
	if self.state then
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

function PressurePlate:draw(x,y)
	love.graphics.setColor(self.colorCorde.r,self.colorCorde.g,self.colorCorde.b,255)
	-- love.graphics.draw(self.sprite, self.position.x, self.position.y)
	if self.state then
	    love.graphics.draw( self.caillouSprite, self.position.x, self.position.y)
	else
    	love.graphics.draw(self.sprite, self.position.x, self.position.y)		
	end
	love.graphics.setColor(255,255,255,255)

end