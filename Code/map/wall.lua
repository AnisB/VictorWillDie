
require("const")
require("hitbox")

Wall = {}
Wall.__index =  Wall

function Wall.new(position, dimension, physics)
    local self = {}
    setmetatable(self, Wall)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
	physics:insertStaticActor(self.hitbox)
    return self
end

function Wall:getPosition()
    return self.position
end

function Wall:update(dt)
end

function Wall:init()
end

function Wall:collideWith( object, collision )

end

function Wall:unCollideWith( object, collision )

end

function Wall:draw()
    -- love.graphics.setColor(0,255,0,255)
    -- love.graphics.rectangle( 'fill', self.position.x, self.position.y, self.width, self.height )
    -- love.graphics.setColor(255,255,255,255)
end
