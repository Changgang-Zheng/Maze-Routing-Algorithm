function [path,step]=Get_Path(mitrix,path,Length_of_total,edhor,edver)
    k=0;
    circle=100000000;%maximum step
    ic=0;%counter
    step=1;
    while (ic<=circle)%maximum step
        total=1;
        while (total<Length_of_total)%all the struct i the mitrix cell
            if(path{7,step}>0)
                    if(mitrix{1,total}~=0)
                        if(mitrix{2,total}==path{2,step}-1)%if the column is lower than the last step
                            if(mitrix{3,total}<=path{4,step})
                                if(path{3,step}<=mitrix{4,total})
                                       mitrix{1,total}=3;
                                       step=step+1;
                                       %fprintf('--step:%d',step);% a notation for the program running condition
                                       path{1,step}=mitrix{1,total};
                                       path{2,step}=mitrix{2,total};
                                       path{3,step}=mitrix{3,total};
                                       path{4,step}=mitrix{4,total};
                                       path{5,step}=getbranchup(path,mitrix,step,Length_of_total);%function get branchup
                                       path{6,step}=getbranch(path,mitrix,step,Length_of_total)-getbranchup(path,mitrix,step,Length_of_total);%function getbranch 
                                       path{7,step}=getnewstepup(path,mitrix,step,Length_of_total);%find if there have new 1(step)around it
                                       path{8,step}=getnewstep(path,mitrix,step,Length_of_total)-getnewstepup(path,mitrix,step,Length_of_total);
                                       path{9,step}=0;
                                       total=Length_of_total;
                                end
                            end
                        end
                    end
            elseif(path{8,step}>0)%lower walkable//upper unwalkable
                if(mitrix{1,total}==1)
                     if(mitrix{2,total}==path{2,step}+1)%if the column is lower than the last step
                         if(mitrix{3,total}<=path{4,step})
                               if(path{3,step}<=mitrix{4,total})
                                    mitrix{1,total}=3;
                                    step=step+1;
                                    %fprintf('--step:%d',step);% a notation for the program running condition
                                    path{1,step}=mitrix{1,total};
                                    path{2,step}=mitrix{2,total};
                                    path{3,step}=mitrix{3,total};
                                    path{4,step}=mitrix{4,total};
                                    path{5,step}=getbranchup(path,mitrix,step,Length_of_total);%function get branchup
                                    path{6,step}=getbranch(path,mitrix,step,Length_of_total)-getbranchup(path,mitrix,step,Length_of_total);%function getbranch 
                                    path{7,step}=getnewstepup(path,mitrix,step,Length_of_total);%find if there have new 1(step)around it
                                    path{8,step}=getnewstep(path,mitrix,step,Length_of_total)-getnewstepup(path,mitrix,step,Length_of_total);
                                    path{9,step}=0;
                                    total=Length_of_total;
                               end
                        end
                     end
                end
            elseif(path{8,step}==0&&path{7,step}==0)
                    if(mitrix{2,total}==path{2,step})%if the column is lower than the last step
                             if(mitrix{3,total}<=path{4,step})
                                   if(path{3,step}<=mitrix{4,total})
                                        step=step-1;
                                        if(step==0)
                                            total=Length_of_total;
                                            ic=100000000000000000;
                                            step=step+1;
                                        end
                                        %fprintf('--step:%d',step);% a notation for the program running condition
                                        mitrix{1,total}=0;
                                        path{5,step}=getbranchup(path,mitrix,step,Length_of_total);%function get branchup
                                        path{6,step}=getbranch(path,mitrix,step,Length_of_total)-getbranchup(path,mitrix,step,Length_of_total);%function getbranch
                                        path{7,step}=getnewstepup(path,mitrix,step,Length_of_total);%find if there have new 1(step)around it
                                        path{8,step}=getnewstep(path,mitrix,step,Length_of_total)-getnewstepup(path,mitrix,step,Length_of_total);
                                        path{9,step}=5;
                                        total=Length_of_total;
                                   end
                             end
                    end
            end
        total=total+1;
        end


        ep=1;%check if at the end point
        %while (ep<=Length_of_total)%all the struct i the mitrix cell
        if(edver==path{2,step})
           if(edhor>=path{3,step})
               if(edhor<=path{4,step})
                  ic=circle+1;
               end
           end
        end
        ep=ep+1;
        %end

        ic=ic+1;
        %check

        k=k+1;
        %fprintf('--total step:%d\n',k);% a notation for the program running condition

        %check
    end
return
