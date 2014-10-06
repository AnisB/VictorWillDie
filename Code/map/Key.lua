
require("const")
require("hitbox")

Key = {}
Key.__index =  Key

function Key.new(position, dimension, physics, keyId, doorId)
    local self = {}
    setmetatable(self, Key)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.id = keyId
    self.door = doorId
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
	physics:insertInteractiveActor(self.hitbox)
    
    self.sprite = love.graphics.newImage('image/key.png')
    return self
end

function Key:getPosition()
    return self.position
end

function Key:update(dt)
end

function Key:init()
end

function Key:collideWith( object, collision )

end

function Key:unCollideWith( object, collision )

end

function Key:draw()
    if(self.hitbox.active) then
        -- love.graphics.setColor( 255, 0, 0, 255 )
        -- love.graphics.rectangle( 'fill', self.position.x, self.position.y, self.width, self.height )
        -- love.graphics.setColor( 255, 255, 255, 255 )
        sprite = self.sprite
        scaleX = self.width / sprite:getWidth()
        scaleY = self.height / sprite:getHeight()
        love.graphics.draw( self.sprite, self.position.x, self.position.y, 0, scaleX, scaleY )
    end
    -- print(self.sprite)
    -- love.graphics.draw( self.sprite, self.position.x, self.position.y, 0, 1, 1 )
end
