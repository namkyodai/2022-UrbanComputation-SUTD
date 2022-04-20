% length constraint matrix generator transposer
AE1 = csvread('original_matrix.csv');
AE1t = transpose(AE1);
csvwrite('transposed_matrix.csv', AE1t);


