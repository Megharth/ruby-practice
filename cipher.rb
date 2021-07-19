def caeser_cipher line, shift
    shift = shift % 26
    alphabets = ('a'..'z').to_a
    shiftedAlphabets = ('a'..'z').to_a

    shift.times do
        char = shiftedAlphabets.shift
        shiftedAlphabets += [char]
    end

    cipher = '';
    line.split('').each do |char|
        upperCase = /[[:upper:]]/.match(char)
        if(upperCase)
            char = char.downcase
        end
        ii = alphabets.find_index(char)
        if ii != nil
            cipher += upperCase ? shiftedAlphabets[ii].upcase : shiftedAlphabets[ii]
        else 
            cipher += char
        end
    end

    cipher
end

puts caeser_cipher "What a string!", 5
puts caeser_cipher "Zz", 5