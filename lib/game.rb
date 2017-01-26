class Game

  attr_accessor :player1, :player2, :current_player, :board

  def initialize
    self.board = [ [false, false, false],
                   [false, false, false],
                   [false, false, false] ]
  end

  def add_player( player )
    raise "Already two players exist" if player2_exist?
    player1_exist? ? self.player2 = player : self.player1 = player
  end

  def start
    raise "To start, require two players" if !player2_exist?
    set_player1_turn
    true
  end

  def change_turn
    previous_turn_by_player1? ? set_player2_turn : set_player1_turn
  end

  def claim_field( row, column )
    row = row - 1       #change row number for board array
    column = column - 1 #change column number for board array
    raise "The field has already been taken" if the_field_unavailable?( row, column )
    self.board[row][column] = self.current_player
    change_turn
  end

  def check_result( row, column )
    "You win!" if got_a_row?( row, column )
  end

  private

  def player1_exist?
    !player1.nil?
  end

  def player2_exist?
    !player2.nil?
  end

  def previous_turn_by_player1?
    self.current_player == self.player1
  end

  def set_player1_turn
    self.current_player = self.player1
  end

  def set_player2_turn
    self.current_player = self.player2
  end

  def the_field_unavailable?( row, column )
    self.board[row][column] != false
  end

  def got_a_row?( row, column )
    self.board[row].all?{ |player| player == self.current_player }
  end

end
