function save_image(h, W, H, output_path, filename)

    if exist('tmp/configure.mat', 'file')
        load tmp/configure.mat config;	
    else
        config = setup;
    end
    
    if ~exist(output_path, 'dir')
        mkdir(output_path);
    end
    
    dpi = 100;
    
    set(h, 'paperposition', [0 0 W/dpi H/dpi]);
    set(h, 'papersize', [W/dpi H/dpi]);
    print(h, '-djpeg', sprintf('%s/%s.jpg', output_path, filename), sprintf('-r%d', dpi));
end