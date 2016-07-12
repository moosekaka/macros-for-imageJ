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


 function getTag(tag) {
      info = getImageInfo();
      index1 = indexOf(info, tag);
      if (index1==-1) return "";
      index1 = indexOf(info, ":", index1);
      if (index1==-1) return "";
      index2 = indexOf(info, ",", index1);
      value = substring(info, index1+1, index2);
      return value;
  }

  
for (k=0;k<list.length;k++){
nch1 = 0; nch2 = 0; nch3 = 0; nch4 = 0; nch5=0;  
	if(File.isDirectory(dir+list[k])){
	print("now on folder : "+dir+list[k]+"Pos0/");
	names=split(list[k],"/") ;
	fileList=getFileList(dir+list[k]+"Pos0/");
	print(names[0]);
	
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
		run("Image Sequence...", "open=["+dir+list[k]+"Pos0/"+fileList[nch1]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=BF sort");
		run("Save", "save=["+dir+names[0]+"_BFstack"+".tif]"); close();
		}
		
		if(nch3>0){
		run("Image Sequence...", "open=["+dir+list[k]+"Pos0/"+fileList[nch3]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=GFP sort");
		run("Save", "save=["+dir+names[0]+"_GFPstack"+".tif]"); close();
		}		
		if(nch2>0){
		run("Image Sequence...", "open=["+dir+list[k]+"Pos0/"+fileList[nch2]+"] number="+numofPics+" starting=1 increment=1 scale=100 file=RFP sort");
		//Power=getTag("DAC2_561-Volts");
		//Gain=getTag("Hamamatsu_DCAM-EMGain");
		//AcqTime=getTag("Exposure-ms");

		//Pow=substring(Power,2,indexOf(Power,"\"",2));
		//EMGn=substring(Gain,2,indexOf(Gain,"\"",2));
		//print(AcqTime);	
		//run("Save", "save=["+dir+names[0]+"_RFPstack_"+Pow+"_"+EMGn+"_"+AcqTime+".tif]"); close();
		run("Save", "save=["+dir+names[0]+"_RFPstack"+".tif]"); close();
		

		}
}
print("All Done!");

