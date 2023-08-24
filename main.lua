function love.load()
    widthScreen = love.graphics.getWidth( ) --LarguraTela
    heightScreen = love.graphics.getHeight( ) --AlturaTela

    i = 1
    blockQtd = 10
    lineQtd = 1
    positionLineX = 0
    positionLineY = 0

    gameBlocks = createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionLineX, positionLineY)
end

function love.draw()
    createGame(gameBlocks)
end

function love.update()

end

function createGame(obj)
    contador = 0

    for chave, valor in pairs(obj) do
        contador = contador + 1
    end

    for i = 1, contador, 1 do
        love.graphics.setColor(obj[i].color[1], obj[i].color[2], obj[i].color[3])
        love.graphics.rectangle("fill", obj[i].x, obj[i].y, obj[i].width, obj[i].height)
    end
end

function createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionX, positionY)
    widthBlocks = (widthScreen/blockQtd)
    heightBlocks = (heightScreen/10)

    lines = createLineBlocks(blockQtd, widthBlocks, heightBlocks, positionX, positionY)

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
        color = {love.math.random(255)/255, love.math.random(255)/255, love.math.random(255)/255}
    }

    return block
end

