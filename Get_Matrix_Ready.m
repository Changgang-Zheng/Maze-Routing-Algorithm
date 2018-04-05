function [mitrix,Length_of_total]=Get_Matrix_Ready(migong)
    mitrix=cell(9,100000);%first is if it can go, second is the row,third is the column low,4th is the column high
    lengthmigong = length(migong);
    widemigong = numel(migong)/length(migong);
    l=1;
    h=1;
    mitrixn=1;%the n th place that our car can go
    while (h<=widemigong)%high,row
        l=1;
        while(l<=lengthmigong)%column
            if (migong(h,l)==1)
                count=0;%help us to get column high
                mitrix{1,mitrixn}=1;
                mitrix{2,mitrixn}=h;
                mitrix{3,mitrixn}=l;
                mitrix{5,mitrixn}=0;
                mitrix{6,mitrixn}=0;
                mitrix{7,mitrixn}=0;
                mitrix{8,mitrixn}=0;
                mitrix{9,mitrixn}=0;%0 refers to up //1 refers to down
                while(migong(h,l+count)==1)
                    count=count+1;
                end
                l=l+count;
                mitrix{4,mitrixn}=l-1;
                mitrixn=mitrixn+1;
            end
            l=l+1;
        end
        h=h+1;
    end
Length_of_total=mitrixn;
