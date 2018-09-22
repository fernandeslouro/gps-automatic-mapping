function [latdeg,longdeg] = tratazerointervalos( dados_recetor )
%Funcao que tira os pontos que são erros de medicao do gps

%%eliminar os pontos que estão na origem
a=1;
for(i=1:length(dados_recetor))
    for(j=1:length(dados_recetor(1,:)))
        if(dados_recetor(i,j)~=0)
            dados_recetor1(a,1)=dados_recetor(i,1);
            dados_recetor1(a,2)=dados_recetor(i,2);
            dados_recetor1(a,3)=dados_recetor(i,3);
            a=a+1;
        end
    end
end
            
latdeg=dados_recetor1(:,1);
longdeg=dados_recetor1(:,2);
alt=dados_recetor1(:,3);
end
%{
%% converter as coordenadas de graus para XYZ
for(i=1:length(dados_recetor1(:,1)))
latrad(i,:) = deg2rad(latdeg(i,:));
longrad(i,:) = deg2rad(longdeg(i,:));
[X(i,:),Y(i,:),Z(i,:)]=RadparaXYZWGS84( latrad(i,:),longrad(i,:),alt(i,:));
end

%% retirar pontos que são erros de localização
X1=X;
Y1=Y;
Z1=Z;
for(i=1:size(X)-1)
if(abs(X(i+1,:)-X(i,:))>5||abs(Y(i+1,:)-Y(i,:))>5||abs(Z(i+1,:)-Z(i,:))>5)
    
    X1(i,:)=[];
    Y1(i,:)=[];
    Z1(i,:)=[];
    
end
end
   %}



