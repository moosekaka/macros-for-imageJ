//Macro to fit Ellipse from output of MATLAB ROI's
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
x=list.length;
print("number of files/folders= "+x);

//find the number of text files containing the MATLAB output
count=1;
for (j=0;j<list.length;j++){
	if(endsWith(list[j],"txt")){
  	//print(list[j]);
  	count++;
	}
}
  
print("number of text files= "+count);  
  
for (k=1;k<count;k++){
run("XY Coordinates... ", "open="+dir+"Cell_"+k+".txt");
run("Fit Ellipse");
roiManager("Add");
}
//roiManager("Sort");
roiManager("Save", dir+"RoiSet.zip");

//Display fitted ellipse on processed BFSubstack 
//open(dir+"Substack.tif");
//setBatchMode(false);
//roiManager("Sort");
//roiManager("Show All with labels");
