function [q, t_b, t_f]=lspbt(q_start,q_final,max_speed,max_acceleration,num)
    dim1 = size(q_start);
    q = ones(num,dim1(2));
    for k=1:dim1(2)
        if q_final(k)-q_start(k)<0
            max_speed(k)=-1*max_speed(k);
            max_acceleration(k)=-1*max_acceleration(k);
        end
    end
    for j= 1:dim1(2)
        t_b(j) = max_speed(j)/max_acceleration(j);
        t_f(j)=((q_final(j)-q_start(j))/max_speed(j))+(max_speed(j)/max_acceleration(j));
        disp(abs(q_final(j)-q_start(j)))
        if abs(q_final(j)-q_start(j))<10^(-14)
            disp('Check')
            if(t_f(j) < 2*t_b(j)) 
                error("LSPB Trajectory is not feasible! Please update!");
            end
        end
    end

    M=max(t_f);
    for i=1:dim1(2)
        t_f(i)=M;
        max_speed(i)=(max_acceleration(i)*M + sqrt((max_acceleration(i)*M)^2 -4*max_acceleration(i)*(q_final(i)-q_start(i))))/2;
    end

    for k = 1:dim1(2)     
       for i = 1:floor(num*t_b(k)/t_f(k))
            q(i,k) = q_start(k)+(max_acceleration(k)/2)*((i*t_f(k)/num)^2);
            %fprintf("%d", i);
       end
        
       for i = floor(num*t_b(k)/t_f(k)):floor(num*(t_f(k)-t_b(k))/t_f(k))
            q(i,k) = q_start(k)+(max_speed(k)*t_b(k)/2)+ (max_speed(k)*((i*t_f(k)/num)-(t_b(k))));
            %%fprintf("%d", i)
       end

       for i=floor(num*(t_f(k)-t_b(k))/t_f(k)):floor(num)
            q(i,k) = q_final(k)-(max_acceleration(k)/2)*(i*t_f(k)/num-t_f(k))^2;
            %fprintf("%d", i)
            %disp(q(i))
       end 
    end

    disp(q);
    disp(t_b);
    disp(t_f);
   end