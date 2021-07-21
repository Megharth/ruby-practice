# To register the player
class Player
    attr_reader :name
    attr_accessor :mark
    def initialize(name)
        @name = name
        @mark = ''
    end
end

# Represents the Tic-Tac-Toe game
class Game
    attr_reader :turn

    # initialize the game with two players
    def initialize(p1, p2)
        @p1 = p1
        @p2 = p2
        @turn = p1
        @boardRef = [['1, 1', '1, 2', '1, 3'], ['2, 1', '2, 2', '2, 3'], ['3,1 ', '3, 2', '3, 3']]
        @board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
        p1.mark = 'X'
        p2.mark = 'O'
    end

    def changeTurn 
        @turn = @turn == @p1 ? @p2 : @p1
    end

    # Mark the box and change the turn
    def markBox ip
        block = ip.split(' ')
        box = @board[block[0].to_i - 1][block[1].to_i - 1]
        if box.include? 'X' or box.include? 'O'
            puts 'Invalid move'
        else
            @board[block[0].to_i - 1][block[1].to_i - 1] = @turn.mark
            changeTurn()
        end
    end

    # Print a reference tic-tac-toe board
    def printReference
        @boardRef.each_with_index do |row, i|
            puts " #{row[0]} | #{row[1]} | #{row[2]} "
            if i != 2
                puts "-------------------"
            end
        end
    end

    # Print the actual state of the board
    def printBoard
        @board.each_with_index do |row, i|
            puts " #{row[0]} | #{row[1]} | #{row[2]} "
            if i != 2
                puts "------------"
            end
        end
    end

    # Check if all the boxes in the board are filled
    def boardEmpty
        @board.each do |row|
            row.each do |col|
                if col.strip == ''
                    return true
                end
            end
        end
        return false
    end
    
    # Check if the game is over
    # cond1: Its a truce
    # cond2: One of the players won
    def gameOver
        conditions = [
            # diagonals
            (@board[0][0] == @board[1][1] and @board[1][1] == @board[2][2] and 
                @board[0][0].strip != '' and @board[1][1].strip != '' and @board[2][2].strip != ''),
            (@board[0][2] == @board[1][1] and @board[1][1] == @board[2][0] and
                @board[0][2].strip != '' and @board[1][1].strip != '' and @board[2][0].strip != ''),
            
            # rows
            (@board[0][0] == @board[0][1] and @board[0][1] == @board[0][2] and 
                @board[0][0].strip != '' and @board[0][1].strip != '' and @board[0][2].strip != ''),
            (@board[1][0] == @board[1][1] and @board[1][1] == @board[1][2] and 
                @board[1][0].strip != '' and @board[1][1].strip != '' and @board[1][2].strip != ''),
            (@board[2][0] == @board[2][1] and @board[2][1] == @board[2][2] and 
                @board[2][0].strip != '' and @board[2][1].strip != '' and @board[2][2].strip != ''),
            
            # cols
            (@board[0][0] == @board[1][0] and @board[1][0] == @board[2][0] and
                @board[0][0].strip != '' and @board[1][0].strip != '' and @board[2][0].strip != ''),
            (@board[0][1] == @board[1][1] and @board[1][1] == @board[2][1] and 
                @board[0][1].strip != '' and @board[1][1].strip != '' and @board[2][1].strip != ''),
            (@board[0][2] == @board[1][2] and @board[1][2] == @board[2][2] and 
                @board[0][2].strip != '' and @board[1][2].strip != '' and @board[2][2].strip != ''),
        ] 


        conditions.each do |cond|
            if cond
                return true
            end
        end

        if !boardEmpty()
            @truce = true
            return true
        end

        return false
    end

    # starts the game
    def start 
        while !gameOver() do
            printReference()
            puts
            printBoard()
            puts "#{@turn.name}, please provide input"
            begin
                ip = gets.chomp
            rescue Interrupt => e
                @gameInterrupt = true
                break
            else
                markBox(ip)
                puts `clear`
            end
        end

        if @truce 
            printBoard()
            puts "Whoops! It's a truce"
        elsif @gameInterrupt
            puts "Game ended :("
        else 
            printBoard()
            changeTurn()
            puts "Congratulations #{@turn.name}, you won!"
        end

    end
end

p1 = Player.new "Megharth"
p2 = Player.new "Bhoomi"

game = Game.new p1, p2
game.start