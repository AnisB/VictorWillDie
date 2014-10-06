
require("const")
require("map.maploader")
require('player')
require('physics')
require('lightshader')
require('blurr')
require('map.autoloopingbackground')
Gameplay = {}
Gameplay.__index = Gameplay


function Gameplay.new()
    local self = {}
    setmetatable(self, Gameplay)

    self.first = love.graphics.newImage(imgFolder.."snow.png")
    self.foreground = love.graphics.newImage(imgFolder.."froze.png")
    self.clouds = AutoLoopingBackground.new(imgFolder.."clouds.png", 100)

    -- Creation de la physique
    self.mapPhys = {}
    self.backgroundMap = {}
    self.mapLoaderMAP = {}

    for i = 1,9 do
      local mapname = 'map'..tostring(i)
      self.backgroundMap[mapname] = love.graphics.newImage(imgFolder..mapname..".png")
      self.mapPhys[mapname] = Physics.new()
      local map = require(mapFolder..mapname)
      self.mapLoaderMAP[mapname] = MapLoader.new(map,self.mapPhys[mapname])
    end
    

    -- Indicateur du type de monde
      self.background = self.backgroundMap['map5']
      self.phys = self.mapPhys['map5']
      self.mapLoader = self.mapLoaderMAP['map5']
      self.player = Player.new({x=self.mapLoader.spawn[1].x,y=self.mapLoader.spawn[1].y},self.phys)

    self.light = LightShader.new()

    self.light:setParameter{
    light_pos = {windowW/2,windowH/2,30}
    }

    self.bloom=CreateBloomEffect(windowW,windowH)
   -- hard coded
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


   self.deathCounter = 0
   self.time = 0

   self.font = love.graphics.newFont(20)
   love.graphics.setFont(self.font)
    return self
end

function Gameplay:init()

end

function Gameplay:endOfLevel(next_level)
    local args = explode("#", next_level)
	local caillou = nil
	if (self.player.caillou) then --the character holds a caillou 
		caillou = self.player.caillou
		self.phys:removeInteractiveActor(caillou.hitbox)
		self.mapLoader:removeCaillou(caillou)
		
	end
    if(self.mapPhys[args[1]]~=nil) then
        self.phys = self.mapPhys[args[1]]
        self.mapLoader = self.mapLoaderMAP[args[1]]
        self.background = self.backgroundMap[args[1]]
    else
        self.mapPhys[args[1]] = Physics.new()
        self.phys = self.mapPhys[args[1]]
        local map = require(mapFolder..args[1])
        self.mapLoaderMAP[args[1]] = MapLoader.new(map,self.phys)
        self.mapLoader = self.mapLoaderMAP[args[1]]
    end
	
	if (caillou) then
		table.insert(self.mapLoader.caillous,caillou)
		self.phys:insertInteractiveActor(caillou.hitbox)
	end
    local spawnID = tonumber(args[2])
    local speed = self.player.hitbox.speed
    self.player:teleport({x=self.mapLoader.spawn[spawnID].x,y=self.mapLoader.spawn[spawnID].y},self.phys,{x=speed.x, y= speed.y})
end

function getArgs(string)
    local ret ={}
    for i in string.gmatch(string, "([^#]+)") do
        table.insert(ret, tonumber(i))
    end
    return ret
end

function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') or (str == nil) then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

-- function Gameplay:destroy()
--     self.shouldEnd=false
--     world:setCallbacks(nil, function() collectgarbage() end)
--     world:destroy()
--     world=nil
--     -- world = love.physics.newWorld( 0, 18*unitWorldSize, false )
--     self.mapLoader:destroy()
--     self.paralax:destroy()
--     self.mapLoaderSolo = nil
--     collectgarbage()
-- end  

function Gameplay:event(parEventType)
	if not self.player.is_dying then
		if parEventType == inputType.UpPressed then
			self.player:moveUp()
		elseif parEventType == inputType.DownPressed then
			self.player:moveDown()
		elseif parEventType == inputType.LeftPressed then
			self.player:moveLeft()
		elseif parEventType == inputType.RightPressed then
			self.player:moveRight()
		elseif (parEventType == inputType.ActionPressedA )then
			self.mapLoader:handleTry(self.player)
			print("Button 1 pressed")	
		elseif (parEventType == inputType.ActionPressedB )then
			self.player:die()
			print("Button 2 pressed")
		elseif (parEventType == inputType.UpReleased) then
			self.player:stopUp()
		elseif (parEventType == inputType.DownReleased) then
			self.player:stopDown()
		elseif (parEventType == inputType.LeftReleased) then
			self.player:stopLeft()
		elseif(parEventType == inputType.RightReleased) then
			self.player:stopRight()
		elseif parEventType == inputType.DownReleased then
			print("DownReleased")
		elseif parEventType == inputType.LeftReleased then
			print("LeftReleased")
		elseif parEventType == inputType.RightReleased then
			print("RightReleased")
		elseif parEventType == inputType.ActionReleasedA then
			print("ActionReleased A")		
		elseif parEventType == inputType.ActionReleasedB then
			print("ActionReleased B")
		else
			print("bluh")
		end
	end
