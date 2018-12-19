local paddle = require('src.paddle')

local ball = {}

ball.r = 5
ball.x = love.graphics.getWidth() / 2
ball.y = paddle.y - 20
ball.speedX = 200
ball.speedY = -200

function ball.checkPaddleCollision(ball, paddle)
    local msv = collisionCheck(ball, paddle)

    if msv ~= nil then
        if msv.x ~= 0 then
            ball.x = ball.x - msv.x
            ball.speedX = -ball.speedX
        end
        if msv.y ~= 0 then
            ball.y = ball.y - msv.y
            ball.speedY = -ball.speedY
        end
    end
end

function ball.checkBricksCollision(ball, bricks)
    for _, b in pairs(bricks) do
        local msv = collisionCheck(ball, b)
        
        if msv ~= nil then
            if msv.x ~= 0 then
                ball.x = ball.x - msv.x
                ball.speedX = -ball.speedX
            end
            if msv.y ~= 0 then
                ball.y = ball.y - msv.y
                ball.speedY = -ball.speedY
            end
            break
        end
    end
end

function ball.update(dt, paddle, bricks)
    ball.x = ball.x + ball.speedX * dt
    ball.y = ball.y + ball.speedY * dt

    if ball.x < 0 then
        ball.x = 0
        ball.speedX = -ball.speedX
    end
    if ball.x > love.graphics.getWidth() then
        ball.x = love.graphics.getWidth()
        ball.speedX = -ball.speedX
    end
    if ball.y < 0 then
        ball.y = 0
        ball.speedY = -ball.speedY
    end
    if ball.y > love.graphics.getHeight() then
        ball.y = love.graphics.getHeight()
        ball.speedY = -ball.speedY
    end

    ball.checkPaddleCollision(ball, paddle)
    ball.checkBricksCollision(ball, bricks)
end

function ball.draw()
    love.graphics.circle('fill', ball.x, ball.y, ball.r)
end

return ball