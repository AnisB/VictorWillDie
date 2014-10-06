require('point')
Hitbox = {}
Hitbox.__index = Hitbox

function Hitbox.new(x,y,w,h,id)
	local self = {}
	setmetatable(self, Hitbox)
-- 	-- Init
	self.position = Point.new(x,y)
	self.width = w
	self.height = h
	self.speed = Point.new(0,0)
	self.id = id
	self.collision_flags = {}
	self.active =  true
	return self
end

function Hitbox:collision(other)
	--previous_position_temp = Point.new(position.x,position.y)
	return CheckCollision( self.position.x, self.position.y, self.width, self.height, other.position.x, other.position.y, other.width, other.height )
end

-- Collision detection function.
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Hitbox:resetCollisionFlags()
	self.collision_flags = {}
end

function Hitbox:addCollisionFlag(interactive)
	table.insert(self.collision_flags, interactive)
end