class TowerOfHanoi
  def initialize(towers)
    @towers = towers
  end

  def play
    towers = [['o', 'oo', 'ooo'], [' ', ' ', ' '], [' ', ' ', ' ']]
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

      # move validated, so make move
      make_move(move, towers)

      #render towers again
      render(towers)

      # check if user has won
      if won?(towers)
        puts "Congratulations! You've won!"
        exit
      end

      # otherwise, reset valid_move
      valid_move = false

    end
  end

  def won?(towers)
    towers.each_with_index do |tower, i|
      return true if tower.none? { |slot| slot == ' '} && i != 0
    end
    return false
  end

  def make_move(move, towers)
    current_tower = towers[move[0].to_i - 1]
    new_tower = towers[move[-1].to_i - 1]

    # get the top disc
    disc = current_tower.find { |disc| disc != ' '}

    # place disc in bottom-most slot of new tower if all empty
    new_tower[-new_tower.reverse.index(' ') - 1] = disc

    # make its former place an empty slot
    current_tower[current_tower.index(disc)] = ' '

  end


  def render(towers)
    (0...@towers).each do |tower|
      (0...@towers).each do |row|
        print towers[row][tower].ljust(5)
      end
      puts "\n"
    end
    (1..@towers).each { |n| print n.to_s.ljust(5)}
    puts "\n"
  end

  def validate_move(move, towers)
    unless move.length == 3
      puts "You might have got your tower numbers or the format wrong.\n Enter where you'd like to move from and to in the format '1,3'."
      return false
    end
    # convert to int and a
    moves = [move[0].to_i-1, move[-1].to_i-1]

    # make sure all towers exist
    if moves.any? {|tower_index| tower_index < 0 || tower_index >= @towers}
      puts "Tower not found. Please move disc between our available towers: #{(1..@towers).to_a}"
      return false
    end

    # make sure tower we're transferring from has disc
    if towers[moves[0]].all? { |tower| tower == ' '}
      puts "We couldn't find any discs to transfer. Try transfering discs from another tower"
      return false
    end

    # if new tower has a disc, make sure it's not smaller than the disc we're trying to move
    if towers[moves[1]].any? { |slot| slot != ' '}
      disc = towers[moves[0]].find { |disc| disc != ' '}
      if towers[moves[1]].any? { |item| item != ' ' && disc.size > item.size }
        puts "No disk may be placed on top of a smaller disk"
        render(towers)
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
