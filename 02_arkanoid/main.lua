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