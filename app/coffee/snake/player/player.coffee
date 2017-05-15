assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Direction = require '../../utils/direction.coffee'
DirectionUtils = require '../../utils/direction-utils.coffee'

PlayerSprites = require './player-sprites.coffee'

class Player
  @V_DIRECTIONS = [Direction.W, Direction.N, Direction.E, Direction.S]
  @V_MIN_LENGTH = 2

  constructor: (game, grid, playerTheme) ->
    assert game?, "Game missing"
    assert grid?, "Grid missing"

    @game = game
    @grid = grid
    @theme = playerTheme


  setRandomlyInGrid: (length) ->
    assert length >= Player.V_MIN_LENGTH, "Length not big enough"
    @length = length
    nbCases = @grid.config.width * @grid.config.height
    if @length + @grid.nbObstacles >= nbCases
      throw "Too much obstacles in the grid for the player"

    caseImpossibleForPlayer = true
    cmpt = 0
    while cmpt < nbCases and caseImpossibleForPlayer
      rndCase = @grid.getRandomCase()
      path = rndCase.getLongestPath @length
      caseImpossibleForPlayer = path.length + 1 < @length or rndCase.isADeadEnd()
      cmpt += 1

    if caseImpossibleForPlayer
      throw "No place in the grid for this player"

    headDirection = path[path.length - 1]

    # TODO
    if rndCase.type.walls[headDirection] == 1
      a = 1

    path.push headDirection
    path.reverse() # Head is the first cell in tab

    @headCase = rndCase
    @path = path

    console.log @headCase
    console.log @path

    @createSprites()


  isInitialized: ->
    return @headCase? and @path?


  createSprites: ->
    assert @headCase? and @path?, "Head Case / path missing"

    @sprites = new Array @path.length

    currentCase = @headCase

    # Head
    index = 0
    direction = @path[index]
    @sprites[index] = @game.add.sprite currentCase.sprite.x, currentCase.sprite.y, @theme.key, PlayerSprites.head[direction]

    bodyLength = @path.length - 1
    for index in [1...bodyLength] by 1
      direction = @path[index]
      nextDirection = @path[index + 1]
      currentCase = currentCase.getNeighbourAt nextDirection
      
      spriteFrame = PlayerSprites.body[direction][nextDirection]
      console.log currentCase
      @sprites[index] = @game.add.sprite currentCase.sprite.x, currentCase.sprite.y, @theme.key, spriteFrame

    oppositeDirection = DirectionUtils.getOpposite direction
    currentCase = currentCase.getNeighbourAt oppositeDirection
    direction = @path[bodyLength]
    @sprites[bodyLength] = @game.add.sprite currentCase.sprite.x, currentCase.sprite.y, @theme.key, PlayerSprites.tail[direction]

    for sprite in @sprites
      if not sprite?
        continue

      sprite.anchor.setTo 0.5, 0.5

      # scaleFactor = (currentCase.width / sprite.width) + (currentCase.height / sprite.height) / 2
      # sprite.scale.setTo scaleFactor


  draw: ->


  moveLeft: ->
    @move Direction.W


  moveRight: ->
    @move Direction.E


  moveUp: ->
    @move Direction.N


  moveDown: ->
    @move Direction.S


  ###
  Functions below will be defined by the grid associated to the player
  ###
  move: (direction) ->
    undefined


  startAccelerate: ->
    undefined


  endAccelerate: ->
    undefined


module.exports = Player
