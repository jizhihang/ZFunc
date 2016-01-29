function value = set_options(option, name, default)

    if iscell(option)
        if isempty(option)
            option = [];
        elseif length(option) == 1
            option = option{1};
        else
            option = cell2option(option);
        end
    end

    if isfield(option, name)
        value = option.(name);
    else
        value = default;
    end

end

function option = cell2option(array)

    m = round(length(array) / 2);

    if m == 0
        option = [];
        return;
    end

    for i = 1 : m
        p = i * 2 - 1;
        option.(array{p}) = array{p + 1};
    end

end
