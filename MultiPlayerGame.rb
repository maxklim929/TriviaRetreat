require 'ruby2d'
require_relative 'QuestionsMap'
class MultiPlayerGame
  QAHash = QuestionsMap.QARet
  Questions = QAHash.keys
  @p1Turn = true
  @@submit = false
  @@answerScreen = false
  @@num = rand(0...(QAHash.size - 1))

  def initialize
    @@pointsP1 = 0
    @@pointsP2 = 0
    reQuestion
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
    question_temp = Questions[@@num]
    quest_size = 20
    if (question_temp.length > 30)
      quest_size = 17
    end
    @@question = Text.new(
      question_temp,
      x: (Window.width / 2) - (question_temp.length * 4), y: (Window.height / 2) - 20,
      size: quest_size,
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
      x: Window.width - (Window.width / 4), y: Window.height - 50,
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
    @@typToRec = Rectangle.new(
      x: (Window.width / 2) - 120, y: Window.height - 40,
      width: 250, height: 45,
      color: 'red',
      z: 10
    )
    @@typeTo = Text.new(
      'Type to Answer Then Press Enter...',
      x: (Window.width / 2) - 110, y: Window.height - 30,
      size: 15,
      color: 'black',
      z: 10
    )
  end

  def printResult(finalInput)
    if (finalInput.capitalize() == QAHash[Questions[@@num]].capitalize())
      Text.new(
        'CORRECT!',
        x: (Window.width / 2) - 150, y: (Window.height / 2) - 50,
        size: 50,
        color: 'green',
        style: 'bold',
        z: 20
      )
      if (!@p1Turn)
        @@pointsP1 = @@pointsP1 + 25
        @p1Turn = true
      else
        @@pointsP2 = @@pointsP2 + 25
        @p1Turn = false
      end

    else
      wrongAns = "WRONG! The Answer Was: #{QAHash[Questions[@@num]]}"
      Text.new(
        wrongAns,
        x: (Window.width / 5) - wrongAns.length + 20, y: (Window.height / 2) - 50,
        size: 25,
        color: 'red',
        style: 'bold',
        z: 20
      )
      if (!@p1Turn)
        if (@@pointsP1 >= 10)
          @@pointsP1 = @@pointsP1 - 10
        end
        @p1Turn = true
      else
        if (@@pointsP2 >= 10)
          @@pointsP2 = @@pointsP2 - 10
        end
        @p1Turn = false
      end
    end
    Text.new(
      "Press Space to Continue...",
      x: (Window.width / 2) - 200, y: (Window.height / 2) + 50,
      size: 35,
      color: 'red',
      style: 'blue',
      z: 20
    )
  end
end