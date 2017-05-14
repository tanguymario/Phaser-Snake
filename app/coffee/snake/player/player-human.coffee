Player = require './player.coffee'
PlayerHumanConfig = require './player-human-config.coffee'

assert = require '../../utils/assert.coffee'

debug       = require '../../utils/debug.coffee'
debugThemes = require '../../utils/debug-themes.coffee'

class PlayerHuman extends Player

  @I_GAMEPAD_LEFT = Phaser.Gamepad.XBOX360_DPAD_LEFT
  @I_GAMEPAD_RIGHT = Phaser.Gamepad.XBOX360_DPAD_RIGHT
  @I_GAMEPAD_UP = Phaser.Gamepad.XBOX360_DPAD_UP
  @I_GAMEPAD_DOWN = Phaser.Gamepad.XBOX360_DPAD_DOWN

  constructor: (game, grid, playerConfig, gamepad = null) ->
    super game, grid

    @config = playerConfig

    # Add keys
    @keys =
      left: @game.input.keyboard.addKey @config.keys.left, @
      right: @game.input.keyboard.addKey @config.keys.right, @
      rotateLeft: @game.input.keyboard.addKey @config.keys.up, @
      rotateRight: @game.input.keyboard.addKey @config.keys.down, @

    # Add function called on down
    for key, keyValue of @keys
      keyValue.onDown.add @keyboardOnDownHandler, @
      keyValue.onUp.add @keyboardOnUpHandler, @

    # Add a gamepad
    if @game.input.gamepad.supported and gamepad?
      @gamepad = gamepad
      @gamepad.onDownCallback = @gamepadOnDownHandler
      @gamepad.onUpCallback = @gamepadOnUpHandler


  keyboardOnDownHandler: (key) =>
    switch key
      when @keys.left then @moveLeft()
      when @keys.right then @moveRight()
      when @keys.up then @moveUp()
      when keys.down then @moveDown()


  keyboardOnUpHandler: (key) =>
    switch key
      when @keys.accelerate then @endAccelerate()


  gamepadOnUpHandler: (button) =>
    switch button
      when PlayerHuman.I_GAMEPAD_ACCELERATE then @endAccelerate()


  gamepadOnDownHandler: (button) =>
    switch button
      when PlayerHuman.I_GAMEPAD_MOVE_LEFT then @moveLeft()
      when PlayerHuman.I_GAMEPAD_MOVE_RIGHT then @moveRight()
      when PlayerHuman.I_GAMEPAD_ROTATE_LEFT then @rotateLeft()
      when PlayerHuman.I_GAMEPAD_ROTATE_RIGHT then @rotateRight()
      when PlayerHuman.I_GAMEPAD_ACCELERATE then @startAccelerate()
      when PlayerHuman.I_GAMEPAD_FINISH then @finish()



module.exports = PlayerHuman
