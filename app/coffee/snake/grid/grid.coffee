assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Matrix = require '../../utils/math/matrix.coffee'

Rectangle = require '../../utils/geometry/rectangle.coffee'

class Grid
  constructor: (game, gridConfig, gridTheme, rectangleView) ->
    assert gridConfig?, "Grid Config missing"
    assert gridTheme?, "Grid Theme missing"
    assert rectangleView instanceof Rectangle, "Rectangle view missing"

    @game = game
    @config = new Matrix gridConfig
    @theme = gridTheme
    @view = rectangleView

    for i in [0...@config.width] by 1
      for j in [0...@config.height] by 1
        # TODO graphics
        a = 1


module.exports = Grid