end
    
function Gameplay:update(dt)

    self.time = self.time +dt
    self.clouds:update(dt)
    self.system:update(dt)
    -- Physics  
    self.phys:update(dt)
    for i,v in pairs(self.mapLoaderMAP) do
        v:update(dt)
    end
    self.player:update(dt)
    self.light:setParameter{
    light_pos = {self.player.currentPos.x+unitWorldSize/2, windowH-self.player.currentPos.y-unitWorldSize,30}
    }
	if not self.player.alive then
        self.mapLoader:addCorpse({x=self.player.hitbox.position.x, y=self.player.hitbox.position.y})
		self:endOfLevel('map5#1')
		self.player:init()
    self.deathCounter = self.deathCounter +1
		s_soundManager:restartTheme()
	end
	
	-- print("player "..tostring(self.player.hitbox.position.x).."  "..tostring(self.player.hitbox.position.y).."  "..tostring(self.player.hitbox.width).."  "..tostring(self.player.hitbox.heigh))
	-- for j,q in pairs(self.mapLoader.caillous) do
		-- print("caillou "..tostring(q.hitbox.position.x).."  "..tostring(q.hitbox.position.y).."  "..tostring(q.hitbox.width).."  "..tostring(q.hitbox.heigh))
	-- end
	-- print()
	if not self.player.is_dying and self.player.alive then
		for i,p in pairs(self.player.hitbox.collision_flags) do
			for j,q in pairs(self.mapLoader.keys) do
				if p == q.hitbox then
					s_soundManager:playSound(sounds.metal)
					self.player:addKey(q)
					q.hitbox.active = false
				end
			end
			for j,q in pairs(self.mapLoader.caillous) do
				if p == q.hitbox then
					if(self.player.caillou==nil) then
					s_soundManager:playSound(sounds.pickItem2)
				   self.player:getCaillou(q)
				   q.hitbox.active = false
				end
			end
		end
			for j,q in pairs(self.mapLoader.doors) do
				if p == q.hitbox then
          if(not q.hitbox.active) then 
              s_soundManager:playSound(sounds.openDoor)
              self:endOfLevel(q.teleport)
          end
				end
			end
      for j,q in pairs(self.mapLoader.booleanDoor) do
        if p == q.hitbox and q.hitbox.active then
          for k,r in pairs(self.player.keys) do
          -- print r.active
           if r.door == q.id then
             q:disable()
             s_soundManager:playSound(sounds.openDoor)
           end
          end
        end
      end
		end
	end
    self.mapLoader:checkGame(self.player)
	if self.phys.error_with_collisions and not self.player.is_dying then
		self.phys.error_with_collisions = false
		self.phys.hitbox_player = nil
		self.player:die()
	end
    -- if (self.door_opened) then
        -- self.phys = Physics.new()
    -- end
end
function Gameplay:draw()
    self.light:predraw()

    love.graphics.draw(self.background, 0,0)
    self.mapLoader:draw()
    self.player:draw()
    love.graphics.draw(self.system, 0,0)
    self.clouds:draw()
    self.light:postdraw()
    self.bloom:enableCanvas()
    self.light:draw()
    self.bloom:disableCanvas()
    self.bloom:firstPass()

    local ratio = (1.0-self.player.remainingTime/PARTY_TIME)*0.3
    -- print(self.player.remainingTime)
    if(self.player.remainingTime>3) then
         s_inputManager:setVibration(ratio)
    else
         s_inputManager:setVibration(1.0)
    end

   
    love.graphics.setColor(255,255,255,255*ratio)
    love.graphics.draw(self.foreground, 0,0)
    love.graphics.setColor(255,255,255,255)

    love.graphics.setColor(255,0,0,255)
    love.graphics.print("Score "..self.deathCounter,10,10)
    love.graphics.print("Time "..self.time,1100,10)
    love.graphics.setColor(255,255,255,255)


end
    
function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    b:getUserData():collideWith(a:getUserData(), coll)
    a:getUserData():collideWith(b:getUserData(), coll)
end

function endContact(a, b, coll)
    local x,y = coll:getNormal()
    b:getUserData():unCollideWith(a:getUserData(), coll)
    a:getUserData():unCollideWith(b:getUserData(), coll)
end

function preSolve(a, b, coll)
    local o1 = a:getUserData()
    local o2 = b:getUserData()

    if o1.preSolve then
        o1:preSolve(o2, coll)
    end

    if o2.preSolve then
        o2:preSolve(o1, coll)
    end
end

function Gameplay:postSolve(a, b, coll)
    -- we won't do anything with this function
end

function Gameplay:quit()
end

function Gameplay:pauseGame()
end
