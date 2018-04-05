function vertical=verticald(inhor,inver) 
    picture=imread('u=3068178735,1547418431&fm=200&gp=0.jpg');
    migong=im2bw(picture,0.5);
    
    j=0;%count the number while chenking the vertical side
    jhor=inhor;%count the number while checking the horizantal side
    jver=inver;%count the number while chenking the vertical side
    verup=0;%the upper distance from point to the wall
    verbelow=0;%the below distance from point to the wall

    while(j<1)
        if (migong(inhor,jver)==1)
            jver=jver+1;
        end
        if (migong(inhor,jver)==0)
            verup=jver-inver-1;
            j=1;
        end
    end
    j=0;
    jhor=inhor;%count the number while checking the horizantal side
    jver=inver;%count the number while chenking the vertical sid
    while(j<1)
        if (migong(inhor,jver)==1)
            jver=jver-1;
        end
        if (migong(inhor,jver)==0)
            verblow=inver-jver-1;
            j=1;
        end
    end
    vertical=verblow+verup;
re=verblow+verup;
