Point = {}
Point.__index = Point

function Point.new(x,y)
	local self = {}
	setmetatable(self, Point)
-- 	-- Init
	self.x = x
	self.y = y 
	return self
end