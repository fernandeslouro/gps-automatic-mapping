function [media,confianca, dtotal]=caminhomedio(cam1,conf1,cam2,conf2, ponderacao)
%CAMINHOMEDIO Calcula caminhos m�dios e confian�a nos caminhos
%   Esta fun��o aplica o algoritmo Dynamic Time Warping para calcular o
%   caminho m�dio entre 2 caminhos. A matriz de dist�ncias n�o � de facto
%   calculada, mas apenas as partes necess�rias para encontrar o "caminho"
%   de menor dist�ncia. � tamb�m calculada uma estimativa da confian�a que
%   podemos ter em cada ponto do caminho m�dio. Esta confian�a � calculada,
%   quando j� estamos a fazer "m�dias de m�dias", das confian�as de
%   caminhos anteriores

%Vamos trabalhar apenas com latitudes e longitudes, dado que isto permite
%uma acelera��o dos c�lculos, e os dados de altitude n�o s�o necess�rios,
%dado que podemos, ao visualizar os dados no Google Garth, "fixar" os dados
%� altitude do ch�o
cam1(:,3)=[]; cam2(:,3)=[];
%% Encontrar o caminho pela matriz

%O vetor caminho � o vetor onde v�o ficar as posi��es por onde o "caminho
%de menor dist�ncia" passa na matriz de dist�ncias
caminho(1,:)=[1 1];
i=1; j=1; a=2; %contadores

while i<(length(cam1)-1) && j<(length(cam2)-1) %enquanto n�o chegar ao fim da matriz
    %vai-se calcular a dist�ncia dos pontos � direita, abaixo e na
    %diagonal, partindo do canto superior esquerdo. As dist�ncias
    %calculadas n�o s�o euclideanas, mas sim entre coordenadas, que t�m uma
    %f�rmula mais complexa
  
    direita=distance(cam1(i,:),cam2(j+1,:));
    diagonal=distance(cam1(i+1,:),cam2(j+1,:));
    baixo=distance(cam1(i+1,:),cam2(j,:));
  
   
    %se a dist�ncia menor das 3 for � direita, ir para a direita
if direita<diagonal && direita<baixo 
    caminho(a,:)=[i,j+1];
    j=j+1;
    a=a+1; 
    continue
end
    %se a dist�ncia menor das 3 for na diagonal, ir para a diagonal
if diagonal<direita && diagonal<baixo 
    caminho(a,:)=[i+1,j+1];
    i=i+1;
    j=j+1;
    a=a+1;
    continue
end
    %se a dist�ncia menor das 3 for abaixo, ir para baixo
if baixo<diagonal && baixo<direita 
    caminho(a,:)=[i+1,j];
    i=i+1;
    a=a+1;
    continue
end
%Por vezes, por raz�o ainda desconhecida, o ciclo ficava preso. Para
%resolver isto temos a condi��o de que, n�o sendo nenhuma escolhida, iremos
%avan�ar na diagonal
 caminho(a,:)=[i+1,j+1];
 i=i+1;
 j=j+1;
 a=a+1;  
end

%% Calcular o caminho m�dio e a confian�a no caminho

media=zeros(length(caminho),2);
dtotal=0;
for i=1:length(caminho)
    %Os pontos do caminho m�dio est�o a meio da linha que une pontos
    %"correspondentes" dos dois caminhos. Tem-se em conta que alguns
    %caminhos s�o menos "importantes", por isso faz-se uma pondera��o
    media(i,1)=(cam1(caminho(i,1),1)+ponderacao*cam2(caminho(i,2),1))/(1+ponderacao);
    media(i,2)=(cam1(caminho(i,1),2)+ponderacao*cam2(caminho(i,2),2))/(1+ponderacao);
    
    if i>1
    dist=distance(media(i,1), media(i,2), media(i-1,1), media(i-1,2),'degrees' );
    dtotal=dtotal+deg2km(dist, 'earth');
    end
    %Isto � o calculador de confian�a do trajeto. Se estivermos a tirar a
    %m�dia de dois trajetos GPS (n�o s�o fornecidos valores de confian�a 
    %dos caminhos, logo conf1==0 (e conf2==0), o valor de confian�a de um ponto �
    %inversamente proprorcional � dist�ncia dos dois pontos de onde a m�dia
    %foi tirada. No caso de estarmos a fazer uma "m�dia de caminhos
    %m�dios", s�o tamb�m fornecidos � fun��o um indicador das distancias
    %entre os pontos de onde as m�dias foram tiradas. Nesse caso, faz-se,
    %para cada ponto, uma m�dia dos valores de dist�ncia de cada ponto
    if conf1==0
        confianca(i)=distance(cam1(caminho(i,1),1), cam1(caminho(i,1),2), cam2(caminho(i,2),1), cam2(caminho(i,2),2) );
    else
        confianca(i)=(conf1(caminho(i,1))+conf2(caminho(i,2)))/2;
    end
end
confianca=confianca';
media(:,3)=[0]; media(:,3)=[0];
