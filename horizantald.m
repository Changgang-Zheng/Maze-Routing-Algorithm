function horizantal=horizantald(inhor,inver) 
    picture=imread('u=3068178735,1547418431&fm=200&gp=0.jpg');
    migong=im2bw(picture,0.5);
    i=0;%count the number while checking the horizantal side
    ihor=inhor;%count the number while checking the horizantal side
    iver=inver;%count the number while chenking the vertical sid
    horright=0;%the right distance from point to the wall
    horlefy=0;%the left distance from point to the wall

    while(i<1)
        if (migong(ihor,inver)==1)
            ihor=ihor+1;
        end
        if (migong(ihor,inver)==0)
            horright=ihor-inhor-1;
            i=1;
        end
    end
    i=0;
    ihor=inhor;%count the number while checking the horizantal side
    iver=inver;%count the number while chenking the vertical side
    while(i<1)
        if (migong(ihor,inver)==1)
            ihor=ihor-1;
        end
        if (migong(ihor,inver)==0)
            horleft=inhor-ihor-1;
            i=1;
        end
    end
    horizantal=horright+horleft;
re=horright+horleft;
