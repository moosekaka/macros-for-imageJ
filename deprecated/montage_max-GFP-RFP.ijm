//Macro to save FP  files into a stack
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

setBatchMode(false)
 dir = getDirectory("Choose the Directory ");

  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
  print(dir+list[0])

//
for (k=0;k<list.length;k++){
	print(list[k]);
	temp=split(list[k],"_.");
	indexID=temp[2]; 
	
	//matches any file that starts with R or G 
	if(matches(list[k],"maxR.*")){ 
	print("now on "+list[k]+" which has index "+k);
	open(dir+list[k]);run("8-bit");
	//run("Size...", "width=512 height=512 constrain average interpolation=Bilinear");
	//open rfp and gfp channels
	open(dir+"maxGFP_project_"+indexID+".tif");run("8-bit");
	open(dir+"BF_FocalSlice_"+indexID+".tif");
	run("Images to Stack", "name=Stack title=[] use");
	run("Make Montage...", "columns=3 rows=1 scale=1 first=1 last=3 increment=1 border=0 font=12 label");
	saveAs("tiff",dir+'\\'+"montage_"+temp[2]); close();close();
	}	
	
}

