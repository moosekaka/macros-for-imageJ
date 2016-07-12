//Macro to make stacks into max intensity proj
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose a Directory ");
 dirP=File.getParent(dir);

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);
  
for (k=0;k<list.length;k++){
	
	temp=split(list[k],"_.");
	posID=temp[1]; timeID=temp[3];
	//matches any file that starts with R or G 
	if(matches(list[k],"[RG].*.tif")){ 
	print("now on position "+posID+" timepoint "+timeID);
		
	//NOTE: directory cannot have spaces!!
	open(dir+list[k]);
	run("Z Project...", "start=1 stop=40 projection=[Max Intensity]");
	saveAs("tiff",dirP+"\\maxPrj\\maxProject_Pos_"+posID+"_Time_"+timeID); close();close();
	}
}
