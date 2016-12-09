class TowerOfHanoi
  def initialize(discs=3)
    @discs = discs
  end

  def play
    towers = [build_first_tower(@discs), [],[]]
    valid_move = false
    game_over = false
    move = ''

    welcome_message

    render(towers)

    until game_over

      until valid_move
        puts "\nEnter move > "
        move = gets.strip
        puts "\n"

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

  def build_first_tower(discs)
    first = []
    (1..discs).each do |n|
      first.unshift(n)
    end
    first
  end

  def won?(towers)
    towers.each_with_index do |tower, i|
      return true if i != 0 && tower == (1..@discs).to_a.reverse
    end
    false
  end

  def make_move(move, towers)
    current_tower = towers[move[0].to_i - 1]
    new_tower = towers[move[-1].to_i - 1]

    # get the top disc, which will always be the smallest disc in the tower
    disc = current_tower.min

    # place disc in bottom-most slot of new tower
    new_tower << disc

    # make its former place an empty slot
    current_tower.delete(disc)

  end


  def render(towers)
    space = @discs + 2
    (0..@discs).reverse_each do |row|
      (0...@discs).each do |tower|
        print towers[tower][row].nil? ? ' '.ljust(space) : ("o" * towers[tower][row]).ljust(space)
      end
      puts "\n"
    end
    (1..@discs).each { |n| print n.to_s.ljust(space)}
    puts "\n"
  end

  def validate_move(move, towers)
    return false unless right_format?(move)

    # store tower indices
    from = move[0].to_i - 1
    to = move[-1].to_i - 1

    # make sure all towers exist
    return false unless towers_exist?(from, to)

    # make sure 'from' tower has disc
    return false if tower_empty?(towers[from])

    # if new tower has a disc, make sure it's not smaller than the disc we're trying to move
    unless towers[to].empty?
      return false if correct_order?(towers[from], towers[to])
    end

    # validate move
    true

  end

  def towers_exist?(from_index, to_index)
    unless (0...@discs).include?(to_index) && (0...@discs).include?(from_index)
      puts "Tower not found. Please move disc between our available towers: #{(1..@discs).to_a}"
      return false
    end
    true
  end

  def correct_order?(from_tower, to_tower)
    puts "No disc may be placed on top of a smaller disc" if from_tower.min > to_tower.min
    from_tower.min > to_tower.min
  end

  def right_format?(move)
    puts "You might have got your tower numbers or the format wrong.\n Enter where you'd like to move from and to in the format '1,3'." unless move.length == 3
    move.length == 3
  end

  def tower_empty?(tower)
    puts "We couldn't find any discs to transfer. Try transferring discs from another tower" if tower.empty?
    tower.empty?
  end

  def welcome_message
    puts 'Welcome to Tower of Hanoi!'
    puts 'Instructions:'
    puts 'Enter where you\'d like to move from and to in the format \'1,3\'. Enter \'q\' to quit.'
  end

end


t = TowerOfHanoi.new(3)
t.play
