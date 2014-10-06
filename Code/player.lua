
require('animation')
Player = {}
Player.__index = Player

PARTY_TIME=60
DEATH_DURATION=2

function Player.new(position, physics)
    local self = {}
    setmetatable(self, Player)

    self.initialPos = position
    self.currentPos = position
    self.width = 96
    self.height = 96

    self.playerSpeed = 250



    self.keys = {}
    self.caillou = nil
    self.hitbox = Hitbox.new(self.currentPos.x, self.currentPos.y, self.width * 0.5, self.height * 0.5)
    physics:insertAnimatedActor(self.hitbox)
	physics.hitbox_player = self.hitbox

    self.animDown = AnimPerso.new("down")
    self.animDown:load("stop",true)
    self.animUp = AnimPerso.new("up")
    self.animUp:load("stop",true)
    self.animLeft = AnimPerso.new("left")
    self.animLeft:load("stop",true)
    self.animRight = AnimPerso.new("right")
    self.animRight:load("stop",true)

    self.currentAnim = self.animDown
    self:init()
	self.alive = true
	self.is_dying = false
	self.timer_death = DEATH_DURATION
	self.walking = false
    return self
end

function Player:getCaillou(getCaillou)
    self.caillou = getCaillou
end


function Player:teleport(position, physics, speed)
    self.currentPos = position
    self.hitbox = Hitbox.new(self.currentPos.x, self.currentPos.y, self.width * 0.5, self.height * 0.5)
    self.hitbox.speed = speed
    physics:insertAnimatedActor(self.hitbox)
	physics.hitbox_player = self.hitbox
    if(self.hitbox.speed.x == 0 and self.hitbox.speed.y == 0 ) then
        self.currentAnim:load("stop",true)
    end
end

function Player:moveUp()
    self.hitbox.speed.y= self.hitbox.speed.y-self.playerSpeed
    self.currentAnim = self.animUp
    self.animUp:load("walk",true)
	self.walking = true
end

function Player:moveDown()
    self.hitbox.speed.y=self.playerSpeed
    self.currentAnim = self.animDown
    self.animDown:load("walk",true)
	self.walking = true
end

function Player:moveLeft()
    self.hitbox.speed.x=-self.playerSpeed
    self.currentAnim = self.animLeft
    self.animLeft:load("walk",true)
	self.walking = true
end

function Player:moveRight()
    self.hitbox.speed.x= self.playerSpeed
    self.currentAnim = self.animRight
    self.animRight:load("walk",true)
	self.walking = true
end
function Player:stopUp()
    self.hitbox.speed.y= 0
    if(self.hitbox.speed.y==0 and self.hitbox.speed.x == 0) then
        self.currentAnim:load("stop",true)
		self.walking = false
    elseif self.hitbox.speed.x > 0 then
        self.currentAnim = self.animRight
    elseif self.hitbox.speed.x < 0 then
        self.currentAnim = self.animLeft
    end
end

function Player:stopDown()
    self.hitbox.speed.y= 0
    if(self.hitbox.speed.y==0 and self.hitbox.speed.x == 0) then
        self.currentAnim:load("stop",true)
		self.walking = false
    elseif self.hitbox.speed.x > 0 then
        self.currentAnim = self.animRight
    elseif self.hitbox.speed.x < 0 then
        self.currentAnim = self.animLeft
    end
end

function Player:stopLeft()
    self.hitbox.speed.x=0
    if(self.hitbox.speed.y==0 and self.hitbox.speed.x == 0) then
        self.currentAnim:load("stop",true)
		self.walking = false
    elseif self.hitbox.speed.y < 0 then
        self.currentAnim = self.animUp
    elseif self.hitbox.speed.y > 0 then
        self.currentAnim = self.animDown
    end
end

function Player:stopRight()
    self.hitbox.speed.x= 0
    if(self.hitbox.speed.y==0 and self.hitbox.speed.x == 0) then
        self.currentAnim:load("stop",true)
		self.walking = false
    elseif self.hitbox.speed.y < 0 then
        self.currentAnim = self.animUp
    elseif self.hitbox.speed.y > 0 then
        self.currentAnim = self.animDown
    end
end

function Player:init()
    self.currentPos = self.initialPos
    self.remainingTime = PARTY_TIME
	self.alive = true
	self.is_dying = false 
    self.currentAnim:load("stop", true)
end

function Player:addKey(parKey)
    table.insert(self.keys, parKey)
end 
function Player:update(dt)
    self.currentAnim:update(dt)
	self.remainingTime = self.remainingTime - dt
	if self.remainingTime < 0 and not self.is_dying then
		self:die()
	end
    self.currentPos = self.hitbox.position
	
	if self.walking and not self.is_dying then
		s_soundManager:playRandomStepSound()
	end 
	
	if self.is_dying then
		self.timer_death = self.timer_death - dt
		if self.timer_death < 0 then
			self.alive = false
			self.walking = false
		end
	end
	
end

function Player:die()
	s_soundManager:playSound(sounds.death)
	self.is_dying = true
	self.hitbox.speed.x = 0
	self.hitbox.speed.y = 0
	self.timer_death = DEATH_DURATION
	self.currentAnim:load("die",true)
	self:dropCaillou()
end

function Player:draw(dt)
    -- love.graphics.setColor( 255, 0, 0, 255 )
    -- love.graphics.rectangle( 'fill', self.hitbox.position.x, self.hitbox.position.y, self.hitbox.width, self.hitbox.height )
    -- love.graphics.setColor( 255, 255, 255, 255 )

    sprite = self.currentAnim:getSprite()
    scaleX = self.width / sprite:getWidth()
    scaleY = self.height / sprite:getHeight()
    love.graphics.draw( self.currentAnim:getSprite(), self.currentPos.x - self.width * 0.25, self.currentPos.y - self.height * 0.5, 0, scaleX, scaleY )
	
	if (self.caillou) then
		love.graphics.draw(  self.caillou.sprite, self.currentPos.x, self.currentPos.y - self.caillou.height, 0, self.caillou.width / self.caillou.sprite:getWidth(), self.caillou.height / self.caillou.sprite:getHeight())
	end
	-- love.graphics.rectangle( 'fill', self.currentPos.x, self.currentPos.y, self.width, self.height )

end

function Player:dropCaillou()
	if (self.caillou) then
		self.caillou.position.x = self.currentPos.x
		self.caillou.position.y = self.currentPos.y
		self.caillou.hitbox.position.x= self.currentPos.x
		self.caillou.hitbox.position.y= self.currentPos.y
		self.caillou.hitbox.active = true
		self.caillou=nil
	end
	
end