assert = require '../utils/assert.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

class Snake
  @V_MIN_PLAYERS = 1
  @V_MAX_PLAYERS = Infinity

  constructor: (game, grid, players...) ->
    assert game?, "Game missing"
    assert grid?, "Grid missing"
    assert players.length >= Snake.V_MIN_PLAYERS, "Not enough players"
    assert players.length <= Snake.V_MAX_PLAYERS, "Too much players"

    @game = game
    @grid = grid
    @players = players

    playerStartLength = 3

    for player in @players
      player.setRandomlyInGrid playerStartLength


module.exports = Snake
