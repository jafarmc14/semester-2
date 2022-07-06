function q=invkin(bot,px,py,pz)
T=[1 0 0 px;0 1 0 py ; 0 0 1 pz; 0 0 0 1];
v=bot.ikine(T);
q=[v(1),v(2)+pi/2,-v(3), -v(4), -v(5), v(6)];
end
