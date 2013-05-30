class CliGame < Game
  def self.play
    print "Enter player 1's (black) name: "
    player2 = CliPlayer.new(gets.strip)
    print "Enter player 2's (red) name: "
    player1 = CliPlayer.new(gets.strip)
    
    game = self.new(player1, player2)
    game.play!
  end
end
