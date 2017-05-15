assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Coordinates = require '../../utils/coordinates.coffee'

Direction = require '../../utils/direction.coffee'

DirectionUtils = require '../../utils/direction-utils.coffee'

class Case
  @V_DIRECTIONS = [Direction.W, Direction.N, Direction.E, Direction.S]

  constructor: (game, grid, caseType, gridCoords, gameCoords, size) ->
    assert caseType?, "Case type missing"
    assert gridCoords?, "Grid Coords missing"
    assert gameCoords?, "Game Coords missing"
    assert size?, "Size missing"

    @game = game
    @grid = grid
    @coords = gridCoords
    @gameCoords = gameCoords
    @spriteSize = size
    @type = caseType

    # Add sprite
    @sprite = @game.add.sprite @gameCoords.x + @spriteSize / 2, @gameCoords.y + @spriteSize / 2, @grid.theme.key, @type.spriteFrame
    @sprite.anchor.setTo 0.5, 0.5
    @sprite.scale.setTo @spriteSize / @sprite.width

    @possibleDirections = []


  getLongestPath: (depth = 1, random = true, parentDirection = null) ->
    path = []
    if depth <= 0
      return path

    if parentDirection?
      parentDirectionFromCurrent = DirectionUtils.getOpposite parentDirection

    for direction in @possibleDirections
      if direction == parentDirectionFromCurrent
        continue

      neighbour = @getNeighbourAt direction
      if neighbour?
        neighbourPath = neighbour.getLongestPath depth - 1, random, direction
        if neighbourPath.length > path.length
          path = neighbourPath
        else if random and Math.random() > 0.5
          path = neighbourPath

    if parentDirection?
      path.push parentDirectionFromCurrent

    return path


  isImpossible: ->
    return @type.obstacle or @possibleDirections.length == 0


  isADeadEnd: ->
    return @possibleDirections.length == 1


  updatePossibleDirections: ->
    if @type.obstacle
      return

    for direction in Case.V_DIRECTIONS
      if @type.walls[direction] == 0
        oppositeCase = @getNeighbourAt direction
        oppositeDirection = DirectionUtils.getOpposite direction
        if oppositeCase?
          if oppositeCase.type.walls[oppositeDirection] == 0
            @possibleDirections.push direction


  getNeighbourAt: (direction) ->
    assert direction?, "direction missing"
    directionCoords = direction.value.clone()
    directionCoords.y *= -1

    neighbourCoords = Coordinates.Add @coords, directionCoords
    return @grid.getCaseAtGridCoords neighbourCoords


module.exports = Case
