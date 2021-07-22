class Player
    attr_reader :name, :role
    def initialize(name, role, type)
        @name = name
        @role = role
        @type = type
        @colors = [:red, :blue, :green, :white, :black, :yellow, :orange, :magenta, :cyan]
    end

    def setCode
        if(@type == :computer)
            @code = [@colors.sample, @colors.sample, @colors.sample, @colors.sample]
        end
    end

    def guessCode
        begin
            puts "Guess the code"
            code = gets.chomp
            code = code.split(' ')
            code = code.map do |color| 
                color.downcase.to_sym
            end
            return code
        rescue Interrupt
            puts "\nGame ended :("
            return nil
        end
    end

    def verifyCode code
        if code == @code
            return [:r, :r, :r, :r]
        else
            result = Array.new
            code.each_with_index do |color, ii|
                if @code.include? color
                    if @code[ii] == color
                        result.push :r
                    else
                        result.push :w
                    end
                else
                    result.push('-')
                end
            end
            return result 
        end
    end
end

class Game
    def initialize(name)
        @codeBreaker = Player.new(name, :codeBreaker, :human)
        @codeMaker = Player.new("Computer", :codeMaker, :computer)
        @trials = 12
        @history = Array.new
    end

    def printBoard
        puts `clear`
        @history.each do |code|
            puts '+-------------------------------------------+' 
            puts "| #{code[0]} | #{code[1]} | #{code[2]} | #{code[3]} | #{code[4]} |"
            puts '+-------------------------------------------+' 
        end
    end

    def printScore
        puts '+----------------------------------+'
        puts "| #{@codeMaker.name}      |      #{@history.length - 1}      |"
        puts '+----------------------------------+'
        puts "| #{@codeBreaker.name}      |      #{@trials - @history.length + 1}      |"
        puts '+----------------------------------+'

    end

    def start
        @codeMaker.setCode()
        @trials.times do 
            code = @codeBreaker.guessCode()
            if code != nil
                results = @codeMaker.verifyCode(code)
                code.push(results.join(' '))
                @history.push(code)
                printBoard()

                if results == [:r, :r, :r, :r]
                    puts "Congratulations #{@codeBreaker.name}, you managed to break the code!"
                    break
                end
            else
                break
            end
        end

        if @history.length == 12 
            puts "Whoops #{@codeBreaker.name}, you couldn't break the code!"
        end

        printScore()
    end
end

game = Game.new("Megharth")
game.start()