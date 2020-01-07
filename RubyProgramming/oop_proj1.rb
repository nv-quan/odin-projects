class InvalidMarker < StandardError
  def initialize(msg = "Marker should be only 'x' or 'o'", exception_type="custom")
    @exception_type = exception_type
    super(msg)
  end
end
class Board
  #Board design: table of 'x', 'o' or nil
  def initialize
    @table = Array.new(9, nil)
    @winner = nil
  end
  def found_winner?
    line = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
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
    unless mark == 'x' || mark == 'o'
      raise InvalidMarker
    else
      @table[position] = mark
    end
  end
  def get_empty_cell
    res = []
    @table.each_with_index do |x, idx|
      res.push(idx) if x.nil?
    end
    res
  end
end
