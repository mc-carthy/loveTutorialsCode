local bricks = {}

bricks.w = 80
bricks.h = 20
bricks.rows = 4
bricks.columns = 7
bricks.paddingX = 10
bricks.paddingY = 5
bricks.originX = 80
bricks.originY = 40
bricks.levelBricks = {}

function bricks.createBricks()
    for x = 1, bricks.columns do
        for y = 1, bricks.rows do
            local b = bricks.createBrick(bricks.originX + (bricks.w + bricks.paddingX) * (x - 1), bricks.originY + (bricks.h + bricks.paddingY) * (y - 1))
            table.insert(bricks.levelBricks, b)
        end
    end
end

function bricks.checkBallCollision(bricks, ball)
    for i, b in ipairs(bricks.levelBricks) do
        if collisionCheck(ball, b) then
            table.remove(bricks.levelBricks, i)
        end
    end
end

function bricks.createBrick(x, y, w, h)
    local b = {}
    b.x = x
    b.y = y
    b.w = w or bricks.w
    b.h = h or bricks.h
    return b
end

function bricks.update(dt, ball)
    bricks.checkBallCollision(bricks, ball)
end

function bricks.drawBricks()
    for _, b in pairs(bricks.levelBricks) do
        love.graphics.rectangle("line", b.x, b.y, bricks.w, bricks.h)
    end
end

return bricks