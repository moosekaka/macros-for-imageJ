//Macro to save FP  files into a stack
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose the Directory ");
 dirP=File.getParent(dir);

 print("parent Dir is :"+dirP);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
  print(dir);
  
for (k=0;k<list.length;k++){
	
	
	temp=split(list[k],"_.");
	//indexID=temp[1]; 
	//matches any file that starts with R or G 
	if(matches(list[k],"maxR.*_00_.*tif")){ 
	print("now on "+list[k]+" which has index "+k);
	//open(dir+list[k]);
	//run("Size...", "width=512 height=512 constrain average interpolation=Bilinear");
	//open rfp and gfp channels
	open(dir+"maxRFP_Project_"+temp[2]+"_"+temp[3]+"_"+temp[4]+".tif");
	open(dir+"maxRFP_Project_"+"01"+"_"+temp[3]+"_"+temp[4]+".tif");
	open(dir+"maxGFP_Project_"+"01"+"_"+temp[3]+"_"+temp[4]+".tif");
	run("Images to Stack", "name=Stack title=[] use");
	run("Make Montage...", "columns=3 rows=1 scale=1 first=1 last=3 increment=1 border=0 font=12 label");
	saveAs("tiff",dir+'\\'+"montage_"+temp[2]+"_"+temp[3]+"_"+temp[4]); close();
	}	
		
}
