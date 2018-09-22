function [cam ] = ordem( cam )
if cam(1,1)>cam(length(cam),1)
    cam= flipud (cam);
end

