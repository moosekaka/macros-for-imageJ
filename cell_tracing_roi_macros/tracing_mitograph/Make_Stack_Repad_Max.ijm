/* Script to save individual image acquisitions from MicroManager
 * into brightfield and RFP/GFP stacks before cell circling 
 * for input into Mitograph */
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log");
run("Close");
setBatchMode(true);

//get tag based on file Show info
function getTag(tag) {
	info = getImageInfo();
	index1 = indexOf(info, tag);
	if (index1==-1) return "";
	index1 = indexOf(info, ":", index1);
	if (index1==-1) return "";
	index2 = indexOf(info, ",", index1);
	value = substring(info, index1+1, index2);
	return value;
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


//repad filenames
function repad_rename(strg){
	_FileName = "";
	if (matches(strg, ".*[BFP]stack.*")){
		_FileName = split(strg, ".");
		_index = split(_FileName[0], "\\");
		L = _index.length - 1;
		index = split(_index[L], "_");
		_ind=IJ.pad(index[1], 3);
		_FileName = replace(_FileName[0], "(?<=_)[0-9]+", _ind) + ".tif";
		//print("repadded " + strg +" to "+ _FileName+ "\n");
		File.rename(strg, _FileName);
	}
}


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


// copies slice from src image stack to dest image stack
function insertSlice(n_src, id_src, n_dest, id_dest ){
	selectImage(id_src);
	fname = getMetadata("Label");
	setSlice(n_src);
	run("Copy");
	selectImage(id_dest);
	setSlice(n_dest);
	run("Paste");
	setMetadata("Label", fname);
	close(id_src);
}


// Main
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
x = list.length;
print("number of folders: " + x);
print("\n");
for (k=0;k<list.length;k++){
	print(k + dir + list[k]);
}

newImage("BFfocalPlane", "8-bit black", 512, 512, x);
bffoc = getImageID(); bfcount=0;
newImage("MAX RFP", "16-bit black", 512, 512, x);
maxrfp = getImageID(); rfpcount=0;
newImage("MAX GFP", "16-bit black", 512, 512, x);
maxgfp = getImageID(); gfpcount=0;

	for (k=0;k<list.length;k++){
		if (File.isDirectory(dir+list[k])){
		names=split(list[k],"/") ;
		fileList=getFileList(dir+list[k]);
		nch1 = 0; nch2 = 0; nch3 = 0; nch4 = 0; nch5=0;
			for (n=0; n<fileList.length; n++){
			if 	(indexOf(fileList[n],"BF") > 0)
				nch1 = n;
			else if (indexOf(fileList[n],"RFP") > 0)
				nch2 = n;
			else if (indexOf(fileList[n],"GFP") > 0)
				nch3 = n;
			else if (indexOf(fileList[n], "DAPI") > 0)
				nch4 = n;
			else if (indexOf(fileList[n], "Cy5") > 0)
				nch5 = n;
			}
		}

		numofPics=fileList.length;
		//Brightfield channel
		if(nch1>0){
		bfcount++;
		run("Image Sequence...", "open=[" + dir + list[k] + fileList[nch1] + "] number=" + numofPics + " starting=1 increment=1 scale=100 file=BF sort");
		fpath = dir + names[0] + "_BFstack.tif" ;
		save(fpath);
		repad_rename(fpath); print("\n");
		img_src = getImageID();
		label = getTitle;
		fdup = getFocal(img_src);
		insertSlice(fdup, img_src, bfcount, bffoc);
		setMetadata("Label", label);
		}
		//RFP channel
		if(nch2>0){
		rfpcount++;
		run("Image Sequence...", "open=["+dir + list[k] + fileList[nch2] + "] number=" + numofPics + " starting=1 increment=1 scale=100 file=RFP sort");
		fpath = dir + names[0] + "_RFPstack.tif" ;
		save(fpath);
		repad_rename(fpath); print("\n");
		img_src = getImageID();
		zid = zproj(img_src);
		insertSlice(1, zid, rfpcount, maxrfp);
		}
		//GFP channel
		if(nch3>0){
		gfpcount++;
		print(gfpcount);
		run("Image Sequence...", "open=[" + dir + list[k] + fileList[nch3] + "] number="+numofPics + " starting=1 increment=1 scale=100 file=GFP sort");
		fpath = dir + names[0] + "_GFPstack.tif" ;
		save(fpath);
		repad_rename(fpath); print("\n");
		img_src = getImageID();
		zid = zproj(img_src);
		insertSlice(1, zid, gfpcount, maxgfp);
		}
	}

selectImage(bffoc);
run("Save", "save=["+dir+"zBFfocal.tif]");
selectImage(maxrfp);
run("Save", "save=["+dir+"Max_RFP.tif]");
selectImage(maxgfp);
run("Save", "save=["+dir+"Max_GFP.tif]");
print("All Done!");
