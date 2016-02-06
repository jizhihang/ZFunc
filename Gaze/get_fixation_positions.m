% read fixations, and return N x 2 matrix contains the location of
% fixations from all subjects
function fixation_positions = get_fixation_positions(fixations, ratio)

    subjects = [fixations.subject_ids];
    n_subjects = length(subjects);

    fixation_positions = [];
    for s=1:n_subjects
        fix_pos = fixations.fixation{s};
        fixation_pos = zeros(size(fix_pos.fix_X,2), 2);
        if ~isempty(fix_pos.fix_X)
            fixation_pos(:,1) = fix_pos.fix_X .* ratio(2);
            fixation_pos(:,2) = fix_pos.fix_Y .* ratio(1);
        end
        fixation_positions = [fixation_positions; fixation_pos];
    end
end