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

    @createSprites()


  isInitialized: ->
    return @headCase? and @path?


  createSprites: ->
    assert @headCase? and @path?, "Head Case / path missing"

    # Vars init
    pathLength = @path.length
    @sprites = new Array pathLength
    index = 0
    currCase = @headCase

    # Head sprite
    direction = @path[index]
    sprite = @game.add.sprite currCase.sprite.x, currCase.sprite.y, @theme.key, PlayerSprites.head[direction]
    @path[index] = { dir: direction, sprite: sprite }

    # Body and Tail sprites
    for index in [1...pathLength]
      direction = @path[index]
      directionOpposite = DirectionUtils.getOpposite direction

      currCase = currCase.getNeighbourAt directionOpposite

      if index >= pathLength - 1
        sprite = @game.add.sprite currCase.sprite.x, currCase.sprite.y, @theme.key, PlayerSprites.tail[direction]
        @path[index] = { dir: direction, sprite: sprite }
      else
        nextDirection = @path[index + 1]
        nextDirectionOpposite = DirectionUtils.getOpposite nextDirection
        sprite = @game.add.sprite currCase.sprite.x, currCase.sprite.y, @theme.key, PlayerSprites.body[direction][nextDirectionOpposite]
        @path[index] = { dir: direction, sprite: sprite }

    # Update sprites
    scaleFactor = @headCase.sprite.width / @path[0].sprite.width
    for path in @path
      path.sprite.anchor.setTo 0.5, 0.5
      path.sprite.scale.setTo scaleFactor


  moveForward: ->
    step = @headCase.sprite.width

    for path in @path
      


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
