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
	if(matches(list[k],"0507.*tif")){ 
	temp=split(list[k],"_.");
	indexID=temp[1]; 
	indexRoi=temp[3];
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"max_"+list[k]); close();close();
	}
	
		
}
