
require("const")
require("hitbox")

BooleanDoor = {}
BooleanDoor.__index =  BooleanDoor

function BooleanDoor.new(position, dimension, physics, id, isOpen, colorCode, special)
    local self = {}
    setmetatable(self, BooleanDoor)
    self.position={x=position.x,y=position.y}
    self.width = dimension.w
    self.height = dimension.h
    self.id = id
    self.hitbox = Hitbox.new(self.position.x, self.position.y, self.width, self.height)
    self.special = special
    if(special=="true") then
        physics:insertDoorActor(self.hitbox)
    else
        physics:insertStaticActor(self.hitbox)
    end

    self.horizontal = (self.width>self.height)
    if(special=="true") then
        self.close = love.graphics.newImage('image/specialDoorClose.png')
        self.open = love.graphics.newImage('image/specialDoorOpen.png')
    else

        if self.horizontal then
            self.close = love.graphics.newImage('image/door_horizontal_close.png')
            self.open = love.graphics.newImage('image/door_horizontal_open.png')
        else
            self.close = love.graphics.newImage('image/door_vertical_close.png')
            self.open = love.graphics.newImage('image/door_vertical_open.png')    
        end
    end
    self.sprite = self.close

    if (isOpen== "true") then
        self:disable()
    end
    if(colorCode==nil) then
        colorCode="255#255#255"
    end
    local colors = explode("#",colorCode)
    self.colors = {r= tonumber(colors[1]), g= tonumber(colors[2]), b= tonumber(colors[3])}
    return self
end

function BooleanDoor:getPosition()
    return self.position
end

function BooleanDoor:update(dt)
end

function BooleanDoor:init()
end

function BooleanDoor:draw()
    -- love.graphics.setColor( 255, 0, 0, 255 )
    -- love.graphics.rectangle( 'fill', self.position.x, self.position.y, self.width, self.height )
    -- love.graphics.setColor( 255, 255, 255, 255 )
    


    if (self.special) then
       love.graphics.setColor(self.colors.r,self.colors.g,self.colors.b,255)
        love.graphics.draw( self.sprite, self.position.x + 5, self.position.y-unitWorldSize)
        love.graphics.setColor(255,255,255,255)
    else
    love.graphics.setColor(self.colors.r,self.colors.g,self.colors.b,255)
    love.graphics.draw( self.sprite, self.position.x, self.position.y)
    love.graphics.setColor(255,255,255,255)
    end
end

function BooleanDoor:activate()
	self.sprite = self.close
	self.hitbox.active = true
end

function BooleanDoor:disable()
	self.sprite = self.open
	self.hitbox.active = false
end