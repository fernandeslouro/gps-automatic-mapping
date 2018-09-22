%%ANALISA_NMEA_FILE
%Esta funcao percorre o ficheiro NMEA, procura as linhas GPGGA, e daí
%retiramos os valores de latitude, longitude e altitude para análise dos
%percursos que fizemos. 
%Input: nome do ficheiro
%Output: matriz com os dados do recetor [lat long alt]

function [dados_recetor] =analisa_nmea_file(nome)
velocidade=[];
fileID = fopen(nome, 'r');
if fileID <0
    error('error opening file \n');
end

aux =0;
flag_GPGGA=0;
linha=[];
dados_recetor=[];   %lat long alt
linha = fgetl(fileID);
i=1;

while i~=length(linha)
        if linha(i)==',' && linha(i+1)==','
            for j = length(linha):-1:i+1
                linha(j+1)=linha(j);
            end
            linha(i+1)=' ';
        end
        i=i+1;
end
      
while true
    
    linha = fgetl(fileID);
    tamanho = size(linha);
    
    if linha==-1
        break;
    end
    
    [address_field, linha]=strtok(linha, '$,');
    
    if strcmp(address_field, 'GPGGA')
         aux=aux+1;     
        flag_GPGGA=flag_GPGGA+1;
        %UTC
        [str_utc, linha] = strtok(linha,',');
        
        %latitude
        [str_lat, linha] = strtok(linha, ',');
        [lat_sign, linha]= strtok(linha, ',');
        lat_aux=str2double(str_lat)/100;
        lat_deg=fix(lat_aux);
        lat_min_aux=(lat_aux-lat_deg)*100;
        lat=[lat_deg, lat_min_aux];
        lat=dm2degrees(lat);
        
        if strcmp(lat_sign, 'S')
            lat=-lat;
        end
if(lat==0)
    lat=[];
end
        %longitude
        [str_long, linha] = strtok(linha, ',');
        [long_sign, linha]= strtok(linha, ',');
        long_aux=str2double(str_long)/100;
        long_deg=fix(long_aux);
        long_min_aux=(long_aux-long_deg)*100;
        long=[long_deg, long_min_aux];
        long=dm2degrees(long);
        
        if strcmp(long_sign, 'W')
            long=-long;
        end
        if(long==0||lat==0)
       long=[];
       end
       
        %quality indicator
        [QA, linha] = strtok(linha, ',');
        
        %num sat usados
        [num_sat, linha] = strtok(linha, ',');
        
        %HDOP
        [HDOP, linha] = strtok(linha, ',');
        
        %altitude
        if strcmp (QA, '1') || strcmp (QA, '2') || strcmp (QA, '3') || strcmp (QA, '4') || strcmp (QA, '5') 
        [str_alt, linha] = strtok(linha, ',');
        alt=str2double(str_alt);
       
        if(long==0||lat==0||alt==0)
        alt=[];
        end
        dados_recetor(aux,1)=lat;
        dados_recetor(aux,2)=long;
        dados_recetor(aux,3)=alt;
       
        end
       
        
    end 
   
end
end
