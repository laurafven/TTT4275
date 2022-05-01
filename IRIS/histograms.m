clear all
close all
clc

%Load data
classes = 3;                    % Number of classes
features = 4;                   % Number of dimension
numBins = 8;                    % Number of bins in the histogram

class1 = load('class_1');
class2 = load('class_2');
class3 = load('class_3');
allClasses = [class1; class2; class3];

figure(1); hold on;
histogram(class1(:,1),numBins, 'FaceColor', '#A2142F')
histogram(class2(:,1),numBins, 'FaceColor', '#77AC30')
histogram(class3(:,1),numBins, 'FaceColor', '#EDB120')
xlabel("Sepal Length")
legend('Setesa','Versicolor','Verginica')

figure(2); hold on;
histogram(class1(:,2),numBins, 'FaceColor', '#A2142F')
histogram(class2(:,2),numBins, 'FaceColor', '#77AC30')
histogram(class3(:,2),numBins, 'FaceColor', '#EDB120')
xlabel("Sepal Width")
legend('Setesa','Versicolor','Verginica')

figure(3); hold on;
histogram(class1(:,3),numBins, 'FaceColor', '#A2142F')
histogram(class2(:,3),numBins, 'FaceColor', '#77AC30')
histogram(class3(:,3),numBins, 'FaceColor', '#EDB120')
xlabel("Petal Length")
legend('Setesa','Versicolor','Verginica')

figure(4); hold on;
histogram(class1(:,4),numBins, 'FaceColor', '#A2142F')
histogram(class2(:,4),numBins, 'FaceColor', '#77AC30')
histogram(class3(:,4),numBins, 'FaceColor', '#EDB120')
xlabel("Petal Width")
legend('Setesa','Versicolor','Verginica')
