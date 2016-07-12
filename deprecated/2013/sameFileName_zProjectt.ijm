
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
	temp=split(list[k],"_");
	//print(temp[1]);
	indexID=temp[2]; 
	
	
	if(matches(list[k],".*RFP.*.tif")){ 
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"maxRFP_"+temp[0]+"_"+temp[1]+"_"+temp[2]); close();close();
	}
	if(matches(list[k],".*GFP.*.tif")){ 
	print("now on "+list[k]+" which has index "+k);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	saveAs("tiff",dir+"maxGFP_"+temp[0]+"_"+temp[1]+"_"+temp[2]); close();close();
	}
}
print("Done!");