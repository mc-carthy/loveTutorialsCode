local paddle = {}

paddle.w = 100
paddle.h = 10
paddle.y = love.graphics.getHeight() - 100
paddle.x = love.graphics.getWidth() / 2 - paddle.w / 2
paddle.speed = 400

function paddle.update(dt, ball)
    local dx = 0
    if love.keyboard.isDown("a") then
        dx = dx - 1
    end
    if love.keyboard.isDown("d") then
        dx = dx + 1
    end
    paddle.x = paddle.x + dx * paddle.speed * dt
    paddle.x = math.clamp(paddle.x, 0, love.graphics.getWidth() - paddle.w)
    paddle.checkBallCollision(paddle, ball)
end

function paddle.draw()
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.w, paddle.h)
end

function paddle.checkBallCollision(paddle, ball)
    collisionCheck(ball, paddle)
end

return paddle