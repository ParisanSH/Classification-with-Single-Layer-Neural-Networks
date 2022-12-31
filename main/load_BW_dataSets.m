function[data, datan1, datan2] = load_BW_dataSets(Folder)
sub_fold = genpath(Folder);
l = sub_fold
fold_name = {};
while true
[each_fold, l] = strtok(l, ';');
if isempty(each_fold)
break;
end
fold_name = [fold_name each_fold];
end
data = cell(26,20);
datan1 = cell(26,20);datan2 = cell(26,20);
fold_num = 0;
for folder = 1 : length(fold_name)
current_ = fold_name{folder};
pattern = sprintf('%s/*.png', current_); 
base_file = dir(pattern);
imgnum = length(base_file);
if imgnum >= 1
fold_num = fold_num + 1;
    for fold = 1 : imgnum
		f_name = fullfile(current_, base_file(fold).name);
        img = imread(f_name);
        binaryimg = double(im2bw(img));
        binaryimg(binaryimg == 0) = -1;
        data{fold_num,fold} = binaryimg;
        binaryimg = double(im2bw(img));
        zero_pos = find(binaryimg==0);
        [num ~] = size(zero_pos);
        noise_num = round(num * 0.15);
        for i= 1:noise_num
            pos = randi(num);
            binaryimg(zero_pos(pos,1))= 1;
        end
        binaryimg(binaryimg == 0) = -1;
        datan1{fold_num,fold} = binaryimg;
        binaryimg = double(im2bw(img));
        zero_pos = find(binaryimg==0);
        [num ~] = size(zero_pos);
        noise_num = round(num * 0.25);
        for i= 1:noise_num
            pos = randi(num);
            binaryimg(zero_pos(pos,1))= 1;
        end
        binaryimg(binaryimg == 0) = -1;
        datan2{fold_num,fold} = binaryimg;
    end
end
end
end