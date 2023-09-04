--[[

BRICK
BREAKER

]]

ballClass = require 'ball'
playerClass = require 'player'
blockClass = require 'block'

function love.load()
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    sfxmusic = love.audio.newSource("background.mp3", "stream")

    widthScreen = love.graphics.getWidth( ) --LarguraTela
    heightScreen = love.graphics.getHeight( ) --AlturaTela

    blockQtd = 1
    lineQtd = 5

    positionLineX = 0
    positionLineY = 0

    spdPlayer = widthScreen * 0.2
    spdBall = widthScreen * 0.01

    startGame = false
    win = false

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
    createWinGame()
    createStartGame()
end

function love.update(dt)
    runGame()
    runBall()
    winGame()
end

function runGame()
    if love.keyboard.isDown('escape') then
        love.event.quit()
    end
    if love.keyboard.isDown('space') then
        startGame = true
        if not sfxmusic:isPlaying( ) then
            love.audio.play( sfxmusic )
        end
    end
    if love.keyboard.isDown('kpenter') then
        win = false
        reset()
    end

    resetGame()
end

function resetGame()
    if ((ball.y) >= heightScreen) then
       reset()
    end
end

function createWinGame()
    if (win) then
        up = false
        down = false
        left = false
        right = false
        spdBall = 0
        
        player.x = (widthScreen/2)-(baseWidth/2)
        ball.x = player.x + (player.width)/2 - widthBall/2
        ball.y = player.y - ball.height

        love.graphics.setFont(scoreFont)
        love.graphics.print('Win', (widthScreen/2)-((widthScreen*0.1)/2), (heightScreen/2))
        love.graphics.setFont(largeFont)
        love.graphics.print('press enter to reset', (widthScreen/2)-((widthScreen*0.325)/2), (heightScreen/2+50))
    end
end

function createStartGame()
    --love.graphics.setFont(scoreFont)
    --love.graphics.print('Win', (widthScreen/2)-((widthScreen*0.1)/2), (heightScreen/2))
    if(startGame ~= true)then
        love.graphics.setFont(largeFont)
        love.graphics.print('press space to start', (widthScreen/2)-((widthScreen*0.325)/2), (heightScreen/2+50))
    end
end

function winGame()
    contBlocks = 0
    for chave, valor in pairs(gameBlocks) do
        for key, value in pairs(valor) do
            contBlocks = contBlocks +1
        end
    end

    if(contBlocks == 0) then
        win = true

        if sfxmusic:isPlaying( ) then
            love.audio.stop( sfxmusic )
        end
    end
end

function reset()
    if sfxmusic:isPlaying( ) then
        love.audio.stop( sfxmusic )
    end

    startGame = false

    spdBall = widthScreen * 0.01

    up = false
    down = false
    left = false
    right = false

    gameBlocks = createLines(lineQtd, blockQtd, widthScreen, heightScreen, positionLineX, positionLineY)

    player.x = (widthScreen/2)-(baseWidth/2)
    ball.x = player.x + (player.width)/2 - widthBall/2
    ball.y = player.y - ball.height +1
end