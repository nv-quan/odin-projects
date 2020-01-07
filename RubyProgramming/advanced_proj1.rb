def bubble_sort(arr)
  (arr.length - 1).times do |j| 
    (arr.length - j - 1).times { |i| arr[i], arr[i + 1] = arr[i + 1], arr[i] if arr[i] > arr[i + 1] }
  end
  arr
end

def bubble_sort_by(arr)
  (arr.length - 1).times do |j|
    (arr.length - j - 1).times { |i| arr[i], arr[i + 1] = arr[i + 1], arr[i] if yield(arr[i], arr[i + 1]) > 0 }
  end
  arr
end
