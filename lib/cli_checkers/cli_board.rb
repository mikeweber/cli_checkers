class Board
  def to_s
    output = "  0|1|2|3|4|5|6|7\n"
    
    8.times do |row|
      output << "#{row}|"
      self.cols.each.with_index do |column, col|
        piece = column[row]
        chr = piece.nil? ? ((col + row).odd? ? ' ' : '█') : (piece.color == :black) ? (piece.kinged? ? '◎' : '○') : (piece.kinged? ? '◉' : '●')
        output << "#{chr}|"
      end
      output << "\n"
    end
    
    return output
  end
end
