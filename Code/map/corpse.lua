
require("const")

Corpse = {}
Corpse.__index =  Corpse

function Corpse.new(position)
    local self = {}
    setmetatable(self, Corpse)
    self.position={x=position.x,y=position.y}
    self.image = love.graphics.newImage("image/anim/right/die/8.png")
    print("CORPSE POSITION")
    print(self.position.x, self.position.y )
    return self
end

function Corpse:update(dt)
end

function Corpse:init()
end

function Corpse:draw()
    love.graphics.draw( self.image, self.position.x - unitWorldSize/2, self.position.y -unitWorldSize,0, 1.5, 1.5)
end
