Player = Object:extend()

function Player:new()

  self.spritesheet = love.graphics.newImage("assets/sprites/Tilesheet/colored_transparent_packed.png")
  self.grid = Anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
  self.animations = {}
  self.animations.walkRight = Anim8.newAnimation(self.grid('19-21', 8), 0.2)
  self.animations.walkLeft = self.animations.walkRight:clone():flipH()
  self.currentAnimation = self.animations.walkRight;

  self.x = 120
  self.y = 200
  self.w = 16
  self.h = 16
  self.speed = 80
  self.vel = {}
  self.vel.x = 0
  self.vel.y = 0
  self.maxSpeed = 200
  self.acceleration = 2000
  self.friction = 3500
  self.gravity = 1200
  self.onGround = false
  self.currentGroundCollision = nil
  self.jumpAmount = -400

  self.physics = {}
  self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic")
  self.physics.body:setFixedRotation(true)
  self.physics.shape = love.physics.newRectangleShape(self.w, self.h)
  self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)
end

function Player:update(dt)
  self:syncPhysics()
  self:inputs(dt)
  self:appGravity(dt)
  self.currentAnimation:update(dt)
end

function Player:draw()
  self.currentAnimation:draw(self.spritesheet, self.x, self.y, nil, nil, nil, self.w/ 2, self.h/ 2)
  --love.graphics.rectangle("fill", self.x - self.w / 2, self.y - self.h / 2, self.w, self.h)
end

function Player:syncPhysics()
  self.x, self.y = self.physics.body:getPosition()
  self.physics.body:setLinearVelocity(self.vel.x, self.vel.y)
end

function Player:inputs(dt)
  local isMoving = false
  --self:jump()
  if love.keyboard.isDown("left") or love.keyboard.isDown('a') then
    if self.vel.x > -self.maxSpeed then
      if self.vel.x - self.acceleration * dt > -self.maxSpeed then
        self.vel.x = self.vel.x - self.acceleration * dt
      else
        self.vel.x = -self.maxSpeed
      end
    end
    self.currentAnimation = self.animations.walkLeft
    isMoving = true
  end
  if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
    if self.vel.x < self.maxSpeed then
      if self.vel.x + self.acceleration * dt < self.maxSpeed then
        self.vel.x = self.vel.x + self.acceleration * dt
      else
        self.vel.x = self.maxSpeed
      end
    end
    self.currentAnimation = self.animations.walkRight
    isMoving = true
  end

  self:jump()

  if isMoving == false then
    self.currentAnimation:gotoFrame(1)
    self:applyFriction(dt)
  end
  
end

function Player:applyFriction(dt)
  if self.vel.x > 0 then
    if self.vel.x - self.friction * dt > 0 then
      self.vel.x = self.vel.x - self.friction * dt
    else
      self.vel.x = 0
    end
  elseif self.vel.x < 0  then
    if self.vel.x + self.friction * dt < 0 then
      self.vel.x = self.vel.x + self.friction * dt
    else
      self.vel.x = 0
    end
  end
  print(self.vel.x)
end

function Player:appGravity(dt)
  if not self.onGround then
    self.vel.y = self.vel.y + self.gravity * dt
  end
end

function Player:jump()
  if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) and self.onGround then
    self.vel.y = self.jumpAmount
    self.onGround = false
  end
end

function Player:land(collision)
  self.currentGroundCollision = collision
  self.vel.y = 0
  self.onGround = true
end

function Player:beginContact(a, b, collision)
  if self.onGround then
    return
  end
  local nx, ny = collision:getNormal()
  if a == self.physics.fixture then
    if ny > 0 then
      self:land(collision)
    end
  elseif b == self.physics.fixture then
    if ny < 0 then
      self:land(collision)
    end    
  end
end

function Player:endContact(a, b, collision)
  if a == self.physics.fixture or b == self.physics.fixture then
    if self.currentGroundCollision == collision then
      self.onGround = false
    end
  end
end
