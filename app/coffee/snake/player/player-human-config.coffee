Phaser = require 'Phaser'

Enum = require 'enum'

module.exports =
  player1:
    keys:
      left: Phaser.Keyboard.Q
      right: Phaser.Keyboard.D
      up: Phaser.Keyboard.Z
      down: Phaser.Keyboard.S
  player2:
    keys:
      left: Phaser.Keyboard.LEFT
      right: Phaser.Keyboard.RIGHT
      up: Phaser.Keyboard.UP
      down: Phaser.Keyboard.DOWN
