function [ coeffs ] = coeff_calc_P2S_US(n_inner_windows, n_outer_windows)
% Calculate inverse cumulative distribution function approximation
% coefficients for hierarchical power-of-2 / uniform segmentation.
% Note: this function requires a Symbolic Math toolbox licence due to the
% high precision required in the upper bins. Also note that the run time
% for this function can be several hours.

coeffs=zeros(n_inner_windows*n_outer_windows,3);

inc = sym(0.25);
outer_range_start_d = sym(0.5);
outer_range_end_d = outer_range_start_d + inc;

disp('Starting coeff calculation');

for i = 1:n_outer_windows
        
    outer_range_d = (0:(n_inner_windows*2^15-1))*(outer_range_end_d-outer_range_start_d)+outer_range_start_d*n_inner_windows*2^15;  
    
    disp(strcat('Outer bin num:',int2str(i)));
    for j = 1:n_inner_windows
        disp(strcat('Inner bin num:',int2str(j)));
       
       inner_range = outer_range_d(((j-1)*2^15+1):(j*2^15))/(n_inner_windows*2^15);

       partial_icdf = sqrt(2)*erfinv(2*(inner_range) - 1);
       disp('ICDF calculated...');drawnow;
       
       orig_digits = digits(64);
       high_prec_icdf = double(partial_icdf);
       digits(orig_digits);
       disp('ICDF converted to double...');drawnow;
       
       n_coeffs = polyfit(((0:(2^15-1))/2^15),high_prec_icdf,2);
       disp('Polyfit complete...');drawnow;
       
       coeffs(((i-1)*4+j),:) = n_coeffs;       

    end
            
    outer_range_start_d =  outer_range_end_d;% + 2^-(i+14);
    inc = inc/2;
    outer_range_end_d = outer_range_end_d + inc;

end

