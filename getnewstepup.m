%check how many new road a step have
function newstep=getnewstepup(path,mitrix,step,Length_of_total) 
    istep=0;
    total=1;
    while (total<=Length_of_total)%all the struct i the mitrix cell
        if(mitrix{1,total}==1)%if we can go
          if(mitrix{2,total}==path{2,step}-1)%if the column is higher than the last step
            if(mitrix{3,total}<=path{4,step})
                if(path{3,step}<=mitrix{4,total})
                   istep=istep+1;
                end
            end
          end
        end
        total=total+1;
    end
newstep=istep;