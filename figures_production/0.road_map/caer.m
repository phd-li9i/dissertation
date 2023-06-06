function c = caer(real_ranges, virtual_ranges)
  c = 0;
  for i = 1:size(real_ranges,2)
    c = c + abs(real_ranges(i) - virtual_ranges(i));
  end
end
