//macro for creating montage of individual BF cell frames


// make max proj
function zproj(imageID){
	selectImage(imageID);
	fn = getInfo("image.filename");
	print("make mx proj of "+fn);
	run("Z Project...", "start=1 stop=500 projection=[Max Intensity]");
	setMetadata("Label", fn );
	x = getImageID();
	return x;
}


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

// PROCESS BRIGHTFIELD STACKS TO SINGLE SLICE FOCUSED STACK
_RootFolder = getDirectory("Choose a Directory");
setBatchMode(true);
_List = getFileList(_RootFolder+"/BF/cells");
newImage("cropped_zBFfocal", "8-bit black", 250, 250, _List.length);
bffoc = getImageID();
bfcount=0;
item = 0;

while (item < _List.length)  {
	if ( endsWith(_List[item],".tif") ) {
		bfcount++;
		open(_RootFolder + "/BF/cells/" + _List[item]);
		img_src = getImageID();
		label = getTitle;
		fdup = getFocal(img_src);
		insertSlice(fdup, img_src, bfcount, bffoc);
		print(fdup+img_src);
	}
	item++;
}
run("Save", "save=" +  _RootFolder + "/BF/cropped_zBFfocal.tif");
print("BF Done");


// PROCESS RFP STACKS TO SINGLE SLICE MAX PROJ
run("Close All");
_List = getFileList(_RootFolder+"/RFP/cells");
newImage("cropped_MAX_RFP", "8-bit black", 250, 250, _List.length);
maxrfp = getImageID();
rfpcount=0;
item = 0;

while (item < _List.length)  {
	if ( endsWith(_List[item],".tif") ) {
		rfpcount++;
		open(_RootFolder + "/RFP/cells/" + _List[item]);
		img_src = getImageID();
		label = getTitle;
		zid = zproj(img_src);
		insertSlice(1, zid, rfpcount, maxrfp);
	}
	item++;
}
run("Save", "save=" +  _RootFolder + "/RFP/cropped_maxRFP.tif");
print("RFP Done");
