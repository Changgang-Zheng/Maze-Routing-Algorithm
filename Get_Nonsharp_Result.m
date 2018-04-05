function [Path,Step]=Get_Nonsharp_Result(mitrix,path,step,Length_of_total,sensitivity)
    Path=path;
    Add=cell(9,1);
    Step=step;
    i=2;
    count=2;
    while i<=(step-1)
        count_sharp=0;
        count_double=0;
        if path{2,i}>=path{2,i-1} && path{2,i}>=path{2,i+1}
            Length=floor((path{4,i-1}+path{4,i+1}-path{3,i-1}-path{3,i+1})/sensitivity);
            in=path{3,i}; 
            en=path{4,i};
            hi=path{2,i};
            j=1;
            while j<=Length
                k=1;
                while k<=Length_of_total
                    if mitrix{2,k}==(hi+j)
                        if in<=mitrix{4,k} && en>=mitrix{3,k}
                            Add(:)=mitrix(:,k);
                            if in<=mitrix{4,k} && in>=mitrix{3,k}
                                Add{3}=in;
                            else
                                Add{3}=mitrix{3,k};
                            end
                            if en<=mitrix{4,k} && en>=mitrix{3,k}
                                Add{4}=en;
                            else
                                Add{4}=mitrix{4,k};
                            end
                            if j==Length
                                Path = [Path(:,1:(i+j-1)) Add(:) Path(:,(i+j):9999)];
                                %Path = [Path(:,1:(count+j)) Add(:) Path(:,(count+j):9999)];
                                %Path = [Path(:,1:(count+count_double+count_sharp)) Add(:) Add(:) Path(:,(count+count_double+count_sharp+1):9999)];
                                Step=Step+1;
                                count_sharp=count_sharp+1;
                                %i=i+1;
                            else
                                Path = [Path(:,1:(i+j-1)) Add(:) Add(:) Path(:,(i+j):9999)];
                                %Path = [Path(:,1:(count+count_double+count_sharp)) Add(:) Add(:) Path(:,(count+count_double+count_sharp):9999)];
                                Step=Step+2;
                                count_double=count_double+1;
                                %i=i+2;
                            end
                            in=Add{3};
                            en=Add{4};
                        end
                    end
                    k=k+1;
                end
                j=j+1;
            end
        end
        if path{2,i}<=path{2,i-1} && path{2,i}<=path{2,i+1}
            Length=floor((path{4,i-1}+path{4,i+1}-path{3,i-1}-path{3,i+1})/sensitivity);
            in=path{3,i};
            en=path{4,i};
            hi=path{2,i};
            j=1;
            while j<=Length
                k=1;
                while k<=Length_of_total
                    if mitrix{2,k}==(hi-j)
                        if in<=mitrix{4,k} && en>=mitrix{3,k}
                            Add(:)=mitrix(:,k);
                            if in<=mitrix{4,k} && in>=mitrix{3,k}
                                Add{3}=in;
                            else
                                Add{3}=mitrix{3,k};
                            end
                            if en<=mitrix{4,k} && en>=mitrix{3,k}
                                Add{4}=en;
                            else
                                Add{4}=mitrix{4,k};
                            end
                            if j==Length
                                Path = [Path(:,1:(i+j-1)) Add(:) Path(:,(i+j):9999)];
                                %Path = [Path(:,1:(count+count_double+count_sharp)) Add(:) Path(:,(count+count_double+count_sharp+1):9999)];
                                Step=Step+1;
                                count_sharp=count_sharp+1;
                                %i=i+1;
                            else
                                Path = [Path(:,1:(i+j-1)) Add(:) Add(:) Path(:,(i+j):9999)];
                                %Path = [Path(:,1:(count+count_double+count_sharp)) Add(:) Path(:,(count+count_double+count_sharp):9999)];
                                Step=Step+2;
                                count_double=count_double+1;
                                %i=i+2;
                            end
                            in=Add{3};
                            en=Add{4};
                        end
                    end
                    k=k+1;
                end
                j=j+1;
            end
        end
        i=i+1;
        count=count+count_sharp+2*count_double+1;
    end
return