//Macro to throw away the last 5 slices from a bad stack
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
//setBatchMode(true)
 dir = getDirectory("Choose a Directory ");

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of files: "+x);

for (k=0;k<list.length;k++){
	if(matches(list[k],".*[BGR]F.*")){
	print("now on file : "+dir+list[k]+" which has index "+k);
	open(dir+list[k]);
	getDimensions(width, height, channels, slices,frames);
	run("Make Substack...", "  slices=22-"+slices-11);
	saveAs("Tiff",parentPath+"Documents\\"+list[k]);
	close();
	close();
	}
	
}

		

