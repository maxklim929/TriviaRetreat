class Game
  def initialize
    @@testCard = Rectangle.new(
      x: 0, y: (Window.height / 2) - 50,
      width: Window.width, height: 100,
      color: 'gray',
      z: 10
    )
    @@question = Text.new(
      Questions[@@num],
      x: (Window.width / 2) - (Questions[@@num].length * 5), y: (Window.height / 2) - 20,
      size: 20,
      color: 'black',
      z: 20
    )
  end

  def reQuestion
    @@num = rand(0...(QAHash.size - 1))
    Window.clear
    $testCard =  Rectangle.new(
      x: 0, y: (Window.height / 2) - 50,
      width: Window.width, height: 100,
      color: 'gray',
      z: 10
    )
    @@question = Text.new(
      Questions[@@num],
      x: (Window.width / 2) - (Questions[@@num].length * 5), y: (Window.height / 2) - 20,
      size: 20,
      color: 'black',
      z: 20
    )
    @@pointCounterP1 = Text.new(
      "Points P1: #{@@pointsP1}",
      x: 0, y: Window.height - 50,
      size: 20,
      color: 'black',
      z: 10
    )
    @@pointCounterP2 = Text.new(
      "Points P2: #{@@pointsP2}",
      x: Window.width - (Window.width / 5), y: Window.height - 50,
      size: 20,
      color: 'black',
      z: 10
    )
    backToMain = Rectangle.new(
      x: (Window.width / 2) - 100, y: (Window.height / 2) + 120,
      width: 200, height: 70,
      color: 'blue',
      z: 10
    )
    Text.new(
      'Main Menu',
      x: backToMain.x + 50, y: backToMain.y + 25,
      size: 20,
      color: 'black',
      z: 10
    )
  end
end
