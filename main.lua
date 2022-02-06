io.stdout:setvbuf("no")

function love.load()
  Sti = require 'libraries/sti'
  Object = require 'libraries/classic'
  Anim8 = require 'libraries/anim8'
  require "classes/player"
  require "classes/game"
  -- require "classes/camera"
  game = Game()
end


function love.update(dt)
  game:update(dt)
end


function love.draw()
  game:draw()
end

