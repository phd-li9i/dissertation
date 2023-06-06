s1;
s2;

t = -3*pi/4:3*pi/2/(numel(s1)-1):3*pi/4;


for i=1:numel(s1)
  printf('    true_data[0,%d] = %f\n', i-1, s1(i)*cos(t(i)));
  printf('    true_data[1,%d] = %f\n', i-1, s1(i)*sin(t(i)));
end

for i=1:numel(s2)
  printf('    moved_data[0,%d] = %f\n', i-1, s2(i)*cos(t(i)));
  printf('    moved_data[1,%d] = %f\n', i-1, s2(i)*sin(t(i)));
end
