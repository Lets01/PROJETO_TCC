clear

IMG = imread('in19_cut2.png');
% IMG = imread('in19_cut.png');

IMG1=IMG(:,:,1);

linha = (IMG(:,:,1) == 255);

%Função que identifica objetos em uma imagem em preto e branco;
%B --> representa o contorno dos objetos;
%A --> matriz de indices, em que cada elemento da matriz é um inteiro,
%indicando de qual objeto da matriz esse elemento faz parte;
%'noholes' procura apenas pelos limites do objetos
[B,A] = bwboundaries(linha, 'noholes');

hold on
    for k = 1:length(B)
       F = B{k};

       [X] = F(:,2);
       [Y] = F(:,1);

       %plot( X ,Y, 'b', 'LineWidth', 0.2);  
       %grid on;

       for s=1:length(X)  

           [P_ant.X(s)] = X(s);
           [P_ant.Y(s)] = Y(s);

           [P_prox.X(s)] = X(s+1);
           [P_prox.Y(s)] = Y(s+1);

           % Para quando voltar no contorno
            if (P_prox.X(s) < P_ant.X(s))
                break;
            end

           % Coeficiente angular 1
           A1 = (P_prox.Y(s) - P_ant.Y(s))/(P_prox.X(s) - P_ant.X(s));
           
           % Coeficiente linear 1
           B1 = ((P_ant.Y(s) - (A1*(P_ant.X(s)))));

           % Coordeanada anterior de X e a proxima coordenada de X
           Xn = [P_ant.X(s) P_prox.X(s)];
           
           % Equação da reta
           Yn = A1*(Xn)+B1;
           
           % Mostra as retas
           plot(Xn, Yn);
           
           %--------------------------------------------------
           % Tentativa para encontrr a reta ortogonal 
           %--------------------------------------------------
           
           %ponto médio...
           %[XM] = (P_prox.X(s) + P_ant.X(s))/2;
           %[YM] = (P_prox.Y(s) + P_ant.Y(s))/2;
           %PM = [XM YM];
           %Cord = [YM+5 YM-5];
           
           % Encontrando a função inversa
           A_inv = (-1/A1);
           
           % Coeficiente linear
           B2 = ((P_prox.Y(s)-(A_inv*(P_ant.X(s)))));

           % Equação da reta
           Yn2 = A_inv*(Xn)+B2;
           
           plot(Xn, Yn2);
           
           spy(A);% Mostra os pontos azuis
       end
    end
hold off

