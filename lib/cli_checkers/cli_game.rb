class CliGame < Game
  def self.play
    CursesHelper.status "Enter player 1's (black) name: "
    player2 = RandomAIPlayer.new('Player 1')
    CursesHelper.status "Enter player 2's (white) name: "
    player1 = RandomAIPlayer.new('Player 2') # Curses.getstr.strip
    
    game = self.new(player1, player2)
    game.play!
  end
  
  def run_game
    begin
      init_screen
      nl
      
      while playing?
        sleep(0.05)
        begin
          take_turn
        rescue EndGame => eg
          @playing = false
        end
        CursesHelper.display self.whose_turn, self.board
      end
      winning_message = if self.red.lost?
        "Black wins!"
      elsif self.black.lost?
        "White wins!"
      end
      CursesHelper.status "#{winning_message} Press any key to exit."
      Curses.getch
    ensure
      close_screen
    end
  end
end
