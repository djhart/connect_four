black = " \u25ce "
white = " \u25c9 "


class Player
	attr_accessor  :color, :board
	@@blank = " \u25ef "

	def initialize(color)
		@color = color
		@@board = Array.new(6) {Array.new(7, @@blank)}				
	end

	def take(space)
		@@board[space[0]][space[1]] = @color
	end

	def find_row(column)
		i = 0
		until (@@board[5 - i][column] == @@blank) || i > 5
			i += 1
		end
		return 5 - i
	end

	def turn
		Player.display
		column = 100
		row = 100
		until (0..6).include?(column) && (0..5).include?(row)
			puts "#{@color} to move. Which column?"
			column = gets.chomp.to_i
			row = find_row(column)
		end
		space = [row, column]
		take(space)
		
	end

	def group(space, n, m, i = 1)
		#n, m row and column increments, respectively
		x,y = space[0], space[1]
		unless i == 4 || !((0..5).include?(x + n)) || !((0..6).include?(y + m))
			if @@board[x][y] == @@board[x + n][y + m]
				i += 1
				i = group([x + n, y + m], n, m, i)
			end
		end
		return i 
	end
		
	def win?
		win = false
		(0..5).to_a.each{|x| 
			(0..6).to_a.each{|y|
				if @@board[x][y] == @color
					win = true if group([x,y], -1, 1) == 4
					win = true if group([x,y], 1, 1) == 4
					win = true if group([x,y], 0, 1) == 4
					win = true if group([x,y], 1, 0) == 4
				end
			}
		}
		return win
	end

	def self.display
		@@board.each {|x| x.each {|y| print y}; puts ""}
	end

	def self.board
		return @@board
	end


end


turn = 0

playerOne = Player.new(white)
playerTwo = Player.new(black)

while turn < 42 
	if turn % 2 == 0
		playerOne.turn
		turn += 1
		if playerOne.win?
			Player.display
			puts "#{playerOne.color} wins!"
			turn = 50
		end
	else
		playerTwo.turn
		turn += 1
		if playerTwo.win?
			Player.display
			puts "#{playerTwo.color} wins!"
			turn = 50
		end
	end
end
