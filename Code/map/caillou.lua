
require("const")
require("hitbox")

Caillou = {}
Caillou.__index =  Caillou

function Caillou.new(position, dimension, physics)
    local self = {}
    setmetatable(self, Caillou)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
	physics:insertInteractiveActor(self.hitbox)
    
    self.sprite = love.graphics.newImage('image/caillou.png')
    return self
end

function Caillou:getPosition()
    return self.position
end

function Caillou:update(dt)
end




function Caillou:draw()
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
