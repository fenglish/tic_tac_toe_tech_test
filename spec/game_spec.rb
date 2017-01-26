require 'game'

describe Game do

  subject( :game ){ described_class.new }
  let( :player_x ){ double :player_x }
  let( :player_o ){ double :player_o }
  let( :player_p ){ double :player_p }

  context "#add_player" do
    it "should add player" do
      game.add_player( player_x )
      expect( game.player1 ).to eq player_x
    end

    it "should add the player to player2 when player1 exist" do
      game.add_player( player_x )
      game.add_player( player_o )
      expect( game.player1 ).to eq player_x
      expect( game.player2 ).to eq player_o
    end

    it "should not add any players when player1 and player2 exist" do
      game.add_player( player_x )
      game.add_player( player_o )
      expect{ game.add_player( player_p ) }.to raise_error("Already two players exist")
    end
  end

  context "#start" do
    it "should start a game with two players" do
      game.add_player( player_x )
      game.add_player( player_o )
      expect( game.start ).to eq true
    end

    it "should raise an error when there are not two players" do
      # No player
      expect{ game.start }.to raise_error("To start, require two players")
      # One player
      game.add_player( player_x )
      expect{ game.start }.to raise_error("To start, require two players")
    end
  end

  context "#change_current_player" do

    before(:each) do
      game.add_player( player_x )
      game.add_player( player_o )
      game.start
    end

    it "should change current player" do
      expect( game.current_player ).to eq game.player1
      game.change_current_player
      expect( game.current_player ).to eq game.player2
    end

  end

  context "#claim_field" do

    before(:each) do
      game.add_player( player_x )
      game.add_player( player_o )
      game.start
    end

    it "should mark the field by current player" do
      game.claim_field(1,1)
      expect( game.board[1-1] ).to be game.current_player
    end

    it "should raise an error when the field has already been taken" do
      game.claim_field(1,1)
      expect{ game.claim_field(1,1) }.to raise_error("The field has already been taken")
    end

  end

end
