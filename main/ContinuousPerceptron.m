clc;
clear all;
close all;
workspace; 
format longg;
format compact;
%% read data
start_path = fullfile(matlabroot, '\toolbox');
if ~exist(start_path, 'dir')
	start_path = matlabroot;
end
uiwait(msgbox('Pick a starting folder on the next window that will come up.'));
english_alphabet_folder = uigetdir(start_path);
if english_alphabet_folder == 0
	return;
end
[dsets, noisy15, noisy25] = load_BW_dataSets(english_alphabet_folder);
[x,y] = size(dsets);
dataVec = zeros(3600,x*y);
noisy15_vec = zeros(3600,x*y);
noisy25_vec = zeros(3600,x*y);
for i = 1:x
    for j = 1:y
        v_sets = reshape(dsets{i,j}, 3600,1);
        v_n15 = reshape(noisy15{i,j}, 3600,1);
        v_n25 = reshape(noisy25{i,j}, 3600,1);
        dataVec(:,(i-1)*y +j) = v_sets(:)';
        noisy15_vec(:,(i-1)*y +j) = v_n15(:)';
        noisy25_vec(:,(i-1)*y +j) = v_n25(:)';
    end
end
targets = zeros(26,520);
for i= 0:25
    for j= 1:20
       targets(i+1, i*20 +j)= 1; 
    end
end
%% continuous perceptron network
net = newp(dataVec,targets,'logsig'); % use sigmoid function
net.trainParam.epochs = 60;
accuracy_train = 0; accuracy_test = 0;
for LOOCV=1:520
    tr = dataVec;
    ts = tr(:,LOOCV);
    tr(:,LOOCV)=[];
    Tr_all = targets;
    teTr = Tr_all(:,LOOCV);
    Tr_all(:,LOOCV) = [];
    net = newp(dataVec,targets,'logsig'); 
    net.trainParam.epochs = 40;
    net = train(net,tr,Tr_all);
    train_out = sim(net,tr);
    test_out = sim(net,ts);
    if test_out == teTr
        accuracy_test = accuracy_test + 1;
    end
    true = 0;
    for i=1:length(Tr_all(1,:))
        if train_out(:,i) == Tr_all(:,i)
            true = true+1;
        end
    end
    accuracy_train = accuracy_train + true/length(Tr_all(1,:));   
end
accuracy_test = accuracy_test/520; accuracy_train = accuracy_train/520;
net = newp(dataVec,targets,'logsig');
net.trainParam.epochs = 100;
net = train(net,dataVec,targets);
Y = sim(net,dataVec);
netResult_noise1 = sim(net,noisy15_vec);
netResult_noise2 = sim(net,noisy25_vec);
accuracy_n15 = 0; accuracy_n25 = 0;
for i=1:length(targets(1,:))
    if netResult_noise1(:,i) == targets(:,i)
       accuracy_n15 = accuracy_n15 +1;
    end
    if netResult_noise2(:,i) == targets(:,i)
       true_n2 = true_n2 +1;
    end
end
accuracy_noisy15 = accuracy_n15/length(targets(1,:));
accuracy_noisy25 = true_n2/length(targets(1,:));
msg = sprintf(['Results of continuous perceptron network:\n\n',...
               'train accuracy = %.4g\n',...
               'test accuracy = %.4f\n',...
               'accuracy with 15percent noise = %.4f\n',...
               'accuracy with 25percent noise = %.4f\n'],...
               accuracy_train,accuracy_test,accuracy_noisy15,accuracy_noisy25);
msgbox(msg,'Output Params');
