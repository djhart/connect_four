require 'spec_helper.rb'

describe Player do 

	before :each do 
		@black = " \u25ce "
		@white = " \u25c9 "
		@whitePlayer = Player.new(@white)
		@blackPlayer = Player.new(@black)
	end

	describe "#new" do 
		it "takes color, makes player" do
			expect(@whitePlayer).to be_an_instance_of Player
		end
	end

	describe "#take" do 
		it "makes a space player color" do 
			@whitePlayer.take([0,0])
			expect(Player.board[0][0]).to eql(@white)
		end
	end

	describe "#group" do
		it "counts ascending in a row" do
			@whitePlayer.take([0,0])
			@whitePlayer.take([3,0])
			@whitePlayer.take([1,1])
			@whitePlayer.take([2,0])
			expect(@whitePlayer.group([2,0],-1,1)).to eql(2)
		end

		it "stops at 4" do 
			@whitePlayer.take([5,0])
			@whitePlayer.take([4,1])
			@whitePlayer.take([3,2])
			@whitePlayer.take([2,3])
			@whitePlayer.take([1,4])
			@whitePlayer.take([0,5])
			expect(@whitePlayer.group([5,0],-1,1)).to eql(4)
		end

		it "counts descending in a row" do 
			@whitePlayer.take([0,0])
			@whitePlayer.take([1,1])
			@whitePlayer.take([2,2])
			@whitePlayer.take([3,3])
			@whitePlayer.take([4,4])
			@whitePlayer.take([5,5])
			expect(@whitePlayer.group([0,0],1,1)).to eql(4)
		end

		it "counts horizontally" do
			@whitePlayer.take([0,0])
			@whitePlayer.take([0,1])
			@whitePlayer.take([0,2])
			@whitePlayer.take([0,3])
			@whitePlayer.take([0,4])
			@whitePlayer.take([0,5])
			expect(@whitePlayer.group([0,0],0,1)).to eql(4)
		end

		it "counts vertically" do 
			@whitePlayer.take([0,0])
			@whitePlayer.take([1,0])
			@whitePlayer.take([2,0])
			@whitePlayer.take([3,0])
			@whitePlayer.take([4,0])
			@whitePlayer.take([5,0])
			expect(@whitePlayer.group([0,0],1,0)).to eql(4)
		end

		it "handles edges" do
			@whitePlayer.take([0,0])
			@whitePlayer.take([5,0])
			@whitePlayer.take([0,5])
			@whitePlayer.take([5,5])
			expect(@whitePlayer.group([0,0],-1,1)).to eql(1)
			expect(@whitePlayer.group([0,0],1,1)).to eql(1)
			expect(@whitePlayer.group([0,0],1,0)).to eql(1)
			expect(@whitePlayer.group([0,0],0,1)).to eql(1)
		end
	end

	describe "#win?" do 

		it "wins ascending" do
			@whitePlayer.take([5,0])
			@whitePlayer.take([4,1])
			@whitePlayer.take([3,2])
			@whitePlayer.take([2,3])
			@whitePlayer.take([1,4])
			@whitePlayer.take([0,5])
			expect(@whitePlayer.win?).to eql(true)
		end

		it "wins descending" do 
			@whitePlayer.take([0,0])
			@whitePlayer.take([1,1])
			@whitePlayer.take([2,2])
			@whitePlayer.take([3,3])
			@whitePlayer.take([4,4])
			@whitePlayer.take([5,5])
			expect(@whitePlayer.win?).to eql(true)
		end

		it "wins horizontally" do
			@whitePlayer.take([0,0])
			@whitePlayer.take([0,1])
			@whitePlayer.take([0,2])
			@whitePlayer.take([0,3])
			@whitePlayer.take([0,4])
			@whitePlayer.take([0,5])
			expect(@whitePlayer.win?).to eql(true)
		end

		it "wins vertically" do 
			@whitePlayer.take([0,0])
			@whitePlayer.take([1,0])
			@whitePlayer.take([2,0])
			@whitePlayer.take([3,0])
			expect(@whitePlayer.win?).to eql(true)
		end

		it "handles edges" do
			@whitePlayer.take([0,0])
			@whitePlayer.take([5,0])
			@whitePlayer.take([0,5])
			@whitePlayer.take([5,5])
			expect(@whitePlayer.win?).to eql(false)
		end

	end
	
end