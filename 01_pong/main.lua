function love.load()
    ballX = love.graphics.getWidth() / 2
    ballY = love.graphics.getHeight() / 2
    ballRad = 5
    ballSpeed = 100
end

function love.update(dt)
    ballX = ballX + ballSpeed * dt
    if ballX < 0 then
        ballX = 0
        ballSpeed = -ballSpeed
    end
    if ballX > love.graphics.getWidth() then
        ballX = love.graphics.getWidth()
        ballSpeed = -ballSpeed
    end
end

function love.draw()
    love.graphics.circle("fill", ballX, ballY, ballRad)
    -- love.graphics.print(string.format("%.0f", ballX), 10, 10)
end
