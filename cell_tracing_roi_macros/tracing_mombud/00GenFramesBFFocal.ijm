//macro for craeting stack of BFstacks using the minimal stdev frame


//returns the slice number with the best focus in BF
function getFocal(id){
	selectImage(id);
	getDimensions(w, h, dummy, slices, dummy);
	run("Set Measurements...", "area mean standard modal min limit display redirect=None decimal=3");

		//set initial stdev value to that of frame 1
		frameToDup=1;
		setSlice(1);
		getStatistics(area, mean, min, max,stdev);
		minVal = stdev;
		//iterate through all slices, measure the mean, and compare to the min stdev
		for (n=2; n<=slices; n++) {
			setSlice(n);
			getStatistics(area, mean, min, max, stdev);
			if (stdev < minVal) {
			minVal = stdev;
			frameToDup = n;
			}
		}
		print ("Focal slice is on  slice " + frameToDup);

		return frameToDup;
}


// copies slice from src image stack to dest image stack
function insertSlice(n_src, id_src, n_dest, id_dest ){
	selectImage(id_src);
	//fname = getMetadata("Label");
	fname = getTitle();
	setSlice(n_src);
	run("Copy");
	selectImage(id_dest);
	setSlice(n_dest);
	run("Paste");
	setMetadata("Label", fname);
	close(id_src);
}


// Selecting the folder that contains the TIFF frame files
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 
_RootFolder = getDirectory("Choose a Directory");
setBatchMode(false);
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


// The focal slice stack to store in focus BF frames
newImage("zBFfocal", "16-bit black", w, h, ntiff);
bffoc = getImageID(); bfcount=0;
item = 0; im = 0;
while (item < _List.length)  {
	if ( endsWith(_List[item],".tif") ) {
		bfcount++;
		open(_RootFolder + _List[item]);
		img_src = getImageID();
		label = getTitle;
		fdup = getFocal(img_src);
		insertSlice(fdup, img_src, bfcount, bffoc);
		print(fdup+img_src);
	}
	item++;
}

run("Save", "save=" +  _RootFolder + "zBFfocal.tif");
