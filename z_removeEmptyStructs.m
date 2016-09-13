function newStruct=z_removeEmptyStructs(inputStruct, fieldName)

indxField={inputStruct.(fieldName)};


Index = (not(cellfun('isempty', indxField)));
newStruct=inputStruct(Index);


end