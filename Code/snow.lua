   -- hard coded
   system = love.graphics.newParticleSystem( love.graphics.newImage("image/fire.png"), 400 )
   system:setPosition( 607, 0 )
   system:setOffset( 0, 405 )
   system:setBufferSize( 1900 )
   system:setEmissionRate( 400 )
   system:setLifetime( -1 )
   system:setParticleLife( 6.05 )
   system:setColor( 0, 255, 255, 0, 255, 255, 255, 123 )
   system:setSize( 1, 1, 1 )
   system:setSpeed( 150, 300  )
   system:setDirection( math.rad(90) )
   system:setSpread( math.rad(180) )
   system:setGravity( 0, 5 )
   system:setRotation( math.rad(0), math.rad(0) )
   system:setSpin( math.rad(0), math.rad(1), 1 )
   system:setRadialAcceleration( 0 )
   system:setTangentialAcceleration( 0 )

   -- via table
   system = {
      position = { 607, 0 },
      offset = { 0, 405 },
      bufferSize = 1900,
      emissionRate = 400,
      lifetime = -1,
      particleLife = 6.05,
      color = { 0, 255, 255, 0, 255, 255, 255, 123 },
      size = { 1, 1, 1 },
      speed = { 150, 300 },
      direction = math.rad(90),
      spread = math.rad(180),
      gravity = { 0, 5 },
      rotation = { math.rad(0), math.rad(0) },
      spin = { math.rad(0), math.rad(1), 1 },
      radialAcceleration = 0,
      tangentialAcceleration = 0,
   }
   system = love.graphics.newParticleSystem( love.graphics.newImage("image/fire.png"), system.emissionRate )
   system:setPosition( unpack(system.position))
   system:setOffset( unpack(system.position) )
   system:setBufferSize( system.bufferSize )
   system:setEmissionRate( system.emissionRate )
   system:setLifetime( system.lifetime )
   system:setParticleLife( system.particleLife )
   system:setColor( unpack(system.color) )
   system:setSize( unpack(system.size) )
   system:setSpeed( unpack(system.speed) )
   system:setDirection( math.rad(system.direction) )
   system:setSpread( math.rad(system.spread) )
   system:setGravity( unpack(system.gravity))
   system:setRotation( unpack(system.rotation) )
   system:setSpin( unpack(system.spin) )
   system:setRadialAcceleration( system.radialAcceleration )
   system:setTangentialAcceleration( system.tangentialAcceleration )
