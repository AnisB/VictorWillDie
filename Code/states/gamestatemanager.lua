
require('states.gameplay')
require('states.menu')
require('states.theend')

GameStateManager = {}
GameStateManager.__index = GameStateManager

function GameStateManager.new()
	local self = {}
	setmetatable(self, GameStateManager)

    local states = {}
	states['Gameplay'] = Gameplay.new()
	states['Menu'] = Menu.new()
	states['TheEnd'] = TheEnd.new()

-- 	-- Init
	self.state = states
	self.currentState='Menu'
	self.nextState=nil
	self.isTransiton = 0
	self.transitionTime = 3.0
	self.timer = 0.0
	self.canvas = love.graphics.newCanvas(windowW, windowH)
	return self
end

function GetCurrentState()
	return s_gameStateManager.state[s_gameStateManager.currentState]
end


function GameStateManager:event(parEventType)
	--print("HI DUDE")
	self.state[self.currentState]:event(parEventType)
end

function GameStateManager:update(dt)
	-- Mise a jour de l'état
	self.state[self.currentState]:update(dt)

	-- Transition en fondu
	if(self.isTransiton == 1) then
		self.timer = self.timer +dt
		if(self.timer>=1.0) then
			self.isTransiton = 2
			self.timer= 1.0
			self.currentState = self.nextState
			self.canvas:clear()
		end
	elseif  (self.isTransiton == 2) then
		self.timer = self.timer - dt
		if(self.timer<=0.0) then
			self.timer = 0.0
			self.isTransiton = 0
			-- self.currentState = self.nextState
		end
	end
end

function GameStateManager:draw()	
	if(self.isTransiton == 0) then
		self.state[self.currentState]:draw(1.0)
	else
		self.canvas:clear()
		love.graphics.setCanvas(self.canvas)
		self.state[self.currentState]:draw()
		love.graphics.setCanvas()
		love.graphics.setColor(255*(1.0-self.timer),255*(1.0-self.timer),255*(1.0-self.timer),255)
		love.graphics.draw(self.canvas,0,0)
	end
end
function GameStateManager:changeState(newState)
	self.nextState = newState
	self.isTransiton =  1
end

s_gameStateManager = GameStateManager.new()
