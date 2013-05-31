module CursesHelper
  STATUS_LINE = 10
  STATUS_LINE_LENGTH = 200
  
  def self.display(player)
    self.write(0, 0, player.board_to_s)
    
    if player.lost?
      status("Player #{player.name} has lost")
    else
      status("It is #{player.name}`s turn...")
    end
    self.clear_input
  end
  
  def self.status(message)
    # pad the status with spaces to replace old characters
    message += " " * (STATUS_LINE_LENGTH - message.length)
    write(STATUS_LINE, 0, message)
  end
  
  def self.clear_input
    write(STATUS_LINE + 1, 0, ' ' * STATUS_LINE_LENGTH)
    setpos(STATUS_LINE + 1, 0)
  end
  
  def self.write(line, column, text)
    setpos(line, column)
    addstr(text)
  end
end
