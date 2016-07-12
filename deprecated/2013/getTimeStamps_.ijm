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
	//print("now on folder : "+dir+list[k]);
	
	fileList=getFileList(dir+list[k]);
	
		for (n=0;n<fileList.length;n++){
			nch2=10000;
			if (indexOf(fileList[n],"R") >= 0) 
				nch2=n;
			
	
				if(nch2!=10000){
					
				open(dir+list[k]+fileList[n]);
				info = getImageInfo();
				index1 = indexOf(info, "\"Time\":");
				Time=substring(info, index1+9, indexOf(info, "0700", index1)-1);
				print(fileList[n]);print(Time);close();
				}
	
			}	
		}
}	
	
print("All Done!");