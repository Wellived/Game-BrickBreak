function love.load()
    widthScreen = love.graphics.getWidth( ) --LarguraTela
    heightScreen = love.graphics.getHeight( ) --AlturaTela

    blockQtd = 5
    lineQtd = 5

    positionLineX = 0
    positionLineY = 0

    spdPlayer = widthScreen * 0.2
    spdBall = widthScreen * 0.01

    startGame = false

    i = 1

    up = false
    down = false
    left = false
    right = false

    gameBlocks = createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionLineX, positionLineY)
    player = createPlayer(widthScreen, heightScreen)
    ball = createBall(widthScreen, heightScreen)
end

function love.draw()
    createGameBlocks(gameBlocks)
    createGamePlayer(player)
    createGameBall(ball)
end

function love.update(dt)
    ballColide()
    ballMovement()
end

function ballMovement()
    if up then
        ball.y = ball.y - spdBall
    end

    if down then
        ball.y = ball.y + spdBall
    end

    if left then
        ball.x = ball.x - spdBall
    end

    if right then
        ball.x = ball.x + spdBall
    end
end

function ballColide()
    if startGame then
        colidePlayer()
        colideArea()
    end
end

function colideArea()
    if (ball.y + ball.height) >= (heightScreen + ball.height) then
        startGame = false
        spdBall = 0
    end

    if (ball.y) <= 0 then
        up = false
        down = true
        if (randonDirection() == 0) then
            left = true
            right = false
        else
            right = true
            left = false
        end
    end

    if (ball.x + ball.width) >= widthScreen then 
        right = false
        left = true
    end

    if (ball.x) <= 0 then 
        left = false
        right = true
    end

end

function colidePlayer()
    if (ball.y + ball.height) >= (player.y) and ((ball.x + ball.width) >= player.x and (ball.x + ball.width) <= (player.x + player.width)) then
        up = true
        down = false

        if (randonDirection() == 0) then
            left = true
            right = false
        else
            right = true
            left = false
        end
        -- ball.y = ball.y - spdBall
        -- ballDirection = love.math.random(0,1)
    end
end

function randonDirection()
    return love.math.random(0,1)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
    if scancode == "space" then 
        startGame = true
    end

    if scancode == "left" then 
        player.x = player.x - spdPlayer 
        verifyField(player)
    end
    if scancode == "right" then 
        player.x = player.x + spdPlayer
        verifyField(player)
    end
    
end

function verifyField(player)
    if(player.x) <= 0 then
        player.x = 0
    end

    if(player.x + player.width) >= widthScreen then
        player.x = widthScreen - player.width
    end
end

function createGameBall(obj)
    love.graphics.setColor(obj.color[1], obj.color[2], obj.color[3])
    love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)
end

function createGamePlayer(obj)
    love.graphics.setColor(obj.color[1], obj.color[2], obj.color[3])
    love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)
end

function createPlayer(widthScreen, heightScreen)
    baseWidth = widthScreen/5
    baseHeight = heightScreen/20

    positionX = (widthScreen/2)-(baseWidth/2)
    positionY = heightScreen-baseHeight

    base = player(baseWidth, baseHeight, positionX, positionY)

    return base
end

function player(baseWidth, baseHeight, positionX, positionY)
    player = {
        x = positionX,
        y = positionY,
        width = baseWidth,
        height = baseHeight,
        color = {1, 1, 1}
    }

    return player
end

function createGameBlocks(obj)
    contLines = 0
    contBlocks = 0

    for chave, valor in pairs(obj) do
        contLines = contLines + 1
        for key, value in pairs(valor) do
            contBlocks = contBlocks +1
        end
    end
    
    contBlocks = contBlocks/contLines

    for i = 1, contLines, 1 do
        for j = 1, contBlocks, 1 do
            love.graphics.setColor(obj[i][j].color[1], obj[i][j].color[2], obj[i][j].color[3])
            love.graphics.rectangle("fill", obj[i][j].x, obj[i][j].y, obj[i][j].width, obj[i][j].height)
        end
    end
end

function createBall(widthScreen, heightScreen)
    widthBall = widthScreen/20
    heightBall = widthBall
    positionX = player.x + (player.width)/2 - widthBall/2
    positionY = player.y - heightBall

    bola = ball(positionX, positionY, widthBall, heightBall)

    return bola
end

function ball(positionX, positionY, widthBall, heightBall)
    bola = {
        x = positionX,
        y = positionY,
        width = widthBall,
        height = heightBall,
        color = {1, 1, 0}
    }

    return bola
end

function createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionX, positionY)
    widthBlocks = (widthScreen/blockQtd)
    heightBlocks = (heightScreen/10)
    lines = {}

    for i = 1, lineQtd, 1 do
        lines[i] = createLineBlocks(blockQtd, widthBlocks, heightBlocks, positionX, positionY)
        positionY = positionY + heightBlocks
    end

    return lines
end

function createLineBlocks(blockQtd, widthBlock, heightBlock, positionX, positionY)
    lineBlocks = {}

    for i = 1, blockQtd, 1 do
        lineBlocks[i] = createBlock(widthBlock, heightBlock, positionX, positionY)
        positionX = positionX + widthBlock
    end
    
    return lineBlocks
end

function createBlock(widthBlock, heightBlock, positionX, positionY)
    block = {
        x = positionX,
        y = positionY,
        width = widthBlock,
        height = heightBlock,
    }

    cor = true
    while cor do
        color = {love.math.random(255)/255, love.math.random(255)/255, love.math.random(255)/255}
        colored = (color[1] + color[2] + color[3])/3

        if (colored >= 0.1) and (colored <= 0.9) then
            block.color = color
            cor = false
        end
    end

    return block
end