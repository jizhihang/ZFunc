function [h_box h_text] = show_boundingbox(box, varargin)
% Draw bounding box
% Input
%   box         - bounding box region (xmin, ymin, xmax, ymax)
%   varargin
%       color   - edge color of bounding box
%       label   - label of bounding box
% History
%   create    -  Kiwon Yun (kyun@cs.stonybrook.edu), 06-06-2011
%   modify    -  Kiwon Yun (kyun@cs.stonybrook.edu), 06-06-2011

% function option
edge_color = set_options(varargin, 'color', 'r');
edge_alpha = set_options(varargin, 'alpha', 1);
label = set_options(varargin, 'label', '');
style = set_options(varargin, 'style', '-');
width = set_options(varargin, 'lineWidth', 5);
fontweight = set_options(varargin, 'fontWeight', 'normal');
fontsize = set_options(varargin, 'fontSize', 10);
fontcolor = set_options(varargin, 'fontColor', 'k');
label_margin = set_options(varargin, 'label_margin', 15.0); % the label will be appeared more above with a larger value

dbox = box; % if an input parameter is a detected window
pos(1:2) = dbox(1:2);
pos(3:4) = dbox(3:4) - dbox(1:2);

if all(pos > 0)    
    p = patch(dbox([1,3,3,1]),dbox([2,2,4,4]),[1 1 1 1],'FaceColor','none', 'LineStyle', style);
    set(p,'EdgeColor',edge_color, 'LineWidth',width, 'EdgeAlpha', edge_alpha);
    
    if edge_alpha > 0.5
        h_text = text(dbox(1), dbox(2)-label_margin, sprintf('%s', label), 'Color', fontcolor, 'FontWeight', fontweight, 'FontSize', fontsize, 'BackgroundColor', [1 1 1]);    
    end
else
    fprintf('either height or width less than zero (top: %d, left:%d, bottom:%d, right:%d)\n', box(1), box(2), box(3), box(4));
end 
