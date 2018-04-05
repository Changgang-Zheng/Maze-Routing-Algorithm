clear;
clc;
picture=imread('timg-2.jpeg');
migong=imbinarize(picture,0.5);% migong=im2bw(picture,0.5);
subplot(1,2,2),imshow(migong),title('迷宫图片')


sensitivity=2;
inhor=280;%inicial point
inver=270;%inicial point

edhor=328;%aiming point
edver=123;%aiming point


horizantal=0;%distance benween the horizantal wall;
vertical=0;%distance benween the vertical wall;

%horizantal=horizantald(inhor,inver);%return the horizantal distance
%vertical=verticald(inhor,inver);%return the vertical distance

%//////////////////////////////////////////////build the struct
lengthmigong = length(migong);
widemigong = numel(migong)/length(migong);

%/////////////////////////////preproess the image//加边
preh=1;
prel=1;
while (preh<=widemigong)%high,row
    prel=1;
    while(prel<=lengthmigong)%column
        if(preh>=widemigong-3||prel>=lengthmigong-3||preh<=3||prel<=3)
            migong(preh,prel)=0;
        end
        prel=prel+1;
    end
    preh=preh+1;
end

%/////////////////////////////
%{
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
%}

%//////////////////////////////////////////find the inicial step of the path

%{
hp=1;
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
%}
%////////////////////////////////////////decision-making tree

%{
k=0;
circle=100000000;%maximum step
ic=0;%counter
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
                                   fprintf('--step:%d',step);% a notation for the program running condition
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
                                fprintf('--step:%d',step);% a notation for the program running condition
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
                                    fprintf('--step:%d',step);% a notation for the program running condition
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
    fprintf('--total step:%d\n',k);% a notation for the program running condition
  
    %check
end
%}

[mitrix,Length_of_total]=Get_Matrix_Ready(migong);
[path]=Get_Inicial_Step(mitrix,Length_of_total,inhor,inver);
[path,step]=Get_Path(mitrix,path,Length_of_total,edhor,edver);
%[path,step]=Get_Nonsharp_Result(mitrix,path,step,Length_of_total,sensitivity);
%% // Process the path
%{
for i=2:(step-1)
    if path{2,i}>=path{2,i-1} && path{2,i}>=path{2,i+1}
        Length=floor((path{4,i-1}+path{4,i+1}-path{3,i-1}-path{3,i+11})/sensitivity);
        in=path{3,i}; 
        en=path{4,i};
        hi=path{2,i};
        j=1;
        while j<=Length
            k=1;
            while k<=Length_of_total
                if mitrix{2,k}==(hi+j)
                    mitrix(:,k)
                    
                    if in<=mitrix{4,k} && en>=mitrix{3,k}
                        in=mitrix{3,k};
                        en=mitrix{4,k};
                        path= [path(:,1:(i+j-1)) mitrix(:,k) path(:,(i+j):9999)];
                        step=step+1;
                        mitrix(:,k)
                    end
                end
                k=k+1;
            end
            j=j+1;
        end
    end
    if path{2,i}<=path{2,i-1} && path{2,i}<=path{2,i+1}
        Length=floor((path{4,i-1}+path{4,i+1}-path{3,i-1}-path{3,i+11})/sensitivity);
        in=path{3,i}; 
        en=path{4,i};
        hi=path{2,i};
        for j=1:Length
            k=1;
            while k<=Length_of_total
                if mitrix{2,k}==(hi-j)
                    mitrix(:,k)
                    
                    if in<=mitrix{4,k} && en>=mitrix{3,k}
                        in=mitrix{3,k};
                        en=mitrix{4,k};
                        path = [path(:,1:(i+j-1)) mitrix(:,k) path(:,(i+j):9999)];
                        step=step+1;
                        mitrix(:,k)
                    end
                end
                k=k+1;
            end
        end
    end
end
%}
%%
%/////////////////////prepare the migong
fmigong=cell(widemigong,lengthmigong);
endi=1;
while(endi<=widemigong)
    endj=1;
    while(endj<=lengthmigong)
        fmigong{endi,endj}=migong(endi,endj);
        endj=endj+1;
    end
