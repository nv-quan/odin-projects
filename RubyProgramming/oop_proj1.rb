class InvalidMarker < StandardError
  def initialize(msg = "Marker should be only 'x' or 'o'", exception_type="custom")
    @exception_type = exception_type
    super(msg)
  end
end
class MarkerExisted < StandardError
  def initialize(msg = "Marker existed at this position", exception_type="custom")
    @exception_type = exception_type
    super(msg)
  end
end
class Board
  attr_reader :winner
  #Board design: table of 'x', 'o' or nil
  def initialize
    @table = Array.new(9, nil)
    @winner = nil
  end
  def found_winner?
    line = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]].map { |arr| arr.map { |x| x - 1 } }
    line.each do |arr|
      marks = arr.collect { |idx| @table[idx] }.uniq
      if marks.size == 1 && marks.uniq[0] != nil
        @winner = marks.uniq[0]
        return true
      end
    end
    false
  end
  def finished?
    @table.all?
  end
  def put_mark(mark, position)
    if mark != 'x' && mark != 'o'
      raise InvalidMarker
    elsif @table[position].nil?
      @table[position] = mark
    else
      raise MarkerExisted
    end
  end
  def get_empty_cell
    res = []
    @table.each_with_index do |x, idx|
      res.push(idx) if x.nil?
    end
    res
  end
  def print_board
    cells = @table.map { |x| x.to_s.ljust(2) }
    3.times do |i|
      start = i * 3
      cells[start..start+2].each { |c| print "| #{c}" }
      puts "|"
      if i != 2
        puts "-------------"
      end
    end
  end
end
loop do 
  board = Board.new
  puts "Game started, press Ctr + C to exit"
  puts "Player 1 goes first"
  player = 1
  loop do 
    board.print_board
    puts "Player #{player}'s turn: "
    pos = gets.chomp.to_i
    if pos > 9 || pos < 1
      puts "Mark position should be from 1 to 9"
      next
    else
      pos -= 1
      mark = player == 1 ? 'x' : 'o'
      begin 
        board.put_mark(mark, pos)
      rescue MarkerExisted => e
        puts e.message
        next
      end
      if board.found_winner?
        winner = board.winner == 'x' ? 1 : 2
        board.print_board
        puts "Player #{winner} win"
        break
      elsif board.finished?
        board.print_board
        puts "Tie"
        break
      else
        player = player == 1 ? 2 : 1
      end
    end
  end
end
