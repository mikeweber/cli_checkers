class RandomAIPlayer < Player
  def make_move
    piece_to_move = self.moveable_pieces[rand(self.moveable_pieces.size)]
    was_jump = piece_to_move.move_to(*piece_to_move.legal_moves[rand(piece_to_move.legal_moves.size)].position)
    
    return piece_to_move, was_jump
  end
end
