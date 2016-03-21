
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose the directory that contains the stacks for max projection ");

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
  print(list[0]);
  
for (k=0;k<list.length;k++){
	
	names=split(list[k],"/");
	//print(names[0]);
	//print(list[k]);
	temp=split(list[k],"_.");
	//print(temp[1]);
	indexID=temp[1]; 
	
	if(matches(list[k],".*[R].*.tif")){ 
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	setSlice(nSlices/2);
	run("Duplicate...", "title="+list[k]);
	saveAs("tiff",dir+"maxRFP_Project_"+names[0]); close();close();
	}
	if(matches(list[k],"[D].*.tif")){ 
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"maxDAPI_Project_"+indexID); close();close();
	}
	if(matches(list[k],"[C].*.tif")){ 
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"maxCy5_Project_"+indexID); close();close();
	}
}