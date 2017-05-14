assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

Direction = require '../../utils/direction.coffee'

PlayerSprites = require './player-sprites.coffee'

class Player
  constructor: (game) ->
    assert game?, "Game missing"

    @game = game


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
