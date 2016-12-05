clear all; close all; clc; % Tidy up before start

test_len = 10000; % Number of random samples to generate

%% Warning
% Note that fixed-point calculations have been donebased on the following
% fixed point scalings for the coefficient tables:
% Coeff1 = ufix(18,24)
% Coeff2 = ufix(18,20)
% Coeff3 = ufix(21,17)
% If different fixed point types are required, revist the calculations.

%% Initial values for intermediate Tausworthe registers
% Arbitrary starting values - need to match Verilog code for consistancy
s1 = dec2bin(uint64(1234),64);
s2 = dec2bin(uint64(5678),64);
s3 = dec2bin(uint64(9012),64);

%% Load or generate coefficients table
% Generation of the coefficient table takes a long time due to use of the
% Symbolic Math toolbox for accuracy so re-load pregenerated tables if
% possible.

if exist('fix_coeffs.mat','file')
    load fix_coeffs.mat;
else
    if exist('coeffs.mat','file')
        load coeffs.mat;
    else
        n_inner_windows = 4;
        n_outer_windows = 62;

        [ coeffs ] = coeff_calc_P2S_US(n_inner_windows, n_outer_windows);
        clc;
        savefile = 'coeffs.mat';
        save(savefile,'coeffs','n_inner_windows','n_outer_windows');
    end
    fix_coeffs = zeros(n_inner_windows*n_outer_windows,3);
    
    c1_frac_length = find_frac_length(coeffs(:,1),18);
    fix_coeffs(:,1) = (round(coeffs(:,1) * 2^c1_frac_length));
    
    c2_frac_length = find_frac_length(coeffs(:,2),18);
    fix_coeffs(:,2) = (round(coeffs(:,2) * 2^c2_frac_length));
    
    c3_frac_length = find_frac_length(coeffs(:,3),21);
    fix_coeffs(:,3) = (round(coeffs(:,3) * 2^17));
    
    savefile = 'fix_coeffs.mat';
    save(savefile,'coeffs','fix_coeffs','n_inner_windows','n_outer_windows',...
         'c1_frac_length','c2_frac_length','c3_frac_length');
end

%% Pre-declare variables for loop speed
lz_pos = zeros(test_len,1);
mult_input = zeros(test_len,1);
float_interpolator = zeros(test_len,1);
float_output = zeros(test_len,1);
sign = zeros(test_len,1);
addr = zeros(test_len,1);

mult1 = zeros(test_len,1);
sum1 = zeros(test_len,1);
sum1_t = zeros(test_len,1);
mult2 = zeros(test_len,1);
sum2 = zeros(test_len,1);
sum2_t = zeros(test_len,1);
fix_output = zeros(test_len,1);

urn = cell(test_len,1);

%% Run test
for i = 1:test_len
    
    [urn_b, new_s1, new_s2, new_s3] = urng(s1,s2,s3);
    urn{i} = urn_b;
    s1=new_s1;
    s2=new_s2;
    s3=new_s3;
    
    lz_pos(i) = lzd(urn_b);    
    mult_input(i) = mask_to_zero( urn_b, lz_pos(i) ); %sfix(16,15)
        
    offset = bin2dec( urn_b(62:63));
    addr(i) = (lz_pos(i)-1)*4 + offset + 1;
    
    %% Interpolator
    mult_in=mult_input(i)/2^15; 
        
    mult1(i) = round((mult_in * fix_coeffs(addr(i),1)/2^24) * 2^39); %sfix(35,39)
    
    sum1(i) = mult1(i) + fix_coeffs(addr(i),2)*2^19; %sfix(39,39)
    sum1_t(i) = floor(sum1(i) / 2^19); %Truncate to sfix(20,20)
    
    mult2(i) = round( (mult_in * sum1_t(i)/2^20) * 2^35); %sfix(36,35)
    
    sum2(i) = mult2(i) + fix_coeffs(addr(i),3) * 2^18; %sfix(41,35);
    sum2_t(i) = floor( sum2(i) / 2^24); % Truncate to sfix(16,11)
    
    % Also calculate a floating point interpolator result for reference
    float_interpolator(i) = (coeffs(addr(i),1)*mult_in^2 + coeffs(addr(i),2)*mult_in + coeffs(addr(i),3));
    
    if urn_b(64) == int2str(1)
        fix_output(i) = -sum2_t(i);
        float_output(i) = -float_interpolator(i);
        sign(i) = -1;
        
    else
        fix_output(i) = sum2_t(i);
        sign(i) = 1;
        float_output(i) = float_interpolator(i);
        
    end
end

save_fix_results;

%% Display results
figure;hist(float_output);title('Floating point interpolator reference histogram');
figure;normplot(float_output);title('Floating point interpolator reference normal plot');
disp('Floating point interpolator ref results:');
[H,P,KSSTAT,CV] = kstest(float_output);
disp(strcat('H:',int2str(H),', P:',num2str(P),', KS Stat:',num2str(KSSTAT),', CV:',num2str(CV)))

disp('Fixed point interpolator results:');
figure;hist(fix_output/2^11);title('Fixed point interpolator histogram');
figure;normplot(fix_output/2^11);title('Fixed point interpolator normal plot');
[H,P,KSSTAT,CV] = kstest(fix_output/2^11);
disp(strcat('H:',int2str(H),', P:',num2str(P),', KS Stat:',num2str(KSSTAT),', CV:',num2str(CV)))
