//This makes stacks for each timepoint and each position
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
dir = getDirectory("Choose a Directory ");
 //dirTemp = getDirectory("temp");print(dirTemp);

 print(dir);
 dirP=File.getParent(dir);
 File.makeDirectory(dirP+"\\RFP\\") ;
 File.makeDirectory(dirP+"\\GFP\\") ;
 File.makeDirectory(dirP+"\\BF\\") ;
  positionFolders = getFileList(dir);
  x=positionFolders.length;
  print("number of folders: "+x);
  //print(positionFolders[1]);
for (i=0;i<x;i+=1){
  list=getFileList(dir+positionFolders[i]);	
  //print(list[1]);
  y=list.length;
  timepoint=newArray(y);
// enter j = total number of timepoints
	for (j=0;j<1;j+=1){
		for (k=0;k<list.length;k++){
			if(matches(list[k],"img.*tif")){
			text=split(list[k],"_");
			//print(text[1]);	
			timepoint[k]=parseInt(text[1]);
			}				
			//check to see if the current file has the current timepoint and the correct channel	
				if (matches(list[k],".*R.*")&&(timepoint[k]==j)){			
				open(dir+positionFolders[i]+list[k]);
				text2=split(list[k],"_");			
				}
		}
			
			if(nImages>0){
				temp=text2[2]+"Position_"+IJ.pad(i,2)+"_Time_"+IJ.pad(j+1,2);
				run("Images to Stack", "name=&temp title=[]");	
				print("Saving to "+dirP+"\\RFP\\"+temp);				
				saveAs("Tiff",dirP+"\\RFP\\"+temp);close();	
			}	
			
	}
}


	

			