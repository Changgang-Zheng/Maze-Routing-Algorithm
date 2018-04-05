%check how many new road a step have
function branchup=getbranchup(path,mitrix,step,Length_of_total) 
    ibranchup=0;
    total=1;
    while (total<=Length_of_total)%all the struct i the mitrix cell
        if(mitrix{1,total}~=0)%if we can go
          if(mitrix{2,total}==path{2,step}-1)%if the column is higher than the last step
            if(mitrix{3,total}<=path{4,step})
                if(path{3,step}<=mitrix{4,total})
                   ibranchup=ibranchup+1;
                end
            end
          end
        end
        total=total+1;
    end
branchup=ibranchup;
