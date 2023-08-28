--[[

BRICK
BREAKER

]]

ballClass = require 'ball'
playerClass = require 'player'
blockClass = require 'block'

function love.load()
    widthScreen = love.graphics.getWidth( ) --LarguraTela
    heightScreen = love.graphics.getHeight( ) --AlturaTela

    blockQtd = 9
    lineQtd = 6

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
    ball = createBall(widthScreen, heightScreen, player)
end

function love.draw()
    createGameBlocks(gameBlocks)
    createGamePlayer(player)
    createGameBall(ball)
end

function love.update(dt)
    runGame()
    runBall()
end

function runGame()
    if love.keyboard.isDown('escape') then
        love.event.quit()
    end
    if love.keyboard.isDown('space') then
        startGame = true
    end

    resetGame()
end

function resetGame()
    if ((ball.y) >= heightScreen) then
        startGame = false
        up = false
        down = false
        left = false
        right = false

        gameBlocks = createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionLineX, positionLineY)

        player.x = (widthScreen/2)-(baseWidth/2)
        ball.x = player.x + (player.width)/2 - widthBall/2
        ball.y = player.y - ball.height
    end
end