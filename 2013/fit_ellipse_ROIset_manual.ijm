//Macro to cut out 8 bit stacks from ROI's 
//print("this is just to make sure log is open");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

parentPath = getDirectory("home");
//setBatchMode(true);
 dir = getDirectory("Choose a Directory ");

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
roiManager("reset");
for (k=0;k<list.length;k++){
	if(matches(list[k],"(?i)B(?!.*(zip|roi)).*tif")){ 
	temp=split(list[k],"_.");
	indexID=temp[1];
	open(dir+list[k]);
	
	//roiManager("Open",dir+temp2);
	if(File.exists(dir+"RoiSet_"+indexID+".zip")){ 
	roiManager("Open",dir+"RoiSet_"+indexID+".zip");
	}
		n = roiManager("count");
		print("list of rois = "+n);
		for (m=0;m<n;m++){
		//run("Duplicate...","title=NewStack duplicate"); //ensures dup entire stack
		roiManager("Select", m);
		run("Fit Ellipse");		
		run("Measure");		
		}
		selectWindow("Results");
		saveAs("Results", dir+"Results"+indexID+".txt");
		run("Clear Results");
		roiManager("reset");
		run("Close");
	}
}
