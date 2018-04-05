%check how many new road a step have
function branch=getbranch(path,mitrix,step,Length_of_total) 
    ibranch=0;
    total=1;
    while (total<=Length_of_total)%all the struct i the mitrix cell
        if(mitrix{1,total}~=0)%if we can go
          if(mitrix{2,total}==path{2,step}-1)%if the column is higher than the last step
            if(mitrix{3,total}<=path{4,step})
                if(path{3,step}<=mitrix{4,total})
                   ibranch=ibranch+1;
                end
            end
          end
          if(mitrix{2,total}==path{2,step}+1)%if the column is lower than the last step
            if(mitrix{3,total}<=path{4,step})
                if(path{3,step}<=mitrix{4,total})
                   ibranch=ibranch+1;
                end
            end
          end
        end
        total=total+1;
    end
branch=ibranch;
