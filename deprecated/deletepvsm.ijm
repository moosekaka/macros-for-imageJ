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
	if(matches(list[k],".*FP.*")){ 
		File.rename(dir+"BFstack_"+IJ.pad(indexID+1,2)+".tif",dir+"BFstack_"+IJ.pad(indexID,2)+".tif")
	print("now on "+list[k]+" which has index "+k);
	}
}

