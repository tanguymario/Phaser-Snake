assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Matrix = require '../../utils/math/matrix.coffee'

Rectangle = require '../../utils/geometry/rectangle.coffee'

Coordinates = require '../../utils/coordinates.coffee'

class GridLayout
  @GetMaxCaseSize: (config, view) ->
    assert config instanceof Matrix, "Config is not a matrix"
    maxWidth = view.width / config.width
    maxHeight = view.height / config.height
    return Math.min maxWidth, maxHeight


  constructor: (game, grid, view) ->
    assert grid?, "Grid missing"
    assert view instanceof Rectangle, "View missing"

    @game = game
    @grid = grid
    @view = view

    @caseSize = GridLayout.GetMaxCaseSize @grid.config, @view
    @width = @caseSize * @grid.config.width
    @height = @caseSize * @grid.config.height

    topLeft = @view.getTopLeft().clone()
    topLeft.x += (@view.width - @width) / 2
    topLeft.y += (@view.height - @height) / 2

    @view = new Rectangle topLeft, @width, @height
    

  # Return top left corner
  getGameCoordsFromGridCoords: (coords) ->
    assert coords instanceof Coordinates, "Coords missing"
    topLeftCase = @view.getTopLeft().clone()
    topLeftCase.x += @caseSize * coords.x
    topLeftCase.y += @caseSize * coords.y
    return topLeftCase


module.exports = GridLayout
