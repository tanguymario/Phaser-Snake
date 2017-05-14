Phaser = require 'Phaser'

config      = require '../config/config.coffee'

debug       = require '../utils/debug.coffee'
debugThemes = require '../utils/debug-themes.coffee'

Coordinates = require '../utils/coordinates.coffee'
Rectangle = require '../utils/geometry/rectangle.coffee'

Snake = require '../snake/snake.coffee'

Grid = require '../snake/grid/grid.coffee'
GridConfig = require '../snake/grid/grid-config.coffee'
GridTheme = require '../snake/grid/grid-theme.coffee'

PlayerHuman = require '../snake/player/player-human.coffee'
PlayerHumanConfig = require '../snake/player/player-human-config.coffee'
PlayerTheme = require '../snake/player/player-theme.coffee'

class Game extends Phaser.State
  constructor: ->
    debug 'Constructor...', @, 'info', 30, debugThemes.Phaser
    super

    @gridConfig = GridConfig.classic
    @gridTheme = GridTheme.classic

    @playerConfig = PlayerHumanConfig.player1
    @playerTheme = PlayerTheme.classic


  preload: ->
    debug 'Preload...', @, 'info', 30, debugThemes.Phaser

    themes = [@playerTheme, @gridTheme]
    for theme in themes
      @game.load.spritesheet theme.key, theme.src, theme.spriteSize.width, theme.spriteSize.height


  create: ->
    debug 'Create...', @, 'info', 30, debugThemes.Phaser

    # Create a grid
    # By default, view of our grid is the whole game
    rectView = new Rectangle new Coordinates(0, 0), @game.width, @game.height
    grid = new Grid @game, @gridConfig, @gridTheme, rectView

    # Pads for players
    @game.input.gamepad.start()
    pad1 = @game.input.gamepad.pad1
    # pad2 = @game.input.gamepad.pad2
    # pad3 = @game.input.gamepad.pad3
    # pad4 = @game.input.gamepad.pad4

    # Create players
    player1 = new PlayerHuman @game, grid, @playerConfig, pad1

    # Create the snake game logic
    @snake = new Snake @game, grid, player1


  toggleFullscreen: ->
    if @game.scale.isFullScreen
      @game.scale.stopFullScreen()
    else
      @game.scale.startFullScreen()


module.exports = Game
