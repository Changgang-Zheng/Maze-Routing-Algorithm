function [path]=Get_Inicial_Step(mitrix,Length_of_total,inhor,inver)
    path=cell(9,10000);%the nodes that we go through
    hp=1;
    step=1;
    while (hp<=Length_of_total)%all the struct i the mitrix cell
        if(inver==mitrix{2,hp})
           if(inhor>=mitrix{3,hp})
               if(inhor<=mitrix{4,hp})
                   path{1,step}=3;%第一步也算走过
                   path{2,step}=mitrix{2,hp};
                   path{3,step}=mitrix{3,hp};
                   path{4,step}=mitrix{4,hp};
                   path{5,step}=getbranchup(path,mitrix,step,Length_of_total);%function get branchup
                   path{6,step}=getbranch(path,mitrix,step,Length_of_total)-getbranchup(path,mitrix,step,Length_of_total);%function getbranch 
                   path{7,step}=getnewstepup(path,mitrix,step,Length_of_total);%find if there have new 1(step)around it
                   path{8,step}=getnewstep(path,mitrix,step,Length_of_total)-getnewstepup(path,mitrix,step,Length_of_total);
                   path{9,step}=0;
               end
           end
        end
        hp=hp+1;
    end

return