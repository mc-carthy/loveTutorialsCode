local ball = require('src.ball')
local bricks = require('src.bricks')
local paddle = require('src.paddle')

function love.load()
    bricks.createBricks()
end

function love.update(dt)
    paddle.update(dt, ball)
    ball.update(dt, paddle, bricks.levelBricks)
end

function love.draw()
    paddle.draw()
    ball.draw()
    bricks.drawBricks()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function math.clamp(value, min, max)
    return math.max(math.min(value, max), min)
end

function collisionCheck(ball, other)
    local ballRect = {
        x = ball.x - ball.r,
        y = ball.y - ball.r,
        w = ball.r * 2,
        h = ball.r * 2
    }
    if
        ballRect.x < other.x + other.w and
        ballRect.x + ballRect.w > other.x and
        ballRect.y < other.y + other.h and
        ballRect.y + ballRect.h > other.y 
    then
        return getMinimumSeparationVector(ballRect, other)
    else
        return nil
    end
end

function getMinimumSeparationVector(rect1, rect2)
    local x1, x2 = rect1.x - rect2.x - rect2.w, rect1.x + rect1.w - rect2.x
    local y1, y2 = rect1.y - rect2.y - rect2.h, rect1.y + rect1.h - rect2.y

    local dx = (math.abs(x1) < math.abs(x2)) and x1 or x2
    local dy = (math.abs(y1) < math.abs(y2)) and y1 or y2

    if math.abs(dx) < math.abs(dy) then
        return { x = dx, y = 0 }
    else
        return { x = 0, y = dy }
    end
end