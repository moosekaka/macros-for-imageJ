//Macro to batch fit Ellipse from output of MATLAB ROI's
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
			toke=split(list[j],"_/");
			//print(toke[1]);	
			open("SumSubstack_"+toke[1]+".tif");		
			list2=getFileList(dir+list[j]);
					//for each text file that starts with 'Cell*', import coords and fit ellipse												
					for (k=0;k<list2.length;k++){
						
						if(matches(list2[k],"Cell.*txt")){
						run("XY Coordinates... ", "open="+dir+list[j]+list2[k]);
						run("Fit Ellipse");
						roiManager("Add");
						print(dir+list[j]+list2[k]);
						}
					}
				//Save the fitted ellipses into zip file and save Results which contain major/minor length
				//Also clears Results and delete ROIs before moving on to the next image set
				roiManager("Save", dir+list[j]+"RoiSet.zip");
				//List.setMeasurements;
				run("Set Measurements...", "  fit redirect none decimal=3");
				roiManager("Measure");
				selectWindow("Results");
				saveAs("Results", dir+list[j]+"Results.txt");
				run("Clear Results");
				roiManager("Delete");	
				close()	;		
				
				}
	}