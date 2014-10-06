require('const')

SoundManager = {}
SoundManager.__index = SoundManager

sounds = {	death = 'death',
			pickItem1 = 'pickItem1',
			pickItem2 = 'pickItem2',
			metal = 'metal',
			openDoor = 'openDoor',
			closeDoor = 'closeDoor',
			unlockDoor = 'unlockDoor',
			footstep1 = 'footstep1',
			footstep2 = 'footstep2',
			footstep3 = 'footstep3',
			footstep4 = 'footstep4',
			manivelle = 'manivelle',
			cold = 'cold'
}
musics = {	theme = 'theme',
			intro = 'intro',
			final = 'final'
}

function SoundManager.new()
  local self = {}
  setmetatable(self, SoundManager)
  
  self.music_list = {}
  self.music_list[musics.theme] = love.audio.newSource('sound/theme.ogg')
  self.music_list[musics.intro] = love.audio.newSource('sound/intro.ogg')
  self.music_list[musics.final] = love.audio.newSource('sound/final.ogg')
  self.current_music = self.music_list[musics.intro]
  
  self.sound_list = {}
  self.sound_list[sounds.death] = love.audio.newSource('sound/son_mort.ogg',"static")
  self.sound_list[sounds.pickItem1] = love.audio.newSource('sound/pick_item_1.ogg',"static")
  self.sound_list[sounds.pickItem2] = love.audio.newSource('sound/pick_item_2.ogg',"static")
  self.sound_list[sounds.metal] = love.audio.newSource('sound/metal.ogg',"static")
  self.sound_list[sounds.openDoor] = love.audio.newSource('sound/door_open.ogg',"static")
  self.sound_list[sounds.closeDoor] = love.audio.newSource('sound/door_close.ogg',"static")
  self.sound_list[sounds.unlockDoor] = love.audio.newSource('sound/door_unlock.ogg',"static")
  self.sound_list[sounds.footstep1] = love.audio.newSource('sound/footsteps_1.ogg',"static")
  self.sound_list[sounds.footstep2] = love.audio.newSource('sound/footsteps_2.ogg',"static")
  self.sound_list[sounds.footstep3] = love.audio.newSource('sound/footsteps_3.ogg',"static")
  self.sound_list[sounds.footstep4] = love.audio.newSource('sound/footsteps_4.ogg',"static")
  self.sound_list[sounds.manivelle] = love.audio.newSource('sound/manivelle.ogg',"static")
  return self
end

function SoundManager:playSound(sound,volume)
	-- print ("sound")
	-- print (sound)
	-- print (sounds.openDoor)
	if volume then
		volume_sound = volume
	else
		volume_sound = 1
	end
	if not self.sound_list[sound]:isPlaying() then
		self.sound_list[sound]:setVolume(volume_sound)
		love.audio.play(self.sound_list[sound])
	end
end
function SoundManager:playMusic(music)
	love.audio.pause(self.current_music)
	self.current_music = self.music_list[music]
	love.audio.rewind(self.current_music)
	love.audio.play(self.current_music)
end

function SoundManager:Init()
	love.audio.play(self.current_music)
end

function SoundManager:restartTheme()
	self.current_music:rewind()
	self.current_music:play()
end

function SoundManager:update(dt)
	self.time_left = self.time_left - dt
end

function SoundManager:playRandomStepSound()
	
	if not self.sound_list[sounds.footstep1]:isPlaying() and not self.sound_list[sounds.footstep2]:isPlaying() and not self.sound_list[sounds.footstep3]:isPlaying() and not self.sound_list[sounds.footstep4]:isPlaying() then
		random_sound = math.random(0,3)
		if random_sound == 0 then
			sound = sounds.footstep1
		elseif random_sound == 1 then
			sound = sounds.footstep2
		elseif random_sound == 2 then
			sound = sounds.footstep3
		elseif random_sound == 3 then
			sound = sounds.footstep4
		end
		self:playSound(sound,0.2)	
	end
		
end


s_soundManager = SoundManager.new()