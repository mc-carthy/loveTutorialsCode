function love.load()
    currentState = 'mainMenu'
    ballRad = 5
    paddleWidth = 10
    paddleHeight = 80
    resetMainGameState()
    paddleSpeed = 300
    paddle1X = 30
    player1Score = 0
    paddle2X = love.graphics.getWidth() - paddle1X - paddleWidth
    player2Score = 0
    maxScore = 5
    gameOverMessage = ''
end

function love.update(dt)
    if currentState == 'mainGame' then
        updateMainGameState(dt)
    end
end

function love.draw()
    if currentState == 'mainMenu' then
        drawMainMenuState()
    elseif currentState == 'ready' then
        drawReadyState()
    elseif currentState == 'mainGame' then
        drawMainGameState()
    elseif currentState == 'endGame' then
        drawEndGameState()
    end
end

function love.keypressed(key)
    if key == 'space' then
        if currentState == 'mainMenu' then
            currentState = 'ready'
        elseif currentState == 'ready' then
            currentState = 'mainGame'
        elseif currentState == 'endGame' then
            currentState = 'mainMenu'
        end
    end
    if key == 'escape' then
        love.event.quit()
    end
end

function updateMainGameState(dt)
    ballX = ballX + ballSpeedX * dt
    ballY = ballY + ballSpeedY * dt
    if ballX + ballRad < 0 then
        resetMainGameState()
        player2Score = player2Score + 1
        if player2Score >= maxScore then
            currentState = 'endGame'
            gameOverMessage = 'Player 2 wins!\nPress space to return to main menu'
        else
            currentState = 'ready'
        end
    end
    if ballX > love.graphics.getWidth() then
        resetMainGameState()
        player1Score = player1Score + 1
        if player1Score >= maxScore then
            currentState = 'endGame'
            gameOverMessage = 'Player 1 wins!\nPress space to return to main menu'
        else
            currentState = 'ready'
        end
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

function drawMainGameState()
    love.graphics.circle("fill", ballX, ballY, ballRad)
    love.graphics.rectangle('fill', paddle1X, paddle1Y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', paddle2X, paddle2Y, paddleWidth, paddleHeight)
    love.graphics.print('Player 1: ' .. player1Score, 10, 10)
    love.graphics.print('Player 2: ' .. player2Score, love.graphics.getWidth() - 75, 10)
end

function drawMainMenuState()
    love.graphics.print('Main menu\nPress space to begin match', 10, 10)
end
function drawReadyState()
    love.graphics.print('Ready?\nPress space to serve', 10, 10)
end
function drawEndGameState()
    love.graphics.print(gameOverMessage, 10, 10)
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

function resetMainGameState()
    ballX = love.graphics.getWidth() / 2
    ballY = love.graphics.getHeight() / 2
    ballSpeedX, ballSpeedY = love.math.random(100, 200), love.math.random(100, 200)
    if love.math.random() > 0.5 then
        ballSpeedX = ballSpeedX * -1
    end
    paddle1Y = love.graphics.getHeight() / 2 - paddleHeight
    paddle2Y = love.graphics.getHeight() / 2 - paddleHeight
end