//Macro to batch fit Ellipse from output of MATLAB ROI's
//run("Close All");
//print("this is just to make sure log is open");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
//parentPath = getDirectory("home");
setBatchMode(true);
roiManager("reset");
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
	for (j=0;j<list.length;j++){
		//look for directories
		if(endsWith(list[j],"/")){
			print(list[j]);
			//find all files in the directory, note must have only cell coord text files!
			list2=getFileList(dir+list[j]);
			print(list2.length);
					//for each text file, import coords and fit ellipse												
					for (k=0;k<list2.length;k++){
					run("XY Coordinates... ", "open="+dir+list[j]+list2[k]);
					run("Fit Ellipse");
					roiManager("Add");
					print(dir+list[j]+list2[k]);
					}
				//Save the fitted ellipses into zip file and save Results which containg major/minor length
				//Also clears Results and delete ROIs before moving on to the next image set
				roiManager("Save", dir+list[j]+"RoiSet.zip");
				run("Set Measurements...", "  fit redirect=None decimal=3");
				roiManager("Measure");
				selectWindow("Results");
				saveAs("Results", dir+list[j]+"Results.txt");
				run("Clear Results");
				roiManager("Delete");				
				
				}
	}

