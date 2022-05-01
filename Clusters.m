M = 64; % Number of clusters
numClasses = 10; % Numbers from 0-9

load("data_all.mat");

clusters = zeros(M*10,vec_size); % creating zero matrix for cluster templates dim: 640 x 784
clusterClass = zeros(M*10,1); % indicates what class the cluster belongs to dim: 640 x 1

tic % gives elapsed time
for i = 0:9
    train = trainv(trainlab == i,:);
    [~,C] = kmeans(train,M);  % using kmeans to partition the values of the matrix "train" into M clusters,
                                % and returning cluster indixes, C, of each value
    clusters(M*i+1:M*(i+1),:) = C;  % cluster matrix
    clusterClass(M*i+1:M*(i+1)) = i*ones(M,1); % cluster class matrix
    fprintf('%d - class finished\n',i);
end
toc

%save('clusters.mat', 'clusters', 'clusterClass');