//macro for cropoping out individual BF cell stacks
// Defining the size of the singl cell images:
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 
_xy = 250;
_RootFolder = getDirectory("Choose a Directory");

// Creating a directory where the files are saved
File.makeDirectory(_RootFolder + "cells");
setBatchMode(true);
// Prevent generation of 32bit images
run("RandomJ Options", "  adopt progress");

run("ROI Manager...");
roiManager("Reset");
roiManager("Open",File.getParent(_RootFolder) + "/RoiSet.zip");

open("zBFfocal.tif");
MAXP = getImageID;
print(MAXP);

// For each ROI (cell)
for (roi = 0; roi < roiManager("count"); roi++) {
	roiManager("Select",roi);
	_FileName = getInfo("slice.label");
	_FileName = replace(_FileName,".tif","@");
	_FileName = split(_FileName,"@");
	_FileName = _FileName[0];
	print(_FileName);

	open(_RootFolder+_FileName + ".tif");
	ORIGINAL = getImageID;

	run("Restore Selection");

	newImage("CELL","8-bit Black",_xy,_xy,nSlices);
	CELL = getImageID;

	// Estimating the noise distribution around the ROI
	max_ai = 0;
	selectImage(ORIGINAL);
	getStatistics(area, mean, min, max, std);
	for (s = 1; s <= nSlices; s++) {
		//print(s);
		selectImage(MAXP);
		selectImage(ORIGINAL);
		setSlice(s);		
		run("Restore Selection");
		run("Enlarge...", "enlarge=17");		
		run("Copy");
		
		selectImage(CELL);
		setSlice(s);
		run("Select None");		
		run("Add...", "value=" + min/256 + " slice");
		run("Paste");
	}
	run("Select None");
	resetMinAndMax();
	save(_RootFolder + "cells/" + _FileName + "_" + IJ.pad(roi,3) + ".tif");
	selectImage(CELL); close();
	selectImage(ORIGINAL); close();
}

setBatchMode(false);