endi=endi+1;
end

%//////////////////joining the changed migong
mn=1;
while(mn<Length_of_total)
    if(mitrix{1,mn}==1||mitrix{1,mn}==3||mitrix{1,mn}==0)
        f=mitrix{3,mn};
        nf=mitrix{4,mn};
        while(f<=nf)
        fmigong{mitrix{2,mn},f}=mitrix{1,mn};
        f=f+1;
        end
        mn=mn+1;
    else
        mn=Length_of_total+1;
    end
end

%/////////////joining the steps
endstep=1;
while(endstep<=step)
    f=path{3,endstep};
    nf=path{4,endstep};
    while(f<=nf)
        % fmigong{path{2,endstep},f}=path{1,endstep};
        fmigong{path{2,endstep},f}=3;
        f=f+1;
    end
    endstep=endstep+1;
end

%////////////////////////////////////////display///drawpicture
drawh=widemigong;
drawz=lengthmigong;
x=zeros(drawh,1);
y=zeros(drawz,1);
for i=1:drawh
    x(i)=-4.0+i*8.0/drawh;
end
for j=1:drawz
    y(j)=-4.0+8.0*j/drawz;
end

z=zeros(drawh,drawz);

for i=1:drawh
    for j=1:drawz
        tempx=x(i);
        tempy=y(j);
        z(i,j)=fmigong{i,j};
    end
end
surf(z,'EdgeColor','None');
shading interp;

%//////////////////////end

%% // prepare the migong which only have the raw path
Raw=zeros(lengthmigong,widemigong);
endstep=1;
while(endstep<=step)
    f=path{3,endstep};
    nf=path{4,endstep};
    while(f<=nf)
        Raw(path{2,endstep},f)=1;
        f=f+1;
    end
    endstep=endstep+1;
end
surf(Raw','EdgeColor','None');
shading interp;
%%

inhor=270;%inicial point
inver=280;%inicial point

edhor=123;%aiming point
edver=328;%aiming point

%% // re-go throught the migong
[mitrix,Length_of_total]=Get_Matrix_Ready(Raw');
[path]=Get_Inicial_Step(mitrix,Length_of_total,inhor,inver);
[path,step]=Get_Path(mitrix,path,Length_of_total,edhor,edver);
[path,step]=Get_Nonsharp_Result(mitrix,path,step,Length_of_total,sensitivity);
%%

%% // re-paint
migong=migong';
%/////////////////////prepare the migong
fmigong=cell(lengthmigong,widemigong);
endi=1;
while(endi<=lengthmigong)
    endj=1;
    while(endj<=widemigong)
        fmigong{endi,endj}=migong(endi,endj);
        endj=endj+1;
    end
endi=endi+1;
end


%/////////////joining the steps
endstep=1;
while(endstep<=step)
    f=path{3,endstep};
    nf=path{4,endstep};
    while(f<=nf)
        fmigong{path{2,endstep},f}=3;
        %fmigong{path{2,endstep},f}=path{1,endstep};
        f=f+1;
    end
    endstep=endstep+1;
end

%////////////////////////////////////////display///drawpicture
drawh=lengthmigong;
drawz=widemigong;
x=zeros(drawh,1);
y=zeros(drawz,1);
for i=1:drawh
    x(i)=-4.0+i*8.0/drawh;
end
for j=1:drawz
    y(j)=-4.0+8.0*j/drawz;
end

z=zeros(drawh,drawz);

for i=1:drawh
    for j=1:drawz
        tempx=x(i);
        tempy=y(j);
        z(i,j)=fmigong{i,j};
    end
end
surf(z','EdgeColor','None');
shading interp;

%//////////////////////end

