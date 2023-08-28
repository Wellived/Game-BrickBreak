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

function love.keypressed(key, scancode, isrepeat)
    if startGame then
        if scancode == "left" then 
            player.x = player.x - spdPlayer 
            verifyField(player)
        end
        if scancode == "right" then 
            player.x = player.x + spdPlayer
            verifyField(player)
        end
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