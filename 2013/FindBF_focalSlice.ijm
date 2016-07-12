// This macro finds the frame in the z-stack with the min Stdev, makes a substack around this slice and runs preprocessing on the substack
run("Close All");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

setBatchMode(false);
// prompt for directory where list of BF images are stored
  dir = getDirectory("Choose BF stacks directory");
  list = getFileList(dir);

//Iterate through all BF image in the list        
for (k=0;k<list.length;k++){
	if(matches(list[k],".*B.*.tif")){
		open(dir+list[k]);
		run("8-bit");
		//iDent=IJ.pad(k+1,2); //pads the iterator
		print("Working on file : "+ list[k]);
		temp=split(list[k],"_.");
		indexID=temp[1]; 
		
		//set the measurements (do a "record macro" to get this list)
		run("Set Measurements...", "area mean standard modal min limit display redirect=None decimal=3");
		
		//go to slice 1 and measure its stdev to get a starting value
		setSlice(1);
		getStatistics(area, mean, min, max,stdev);
		minVal = stdev;	 
		
		//iterate through all slices, measure the mean, and compare to the min stdev
			for (n=1; n<=nSlices; n++) {
				setSlice(n);
				getStatistics(area, mean, min, max, stdev);
					if (stdev<minVal) {
					minVal = stdev;	//if it is smaller than minVal, then mark this slice as the new minVal
					frameToDup = n-2;
				}
			}
		print("set focal slice to number : "+frameToDup);
		run("Make Substack...", "  slices="+ frameToDup + "-" + frameToDup);
		saveAs("Tiff", dir+"BF_FocalSlice_"+indexID);close;close;
	}
}
			