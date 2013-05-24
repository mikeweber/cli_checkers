class CliGame < Game
  def initialize
    print "Enter player 1's (red) name: "
    player1 = CliPlayer.new(gets.strip)
    print "Enter player 2's (black) name: "
    player2 = CliPlayer.new(gets.strip)
    
    setup_game(player1, player2)
    play!
  end
end
