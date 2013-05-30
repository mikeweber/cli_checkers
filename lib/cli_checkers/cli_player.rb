class CliPlayer < Player
  def initialize(*args)
    super
    @first_move = true
  end
  
  def make_move
    puts board_to_s
    piece = request_piece_loop
    dest  = request_move_to_loop(piece)
    begin
      was_jump = piece.move_to(*dest)
    rescue => e
      puts "Could not make move: #{e.message}"
      make_move
    end
    
    return piece, was_jump
  end
  
  def board_to_s
    output = "  0|1|2|3|4|5|6|7\n"
    
    8.times do |row|
      output << "#{row}|"
      self.board.cols.each.with_index do |column, col|
        piece = column[row]
        char = piece.nil? ? ((col + row).odd? ? ' ' : '█') : (piece.color == :black) ? (piece.kinged? ? '◎' : '○') : (piece.kinged? ? '◉' : '●')
        output << "#{char}|"
      end
      output << "\n"
    end
    
    return output
  end
  
  private
  
  def request_piece_loop
    piece = nil
    while !piece
      piece_position = request_piece
      puts "You asked for the piece at #{piece_position.inspect}"
      unless piece = self.moveable_pieces.detect { |piece| piece.position == piece_position }
        puts "You don't have a piece there that can move. Please try again."
      end
    end
    
    return piece
  end
  
  def request_move_to_loop(piece)
    move = nil
    while !move
      move_to = request_move_to(piece)
      unless move = piece.legal_moves.detect { |legal_move| legal_move.position == move_to }
        puts "I could not recognize that that move. Please try again."
      end
    end
    
    return move.position
  end
  
  def request_piece
    message = "#{self.name}'s (#{self.color}) turn."
    message += " Enter a piece to move by typing the column and row of the piece to move, separated by a space. e.g. '3 2'." if @first_move
    message += " Your moveable pieces are #{self.moveable_pieces.collect { |piece| piece.position }.inspect}."
    @first_move = false
    puts message
    request_coordinate
  end
  
  def request_move_to(piece)
    puts "Now enter where you're moving using column and row. Your available moves are #{piece.legal_moves_as_coordinates.inspect}"
    request_coordinate
  end
  
  def request_coordinate
    input = request_input
    if input =~ /quit|exit/
      self.you_lose!
      raise EndGame
    else
      input.split(' ').collect { |x| x.to_i }
    end
  end
  
  def request_input
    gets.strip
  end
end
