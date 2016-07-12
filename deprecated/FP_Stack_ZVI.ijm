// This macro finds the frame in the z-stack with the min Stdev, makes a substack around this slice and runs preprocessing on the substack

run("Close All");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

setBatchMode(true);
// prompt for directory where list of BF images are stored
  dir = getDirectory("Choose a Directory ");
  list = getFileList(dir);

//Iterate through all BF image in the list        
for (k=0;k<list.length;k++){
nch1 = 0; nch2 = 0; nch3 = 0; nch4 = 0; nch5=0;  
	
	print("now on file : "+dir+list[k]);
	
	//print(fileList[n]);	
	print(indexOf(list[k],"wee"));
	if (indexOf(list[k],"wee") > 0){
		nch1=k;print(nch1);
	}
		
	if(nch1>0){	
	run("Image Sequence...", "open=["+dir+list[k]+"] number="+100+" starting=1 increment=1 scale=100 file=swee sort");
	run("Save", "save=["+dir+"RFP_"+list[k]); close();
	}
}
print("All Done!");