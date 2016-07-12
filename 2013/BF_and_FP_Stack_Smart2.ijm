//Macro to save FP and BF  files into a stack
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
	//lastImg=fileList.length-2;
	//midImg=fileList.length/2;
	
		for (n=0;n<fileList.length;n++){
		//print(fileList[n]);	
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
		//print("number of files in folder: "+fileList.length);
		//print(dir+list[k]+fileList[nch5]); //NOTE: directory cannot have spaces!!
				
		//if(matches(fileList[1],".*BF.*")||matches(fileList[lastImg],".*BF.*")||matches(fileList[midImg],".*BF.*")){
		if(nch1>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch1]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=BF sort");
		run("Save", "save=["+dir+"BFstack_"+iDent+".tif]"); close();
		}
		
		if(nch3>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch3]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=GFP sort");
		run("Save", "save=["+dir+"GFPstack_"+iDent+".tif]"); close();
		}		
		if(nch2>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch2]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=RFP sort");
		run("Save", "save=["+dir+"RFPstack_"+iDent+".tif]"); close();
		}
		if(nch4>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch4]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=DAPI sort");
		run("Save", "save=["+dir+"DAPIstack_"+iDent+".tif]"); close();
		}
		if(nch5>0){
		run("Image Sequence...", "open=["+dir+list[k]+fileList[nch5]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=Cy5 sort");
		run("Save", "save=["+dir+"Cy5stack_"+iDent+".tif]"); close();
		}
}
print("All Done!");

