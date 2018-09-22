function [ cam ] = trataangulos( cam , angulomin)
%TRATAANGULOS elimina os pontos que têm um angulo maior que o angulo minimo
%entre eles.
%Esta função elimina os pontos angulosos do caminho, que normalmente são
%associados a erros de medição do gps quando estamos parados ou por causa
%de obstáculos no sinal. 
for i=2:(length(cam)-1)
%cálculo de dois vetores entre tres pontos consecutivos para calcular o angulo entre eles
vettras=[(cam(i-1,1)-cam(i,1)) (cam(i-1,2)-cam(i,2)) ];
vetfrente=[(cam(i+1,1)-cam(i,1)) (cam(i+1,2)-cam(i,2)) ];
%calculo do angulo entre os vetores
angulos(i)=( acos(min(1,max(-1, vettras(:).' * vetfrente(:) / norm(vettras) / norm(vetfrente) ))))*180/pi;
end


a=1;
for i=1:length(angulos)
    %comparação e remoção dos pontos com angulos inferiores ao angulo
    %minimo
    if angulos(i)<angulomin
    remover(a)=i;
    a=a+1;
    end
end


cam(remover,:)=[];
%{
b=cam;
a=1;
for(i=1:length(b))
    for(j=1:length(b(1,:)))
        if(b(i,j)~=0)
            cam(a,1)=b(i,1);
            cam(a,2)=b(i,2);
            cam(a,3)=b(i,3);
            a=a+1;
        end
    end
end
  %}          