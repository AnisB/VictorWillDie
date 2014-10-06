--[[ 
This file is part of the Field project
]]

-- Includes génériques
require("const")
require("map.wall")
require("map.door")
require("map.key")
require("map.interruptor")
require("map.boolean_door")
require("map.pressureplate")
require("map.caillou")
require("map.corpse")
require("map.endTimer")
require("map.endGame")

MapLoader = {}
MapLoader.__index =  MapLoader

function MapLoader.new(parMap,physics)
    local self = {}
    setmetatable(self, MapLoader)
    self.map = parMap

    self.walls ={}
    self.doors ={}
    self.keys ={}
    self.switch ={}
    self.booleanDoor ={}
    self.pressureplate ={}
    self.caillous = {}
    self.endTimer={}
    self.endGame={}
    for i,d in pairs(self.map.layers) do
        if d.name=="wall" then
            self:createWalls(d,physics)
        elseif d.name=="spawn" then
            self.spawn = d.objects
        elseif d.name=="door" then
            self:createDoors(d,physics)
        elseif d.name=="key" then
            self:createKeys(d,physics)        
        elseif d.name=="switch" then
            self:createSwitch(d,physics)
        elseif d.name=="booleandoor" then
            self:createBooleanDoor(d,physics)
        elseif d.name=="pressureplate" then
            self:createPressurePlate(d,physics)
        elseif d.name=="caillou" then
            self:createCaillous(d,physics)
        elseif d.name=="endtimer" then
            self:createEndTimer(d,physics)
        elseif d.name=="endgame" then
            self:createEndGame(d,physics)
        end
    end

    self.corpse = {}

    return self
end

function MapLoader:addCorpse(pos)
        table.insert(self.corpse, Corpse.new(pos))
end


function MapLoader:createWalls(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.walls, Wall.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics))
    end
end


function MapLoader:createEndTimer(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.endTimer, EndTimer.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height}, j.properties["close"],self))
    end
end

function MapLoader:createEndGame(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.endGame, EndGame.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height}))
    end
end

function MapLoader:createDoors(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.doors, Door.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics, j.properties["id"], j.properties["teleport"], j.properties["color"]))
    end
end

function MapLoader:createKeys(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.keys, Key.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics, j.properties["id"], j.properties["open"]))
    end
end

function MapLoader:createSwitch(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.switch, Interruptor.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics, j.properties["id"], j.properties["open"], j.properties["close"], j.properties["delay"], self))
    end
end

function MapLoader:createBooleanDoor(map,physics)
    for i,j in pairs(map.objects) do
        booleanDoor = BooleanDoor.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics,j.properties["id"], j.properties["open"], j.properties["color"], j.properties["special"])
        table.insert(self.booleanDoor, booleanDoor)
    end
end

function MapLoader:createPressurePlate(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.pressureplate, PressurePlate.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics, j.properties["id"], j.properties["open"], j.properties["close"], j.properties["color"], self))
    end
end

function MapLoader:createCaillous(map,physics)
    for i,j in pairs(map.objects) do
        table.insert(self.caillous, Caillou.new({x=(j.x),y=(j.y)}, {w=j.width, h=j.height},physics))
    end
end

function MapLoader:removeCaillou(caillou)
    for i,p in pairs(self.caillous) do
		if p == caillou then
			table.remove(self.caillous,i)
		end
	end
end

function MapLoader:update(dt)
    for i,p in pairs(self.switch) do
          p:update(dt)
    end  

end

function MapLoader:isSeen(pos1,pos2,w,h)
end

function MapLoader:openGate(parGateID)
    for i, p in pairs(self.booleanDoor) do
        if (p.id == parGateID) then
            p:disable()
        end
    end
end

function MapLoader:closeGate(parGateID)
    for i, p in pairs(self.booleanDoor) do
        if (p.id == parGateID) then
            p:activate()
        end
    end
end

function MapLoader:openDoor(parDoorID)
    for i, p in pairs(self.doors) do
        if (p.id == parDoorID) then
            p:disable()
        end
    end
end

function MapLoader:closeDoor(parDoorID)
    for i, p in pairs(self.doors) do
        if (p.id == parDoorID) then
            p:activate()
        end
    end
end


function MapLoader:handleTry(parPerso)
    for i, p in pairs(self.switch) do
        p:handleTry(parPerso)
    end
    for i, p in pairs(self.pressureplate) do
        p:handleTry(parPerso)
    end
end

function MapLoader:checkGame(parPerso)
    for i, p in pairs(self.endTimer) do
        p:handleTry(parPerso)
    end
    for i, p in pairs(self.endGame) do
        p:handleTry(parPerso)
    end
end

function MapLoader:draw()
    for i,p in pairs(self.walls) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
    for i,p in pairs(self.corpse) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end

    for i,p in pairs(self.keys) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
    for i,p in pairs(self.doors) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end

    for i,p in pairs(self.booleanDoor) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
    for i,p in pairs(self.switch) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
    for i,p in pairs(self.pressureplate) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
    for i,p in pairs(self.caillous) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
    for i,p in pairs(self.endGame) do
        -- if(self:isSeen(pos,p:getPosition(),p.w,p.h)) then
          p:draw()
        -- end
    end
end
function MapLoader:destroy()
    for i,j in pairs(self.tilesets) do
        j:destroy()
    end
end