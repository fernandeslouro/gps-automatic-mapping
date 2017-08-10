function [receptor_data] =nmea_to_matrix(nmea_name)
%ANALISE_NMEA_FILE Gets lat-long-alt time-ordered matrix from NMEA file
%   The function iterates through the NMEA file, lookin for GPGGA-type
%   entries, where we can find location information. From these entries the
%   latirudes, longitudes and altitudes are taken from for further
%   analysis.
%   INPUT: NMEA file name
%   OUTPUT: Matrix with receptor data [lat long alt]

fileID = fopen(nmea_name, 'r');
if fileID <0
    error('error opening file \n');
end

aux =0;
flag_GPGGA=0;
line=[];
receptor_data=[];   %lat long alt
line = fgetl(fileID);
i=1;

while i~=length(line)
        if line(i)==',' && line(i+1)==','
            for j = length(line):-1:i+1
                line(j+1)=line(j);
            end
            line(i+1)=' ';
        end
        i=i+1;
end
      
while true
    
    line = fgetl(fileID);
    
    if line==-1
        break;
    end
    
    [address_field, line]=strtok(line, '$,');
    
    if strcmp(address_field, 'GPGGA')
         aux=aux+1;     
        flag_GPGGA=flag_GPGGA+1;
        %UTC
        [str_utc, line] = strtok(line,',');
        
        %latitude
        [str_lat, line] = strtok(line, ',');
        [lat_sign, line]= strtok(line, ',');
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
        [str_long, line] = strtok(line, ',');
        [long_sign, line]= strtok(line, ',');
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
        [QA, line] = strtok(line, ',');
        
        %nuumber of used satallites
        [num_sat, line] = strtok(line, ',');
        
        %HDOP
        [HDOP, line] = strtok(line, ',');
        
        %altitude
        if strcmp (QA, '1') || strcmp (QA, '2') || strcmp (QA, '3') || strcmp (QA, '4') || strcmp (QA, '5') 
        [str_alt, line] = strtok(line, ',');
        alt=str2double(str_alt);
       
        if(long==0||lat==0||alt==0)
        alt=[];
        end
        receptor_data(aux,1)=lat;
        receptor_data(aux,2)=long;
        receptor_data(aux,3)=alt;
       
        end        
    end    
end
end
