require 'ruby2d'
require_relative 'SinglePlayerGame'
require_relative 'MultiPlayerGame'
set title: "Trivial Retreat", background: 'silver', resizable: true

input = ""
submit = false
answerScreen = false
@mainMenu = true
capitalized = false
gameOn = false
ruleScreen = false
def initializeMain
  @mainMenu = true
  @multiButton = Rectangle.new(
  x: (Window.width / 2) + 10, y: (Window.height / 2),
  width: 200, height: 100,
  color: 'gray',
  z: 10
)
  @singButton = Rectangle.new(
  x: (Window.width / 2) - 210, y: (Window.height / 2),
  width: 200, height: 100,
  color: 'gray',
  z: 10
)
  @ruleButton = Rectangle.new(
  x: (Window.width / 2) - 100, y: (Window.height / 2) + 120,
  width: 200, height: 70,
  color: 'teal',
  z: 10
)
singleText = Text.new(
  'Single-Player',
  x: @singButton.x + 40, y: @singButton.y + 40,
  size: 20,
  color: 'black',
  z: 20
)
multiText = Text.new(
  'Multi-Player',
  x: @multiButton.x + 50, y: @multiButton.y + 40,
  size: 20,
  color: 'black',
  z:20
)
titleText = Text.new(
  'Trivial Retreat!',
  x: Window.width / 4, y: Window.height / 4,
  size: 50,
  color: 'black',
  z:10
)
ruleText = Text.new(
  'Rules',
  x: @ruleButton.x + 70, y: @ruleButton.y + 25,
  size: 20,
  color: 'black',
  z: 10
)
end
initializeMain
on :mouse_down do |event|
  # Read the button event
  case event.button
  when :left
    if (event.x >= @singButton.x && event.x <= @singButton.x + @singButton.width) && (event.y >= @singButton.y && event.y <= @singButton.y + @singButton.height)
      if (@mainMenu)
        clear
        @mainMenu = false
        $game = SinglePlayerGame.new
        gameOn = true
      end
    end
    if (event.x >= @multiButton.x && event.x <= @multiButton.x + @multiButton.width) && (event.y >= @multiButton.y && event.y <= @multiButton.y + @multiButton.height)
      if (@mainMenu)
        clear
        @mainMenu = false
        $game = MultiPlayerGame.new
        gameOn = true
      end
    end
    if (event.x >= @ruleButton.x && event.x <= @ruleButton.x + @ruleButton.width) && (event.y >= @ruleButton.y && event.y <= @ruleButton.y + @ruleButton.height)
      if (ruleScreen || gameOn)
        clear
        initializeMain
        ruleScreen = false
        gameOn = false
      elsif (@mainMenu)
        clear
        @mainMenu = false
        Text.new(
          "Rules:",
          x: (Window.width / 2) - 80, y: 10,
          size: 45,
          color: 'black',
          z: 20
        )
        Text.new(
          "Single-Player: Answer the questions by typing in the answer, you gain 25",
          x: 10, y: (Window.height / 2) - 100,
          size: 18,
          color: 'black',
          z: 20
        )
        Text.new(
          "points if you get a question right, but -10 points if you get one wrong",
          x: 20, y: (Window.height / 2) - 80,
          size: 20,
          color: 'black',
          z: 20
        )
        Text.new(
          "Multi-Player: The same rules from Single-Player apply here, but two",
          x: 10, y: (Window.height / 2),
          size: 18,
          color: 'black',
          z: 20
        )
        Text.new(
          "players alternate, with one being Player 1 and another being Player 2",
          x: 20, y: (Window.height / 2) + 30,
          size: 18,
          color: 'black',
          z: 20
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
        ruleScreen = true
      end
    end
  end
end
on :key_down do |event|
  if (gameOn)
  if ((event.key).length == 1 || event.key == 'space')
    if (submit)
      input = ""
      $checkInput.remove
      submit = false
    end
    if (event.key == 'space')
      if (answerScreen)
        answerScreen = false
        clear
        $game.reQuestion
      else
        input = input + ' '
      end
    else
      if (capitalized)
        input = input + event.key.capitalize()
        capitalized = false
      else
        input = input + event.key
      end
    end
  elsif (event.key == 'left shift')
    capitalized = true
  elsif (event.key == 'backspace')
    input = input[0..-2]
  elsif (event.key == 'return')
    finalInput = input
    if (!submit)
      check = "Did you type \"#{finalInput}?\" Press Enter if so, retype if not."
      $checkInput = Text.new(
        check,
        x: (Window.width / 4) - check.length, y: (Window.height / 2) + 50,
        size: 20,
        color: 'green',
        z: 20
      )
      submit = true
    else
      clear
      answerScreen = true
      $game.printResult(finalInput)
    end
  end
  end
end
show
