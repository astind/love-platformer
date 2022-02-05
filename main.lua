io.stdout:setvbuf("no")

function love.load()
  Sti = require 'libraries/sti'
  Object = require 'libraries/classic'
  Anim8 = require 'libraries/anim8'
  Gamemap = Sti('maps/testmap.lua')
  require "classes/player"
  Player = Player()
end


function love.update(dt)
  Player:update(dt)
end


function love.draw()
  Gamemap:draw()
  Player:draw()
end

