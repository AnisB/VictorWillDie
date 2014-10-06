
LightShader = {}
LightShader.__index = LightShader

  function LightShader.new()
   local self = {}
   setmetatable(self, LightShader)
   self:init()
   self.canvas = love.graphics.newCanvas(windowW, windowH)
   return self
 end


function LightShader:init()
	local xf = love.graphics.newShader[[
   extern vec3 light_pos;
   extern float ao_toggle;

   vec3 dark_color = vec3(0.0, 0.0, 0.0);
   vec3 light_color = vec3(1, 1, 1);

   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {

   // Récupération de la Diffuse
   vec4 diffuse  = Texel(texture, texture_coords);


   //Définition de la direction de la lumière
   vec3 light_direction = light_pos - vec3(pixel_coords, 0);

   // Récupération de la distance par rapport à l'objet (Norme du vecteur)
   float light_distance = length(light_direction);

   // Formule pour l'atténuation
   float attenuation = 85/sqrt(pow(light_distance, 2));

   // Norme du vecteur d'attenuation
   light_direction = normalize(light_direction);

   //Caulcul de la valeur de l'illumination pour un point donné
   float light = clamp(attenuation , 0.0, 1.0);

   // Ombrage
   float cel_light = smoothstep(0.30, 0.52, light)*0.6 + 0.1;

   return vec4(cel_light* diffuse.rgb, 1.0);
}
]]
	
	self.xf = xf
end

  function LightShader:setParameter(p)
     for k,v in pairs(p) do
        self.xf:send(k,v)
    end
  end

function LightShader:update(dt)

end

function LightShader:predraw()
  love.graphics.setCanvas(self.canvas)
   self.canvas:clear()
end

function LightShader:postdraw()
  love.graphics.setCanvas()
end
function LightShader:draw()
   love.graphics.setShader(self.xf)
   love.graphics.draw(self.canvas)
   love.graphics.setShader()
end

