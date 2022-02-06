Camera = Object:extend()

function Camera:new(x, y, zoom, rotation)
  self.x = x or love.graphics.getWidth() / 2
  self.y = y or love.graphics.getHeight() / 2
  self.zoom = zoom or 1
  self.rotation = rotation or 0
end

function Camera:look(x, y)
  self.x, self.y = x, y
end

function Camera:position()
  return self.x, self.y
end

function Camera:start(x, y, w, h)
  x, y = x or 0, y or 0
  w, h = w or love.graphics.getWidth(), h or love.graphics.getHeight()
  local camera_x = x + w / 2
  local camera_y = y + h / 2
  love.graphics.push()
  love.graphics.translate(camera_x, camera_y)
  love.graphics.scale(self.zoom)
  love.graphics.translate(-self.x, -self.y)
end

function Camera:stop()
  love.graphics.pop()
end




