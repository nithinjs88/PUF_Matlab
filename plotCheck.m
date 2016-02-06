num = 0;
array = zeros(10,5);
for i = 1:10
    for j = 1:5
        array(i,j) = num;
        num = num + 1;
    end
end
plot(transpose(array));