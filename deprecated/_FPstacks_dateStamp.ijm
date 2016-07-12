run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

parentPath = getDirectory("home");
setBatchMode(true)
 dir = getDirectory("Choose a Directory ");

 print(dir);
  list = getFileList(dir);
  x=list.length;
  print("number of folders: "+x);
  

for (k=0;k<list.length;k++){
nch1 = 0; nch2 = 0; nch3 = 0; nch4 = 0; nch5=0;  
	if(File.isDirectory(dir+list[k])){
	print("now on folder : "+dir+list[k]);
	fileList=getFileList(dir+list[k]);
		
		for (n=0;n<fileList.length;n++){
			
		if 	(indexOf(fileList[n],"BF") > 0)
			nch1=n;
		else if (indexOf(fileList[n],"RFP") > 0) 
			nch2=n;
		else if (indexOf(fileList[n],"GFP") > 0)
			nch3=n;
		else if (indexOf(fileList[n], "DAPI") > 0) 
			nch4=n;
		else if (indexOf(fileList[n], "Cy5") > 0)
			nch5=n;
		}
	}
numofPics=fileList.length;


		iDent=IJ.pad(k+1,2); //pads the iterator
		if(nch1>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch1]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=BF sort");
		info = getImageInfo();
		index1 = indexOf(info, "\"Date\": "); 
		Date=substring(info, index1+9);
		Date3=substring(Date,0,indexOf(Date,",")-1);
		print(Date3);
		run("Save", "save=["+dir+Date3+"_BFstack_"+iDent+".tif]"); close();
		}

		if(nch3>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch3]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=GFP sort");
		info = getImageInfo();
		index1 = indexOf(info, "\"Date\": "); 
		Date=substring(info, index1+9);
		Date3=substring(Date,0,indexOf(Date,",")-1);
		run("Save", "save=["+dir+Date3+"_GFPstack_"+iDent+".tif]"); close();
		}
				
		if(nch2>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch2]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=RFP sort");
		info = getImageInfo();
		index1 = indexOf(info, "\"Date\": "); 
		Date=substring(info, index1+9);
		Date3=substring(Date,0,indexOf(Date,",")-1);
		run("Save", "save=["+dir+Date3+"_RFPstack_"+iDent+".tif]"); close();
		}
		
}
print("All Done!");
