def Substrings(word, dictionary)
    wordCount = Hash.new(0)
    dictionary.each do |str|
        count = word.downcase.scan(str).length
        if count > 0
            wordCount[str] = count
        end
    end
    wordCount
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts Substrings("below", dictionary)
puts Substrings("Howdy partner, sit down! How's it going?", dictionary)