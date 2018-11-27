function love.load()
    paddle = {}
    paddle.w = 100
    paddle.h = 10
    paddle.y = love.graphics.getHeight() - 100
    paddle.x = love.graphics.getWidth() / 2 - paddle.w / 2
    paddle.speed = 400
end

function love.update(dt)
    local dx = 0
    if love.keyboard.isDown("a") then
        dx = dx - 1
    end
    if love.keyboard.isDown("d") then
        dx = dx + 1
    end
    paddle.x = paddle.x + dx * paddle.speed * dt
end

function love.draw()
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.w, paddle.h)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
