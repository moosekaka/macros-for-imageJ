//macro for cropoping out individual BF cell stacks
// Defining the size of the singl cell images:
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 
_RootFolder = getDirectory("Choose a Directory");
// Creating a directory where the files are saved
File.makeDirectory(_RootFolder + "cells");
setBatchMode(true);
run("ROI Manager...");
roiManager("Reset");
roiManager("Open",_RootFolder + "RoiSet.zip");
open("MaxProjs.tif");
MAXP = getImageID;
// For each ROI (cell)
f = File.open(_RootFolder+"\\table.txt")
for (roi = 0; roi < roiManager("count"); roi++) {
	roiManager("Select",roi);
	_FileName = getInfo("slice.label");
	_FileName = replace(_FileName,".tif","@");
	_FileName = split(_FileName,"@");
	_FileName = _FileName[0];
	print(f,_FileName);
	}