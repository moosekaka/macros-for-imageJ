// This macro finds the frame in the z-stack with the min Stdev, makes a substack around this slice and runs preprocessing on the substack
//print("this is just to make sure log is open");
//selectWindow("Log"); 
//run("Close"); 
run("Close All");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

setBatchMode(true);
// prompt for directory where list of BF images are stored
//!!!!!!!!MUST have ONLY BFSTACK FILES as # of files is important!!!!!!!!!
  dir = getDirectory("Choose a Directory ");
  list = getFileList(dir);

//Iterate through all BF image in the list        
for (k=0;k<list.length;k++){
run("Close All");
open(dir+list[k]);
iDent=IJ.pad(k+1,2); //pads the iterator
print("Working on file : "+dir+' '+iDent);

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
//setSlice(frameToDup);	//go to the frame that has the maximum Mean value
//run("Duplicate...", "title=centerframe");	//duplicate that frame, calling it "centerframe"
//dup = getImageID;	//give this new image the name "dup"
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

//close other images
    // for (i=4; i>0; i--) {
     //	selectImage(i);
	//close();
        //}
selectImage(5);

saveAs("Tiff", dir+"SumSubstack_"+iDent);
close();
print("Done!");

}