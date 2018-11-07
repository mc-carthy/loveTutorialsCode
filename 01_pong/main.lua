function love.load()
    ballX = love.graphics.getWidth() / 2
    ballY = love.graphics.getHeight() / 2
    ballRad = 5
end

function love.update(dt)

end

function love.draw()
    love.graphics.circle('fill', ballX, ballY, ballRad)
end