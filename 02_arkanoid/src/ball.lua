local paddle = require('src.paddle')

local ball = {}

ball.r = 5
ball.x = love.graphics.getWidth() / 2
ball.y = paddle.y - 20
ball.speedX = 200
ball.speedY = -200

function ball.update(dt)
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
end

function ball.draw()
    love.graphics.circle('fill', ball.x, ball.y, ball.r)
end

return ball