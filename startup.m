function startup()
% Add to path all directories required for approximate RL to work

crt = mfilename('fullpath');
[crt,~,~]=fileparts(crt);
addpath(crt);
addpath(fullfile(crt, 'Gaze'));
addpath(fullfile(crt, 'export_figure'));
addpath(fullfile(crt, 'Plot'));
addpath(fullfile(crt, 'cbir'));

addpath(genpath(fullfile(crt, 'saliency')));



end
