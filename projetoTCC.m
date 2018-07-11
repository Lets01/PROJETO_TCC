clear
clc

IMG = imread('IMG_R/in19_cut2.png');

linha = (IMG(:,:,1) == 255);
linha2 = bwmorph(linha,'skel',Inf);
[B,A] = bwboundaries(linha2, 'noholes');

hold on
    for k = 1:length(B)       
       for s=1:length(B{k}(:,2)) 
           
            if (B{k}(s+1,2) < B{k}(s,2))
                break;
            end
           
           Var_X = B{k}(s+1,2)-B{k}(s,2); %variação x
           Var_Y = B{k}(s+1,1)-B{k}(s,1); %variacao y
           [A1] = (Var_Y)/(Var_X);
           [Xn] = [B{k}(s,2) B{k}(s+1,2)];
           [Yn] = [B{k}(s,1) B{k}(s+1,1)];          
           plot(Xn, Yn, 'b');
           Multi=1; % Multiplicador que controla a espessura
           
           if A1 ~= 0
               Alpha= atan(A1);
               P=sqrt(Var_Y.^2+Var_X.^2);
               
               if A1 < 0
                   LY=Multi*abs(P*sin(Alpha));
                   LX=Multi*abs(P*cos(Alpha));
               end
               
               if A1 > 0
                  LY=-Multi*abs(P*sin(Alpha));
                  LX=Multi*abs(P*cos(Alpha)); 
               end
               
               Xn2Atual= [B{k}(s,2)-LX B{k}(s,2)+LX];
               Yn2Atual= [B{k}(s,1)-LY B{k}(s,1)+LY];
               plot(Xn2Atual, Yn2Atual,'r')
           end
           
           if Var_Y == 0
               LX=0;
               LY=sqrt(P)*Multi;
               Xn3 = [B{k}(s,2) B{k}(s,2)];
               Yn3 =[B{k}(s,1)-LY B{k}(s,1)+LY];
               plot(Xn3, Yn3,'g');
           end
           
       end
    end
    spy(A);
hold off