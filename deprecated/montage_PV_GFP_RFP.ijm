//Macro to save FP  files into a stack
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose the Paraview Directory ");
 dirP=File.getParent(dir);

 print("parent Dir is :"+dirP);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
  print(dirP+'\\'+list[1])
  
for (k=0;k<list.length;k++){
	
	run("Show All");
	
	temp=split(list[k],"_.");
	indexID=temp[1]; 
	//matches any file that starts with R or G 
	if(matches(list[k],".*.png")){ 
	print("now on "+list[k]+" which has index "+k);
	open(dir+list[k]);
	run("Size...", "width=512 height=512 constrain average interpolation=Bilinear");
	//open rfp and gfp channels
	open(dirP+"\\RFPchannel\\"+"RFPstack_"+temp[1]+"_Roi_"+temp[3]+".tif");
	open(dirP+"\\GFPchannel\\"+"GFPstack_"+temp[1]+"_Roi_"+temp[3]+".tif");
	}
	run("Images to Stack", "name=Stack title=[] use");
	run("Make Montage...", "columns=3 rows=1 scale=0.85 first=1 last=3 increment=1 border=0 font=12 label");
	
	saveAs("tiff",dirP+'\\'+"montage_"+temp[1]+"_Roi_"+temp[3]); close();close();
}

