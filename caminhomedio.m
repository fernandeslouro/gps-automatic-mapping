function [media,confianca, dtotal]=caminhomedio(cam1,conf1,cam2,conf2, ponderacao)
%CAMINHOMEDIO Calcula caminhos médios e confiança nos caminhos
%   Esta função aplica o algoritmo Dynamic Time Warping para calcular o
%   caminho médio entre 2 caminhos. A matriz de distâncias não é de facto
%   calculada, mas apenas as partes necessárias para encontrar o "caminho"
%   de menor distância. É também calculada uma estimativa da confiança que
%   podemos ter em cada ponto do caminho médio. Esta confiança é calculada,
%   quando já estamos a fazer "médias de médias", das confianças de
%   caminhos anteriores

%Vamos trabalhar apenas com latitudes e longitudes, dado que isto permite
%uma aceleração dos cálculos, e os dados de altitude não são necessários,
%dado que podemos, ao visualizar os dados no Google Garth, "fixar" os dados
%à altitude do chão
cam1(:,3)=[]; cam2(:,3)=[];
%% Encontrar o caminho pela matriz

%O vetor caminho é o vetor onde vão ficar as posições por onde o "caminho
%de menor distância" passa na matriz de distâncias
caminho(1,:)=[1 1];
i=1; j=1; a=2; %contadores

while i<(length(cam1)-1) && j<(length(cam2)-1) %enquanto não chegar ao fim da matriz
    %vai-se calcular a distância dos pontos à direita, abaixo e na
    %diagonal, partindo do canto superior esquerdo. As distâncias
    %calculadas não são euclideanas, mas sim entre coordenadas, que têm uma
    %fórmula mais complexa
  
    direita=distance(cam1(i,:),cam2(j+1,:));
    diagonal=distance(cam1(i+1,:),cam2(j+1,:));
    baixo=distance(cam1(i+1,:),cam2(j,:));
  
   
    %se a distância menor das 3 for à direita, ir para a direita
if direita<diagonal && direita<baixo 
    caminho(a,:)=[i,j+1];
    j=j+1;
    a=a+1; 
    continue
end
    %se a distância menor das 3 for na diagonal, ir para a diagonal
if diagonal<direita && diagonal<baixo 
    caminho(a,:)=[i+1,j+1];
    i=i+1;
    j=j+1;
    a=a+1;
    continue
end
    %se a distância menor das 3 for abaixo, ir para baixo
if baixo<diagonal && baixo<direita 
    caminho(a,:)=[i+1,j];
    i=i+1;
    a=a+1;
    continue
end
%Por vezes, por razão ainda desconhecida, o ciclo ficava preso. Para
%resolver isto temos a condição de que, não sendo nenhuma escolhida, iremos
%avançar na diagonal
 caminho(a,:)=[i+1,j+1];
 i=i+1;
 j=j+1;
 a=a+1;  
end

%% Calcular o caminho médio e a confiança no caminho

media=zeros(length(caminho),2);
dtotal=0;
for i=1:length(caminho)
    %Os pontos do caminho médio estão a meio da linha que une pontos
    %"correspondentes" dos dois caminhos. Tem-se em conta que alguns
    %caminhos são menos "importantes", por isso faz-se uma ponderação
    media(i,1)=(cam1(caminho(i,1),1)+ponderacao*cam2(caminho(i,2),1))/(1+ponderacao);
    media(i,2)=(cam1(caminho(i,1),2)+ponderacao*cam2(caminho(i,2),2))/(1+ponderacao);
    
    if i>1
    dist=distance(media(i,1), media(i,2), media(i-1,1), media(i-1,2),'degrees' );
    dtotal=dtotal+deg2km(dist, 'earth');
    end
    %Isto é o calculador de confiança do trajeto. Se estivermos a tirar a
    %média de dois trajetos GPS (não são fornecidos valores de confiança 
    %dos caminhos, logo conf1==0 (e conf2==0), o valor de confiança de um ponto é
    %inversamente proprorcional à distância dos dois pontos de onde a média
    %foi tirada. No caso de estarmos a fazer uma "média de caminhos
    %médios", são também fornecidos à função um indicador das distancias
    %entre os pontos de onde as médias foram tiradas. Nesse caso, faz-se,
    %para cada ponto, uma média dos valores de distância de cada ponto
    if conf1==0
        confianca(i)=distance(cam1(caminho(i,1),1), cam1(caminho(i,1),2), cam2(caminho(i,2),1), cam2(caminho(i,2),2) );
    else
        confianca(i)=(conf1(caminho(i,1))+conf2(caminho(i,2)))/2;
    end
end
confianca=confianca';
media(:,3)=[0]; media(:,3)=[0];
