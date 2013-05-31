class CliGame < Game
  def self.play
    CursesHelper.status "Enter player 1's (black) name: "
    player2 = CliPlayer.new(Curses.getstr.strip)
    CursesHelper.status "Enter player 2's (red) name: "
    player1 = CliPlayer.new(Curses.getstr.strip)
    
    game = self.new(player1, player2)
    game.play!
  end
  
  def run_game
    init_screen
    nl
    CursesHelper.write(CursesHelper::STATUS_LINE + 1, 0, "Welcome!")
    
    while playing?
      CursesHelper.display self.whose_turn
      begin
        take_turn
      rescue EndGame => eg
        @playing = false
      end
    end
  end
end
