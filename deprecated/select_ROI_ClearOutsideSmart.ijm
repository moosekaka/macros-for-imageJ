
//Macro to cut out 8 bit stacks from ROI's 
//print("this is just to make sure log is open");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

parentPath = getDirectory("home");
//setBatchMode(true);
 dir = getDirectory("Choose a Directory to cut out ROI's ");

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);

for (k=0;k<list.length;k++){
	
	//matches name that starts with 'R', does NOT 'zip' OR 'ROI' and ends wit 'tif'
	//the (?i) at the begin of the regex is to turn mode to case insensitive matching
	if(matches(list[k],"[RG]FP(?!.*(zip|Roi)).*tif")){ 
	print("now on file : "+dir+list[k]+" which has index "+k);
	open(dir+list[k]);

	//open the correspoding ROIzip files which should have same name as the FPstack but is .zip
	temp=split(list[k],"_.");
	indexID=temp[1];
	temp2=replace(list[k],"tif","zip");
	//print(dir+temp2);
	
	roiManager("Open",dir+temp2);
	
		n = roiManager("count");
		for (m=0;m<n;m++){
		run("Duplicate...","title=NewStack duplicate"); //ensures dup entire stack
		roiManager("Select", m);
		run("Clear Outside", "stack"); //check that default background color is black
		run("Select None"); //otherwise will have the yellow boundary
		run("8-bit");
		saveAs("Tiff",dir+temp[0]+"_"+indexID+"_Roi_"+m);
		run("Close");
		}
		roiManager("reset");
		run("Close");
	}
}
print("All Done");

