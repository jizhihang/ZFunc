

function [sm, fixations, fixationStr] = generateFixations(sm, nf, cLabel, clustCent, bandWidth)
%get a saliency map and generate nf fixation points using inhibitation of
%return
% requires walters and koch toolbox to perform inhibitation of return.
% fixations[row col].

smSize = size(sm);
sm = imresize(sm, [128, 171]);
% sm = imresize(sm, 0.5);
sm = (sm - min(sm(:))) / (max(sm(:)) - min(sm(:)));
% [x, y] = size(sm);

%%
% inhibitation of return and fov processing

% make saliency structure

% first initialize parameters
params = defaultSaliencyParams;
% params.foaSize = 0.1667*min(x,y);

saliencyData.origImage.size = [128 171 1];
saliencyData.data = imresize(sm, [48 64]);
saliencyData.parameters = params;

wta = initializeWTA(saliencyData, params);


fixations = zeros(nf, 2);


    
for fix = 1:nf
    
    % evolve WTA until we have the next winner
    winner = [-1,-1];
    
    while(winner(1) == -1)
        [wta,winner] = evolveWTA(wta);
    end
    fprintf('.');
    
    % get shape data and apply inhibition of return    
    wta = applyIOR(wta, winner, params, []);
    
    % convert the winner to image coordinates
%     fixations(fix,:) = winner;
    fixations(fix,:) = winnerToImgCoords(winner, params);
end

sm = imresize(sm, smSize);
fixations(:,1) = ceil(fixations(:,1) - 1e-6)*smSize(1)/768;
fixations(:,2) = ceil(fixations(:,2) - 1e-6)*smSize(2)/1024;
fixations(:,1:2) = fixations(:,2:-1:1);
fixations = fixations';

% generate the coresponding string
fixationStr = '';
for i = 1:nf 
    cp = fixations(:, i); % pick a point
    distance = sqrt(sum(bsxfun(@minus, clustCent, cp).^2));
    %current = find( distance <=  bandWidth );
    fixationStr = cat(2, fixationStr, cLabel{distance <=  bandWidth}); 
end
