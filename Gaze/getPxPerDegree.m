function [pxlPerDegree ] = getPxPerDegree(visual_angle, varargin)


    opts. screen_width = 1024;
    opts.screen_height = 768;
    
    opts. screen_width_mm = 360;
    opts. screen_height_mm = 270;
    
   opts. distance_to_subject = 700;
    
    w_pixel = tan(deg2rad(visual_angle/2))*2*opts.distance_to_subject*opts.screen_width/opts.screen_width_mm;
    h_pixel = tan(deg2rad(visual_angle/2))*2*opts.distance_to_subject*opts.screen_height/opts.screen_height_mm;
    
       
    % 1 degree of angle -> ~0.5 sigma
    % when visual_angle=1, w=h=34.7523;
    pxlPerDegree = [h_pixel,w_pixel];
    
end


