//Macro to save FP  files into a stack
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose a Directory ");

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
  
for (k=0;k<list.length;k++){
	
	//THIS IS ONLY for roi files!
	//matches any file that starts with R or G 
	if(matches(list[k],"R.*Roi.*tif")){ 
	temp=split(list[k],"_.");
	indexID=temp[1];
	indexSer=temp[2]; 
	indexRoi=temp[4];
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"maxRFP_Project_"+indexID+"_"+indexSer+"_"+indexRoi); close();close();
	}
	
	if(matches(list[k],"G.*Roi.*tif")){ 
	temp=split(list[k],"_.");
	indexID=temp[1]; 
	indexSer=temp[2]; 
	indexRoi=temp[4]; 
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"maxGFP_Project_"+indexID+"_"+indexSer+"_"+indexRoi); close();close();
	}
}
