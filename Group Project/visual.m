function r=visual(bot,q)
    for i = 1:size(q(:,1))
        v(i,1)=q(i,1);
        v(i,2)=q(i,2)-pi/2;
        v(i,3)=-q(3); 
        v(i,4)=-q(4);
        v(i,5)=-q(5);
        v(i,6)=q(6);

    end
    
    for i = 1:size(v(:,1))
         bot.plot(v(i,:));
    end
end