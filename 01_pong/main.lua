function love.load()
    ballX = love.graphics.getWidth() / 2
    ballY = love.graphics.getHeight() / 2
    ballRad = 5
    ballSpeedX, ballSpeedY = love.math.random(100, 200), love.math.random(100, 200)
end

function love.update(dt)
    ballX = ballX + ballSpeedX * dt
    ballY = ballY + ballSpeedY * dt
    if ballX < 0 then
        ballX = 0
        ballSpeedX = -ballSpeedX
    end
    if ballX > love.graphics.getWidth() then
        ballX = love.graphics.getWidth()
        ballSpeedX = -ballSpeedX
    end
    if ballY < 0 then
        ballY = 0
        ballSpeedY = -ballSpeedY
    end
    if ballY > love.graphics.getHeight() then
        ballY = love.graphics.getHeight()
        ballSpeedY = -ballSpeedY
    end
end

function love.draw()
    love.graphics.circle("fill", ballX, ballY, ballRad)
    -- love.graphics.print(string.format("%.0f", ballX), 10, 10)
end
