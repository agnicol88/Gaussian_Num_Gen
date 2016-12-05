if ~exist('..\ref_results','dir')
    mkdir('..\ref_results');
end

%% URN Gen
file = '..\ref_results\urn_ref_results.txt';

fid = fopen(file,'wt');
for i = 1:length(urn)
    fprintf(fid,strcat(urn{i},'\n'));
end
fclose(fid);

%% Leading Zero Detector
file = '..\ref_results\lzd_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%02x\n',lz_pos);

fclose(fid);

%% Multiplier input
file = '..\ref_results\mult_input_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%04x\n',mult_input);

fclose(fid);

%% Multiplier 1 output
file = '..\ref_results\mult1_output_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%09x\n',mult1);

fclose(fid);

%% Sum 1 output
file = '..\ref_results\sum1_output_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%010x\n',sum1);

fclose(fid);

%% Multiplier 2 output
file = '..\ref_results\mult2_output_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%09x\n',mult2);

fclose(fid);

%% Sum 2 output
file = '..\ref_results\sum2_output_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%011x\n',sum2);

fclose(fid);

%% Output
file = '..\ref_results\output_ref_results.txt';

fid = fopen(file,'wt');

fprintf(fid,'%i\n',fix_output);

fclose(fid);
