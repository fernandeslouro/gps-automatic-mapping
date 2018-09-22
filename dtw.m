clc; clear all; close all;
%% Pôr os pontos em matrizes, com a mesma orientação
%{
%Fornecer os ficheiros à função analisa_nmea_file, que vai retirar as
%coordenadas dos ficheiros NMEA, e pô-las numa matriz de coordenadas do
%tipo [latitude longitude altitude]
[cidade1]=analisa_nmea_file('cidade1.nmea');
[cidade2]=analisa_nmea_file('cidade2.nmea');
[cidade3]=analisa_nmea_file('cidade3.nmea');
[cidade4]=analisa_nmea_file('cidade4.nmea');
[cidade5]=analisa_nmea_file('cidade5.nmea');
[cidade6]=analisa_nmea_file('cidade6.nmea');
[cidade7]=analisa_nmea_file('cidade7.nmea');
[cidade8]=analisa_nmea_file('cidade8.nmea');
[cidade9]=analisa_nmea_file('cidade9.txt');
[cidade10]=analisa_nmea_file('cidade10.txt');
[cidade11]=analisa_nmea_file('cidade11.txt');

[estradao1]=analisa_nmea_file('estradao1.txt');
[estradao2]=analisa_nmea_file('estradao2.txt');
[estradao3]=analisa_nmea_file('estradao3.txt');
[estradao4]=analisa_nmea_file('estradao4.txt');

%Função ordem, que põe todos os vetores a seguir a mesma orientação do
%caminho (antes deste tratamento, os primeiros pontos de alguns dos caminhos
%correspondiam aos últimos de outros
cidade1=ordem(cidade1);
cidade2=ordem(cidade2);
cidade3=ordem(cidade3);
cidade4=ordem(cidade4);
cidade5=ordem(cidade5);
cidade6=ordem(cidade6);
cidade7=ordem(cidade7);
cidade8=ordem(cidade8);
cidade9=ordem(cidade9);
cidade10=ordem(cidade10);
cidade11=ordem(cidade11);


estradao1=ordem(estradao1);
estradao2=ordem(estradao2);
estradao3=ordem(estradao3);
estradao4=ordem(estradao4);


%%Plotagem dos precursos na cidade, antes da correção dos angulos e com os
precursos já ordenados

%{
plot(cidade1(:,1), cidade1(:,2),'r'); hold on;
plot(cidade2(:,1), cidade2(:,2),'r'); hold on;
plot(cidade3(:,1), cidade3(:,2),'r'); hold on;
plot(cidade4(:,1), cidade4(:,2),'r'); hold on;
plot(cidade5(:,1), cidade5(:,2),'r'); hold on;
plot(cidade6(:,1), cidade6(:,2),'r'); hold on;
plot(cidade7(:,1), cidade7(:,2),'r'); hold on;
plot(cidade8(:,1), cidade8(:,2),'r'); hold on;
plot(cidade9(:,1), cidade9(:,2),'r'); hold on;
plot(cidade10(:,1), cidade10(:,2),'r'); hold on;
plot(cidade11(:,1), cidade11(:,2),'r'); hold on;



%}
%% Tratamento de Dados
%Neste ciclo, aplica-se a função que remove os "pontos angulosos". Esta
%função é corrida 4 vezes para cada trajeto, pois notou-se que isto
%levava a bons resultados
for i=1:4
cidade1=trataangulos(cidade1, 90);
cidade2=trataangulos(cidade2, 90);
cidade3=trataangulos(cidade3, 90);
cidade4=trataangulos(cidade4, 90);
cidade5=trataangulos(cidade5, 90);
cidade6=trataangulos(cidade6, 90);
cidade7=trataangulos(cidade7, 90);
cidade8=trataangulos(cidade8, 90);
cidade9=trataangulos(cidade9, 90);
cidade10=trataangulos(cidade10, 90);
cidade11=trataangulos(cidade11, 90);

end 

%%%%Plotagem dos precursos na cidade, depois da correção dos angulos e com os
precursos já ordenados

plot(cidade1(:,1), cidade1(:,2),'g'); hold on;
plot(cidade2(:,1), cidade2(:,2),'g'); hold on;
plot(cidade3(:,1), cidade3(:,2),'g'); hold on;
plot(cidade4(:,1), cidade4(:,2),'g'); hold on;
plot(cidade5(:,1), cidade5(:,2),'g'); hold on;
plot(cidade6(:,1), cidade6(:,2),'g'); hold on;
plot(cidade7(:,1), cidade7(:,2),'g'); hold on;
plot(cidade8(:,1), cidade8(:,2),'g'); hold on;
plot(cidade9(:,1), cidade9(:,2),'g'); hold on;
plot(cidade10(:,1), cidade10(:,2),'g'); hold on;
plot(cidade11(:,1), cidade11(:,2),'y'); hold on;



%% Caminhos Médios

%A função caminhomedio dá-nos como output o caminho médio dos dois caminhos
%fornecidos em input. Dá também uma indicação de "confiança" que podemos
%ter em cada ponto, ou seja, a distância entre os pontos dos caminhos de
%onde tirámos o caminho médio.
[MC1,confMC1,dMC1]=caminhomedio(cidade1,0,cidade2,0,1);
[MC2,confMC2,dMC2]=caminhomedio(cidade3,0,cidade4,0,1);
[MC3,confMC3,dMC3]=caminhomedio(cidade5,0,cidade6,0,1);
[MC4,confMC4,dMC4]=caminhomedio(cidade7,0,cidade8,0,1);
[MC5,confMC5,dMC5]=caminhomedio(cidade9,0,cidade10,0,1);


%%Plotagem das primeiras médias da cidade, antes da correção dos angulos e com os
precursos já ordenados
%{
plot(MC1(:,1), MC1(:,2),'r'); hold on;
plot(MC2(:,1), MC2(:,2),'r'); hold on; 
plot(MC3(:,1), MC3(:,2),'r'); hold on;
plot(MC4(:,1), MC4(:,2),'r'); hold on;
plot(MC5(:,1), MC5(:,2),'r'); hold on;
%}


%% Tratamento de dados de caminhos médios
%Este ciclo é igual ao usado anteriormente para tratar os caminhos, mas
%agora são tratadas as primeiras médias dos caminhos
for i=1:4
MC1=trataangulos(MC1, 90);
MC2=trataangulos(MC2, 90);
MC3=trataangulos(MC3, 90);
MC4=trataangulos(MC4, 90);
MC5=trataangulos(MC5, 90);
end 

%%Plotagem das primeiras médias da cidade, depois da correção dos angulos e com os
precursos já ordenados
%{

plot(MC1(:,1), MC1(:,2),'b'); hold on;
plot(MC2(:,1), MC2(:,2),'b'); hold on; 
plot(MC3(:,1), MC3(:,2),'b'); hold on;
plot(MC4(:,1), MC4(:,2),'b'); hold on;
plot(MC5(:,1), MC5(:,2),'b'); hold on;

%}
[MMC1,confMMC1,dMMC1]=caminhomedio(MC1,confMC1,MC2,confMC2,1);
[MMC2,confMMC2,dMMC2]=caminhomedio(MC3, confMC3,MC4,confMC4,1);
[MMC3,confMMC3,dMMC3]=caminhomedio(MC5, confMC5,cidade11,confMC5,1/3);

[MMMC1,confMMMC1,dMMC4]=caminhomedio(MMC1,confMMC1,MMC2,confMMC2,1);

[MFC,confMF,dMFC]=caminhomedio(MMMC1,confMMMC1,MMC3, confMMC3,1/3);
disp( sprintf( 'A distância do caminho médio de cidade é de %s kilómetros', dMFC ) );

for i=1:length(MFC)
    line([MFC(i,1) MFC(i,1)], [MFC(i,2)-((confMF(i)/2))*7 MFC(i,2)+((confMF(i)/2))*7],'Linewidth',1.5); hold on;
end

title ('Caminho Médio de Cidade');
xlabel('Latitude');
ylabel('Longitude');

%%plotagem total com as médias intermédias e média final
plot(cidade1(:,1), cidade1(:,2),'g'); hold on;
plot(cidade2(:,1), cidade2(:,2),'g'); hold on;
plot(cidade3(:,1), cidade3(:,2),'g'); hold on;
plot(cidade4(:,1), cidade4(:,2),'g'); hold on;
plot(cidade5(:,1), cidade5(:,2),'g'); hold on;
plot(cidade6(:,1), cidade6(:,2),'g'); hold on;
plot(cidade7(:,1), cidade7(:,2),'g'); hold on;
plot(cidade8(:,1), cidade8(:,2),'g'); hold on;
plot(cidade9(:,1), cidade9(:,2),'g'); hold on;
plot(cidade10(:,1), cidade10(:,2),'g'); hold on;
plot(cidade11(:,1), cidade11(:,2),'g'); hold on;

%plot(MMC1(:,1), MMC1(:,2),'b'); hold on;
%plot(MMC2(:,1), MMC2(:,2),'b'); hold on;
%plot(MMC3(:,1), MMC3(:,2),'b'); hold on;
plot(MFC(:,1), MFC(:,2),'r', 'Linewidth', 2); hold on;


%}
%{
figure
%%Plotagem dos precursos do estradao, antes da correção dos angulos e com os
precursos já ordenados
%{

plot(estradao1(:,1), estradao1(:,2),'r'); hold on;
plot(estradao2(:,1), estradao2(:,2),'r'); hold on;
plot(estradao3(:,1), estradao3(:,2),'r'); hold on;
plot(estradao4(:,1), estradao4(:,2),'r'); hold on;
%}
for i=1:4
estradao1=trataangulos(estradao1, 90);
estradao2=trataangulos(estradao2, 90);
estradao3=trataangulos(estradao3, 90);
estradao4=trataangulos(estradao4, 90);

end 
%%Plotagem dos precursos do estradao, depois da correção dos angulos e com os
precursos já ordenados

plot(estradao1(:,1), estradao1(:,2),'g'); hold on;
plot(estradao2(:,1), estradao2(:,2),'g'); hold on;
plot(estradao3(:,1), estradao3(:,2),'g'); hold on;
plot(estradao4(:,1), estradao4(:,2),'g'); hold on;



%}
%{
[ME1,confME1]=caminhomedio(estradao1,0,estradao2,0,1);
[ME2,confME2]=caminhomedio(estradao3,0,estradao4,0,1);

[MFE,confMFE,dMFE]=caminhomedio(ME1,confME1,ME2,confME2,1);


plot(ME1(:,1), ME1(:,2),'b'); hold on;
plot(ME2(:,1), ME2(:,2),'b'); hold on;

for i=1:length(MFE)
    line([MFE(i,1) MFE(i,1)], [MFE(i,2)-((confMFE(i)/2))*10 MFE(i,2)+((confMFE(i)/2))*10],'Linewidth',2); hold on;
end

%plotagem dos precursos iniciais e da média final no trilho do estradao
plot(estradao1(:,1), estradao1(:,2),'g'); hold on;
plot(estradao2(:,1), estradao2(:,2),'g'); hold on;
plot(estradao3(:,1), estradao3(:,2),'g'); hold on;
plot(estradao4(:,1), estradao4(:,2),'g','displayname','Trajetos de GPS'); hold on;


plot(MFE(:,1), MFE(:,2),'r','LineWidth',2); hold on;
title ('Caminho Médio de Estradão');
xlabel('Latitude');
ylabel('Longitude');
disp( sprintf( 'A distância do caminho médio de cidade é de %s kilómetros', dMFE ) );



for i=1:length(MFE)
    confMFE(i)=1000*deg2km(confMFE(i),'earth');
    confMF(i)=1000*deg2km(confMF(i),'earth');
end

save inicialvariables1.mat cidade1 cidade2 cidade3 cidade4 cidade5 cidade6 cidade7 cidade8 cidade9 cidade10 cidade11
save inicialvariables2.mat estradao1 estradao2 estradao3 estradao4
save variables1.mat MC1 confMC1 dMC1 MC2 confMC2 dMC2 MC3 confMC3 dMC3 MC4 confMC4 dMC4 MC5 confMC5 dMC5  
save variables2.mat MMC1 confMMC1 dMMC1  MMC2 confMMC2 dMMC2 MMC3 confMMC3 dMMC3
save variables3.mat MMMC1 confMMMC1 dMMC4 MFC confMF dMFC 
save variables4.mat ME1 confME1 ME2 confME2 MFE confMFE dMFE

%}

%load das variáveis necessárias para o programa correr

load inicialvariables1.mat
load inicialvariables2.mat
load variables1.mat
load variables2.mat
load variables3.mat
load variables4.mat

%%Escrita dos ficheiros kml  

%médias finais
MFEkml='MFEkml';
kmlwriteline(MFEkml, MFE(:,1), MFE(:,2), 'Color','red','AltitudeMode','clampToGround','Width',5);
MFCkml='MFCkml';
kmlwriteline(MFCkml, MFC(:,1), MFC(:,2), 'Color','red','AltitudeMode','clampToGround','Width',5);

%trilhos originais
filename1='estradao1';
filename2='estradao2';
filename3='estradao3';
filename4='estradao4';
filename5='cidade1';
filename6='cidade2';
filename7='cidade3';
filename8='cidade4';
filename9='cidade5';
filename10='cidade6';
filename11='cidade7';
filename12='cidade8';
filename13='cidade9';
filename14='cidade10';
filename15='cidade11';


kmlwriteline(filename1, estradao1(:,1), estradao1(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename2, estradao2(:,1), estradao2(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename3, estradao3(:,1), estradao3(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename4, estradao4(:,1), estradao4(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename5, cidade1(:,1),   cidade1(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename6, cidade2(:,1), cidade2(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename7, cidade3(:,1), cidade3(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename8, cidade4(:,1), cidade4(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename9, cidade5(:,1),   cidade5(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename10, cidade6(:,1), cidade6(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename11, cidade7(:,1), cidade7(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename12, cidade8(:,1), cidade8(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename13, cidade9(:,1),   cidade9(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename14, cidade10(:,1), cidade10(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
kmlwriteline(filename15, cidade11(:,1), cidade11(:,2), 'Color','cyan','AltitudeMode','clampToGround','Width',1);
