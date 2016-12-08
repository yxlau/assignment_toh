class TowerOfHanoi
  def initialize(towers)
    @towers = towers
  end

  def play
    towers = [ [ 'o', 'oo', 'ooo'], [' ', ' ', ' '], [' ', ' ', ' '] ]
    game_over = false
    valid_move = false
    move = ''

    welcome_message

    render(towers)

    until game_over

      until valid_move
        puts 'Enter move > '
        move = gets.strip

        # let user exit immediately if they've entered 'q'
        exit if move == 'q'

        # validate move
        valid_move = validate_move(move, towers)

      end

      puts "move validated"

      # make move

      #render towers again

      # check if user has won

      # if has won, congratulate user and change game_over state

      # otherwise, reset valid_move


      # prevent infinite loop
      game_over = true

    end
  end



  def render(towers)
    rungs = towers[0].size
    towers.each_with_index do |tower, t|
      (0...rungs).each do |r|
        print towers[r][t].ljust(5)
      end
      puts "\n"
    end
    (1..@towers).to_a.each { |n| print n.to_s.ljust(5) }
    puts "\n"
  end

  def validate_move(move, towers)
    if move.length == 3
      # convert to int and a
      moves = move.split(',').map{ |tower| tower.to_i}

      # make sure all towers exist
      if moves.any? {|tower| tower < 1 || tower > @towers}
        puts "Tower not found. Please move disc between our available towers: #{(1..@towers).to_a}"
        return false
      end

      # make sure tower we're transferring from has disc
      if towers[moves[0]-1].all? { |tower| tower == ' '}
        puts "We couldn't find any discs to transfer. Try transfering discs from another tower"
        return false
      end
    else
      puts "You might have got your tower numbers or the format wrong.\n Enter where you'd like to move from and to in the format '1,3'."
      return false
    end

    # validate move
    return true

  end

  def welcome_message
    puts 'Welcome to Tower of Hanoi!'
    puts 'Instructions:'
    puts 'Enter where you\'d like to move from and to in the format \'1,3\'. Enter \'q\' to quit.'
  end

end


t = TowerOfHanoi.new(3)
t.play
