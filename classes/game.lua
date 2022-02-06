Game = Object:extend()

function Game:new()
  self.map = Sti('maps/testmap.lua', {"box2d"})
  World = love.physics.newWorld(0,0, true)
  World:setCallbacks(beginContact, endContact)
  self.map:box2d_init(World)
  self.map.layers.floors.visible = false
  Player = Player()
end

function Game:update(dt)
  World:update(dt)
  Player:update(dt)
  -- Cam:look(Player.x, Player.y)
end

function Game:draw()
  -- Cam:start()
  -- self.gamemap:drawLayer(self.gamemap.layers["ground"])
  self.map:draw()
  Player:draw()
  -- Cam:stop()
end

function beginContact(a, b, collision)
  Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
  Player:endContact(a, b, collision)
end