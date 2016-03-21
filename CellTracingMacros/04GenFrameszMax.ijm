//macro for creating 8bit z projection stack of individual FP zstack

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

newImage("zMax", "16-bit black", 3*w, h, ntiff);

item = 0; im = 0;
while (item < _List.length)  {
	if ( endsWith(_List[item],".tif") ) {
		im++;
		open(_RootFolder + _List[item]);
		_FileName = split(_List[item],"."); 
		_FileName = _FileName[0];
		print(_FileName);
		stak=getImageID();

		setSlice(1);run("Copy");
		selectWindow("zMax");setSlice(im);makeRectangle(0,0,w,h);run("Paste");
		selectImage(stak);
		run("Z Project...", "start=1 stop=500 projection=[Max Intensity]");run("Copy");
		selectWindow("zMax");setSlice(im);makeRectangle(w+1,0,w,h);run("Paste");
		selectImage(stak);
		setSlice(nSlices);run("Copy");
		selectWindow("zMax");setSlice(im);makeRectangle(2*w+1,0,w,h);run("Paste");
		//close();
		//close();
		
		
		setMetadata("Label",_FileName);
	}
	item++;
}

// Saving max projection stack

run("Save", "save=" +  _RootFolder + "zMax.tif");
print("AllDone");