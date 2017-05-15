Direction = require '../../utils/direction.coffee'

W = Direction.W
N = Direction.N
E = Direction.E
S = Direction.S

module.exports =
  head:
    W: 12
    N: 5
    E: 6
    S: 13
  body:
    W:
      W: 1
      N: 9
      E: 1
      S: 2
    N:
      N: 8
      E: 7
      S: 8
      W: 9
    E:
      E: 1
      S: 0
      W: 1
      N: 7
    S:
      S: 8
      W: 2
      N: 8
      E: 0
  tail:
    W: 10
    N: 3
    E: 4
    S: 11
