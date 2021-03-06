//macro for creating montage of individual BF cell frames

// Selecting the folder that contains the TIFF frame files
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 


_RootFolder = getDirectory("Choose a Directory");
setBatchMode(true);
item = 0;
ntiff = 0;
_List = getFileList(_RootFolder);

while (item < _List.length)  {
	if ( endsWith(_List[item],".tif") ) {
		if (ntiff==0) {
			open(_RootFolder + _List[item]);
			w = getWidth();
			h = getHeight();
			close();
		}
		ntiff++;
	}
	item++;
}
if (ntiff== 0) {
	showMessage("No TIFF files were found.");
} else {
	print("Number of TIFF files: " + ntiff);
}

// Generating the max projection stack

newImage("zBFfocal", "8-bit black", w, h, ntiff);
print(_List.length);
item = 0; im = 0;
while (item < _List.length)  {
	if ( endsWith(_List[item],".tif") ) {
		im++;
		print(_List[item]);
		open(_RootFolder + _List[item]);		;
		_FileName = split(_List[item],"."); 
		_FileName = _FileName[0];
		
		print(_RootFolder+_FileName);
		
		//set the measurements (do a "record macro" to get this list)
		run("Set Measurements...", "area mean standard modal min limit display redirect=None decimal=3");
		
		//go to slice 1 and measure its stdev to get a starting value
		
		setSlice(nSlices/2+1);
		getStatistics(area, mean, min, max,stdev);
		minVal=stdev;frameToDup=0;
		
		run("Duplicate...", "title="+_FileName);
		//close();
		//close();
		
		selectWindow(_FileName);run("Copy");
		selectWindow("zBFfocal");
		setSlice(im);
		run("Paste");
		setMetadata("Label",_FileName);
	}
	item++;
	print(item);
}

// Saving max projection stack

run("Save", "save=" +  _RootFolder + "zBFfocal.tif");
print("All Done"