//This batch script makes montage stacks of FP timeseries images 
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose a Directory ");
 dirTemp = getDirectory("temp");print(dirTemp);

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of folders: "+x);
  timepoint=newArray(x);
// enter j = total number of timepoints
for (j=0;j<20;j+=1){
	for (k=0;k<list.length;k++){
		if(matches(list[k],"img.*tif")){
		text=split(list[k],"_");
		//print(text[1]);	
		timepoint[k]=parseInt(text[1]);
		}				
		//check to see if the current file has the current timepoint and the correct channel	
			if (matches(list[k],".*R.*")&&(timepoint[k]==j)){			
			open(dir+list[k]);
			text2=split(list[k],"_");			
			}
	}
		temp=text2[2]+"_Time_"+IJ.pad(j+1,2);
		if(nImages>0){
			run("Images to Stack", "name=&temp title=[]");					
			saveAs("Tiff",dir+getTitle());close();	
		}	
		
}


	

			