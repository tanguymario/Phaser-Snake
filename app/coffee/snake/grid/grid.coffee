assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Matrix = require '../../utils/math/matrix.coffee'

GridLayout = require './grid-layout.coffee'

Case = require './case.coffee'

Coordinates = require '../../utils/coordinates.coffee'

random = require '../../utils/math/random.coffee'

class Grid
  constructor: (game, gridConfig, gridTheme, rectangleView) ->
    assert gridConfig?, "Grid Config missing"
    assert gridTheme?, "Grid Theme missing"

    @game = game
    @config = new Matrix gridConfig
    @theme = gridTheme
    @layout = new GridLayout @game, @, rectangleView
    @nbObstacles = 0

    # Cases creation
    for i in [0...@config.width] by 1
      for j in [0...@config.height] by 1
        gridCoords = new Coordinates i, j
        gameCoords = @layout.getGameCoordsFromGridCoords gridCoords
        @config.tab[j][i] = new Case @game, @, @config.getAt(i, j), gridCoords, gameCoords, @layout.caseSize
        if @config.getAt(i, j).type.obstacle
          @nbObstacles += 1

    # Update cases possible directions
    for i in [0...@config.width] by 1
      for j in [0...@config.height] by 1
        @config.getAt(i, j).updatePossibleDirections()


  getRandomCase: ->
    rndX = Math.floor(random.between 0, @config.width)
    rndY = Math.floor(random.between 0, @config.height)
    gridCoords = new Coordinates rndX, rndY
    return @getCaseAtGridCoords gridCoords


  # Return a case in at grid coords
  getCaseAtGridCoords: (coords) ->
    assert coords instanceof Coordinates, "Coords missing"

    if coords.x >= 0 and coords.x < @config.width
      if coords.y >= 0 and coords.y < @config.height
        return @config.getAt coords.x, coords.y

    debug 'getCaseAtGridCoords: coords out of bounds', @, 'warning', 250, debugThemes.Grid, coords
    return null


module.exports = Grid
