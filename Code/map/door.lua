
require("const")
require("hitbox")

Door = {}
Door.__index =  Door

function Door.new(position, dimension, physics, keyId, teleportId,colorCode)
    local self = {}
    setmetatable(self, Door)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.id = keyId
    self.teleport = teleportId
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
	-- physics:insertInteractiveActor(self.hitbox)
	physics:insertDoorActor(self.hitbox)
    self.horizontal = (self.width>self.height)
    if self.horizontal then
        self.close = love.graphics.newImage('image/door_horizontal_close.png')
        self.open = love.graphics.newImage('image/door_horizontal_open.png')
    else
        self.close = love.graphics.newImage('image/door_vertical_close.png')
        self.open = love.graphics.newImage('image/door_vertical_open.png')    
    end
    self.sprite = self.close
    if(colorCode==nil) then
        colorCode="255#255#255"
    end
    local colors = explode("#",colorCode)
    self.color = {r= tonumber(colors[1]), g= tonumber(colors[2]), b= tonumber(colors[3])}
    return self
end

function Door:getPosition()
    return self.position
end

function Door:update(dt)
end

function Door:init()
end


function Door:activate()
    self.sprite = self.close
    self.hitbox.active = true
end

function Door:disable()
    self.sprite = self.open
    self.hitbox.active = false
end
function Door:draw()
    -- love.graphics.setColor( 0, 0, 255, 255 )
    -- love.graphics.rectangle( 'fill', self.position.x, self.position.y, self.width, self.height )
    -- love.graphics.setColor( 255, 255, 255, 255 )

    -- sprite = self.sprite
    -- scaleX = self.width / sprite:getWidth()
    -- scaleY = self.height / sprite:getHeight()
    -- love.graphics.draw( self.sprite, self.position.x, self.position.y, 0, scaleX, scaleY )

    love.graphics.setColor(self.color.r,self.color.g,self.color.b,255)
    love.graphics.draw( self.sprite, self.position.x, self.position.y)
    love.graphics.setColor(255,255,255,255)

end
