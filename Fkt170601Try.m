function [ VectorPointKind ] = Fkt170601Try( TimeIntervall, NumberKindPackets, Lambda)
%310517TRY Creates a Timeline with different kinds of Packets and their poisson distributed time of arrival
%INPUT:
%@TimeIntervall     array[T1,T2,...,Tn] of time intervalls for Packets to arrive while 0<T1<T2<...<Tn
%@NumberKindPackets Int is the number of how manny different Packets can arrive
%@Lambda            array[L1,L2,...,Ln] the different Lambdas for the time intervalls

%Creates the (poisson distributed) number of packets arriving at each time intervall
i = 1;
while (i<=length(TimeIntervall))
    RNoP(i) = poissrnd(Lambda(i)); %poisson random number of each time intervall
    i=i+1;
end
TimeIntervallAndNumber = [TimeIntervall;RNoP];%saved the number and the time connected

%plot(TimeIntervall, RNoP);

i=1;
j=1;
%The packets are connected to a specific time and the type of packet is choosen
%The first time intervall is seperate because of T0
while(j<=RNoP(i))
    Timeline(1,j)= rand(1).*(TimeIntervall(i));
    Rndline(1,j)= randi([1,NumberKindPackets]); %Type of a specific packet is choosen
    j=j+1;
end
j=1;
while (i<length(TimeIntervall))
    i=i+1;
    while(j<=RNoP(i))
        %The length of the time intervall is (TimeIntervall(j)-TimeIntervall(j-1))
        %It is set in a relative uniformly random distributed Position in the 
        %time intervall with a random number(rand(1))
        %In the end the relative worth is added to the last time intervall
        Timeline(i,j)= TimeIntervall(i-1)+rand(1).*(TimeIntervall(i)-TimeIntervall(i-1));
        Rndline(i,j)= randi([1,NumberKindPackets]); %Type of a specific packet is choosen
        j=j+1;
    end
    j=1;
end
[senk,waag]=size(Timeline);%Dim of Timeline = Dim of Randline
sw=senk.*waag;%Number of Inputs from the Matrix
TL=reshape(Timeline,1,sw);
RL=reshape(Rndline,1,sw);

scatter(TL, RL);

VectorPointKind = [TL,RL];
end