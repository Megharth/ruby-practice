def sort(arr)
    (arr.length - 1).times  do
        (arr.length - 1).times do |jj|
            if arr[jj] > arr [jj + 1]
                temp = arr[jj]
                arr[jj] = arr[jj + 1]
                arr[jj + 1] = temp
            end
        end
    end

    arr
end

arr = [4,3,78,2,0,2]
p sort(arr)