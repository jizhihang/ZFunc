function Index=z_cellfind(inputstr,strcell)

IndexC = strfind(strcell, inputstr);
Index = find(not(cellfun('isempty', IndexC)));

