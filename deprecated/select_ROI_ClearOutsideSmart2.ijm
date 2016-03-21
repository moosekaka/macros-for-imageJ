
//Macro to cut out 8 bit stacks from ROI's 
//print("this is just to make sure log is open");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

setBatchMode(true);
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
	ORIGINAL = getImageID;
	
	//open the correspoding ROIzip files which should have same name as the FPstack but is .zip
	temp=split(list[k],"_.");
	indexID=temp[1];
	temp2=replace(list[k],"tif","zip");	
	
	roiManager("Open",dir+temp2);	
		n = roiManager("count");
		for (m=0;m<n;m++){
		roiManager("Select", m);
		newImage("CELL_CROPPED","8-bit Black",250,250,nSlices);
		for (s = 1; s <= nSlices; s++) {
	  			selectImage(ORIGINAL);	setSlice(s);	run("Copy");
	  			selectImage("CELL_CROPPED");	
	  			setSlice(s);	
	  			run("Paste");			  	
		}
		//run("Clear Outside", "stack"); //check that default background color is black
		run("Select None"); //otherwise will have the yellow boundary
		saveAs("Tiff",dir+temp[0]+"_"+indexID+"_Roi_"+m);
		run("Close");
		}
		roiManager("reset");
		run("Close");
	}
}
print("All Done");

