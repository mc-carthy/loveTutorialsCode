paddle = {}
ball = {}
bricks = {}
brick = {}

function love.load()
    paddle.w = 100
    paddle.h = 10
    paddle.y = love.graphics.getHeight() - 100
    paddle.x = love.graphics.getWidth() / 2 - paddle.w / 2
    paddle.speed = 400

    ball.r = 5
    ball.x = love.graphics.getWidth() / 2
    ball.y = paddle.y - 20
    ball.speedX = 200
    ball.speedY = -200

    brick.w = 80
    brick.h = 20
    
    bricks.rows = 4
    bricks.columns = 7
    bricks.paddingX = 10
    bricks.paddingY = 5
    bricks.originX = 80
    bricks.originY = 40
    bricks.levelbricks = {}
    bricks.createbricks()
end

function love.update(dt)
    paddle.update(dt)
    ball.update(dt)
end

function love.draw()
    paddle.draw()
    ball.draw()
    bricks.drawbricks()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function paddle.update(dt)
    local dx = 0
    if love.keyboard.isDown("a") then
        dx = dx - 1
    end
    if love.keyboard.isDown("d") then
        dx = dx + 1
    end
    paddle.x = paddle.x + dx * paddle.speed * dt
    paddle.x = math.clamp(paddle.x, 0, love.graphics.getWidth() - paddle.w)
end

function paddle.draw()
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.w, paddle.h)
end

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
    if collisionCheck(ball, paddle) then
        love.graphics.print('Paddle collision!', 10, 10)
    end

    for _, b in pairs(bricks.levelbricks) do
        if collisionCheck(ball, b) then
            love.graphics.print('Brick collision!', 10, 10)
        end
    end

    love.graphics.circle('fill', ball.x, ball.y, ball.r)
end

function bricks.createbricks()
    for x = 1, bricks.columns do
        for y = 1, bricks.rows do
            local b = bricks.createBrick(bricks.originX + (brick.w + bricks.paddingX) * (x - 1), bricks.originY + (brick.h + bricks.paddingY) * (y - 1))
            table.insert(bricks.levelbricks, b)
        end
    end
end

function bricks.createBrick(x, y, w, h)
    local b = {}
    b.x = x
    b.y = y
    b.w = w or brick.w
    b.h = h or brick.h
    return b
end

function bricks.drawbricks()
    for _, b in pairs(bricks.levelbricks) do
        love.graphics.rectangle("line", b.x, b.y, brick.w, brick.h)
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
        local msv = getMinimumSeparationVector(ballRect, other)
        if msv.x ~= 0 then
            ball.x = ball.x - msv.x
            ball.speedX = -ball.speedX
        end
        if msv.y ~= 0 then
            ball.y = ball.y - msv.y
            ball.speedY = -ball.speedY
        end
    else
        return false
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