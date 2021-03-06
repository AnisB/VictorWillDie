AnimPerso = {}
AnimPerso.__index = AnimPerso

AnimPerso.ANIMS = {
	walk = {},
	stop = {},
	die ={},
	dead={}
}


-- name
AnimPerso.ANIMS.walk.name = "walk"
AnimPerso.ANIMS.stop.name = "stop"
AnimPerso.ANIMS.die.name = "die"
AnimPerso.ANIMS.dead.name = "dead"
-- number of sprites :
AnimPerso.ANIMS.walk.number = 8
AnimPerso.ANIMS.die.number = 8
AnimPerso.ANIMS.stop.number = 1
AnimPerso.ANIMS.dead.number = 1

AnimPerso.ANIMS.dead.DELAY= 0.1
AnimPerso.ANIMS.die.DELAY= 0.1
AnimPerso.ANIMS.walk.DELAY= 0.075
AnimPerso.ANIMS.stop.DELAY= 0.1
-- priority 
AnimPerso.ANIMS.walk.priority = 10


-- automatic loopings or automatic switch :
AnimPerso.ANIMS.walk.loop = true

AnimPerso.ANIMS.die.switch = AnimPerso.ANIMS.dead


-- PUBLIC : constructor
function AnimPerso.new(folder)
	local self = {}
	setmetatable(self, AnimPerso)
	self.time = 0.0
	self.sprites = {}
	for key,val in pairs(AnimPerso.ANIMS) do
		self.sprites[key] = {}
		for i=1, val.number do
			local path = 'image/anim/'..folder..'/'..key..'/'..i..'.png'
			self.sprites[key][i] = love.graphics.newImage(path)
		end
	end
	self.currentAnim = AnimPerso.ANIMS.stop
	self.currentPos = 1
	-- begin of an animation
	if self.currentAnim.beginCallback then
		self.currentAnim.beginCallback()
	end
	self:updateImg()
	return self
end

-- PUBLIC : getter for the sprite
function AnimPerso:getSprite()
	return self.currentImg
end


function AnimPerso:syncronize(anim, pos)
	local newAnim = AnimPerso.ANIMS[anim]
		self.currentAnim = newAnim
		self.currentPos = pos
		self:updateImg()
		self.currentAnim.after = newAnim		
end

-- PUBLIC : change animation (you can force it)
function AnimPerso:load(anim, force)
	local newAnim = AnimPerso.ANIMS[anim]
	if force or newAnimPerso.priority > self.currentAnim.priority then
		self.currentAnim = newAnim
		self.currentPos = 1
		-- begin of an animation
		if self.currentAnim.beginCallback then
			self.currentAnim.beginCallback()
		end
		self:updateImg()
	else
		self.currentAnim.after = newAnim
	end
end

-- PUBLIC : update l'anim
function AnimPerso:update(seconds)
	self.time = self.time + seconds
	if self.time > self.currentAnim.DELAY then
		self:next()
		self.time = self.time - self.currentAnim.DELAY
	end
end

-- PRIVATE : go to next sprite
function AnimPerso:next()
	self.currentPos = self.currentPos + 1
	if self.currentPos > self.currentAnim.number then
		-- end of an animation
		if self.currentAnim.endCallback then
			self.currentAnim.endCallback()
		end
		if self.currentAnim.after ~= nil then
			self.currentAnim = self.currentAnim.after
		elseif self.currentAnim.switch ~= nil then
			self.currentAnim = self.currentAnim.switch
		elseif self.currentAnim.loop then
			-- I don't switch
		end
		self.currentPos = 1
		-- begin of an animation
		if self.currentAnim.beginCallback then
			self.currentAnim.beginCallback()
		end
	end
	self:updateImg()
end

-- PRIVATE
function AnimPerso:updateImg()
	self.currentImg = self.sprites[self.currentAnim.name][self.currentPos]
end