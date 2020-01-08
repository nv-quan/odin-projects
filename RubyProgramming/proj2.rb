def stock_picker(arr)
  if arr.empty?
    return []
  else
    min = arr[0]
    idxs_buy = []
    profits = arr.map do |x|
      min = [min, x].min
      idxs_buy.push(arr.index(min))
      x - min
    end
    idx_sell = profits.each_with_index.max[1]
    [idxs_buy[idx_sell], idx_sell]
  end
end

