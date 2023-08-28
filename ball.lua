function createGameBall(obj)
    love.graphics.setColor(obj.color[1], obj.color[2], obj.color[3])
    love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)
end

function createBall(widthScreen, heightScreen, player, positionX, positionY)
    widthBall = widthScreen/20
    heightBall = widthBall
    positionX = player.x + (player.width)/2 - widthBall/2
    positionY = player.y - heightBall

    bola = ball(positionX, positionY, widthBall, heightBall)

   return bola
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
    if startGame then
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
        end
    end
end


function ball(positionX, positionY, widthBall, heightBall)
    bola = {
        x = positionX,
        y = positionY,
        width = widthBall,
        height = heightBall,
        color = {1, 0, 0}
    }

    return bola
end

function colideBlocks(blocks)
    if startGame then
        if ball.x + ball.width <= blocks.x or
            ball.x >= blocks.x + blocks.width then
                return false
        end
        if ball.y + ball.height <= blocks.y or
            ball.y >= blocks.y + blocks.height then
                return false
        end
        return true
    end
end

function randonDirection()
    return love.math.random(0,1)
end

function runBall()
    colideArea()
    colidePlayer()
    ballMovement()  

    if (startGame) then
        for chave, linha in pairs(gameBlocks) do
            for i = #linha, 1, -1 do
                if (colideBlocks(linha[i])) then
                    if (down) then
                        up = true
                        down = false
                
                        if (randonDirection() == 0) then
                            left = true
                            right = false
                        else
                            right = true
                            left = false
                        end
                    else
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
                    table.remove(linha, i)
                end
            end
        end
    end
end