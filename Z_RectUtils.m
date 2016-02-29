classdef z_RectUtils
    % Utitlies function for boxes and rectangles
    % Boxes are      [left, top, with, height]    [x,y,w,h]
    % Rectangles are [left, top, right, bottom];  [x,y,x,y]
    % input are all n by 4
    % By Minh Hoai Nguyen (minhhoai@robots.ox.ac.uk)
    % Date: 8 Aug 2012
    % Last modified: 20 Mar 2014
    % adapted by Zijun Wei
    % Last modified: 4 Feb 2016
    
    methods (Static)
        % box: [left, top, width, height]
        function area = getBoxArea(box)
            if isempty(box)
                area = 0;
            else
                area = box(3)*box(4);
            end;
        end;
        
        % rect: [left, top, right, bottom]
        function area = getRectArea(rect)
            if isempty(rect)
                area = 0;
            else
                area = (rect(4)-rect(2)+1)*(rect(3)-rect(1)+1);
            end;
        end;
        
        
        function areas=getBoxesArea(boxes)
            if isempty(boxes)
                areas = 0;
            else
                areas = boxes(:,3).*boxes(:,4);
            end;
        end
        
        function areas = getRectsArea(rects)
            if isempty(rects)
                areas = 0;
            else
                areas = (rects(:,4)-rects(:,2)+1)*(rects(:,3)-rects(:,1)+1);
            end;
        end;
        
        
        
        % Union of two rectangles
        %         function rect = getRectUnion(rect1, rect2)
        %             xrange = Z_RectUtils.getSegUnion([rect1(1), rect1(3)], [rect2(1), rect2(3)]);
        %             yrange = Z_RectUtils.getSegUnion([rect1(2), rect1(4)], [rect2(2), rect2(4)]);
        %             rect = [xrange(1), yrange(1), xrange(2), yrange(2)];
        %         end;
        %
        %         % Intersection of two rectangles
        %         function rect = getRectInter(rect1, rect2)
        %             xrange = Z_RectUtils.getSegInter([rect1(1), rect1(3)], [rect2(1), rect2(3)]);
        %             yrange = Z_RectUtils.getSegInter([rect1(2), rect1(4)], [rect2(2), rect2(4)]);
        %
        %             if isempty(xrange) || isempty(yrange)
        %                 rect = [];
        %             else
        %                 rect = [xrange(1), yrange(1), xrange(2), yrange(2)];
        %             end
        %
        %         end;
        
        
        
        % boxes: k*4 matrix, each column is [left; top; width; height]
        % rects: k*4 matrix, each column is [left; top; right; bottom]
        function rects = boxes2rects(boxes)
            rects = boxes;
            if ~isempty(boxes)
                rects(:,[3,4]) = boxes(:,[3,4]) + boxes(:,[1,2]) - 1;
            end
        end;
        
        % rects: k*4 matrix, each column is [left; top; right; bottom]
        % boxes: k*4 matrix, each column is [left; top; width; height]
        function boxes = rects2boxes(rects)
            boxes = rects;
            if ~isempty(rects)
                boxes(:,[3,4]) = rects(:,[3,4]) - rects(:,[1,2]) + 1;
            end
        end;
        
        % Get the union box of all boxes
        function unionBox = getBoxesUnion(boxes)
            rects = z_RectUtils.boxes2rects(boxes);
            unionRect = z_RectUtils.getRectsUnion(rects);
            unionBox = z_RectUtils.rects2boxes(unionRect);
        end;
        
        % Get the union rect of all rects
        function unionRect = getRectsUnion(rects)
            unionRect = zeros(1,4);
            unionRect([1,2]) = min(rects(:,[1,2]), [], 1);
            unionRect([3,4]) = max(rects(:,[3,4]), [], 1);
        end;
        
        function unionBox = getBoxesInter(boxes)
            rects = z_RectUtils.boxes2rects(boxes);
            unionRect = z_RectUtils.getRectsInter(rects);
            unionBox = z_RectUtils.rects2boxes(unionRect);
        end;
        
        function unionRect = getRectsInter(rects)
            unionRect = zeros(1,4);
            unionRect([1,2]) = max(rects(:,[1,2]), [], 1);
            unionRect([3,4]) = min(rects(:,[3,4]), [], 1);
        end;
        
        
        
        
        function drawBoxes(boxes, colors, lineWidth,text)
            if ~exist('color', 'var') || isempty(color)
                colors = {'r', 'g', 'b', 'c', 'm', 'y'};
            end;
            
            if ~exist('lineWidth', 'var') || isempty(lineWidth)
                lineWidth = 3;
            end;
            for i=1:size(boxes,2);
                rectangle('Position', boxes(1:4,i), 'LineWidth', lineWidth, 'EdgeColor', colors{mod(i-1, 6) + 1});
            end;
            
            % there are text
            if nargin==4
                for i=1:size(boxes,2)
                    text(boxes(1,i), boxes(2,i), text{i}, ...
                        'BackgroundColor',[.7 .9 .7], 'FontSize', 16, ...
                        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
                end
            end;
        end;
        
        
        
        function drawRects(rects, colors, lineWidth,text)
            if ~exist('color', 'var') || isempty(color)
                colors = {'r', 'g', 'b', 'c', 'm', 'y'};
            end;
            
            if ~exist('lineWidth', 'var') || isempty(lineWidth)
                lineWidth = 3;
            end;
            boxes=z_RectUtils.rects2boxes(rects);
            for i=1:size(boxes,1);
                rectangle('Position', boxes(i,1:4), 'LineWidth', lineWidth, 'EdgeColor', colors{mod(i-1, 6) + 1});
            end;
            
            % there are text
            if nargin==4
                for i=1:size(boxes,1)
                    text(boxes(i,1), boxes(i,2), text{i}, ...
                        'BackgroundColor',[.7 .9 .7], 'FontSize', 16, ...
                        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
                end
            end;
        end;
        
        
        
        
        
        
        
        % Given a rectangle, get the extended rect
        % extFactors is for left, top, right, bottom
        % extFactors(1) = 0.5 mean the left corner is shitfted to the left
        %   half the width of the box.
        % This performs clipping, ex_bbox will be valid box within image
        % boundaries
        function extRect = extendRect(imH, imW, rect, extFactors)
            if isempty(rect)
                extRect = [];
                return;
            end;
            left   = rect(1);
            top    = rect(2);
            right  = rect(3);
            bottom = rect(4);
            box_height = bottom - top + 1;
            box_width  = right - left + 1;
            
            lr = round([left - extFactors(1)*box_width, right + extFactors(3)*box_width]);
            tb = round([top  - extFactors(2)*box_height, bottom + extFactors(4)*box_height]);
            extRect = [lr(1); tb(1); lr(2); tb(2)];
            extRect = z_RectUtils.clipRects(imH, imW, extRect);
        end
        
        
        % Given a reference rect, compute the absolute positions of other
        % rects relative to the reference rect.
        % Inputs:
        %   refRect a 4*1 column vector
        %   relRects a 4*k matrix for k boxes
        % Outputs:
        %   absRects: absolute positions
        function absRects = relRects2absRects(refRect, relRects)
            if size(relRects,1) == 1
                relRects = relRects(:);
            end;
            bbH = refRect(4) - refRect(2); % don't add 1
            bbW = refRect(3) - refRect(1);
            absRects = zeros(size(relRects));
            absRects([1,3],:) = refRect(1) + round(relRects([1,3],:)*bbW);
            absRects([2,4],:) = refRect(2) + round(relRects([2,4],:)*bbH);
        end
        
        % Given a reference rect, compute the relative positions of some
        % rects wrt to the refenrence box.
        % Inputs:
        %   refRect:  4*1 column vector
        %   absRects: 4*k matrix for k boxes
        % Outputs:
        %   relRects: relative positions of absRects wrt refRect
        function relRects = absRects2relRects(refRect, absRects)
            if size(absRects,1) == 1
                absRects = absRects(:);
            end;
            
            bbH = refRect(4) - refRect(2); % don't add 1
            bbW = refRect(3) - refRect(1);
            
            relRects = zeros(size(absRects));
            relRects([1,3],:) = (absRects([1,3],:) - refRect(1))/bbW;
            relRects([2,4],:) = (absRects([2,4],:) - refRect(2))/bbH;
        end
        
        
        
        % Get the relative boxes from the absolute boxes
        % refBox: [left; top; width; height], the reference box
        % boxes: 4*k for k boxes, each column is [left; top; width; height]
        % relBoxes: 4*k for k relative boxes
        %   relBoxes(:,i) is (rel_x, rel_y, rel_w, rel_h)
        %       rel_w, rel_h are relative sizes wrt to the size of refBox
        %       rel_x, rel_y are the distance between center of a box to the center of
        %       the refBox, normalized by the size of refBox
        function relBoxes = absBoxes2relBoxes(refBox, boxes)
            % get center of the reference box
            width = refBox(3);
            height = refBox(4);
            refBoxCx = refBox(1) + (width-1)/2;
            refBoxCy = refBox(2) + (height-1)/2;
            
            % Specify the boxes by the centers of the boxes
            relBoxes = boxes;
            relBoxes(1,:) = relBoxes(1,:) + (relBoxes(3,:)-1)/2;
            relBoxes(2,:) = relBoxes(2,:) + (relBoxes(4,:)-1)/2;
            
            % Shift the coordinate origin to the center of the reference boxes
            relBoxes(1,:) = relBoxes(1,:) - refBoxCx;
            relBoxes(2,:) = relBoxes(2,:) - refBoxCy;
            relBoxes([1,3],:) = relBoxes([1,3],:)/width;
            relBoxes([2,4],:) = relBoxes([2,4],:)/height;
        end
        
        % Get the absBoxes from the relative boxes
        % refBox: [left; top; width; height], the reference box
        % relBoxes: 4*k for k relative boxes
        %   relBoxes(:,i) is (rel_x, rel_y, rel_w, rel_h)
        %       rel_w, rel_y are relative sizes wrt to the size of refBox
        %       rel_xOffset, rel_yOffset are the distance between center of a box to the center of
        %       the refBox, normalized by the size of refBox
        % absBoxes: 4*k matrix, each column is [left; top; width; height]
        function absBoxes = relBoxes2absBoxes(refBox, relBoxes)
            % get center of the reference box
            width = refBox(3);
            height = refBox(4);
            refBoxCx = refBox(1) + (width-1)/2;
            refBoxCy = refBox(2) + (height-1)/2;
            
            absBoxes = relBoxes;
            % rescale
            absBoxes([2,4],:) = absBoxes([2,4],:)*height;
            absBoxes([1,3],:) = absBoxes([1,3],:)*width;
            
            % shift to top-left corner coordinate
            absBoxes(2,:) = absBoxes(2,:) + refBoxCy;
            absBoxes(1,:) = absBoxes(1,:) + refBoxCx;
            
            % specify using the top-left corner of the absBoxes, instead of the center
            absBoxes(1,:) = absBoxes(1,:) - (absBoxes(3,:)-1)/2;
            absBoxes(2,:) = absBoxes(2,:) - (absBoxes(4,:)-1)/2;
        end
        
        
        
        % clip the rects to within the borders of an image
        % rects: k*4 matrix for k rectangles
        function rects = clipRects(imH, imW, rects)
            rects(:,1:4) = max(rects(:,1:4), 1);
            rects(:,[1,3]) = min(rects(:,[1,3]), imW);
            rects(:,[2,4]) = min(rects(:,[2,4]), imH);
        end
        
        % Adapted from Pacal VOC.
        % Compute the symmetric intersection over union overlap between rects set of
        % rects and a single rect
        % rects a k*4 matrix where each column specifies a rectangle
        % a_rect a 1*4 single rectangle
        function o = rectOverlap(a_rect,rects)
            %             rects = rects';
            %             a_rect = a_rect';
            
            x1 = max(rects(:,1), a_rect(1));
            y1 = max(rects(:,2), a_rect(2));
            x2 = min(rects(:,3), a_rect(3));
            y2 = min(rects(:,4), a_rect(4));
            
            w = x2-x1 + 1;
            h = y2-y1 + 1;
            inter = w.*h;
            aarea = (rects(:,3)-rects(:,1) + 1) .* (rects(:,4)-rects(:,2) + 1);
            barea = (a_rect(3)-a_rect(1) + 1) * (a_rect(4)-a_rect(2) + 1);
            % intersection over union overlap
            o = inter ./ (aarea+barea-inter);
            % set invalid entries to 0 overlap
            o(w <= 0) = 0;
            o(h <= 0) = 0;
        end
        
        % Compute assymmetric overlap of intersection over the area of a_rect
        function o = rectOverlapOverArect(a_rect,rects)
            %             rects = rects';
            %             a_rect = a_rect';
            
            x1 = max(rects(:,1), a_rect(1));
            y1 = max(rects(:,2), a_rect(2));
            x2 = min(rects(:,3), a_rect(3));
            y2 = min(rects(:,4), a_rect(4));
            
            w = x2-x1 + 1;
            h = y2-y1 + 1;
            inter = w.*h;
            barea = (a_rect(3)-a_rect(1) + 1) * (a_rect(4)-a_rect(2) + 1);
            % intersection over union overlap
            o = inter./barea;
            % set invalid entries to 0 overlap
            o(w <= 0) = 0;
            o(h <= 0) = 0;
        end
        
        % Compute assymmetric overlap of intersection over the area of rects
        function o = rectOverlapOverRects( a_rect,rects)
            
            
            x1 = max(rects(:,1), a_rect(1));
            y1 = max(rects(:,2), a_rect(2));
            x2 = min(rects(:,3), a_rect(3));
            y2 = min(rects(:,4), a_rect(4));
            
            w = x2-x1 + 1;
            h = y2-y1 + 1;
            inter = w.*h;
            aarea = (rects(:,3)-rects(:,1) + 1) .* (rects(:,4)-rects(:,2) + 1);
            % intersection over union overlap
            o = inter./aarea;
            % set invalid entries to 0 overlap
            o(w <= 0) = 0;
            o(h <= 0) = 0;
        end
        
        
        
        
        % Non-maximum suppression.
        % Greedily select high-scoring detections and skip detections
        % that are significantly covered by a previously selected detection.
        % rects: k*w(w>4) rectangles, rects(:,i) is [x1, y1, x2, y2,..., score]
        function pick = nms(rects, overlap)
 
            
            if isempty(rects)
                pick = [];
                return;
            end
            
            x1 = rects(:,1);
            y1 = rects(:,2);
            x2 = rects(:,3);
            y2 = rects(:,4);
            s = rects(:,end);
            
            area = (x2-x1+1) .* (y2-y1+1);
            [vals, I] = sort(s);
            
            pick = s*0;
            counter = 1;
            while ~isempty(I)
                last = length(I);
                i = I(last);
                pick(counter) = i;
                counter = counter + 1;
                
                xx1 = max(x1(i), x1(I(1:last-1)));
                yy1 = max(y1(i), y1(I(1:last-1)));
                xx2 = min(x2(i), x2(I(1:last-1)));
                yy2 = min(y2(i), y2(I(1:last-1)));
                
                w = max(0.0, xx2-xx1+1);
                h = max(0.0, yy2-yy1+1);
                
                inter = w.*h;
                o = inter ./ (area(i) + area(I(1:last-1)) - inter);
                
                I = I(find(o<=overlap));
            end
            
            pick = pick(1:(counter-1));
            
            
            
            
        end
    end
end  
