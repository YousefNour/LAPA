%Yousef Nour
%Elec 4700 - Lab3 - Monte Carlo PA Assignment
close all
clear all
clc

set(0,'DefaultFigureWindowStyle', 'docked')
set(0,'defaultaxesfontsize', 20)
set(0, 'defaultaxesfontname', 'Times New Roman')
set(0,'DefaultLineLineWidth', 2);

%Matirx dimensions
nx = 20;
ny = 20;
% delta x & Y
xDel = 1;
yDel = xDel;
%Max number of iterations
ni = 300;
%intial matrix of zeros 
newVMat = zeros(nx,ny);
oldVMat = zeros(nx,ny);% to update previous matrix
%matrix of vectors
V = zeros(ny,nx);

[X,Y] = meshgrid(1:xDel:nx,1:yDel:ny);

for k = 1:ni
    for i = 1:nx %loop in columns 
        for j = 1:ny %loop in rows
            %left boundary
            if(i == 1) 
                newVMat(:,i) = i;
            %right boundary
            elseif(i == nx)
                newVMat(j,i) = i;
            %top boundary
            elseif(j == 1) 
                newVMat(:,i) = 0;
            %bottom boundary
            elseif(j == ny) 
                newVMat(j,i) = 0;
             else
                 newVMat(j,i) = (oldVMat(j,i+1) + oldVMat(j,i-1) + oldVMat(j+1,i) + oldVMat(j-1,i))/4 *xDel;
             end
        end
    end
    
    [XVec,YVec] = meshgrid(1:xDel:nx,1:yDel:ny);
    
    subplot(3,1,1);
    quiver(X, Y, -XVec, -YVec);
    title(['Iteration: ' num2str(k)]);
    
    subplot(3,1,2);
    surf(X, Y, newVMat);
    
    %drift calculation
    subplot (3,1,3);
    hold on;
    plot([k-1, k],[mean(mean(oldVMat)),mean(mean(newVMat))], 'b');
    ylim ([0,1]);
    title('drift velocity');
    hold off;
    
    oldVMat = newVMat;
    
    pause(0.05);
end 