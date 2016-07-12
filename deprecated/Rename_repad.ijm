// This macro is to rename stack files into 3-digit padded format
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 
// Selecting the folder that contains the TIFF frame files

_RootFolder = getDirectory("Choose a Directory");

_List = getFileList(_RootFolder);
//print(_List[0]);

//repad filenames
item = 0; 
while (item < _List.length)  {
	if (endsWith(_List[item],".tif")){		
		_FileName = split(_List[item],"."); 
		print(_FileName[0]);
		_index=split(_FileName[0],"_");
		_ind=IJ.pad(_index[1],3);
		_FileName=replace(_FileName[0],"(?<=_)[0-9]+",_ind);
		done=File.rename(_RootFolder+_List[item],_RootFolder+_FileName+".tif");
		}
	item++;
	}