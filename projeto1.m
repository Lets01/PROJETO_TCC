clear

%Abrir imagem
IMG = imread('./IMAGENS/png/in04.png');

%Valores dos pixels da imagem atribuídos à matriz IMG1
IMG1=IMG(:,:,1);

%variavel que guarda o valor aproximado da distancia entre as linhas na imagem analisada
Dist_linha=67*2; 

%variavel que guarda a quantidade de pixels a serem copiados para a nova matriz de um dos lados do ponto
M = Dist_linha*0.45; 

%quantidade total de pxels copiados para a columa/linha da nova matriz;
Col_result = M*2; %

%Tamanho da imagem considerando apenas o aspectro R
[Lin, Col]=size(IMG1);

%Percorrer todos os pixels da imagem origem
% for i=1:Lin
% 	for j=1:Col
%             %Cálculo da coordenada (X,Y) da imagem origem
%             x=i;
%             y=j;
%             %Atribuir valores
%                 %IM_out1(cordx,cordy)=IM_in(cordx,cordy)
%                 
% 	end
% end

%verifica apenas onde a cor vermelha esta, dessa forma exclui todo o resto;
linha = IMG(:,:,1) == 255;
%imshow(linha);

%Função que identifica objetos em uma imagem em preto e branco;
%Retorna duas variaveis:
%B --> representa o contorno dos objetos;
%L --> matriz de indices, em que cada elemento da matriz é um inteiro,
%indicando de qual objeto da matriz esse elemento faz parte;
%'noholes' procura apenas pelos limites do objetos
[B,A] = bwboundaries(linha, 'noholes');

%Contando as linhas da imagem:
%Função regionprops, calcula a area dos linhas;
cont = regionprops(A, 'Area');

%qtd_linhas retorna quantas linhas a imagem possui, desconsiderando onjetos
%muito pequenos.
qtd_linha = sum([cont.Area] > 10);

%calcula o mapa de pixels mais próximos na forma de uma matriz de índices 
%idx. Cada elemento de idx contém o índice linear do pixel diferente de 
%zero mais próximo A.
[D,IDX] = bwdist(A);

%Mostra a imagem original, editada conforme a função abaixo:
imshow(IMG);
%Informa a quantidade de linhas
title(sprintf('\\fontsize{10}{Existem %d linhas nessa imagem}', qtd_linha));

%Permite adicionar formas e estilo sobre a imagem
hold on
%percorre o contorno dos objetos 
for k = 1:length(B)
    %area = Número real de pixels na região.
    area = cont(k).Area;
    
    %filtra objetos pequenos
    if area > 10
        fronteira = B{k};%contorno do objeto;
        %mostra o contorno da linha em preto;
        plot(fronteira(:,2), fronteira(:,1), 'black', 'LineWidth', 1);
        %mostra o texto correspondente a area estilizado;
        text(fronteira(1,2), fronteira(1,1), sprintf('%.0f',area),...
            'Color', 'white',...
            'FontSize', 8,...
            'FontWeight', 'bold',...
            'BackgroundColor', 'black');
        
    end
end
hold off


