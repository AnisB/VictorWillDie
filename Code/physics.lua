require('hitbox')

Physics = {}
Physics.__index = Physics

function Physics.new(x,y)
	local self = {}
	setmetatable(self, Physics)
-- 	-- Init
	self.static_actors = {}
	self.animated_actors = {}
	self.static_interactive_actors = {}
	self.doors = {}
	self.error_with_collisions = false
	self.hitbox_player = nil
	return self
end

function Physics:update(dt)
	self:testCollision(dt)
end

function Physics:insertAnimatedActor(actor)
	table.insert(self.animated_actors,actor)
end

function Physics:insertStaticActor(actor)
	table.insert(self.static_actors,actor)
end
function Physics:insertDoorActor(actor)
	table.insert(self.doors,actor)
end

function Physics:insertInteractiveActor(actor)
	table.insert(self.static_interactive_actors,actor)
end

function Physics:removeInteractiveActor(actor)
	 for i,j in pairs(self.static_interactive_actors) do
		if j == actor then
			table.remove(self.static_interactive_actors,i)
		end
	 end
end

function Physics:testCollision(dt)
	-- for i,animated in pairs(self.animated_actors) do
	if (self.hitbox_player) then
		self.error_with_collisions = false
		error_with_collision_fixed = false
		error_with_collision_door = false
		animated = self.hitbox_player
		-- print ("object "..tostring(i).." "..tostring(animated))
		collision_flag = false
		collision_flag_x = false
		collision_flag_y = false
		temp_position = Point.new(animated.position.x,animated.position.y)
		animated.position.x = animated.position.x + animated.speed.x * dt
		animated.position.y = animated.position.y + animated.speed.y * dt
		requested_position = Point.new(animated.position.x,animated.position.y)
		
		-- print("speed:"..tostring(animated.speed.x).." "..tostring(animated.speed.y))
		-- print("position:"..tostring(temp_position.x).." "..tostring(temp_position.y))
		-- print("requested:"..tostring(requested_position.x).." "..tostring(requested_position.y))
		--Collisions for objects that block the character
		for j,fixed in pairs(self.static_actors) do	
			animated.position.x = requested_position.x
			animated.position.y = requested_position.y		
			if fixed.active and animated:collision(fixed) then
				animated.position.x = temp_position.x
				animated.position.y = requested_position.y
				if animated:collision(fixed) then
					collision_flag_y = true
					-- print ("collision y fixed")
				end
				animated.position.x = requested_position.x
				animated.position.y = temp_position.y
				if animated:collision(fixed) then
					collision_flag_x = true
					-- print ("collision x fixed")
				end				
				animated.position.x = temp_position.x
				animated.position.y = temp_position.y
				if animated:collision(fixed) then
					error_with_collision_fixed = true
						-- print ("collision error with fixed object")
					-- print ("collision x fixed")
				end
			end
		end
		animated:resetCollisionFlags()
		for j,door in pairs(self.doors) do	
			animated.position.x = requested_position.x
			animated.position.y = requested_position.y
			if  animated:collision(door) then
				animated:addCollisionFlag(door)
				if door.active then
					animated.position.x = temp_position.x
					animated.position.y = requested_position.y
					if animated:collision(door) then
						collision_flag_y = true
					-- print ("collision y door")
					end
					animated.position.x = requested_position.x
					animated.position.y = temp_position.y
					if animated:collision(door) then
						collision_flag_x = true
					-- print ("collision x door")
					end
					animated.position.x = temp_position.x
					animated.position.y = temp_position.y
					if animated:collision(door) then
						error_with_collision_door = true
						-- print ("collision error door")
					end
				end
			end
		end
		-- if collision_flag then
			-- animated.position.x = temp_position.x
			-- animated.position.y = temp_position.y
		-- end
		animated.position.x = requested_position.x
		animated.position.y = requested_position.y
		if collision_flag_x and collision_flag_y then
			-- print("collision x and y "..tostring(animated.position.x).." "..tostring(animated.position.y))
			animated.position.x = temp_position.x
			animated.position.y = temp_position.y
			-- print("returning to x and y "..tostring(animated.position.x).." "..tostring(animated.position.y))
		else
			if collision_flag_x then
				-- print("collision x "..tostring(animated.position.x).." "..tostring(animated.position.y))
				animated.position.x = temp_position.x
				-- print("returning to x and y "..tostring(animated.position.x).." "..tostring(animated.position.y))
			end
			if collision_flag_y then
				-- print("collision y "..tostring(animated.position.x).." "..tostring(animated.position.y))
				animated.position.y = temp_position.y
				-- print("returning to x and y "..tostring(animated.position.x).." "..tostring(animated.position.y))
			end
		end

		if error_with_collision_door and error_with_collision_fixed then
			self.error_with_collisions = true
		end
		
		--Collisions for objects that the character interacts with
		for j,interactive in pairs(self.static_interactive_actors) do	
			if interactive.active and animated:collision(interactive) then
				animated:addCollisionFlag(interactive)
			end
		end	
		
	end
	
end