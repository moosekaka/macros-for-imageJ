// This macro finds the frame in the z-stack with the min Stdev, makes a substack around this slice and runs preprocessing on the substack

run("Close All");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

setBatchMode(true);
// prompt for directory where list of BF images are stored
  dir = getDirectory("Choose a Directory ");
  list = getFileList(dir);

//Iterate through all BF image in the list        
for (k=0;k<list.length;k++){
	if(matches(list[k],"Y.*B.*.tif")){
		open(dir+list[k]);
		//iDent=IJ.pad(k+1,2); //pads the iterator
		print("Working on file : "+ list[k]);
		temp=split(list[k],"_.");
		indexID=temp[1]+"_"+temp[3]; 
		
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
					frameToDup = n;
				}
			}
		print("set focal slice to number : "+frameToDup);
		run("Median (3D)");
		run("8-bit");//convert to 8bit else get overflow error in loc var
		
		top=frameToDup-4; //set limits of substack
		bot=frameToDup+4; 
		run("Make Substack...", "  slices="+ top + "-" + bot);
		run("Variance...", "radius=3 stack");
		run("FeatureJ Hessian", "  smallest smoothing=2");
		run("Z Project...", "start=1 stop=9 projection=[Sum Slices]");
		run("16-bit");
		run("Invert");
		selectImage(5);
		
		saveAs("Tiff", dir+"SumSubstack_"+indexID);
		run("Close All");
		print("Done!");
	}

}