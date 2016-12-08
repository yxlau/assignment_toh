class TowerOfHanoi
  def initialize(towers)
    @towers = towers
  end

  def play
    board = [ [ 'o', 'oo', 'ooo'], ['', '', ''], ['', '', ''] ]
    game_over = false
    valid_move = false
    move = ''

    welcome_message

    until game_over

      until valid_move
        puts 'Enter move > '
        move = gets.strip

        # let user exit immediately if they've entered 'q'
        exit if move == 'q'

        valid_move = validate_move(move)

      end

      # make move

      #render board again

      # check if user has won

      # if has won, congratulate user and change game_over state

      # otherwise, reset valid_move


    end
  end

  def validate_move(move)
    # make sure correct format
    # make sure towers exist
    # make sure tower has disc
  end

  def render(board)
    # print towers row by row (instead of tower by tower)
  end

  def welcome_message
    puts 'Welcome to Tower of Hanoi!'
    puts 'Instructions:'
    puts 'Enter where you\'d like to move from and to in the format \'1,3\'. Enter \'q\' to quit.'
  end

end


t = TowerOfHanoi.new(3)
t.play
