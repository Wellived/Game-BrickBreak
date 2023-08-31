function createGameBlocks(obj)
    --print('1')
    --[[contLines = 0
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
]]
for chave, valor in pairs(obj) do
    for key, value in pairs(valor) do
        -- print('block = '.. key)
        -- print('x = '..value.x)
        -- print('y = '..value.y)

        love.graphics.setColor(value.color[1], value.color[2], value.color[3])
        love.graphics.rectangle("fill", value.x, value.y, value.width, value.height)
    end
end

end

function createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionX, positionY)

    widthBlocks = (widthScreen/blockQtd)
    heightBlocks = (heightScreen/10)
    lines = {}

    for i = 1, lineQtd, 1 do
        --print('Linha '.. i)

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

        if (colored >= 0.1) and (colored <= 0.8) then
            block.color = color
            cor = false
        end
    end

    return block
end