
function cnd = isInImagePlane(point, img_x, img_y)
%     if( img_x ~= 1024 && img_y ~= 768 )
%         display('warning in image plane');
%     end

if ( point(1, 1) <= img_x && point(2, 1) <= img_y  && ...
        point(1, 1) >= 1 && point(2, 1) >= 1 )
    cnd = true;
    return
end
cnd = false;

end