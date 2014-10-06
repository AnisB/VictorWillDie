require('hitbox')

Menu = {}
Menu.__index = Menu
function Menu.new()
    local self = {}
    setmetatable(self, Menu)
   self.system = love.graphics.newParticleSystem( love.graphics.newImage("image/fire.png"), 400 )
   self.system:setPosition( 607, 0 )
   self.system:setOffset( 0, 405 )
   self.system:setBufferSize( 1900 )
   self.system:setEmissionRate( 400 )
   self.system:setEmitterLifetime( -1 )
   self.system:setParticleLifetime( 6.05 )
   self.system:setColors( 255, 255, 255, 0, 255, 255, 255, 123 )
   self.system:setSizes( 1, 1, 1 )
   self.system:setSpeed( 150, 300  )
   self.system:setDirection( math.rad(90) )
   self.system:setSpread( math.rad(180) )
   -- self.system:setGravity( 0, 5 )
   self.system:setRotation( math.rad(0), math.rad(0) )
   self.system:setSpin( math.rad(0), math.rad(1), 1 )
   self.system:setRadialAcceleration( 0 )
   self.system:setTangentialAcceleration( 0 )
    self.title = love.graphics.newImage("image/title.png")
    self.start = love.graphics.newImage("image/start.png")
    self.timer = 0
    self.value = 5
    self.pressstart = false
    return self
end

function Menu:update(dt) 
    self.system:update(dt)
    if not self.pressstart then
        if self.timer < self.value then
            self.timer = self.timer + dt
        else
            self.pressstart =  true
        end
    end
    
end

function Menu:event(parEventType)
    if parEventType == inputType.ActionPressedA then
        s_gameStateManager:changeState('Gameplay')
        s_soundManager:playMusic(musics.theme)
    end
end

function Menu:draw()
    love.graphics.draw(self.system, 0,0)
    love.graphics.draw(self.title, 300,300)
    if self.pressstart then
        love.graphics.draw(self.start, 450,425)
    end
end
