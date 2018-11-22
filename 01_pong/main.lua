function love.load()
    resetBall()
    ballRad = 5

    paddleWidth = 10
    paddleHeight = 80
    paddleSpeed = 300
    paddle1X = 30
    paddle1Y = 10
    player1Score = 0
    paddle2X = love.graphics.getWidth() - paddle1X - paddleWidth
    paddle2Y = 10
    player2Score = 0
end

function love.update(dt)
    ballX = ballX + ballSpeedX * dt
    ballY = ballY + ballSpeedY * dt
    if ballX < 0 then
        resetBall()
        player2Score = player2Score + 1
    end
    if ballX > love.graphics.getWidth() then
        resetBall()
        player1Score = player1Score + 1
    end
    if ballY < 0 then
        ballY = 0
        ballSpeedY = -ballSpeedY
    end
    if ballY > love.graphics.getHeight() then
        ballY = love.graphics.getHeight()
        ballSpeedY = -ballSpeedY
    end

    if love.keyboard.isDown('w') then
        paddle1Y = paddle1Y - paddleSpeed * dt
    end
    if love.keyboard.isDown('s') then
        paddle1Y = paddle1Y + paddleSpeed * dt
    end
    if love.keyboard.isDown('up') then
        paddle2Y = paddle2Y - paddleSpeed * dt
    end
    if love.keyboard.isDown('down') then
        paddle2Y = paddle2Y + paddleSpeed * dt
    end

    paddle1Y = math.clamp(paddle1Y, 0, love.graphics.getHeight() - paddleHeight)
    paddle2Y = math.clamp(paddle2Y, 0, love.graphics.getHeight() - paddleHeight)

    checkCollisions()
end

function love.draw()
    love.graphics.circle("fill", ballX, ballY, ballRad)
    love.graphics.rectangle('fill', paddle1X, paddle1Y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', paddle2X, paddle2Y, paddleWidth, paddleHeight)
    love.graphics.print('Player 1: ' .. player1Score, 10, 10)
    love.graphics.print('Player 2: ' .. player2Score, love.graphics.getWidth() - 75, 10)
end

function math.clamp(value, min, max)
    return math.max(math.min(value, max), min)
end

function checkCollisions()
    if 
        ballX < paddle1X + paddleWidth and
        ballX + ballRad > paddle1X and
        ballY < paddle1Y + paddleHeight and
        ballY + ballRad > paddle1Y 
    then
        ballX = paddle1X + paddleWidth
        ballSpeedX = -ballSpeedX
    end
    
    if 
        ballX < paddle2X + paddleWidth and
        ballX + ballRad > paddle2X and
        ballY < paddle2Y + paddleHeight and
        ballY + ballRad > paddle2Y 
    then
        ballX = paddle2X - ballRad
        ballSpeedX = -ballSpeedX
    end
end

function resetBall()
    ballX = love.graphics.getWidth() / 2
    ballY = love.graphics.getHeight() / 2
    ballSpeedX, ballSpeedY = love.math.random(100, 200), love.math.random(100, 200)
end