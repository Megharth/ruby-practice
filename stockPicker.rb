def StockPicker(prices)
    prices_asc = prices.sort_by { |a| a }
    prices_desc = prices_asc.reverse
    profit = 0
    result = Array.new
    
    (prices.length/2 + 1).times do |ii|
        buy_rate = prices_asc[ii]
        sell_rate = prices_desc[ii]
        buy_index = prices.find_index buy_rate
        sell_index = prices.find_index sell_rate
        if sell_index > buy_index and sell_rate - buy_rate > profit
            profit = sell_rate - buy_rate
            result = [buy_index, sell_index]
        end
    end

    puts profit
    puts result.to_s
end

StockPicker([17,3,6,9,15,8,6,1,10])

