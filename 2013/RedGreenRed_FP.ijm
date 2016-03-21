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
	print(list[k]);
	temp=getFileList(dir+list[k]);
	n1=0;n2=0;
		for  (j=0;j<temp.length;j++){
		temp2=split(temp[j],"_");	
				
			if (indexOf(temp[j],"GFP")>0 && indexOf(temp[j],"000000001")>0) {
				
				if(indexOf(temp[j],"_000.tif")>0){
					n1=j; //first
				}
			n2=j; //last
			}	
		}
		if (n1>0){
		iDent=IJ.pad(k+1,2);
		print(n1+" "+n2);	
		run("Image Sequence...", "open=["+dir+list[k]+temp[n1]+"] number="+(n2-n1+1)+" starting="+n1+" increment=1 scale=100 file=GFP sort");
		run("Save", "save=["+dir+"GFPstack_01_"+iDent+".tif]"); close();	
		}
	}
}
	