Player = Object.extend(Object)

function Player:new()
  self.spritesheet = love.graphics.newImage("assets/sprites/Tilesheet/colored.png")

  self.grid = Anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight(), nil, nil, 1)
  self.animations = {}
  self.animations.walkRight = Anim8.newAnimation(self.grid('19-21', 8), 0.2)
  self.animations.walkLeft = self.animations.walkRight:clone():flipH()
  self.currentAnimation = self.animations.walkRight;

  --local x_frame = 304
  --local y_frame = 120
  --self.frames = {}
  --table.insert(self.frames, love.graphics.newQuad(x_frame, y_frame, 16, 16, self.image:getWidth(), self.image:getHeight()))
  self.currentFrame = 1
  self.x = 50
  self.y = 50
  self.speed = 2
end

function Player:update(dt)
  Player:inputs(dt)
  self.currentAnimation:update(dt)
end

function Player:draw()
  self.currentAnimation:draw(self.spritesheet, self.x, self.y)
end

function Player:inputs(dt)
  local isMoving = false

  if love.keyboard.isDown("left") or love.keyboard.isDown('a') then
    self.x = self.x - self.speed
    self.currentAnimation = self.animations.walkLeft
    isMoving = true
  end
  if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
    self.x = self.x + self.speed
    self.currentAnimation = self.animations.walkRight
    isMoving = true
  end

  if isMoving == false then
    self.currentAnimation:gotoFrame(1)
  end
  
end


