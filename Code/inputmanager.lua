require('const')

InputManager = {}
InputManager.__index = InputManager


function InputManager.new()
  local self = {}
  setmetatable(self, InputManager)
  return self
end


function InputManager:Init()
	self.right = false
	self.up = false
	self.left = false
	self.down = false
	self.action = false

	self.nbConnectedJoysticks = love.joystick.getJoystickCount()
    self.joysticks = love.joystick.getJoysticks()

    -- Initialisation des données utiles
    local joysticksData ={}
	if self.nbConnectedJoysticks >=1 then
		joysticksData.name = self.joysticks[1]:getName( )
		joysticksData.nbAxis = self.joysticks[1]:getAxisCount( )
			
		-- Il y a un joystick utilisable
		-- print("Nombre d'axes ", joysticksData.nbAxis)
		if(joysticksData.nbAxis > 1) then
				joysticksData.up  = false
				joysticksData.down  = false
				joysticksData.left  = false
				joysticksData.right  = false
			end
		end
		self.joysticksData = joysticksData
end

function InputManager:joystickpressed(akey)
	-- print(akey)
    if akey == 11 or akey == 1 then
		if not self.action then
			self.action = true
			s_gameStateManager:event(inputType.ActionPressedA);
		end
	elseif akey == 13  or akey == 3 then
		if not self.action then
			self.action = true
			s_gameStateManager:event(inputType.ActionPressedB);
		end
	end
end
function InputManager:joystickreleased(akey)
    if akey == 11 or akey == 1 then
		if self.action then
			self.action = false
			s_gameStateManager:event(inputType.ActionReleasedA);
		end  
	elseif akey == 13 or akey == 3 then
		if self.action then
			self.action = false
			s_gameStateManager:event(inputType.ActionReleasedB);
		end
	end
end

-- Gestion des touches
function InputManager:keypressed(akey, isrepeat)
	if akey == "z" or akey == "w" or akey == "up" then
		--up
		if not self.up then
			self.up = true
			s_gameStateManager:event(inputType.UpPressed);
			if self.down then
				self.down = false
				s_gameStateManager:event(inputType.DownReleased);
			end
		end
    elseif akey == "s" or akey == "down" then
		if not self.down then
			self.down = true
			s_gameStateManager:event(inputType.DownPressed);
			if self.up then
				self.up = false
				s_gameStateManager:event(inputType.UpReleased);
			end
		end
    elseif akey == "d" or akey == "right" then
		if not self.right then
			self.right = true
			s_gameStateManager:event(inputType.RightPressed);
			if self.left then
				self.left = false
				s_gameStateManager:event(inputType.LeftReleased);
			end
		end
    elseif akey == "a" or akey == "q" or akey == "left" then
		if not self.left then
			self.left = true
			s_gameStateManager:event(inputType.LeftPressed);
			if self.right then
				self.right = false
				s_gameStateManager:event(inputType.RightReleased);
			end
		end
    elseif akey == " " or akey == "e" then
		if not self.action then
			self.action = true
			s_gameStateManager:event(inputType.ActionPressedA);
		end
	elseif akey == "m" then
		if not self.action then
			self.action = true
			s_gameStateManager:event(inputType.ActionPressedB);
		end
    else
    	-- print("blah")
    end
end

function InputManager:update(dt)

	if self.nbConnectedJoysticks >=1 then
		local xAxis = self.joysticks[1]:getAxis(1)
		local yAxis = self.joysticks[1]:getAxis(2)
		if(xAxis > 0.5) then
			if (self.joysticksData.right~=true) then
				self.joysticksData.left  = false
				self.joysticksData.right = true
				-- if(self.debugPrint) then
				-- 	print("Droite du joystick ", i)
				-- end
				s_gameStateManager:event(inputType.RightPressed);

			end
		elseif (xAxis < -0.5) then
			if (self.joysticksData.left~=true) then
				self.joysticksData.left  = true
				self.joysticksData.right  = false
				-- if(self.debugPrint) then
				-- 	print("Gauche du joystick ", i)
				-- end
				s_gameStateManager:event(inputType.LeftPressed);
			end
		elseif (self.joysticksData.right~=false or self.joysticksData.left~=false) then

			if(self.joysticksData.right~=false) then
				s_gameStateManager:event(inputType.RightReleased);
				self.joysticksData.right  = false
			else	
				s_gameStateManager:event(inputType.LeftReleased);
				self.joysticksData.left  = false
			end
			-- if(self.debugPrint) then
			-- 	print("Centré du joystick ", i)
			-- end

		end

		if(yAxis < -0.5) then
			if (self.joysticksData.up~=true) then
				self.joysticksData.down  = false
				self.joysticksData.up = true
				-- if(self.debugPrint) then
				-- 	print("Haut du joystick ", i)
				-- end
				s_gameStateManager:event(inputType.UpPressed);
				-- s_gameManager:inputPressed('joyUj'..tostring(self.joysticks[1]:getID()))
			end
		elseif (yAxis > 0.5) then
			if (self.joysticksData.down~=true) then
				self.joysticksData.down  = true
				self.joysticksData.up  = false
				-- if(self.debugPrint) then
				-- 	print("Bas du joystick ", i)
				-- end
				s_gameStateManager:event(inputType.DownPressed);

				-- s_gameManager:inputPressed('joyDj'..tostring(self.joysticks[1]:getID()))
			end
		elseif (self.joysticksData.up~=false or self.joysticksData.down~=false) then
			if(self.joysticksData.down~=false) then
				s_gameStateManager:event(inputType.DownReleased);
				-- s_gameManager:inputReleased('joyDj'..tostring(self.joysticks[1]:getID()))

				self.joysticksData.down  = false
			else	
				s_gameStateManager:event(inputType.UpReleased);
				-- s_gameManager:inputReleased('joyUj'..tostring(self.joysticks[1]:getID()))
				self.joysticksData.up  = false
			end
			-- if(self.debugPrint) then
			-- 	print("Centré du joystick ", i)
			-- end
		end		
	end
end

function InputManager:setVibration(intensity)
	if self.nbConnectedJoysticks >=1 then
			self.joysticks[1]:setVibration(intensity,intensity)
	end
end

function InputManager:keyreleased(akey)
	if akey == "z" or akey == "w" or akey == "up" then
		--up
		if self.up then
			self.up = false
			s_gameStateManager:event(inputType.UpReleased);
		end
    elseif akey == "s" or akey == "down" then
		if self.down then
			self.down = false
			s_gameStateManager:event(inputType.DownReleased);
		end
    elseif akey == "d" or akey == "right" then
		if self.right then
			self.right = false
			s_gameStateManager:event(inputType.RightReleased);
		end
    elseif akey == "a" or akey == "q" or akey == "left" then
		if self.left then
			self.left = false
			s_gameStateManager:event(inputType.LeftReleased);
		end
    elseif akey == " " or akey == "e" then
		if self.action then
			self.action = false
			s_gameStateManager:event(inputType.ActionReleasedA);
		end  
	elseif akey == "m" then
		if self.action then
			self.action = false
			s_gameStateManager:event(inputType.ActionReleasedB);
		end
    else
    	-- print("blah")
    end
end

s_inputManager = InputManager.new()