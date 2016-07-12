//This batch script makes montage stacks of BF timeseries images 
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
 //loop through each position k
for (k=0;k<list.length;k++){
		sep=indexOf(list[k],"/");
		position=substring(list[k],0,sep);
		print(position);
print("now on folder : "+dir+list[k]);
fileList=getFileList(dir+list[k]);
print("number of files in folder: "+fileList.length);

run("Image Sequence...", "open="+dir+list[k]+fileList[1]+" number=1639 starting=1 increment=1 scale=100 file=B convert sort");
	
	
			for (j=15;j<40;j++){ 
			run("Make Substack...", "  slices="+(j-5)+"-819-39");
			//run("Save", "save=["+parentPath+"Documents\\" + "Pos_"+k+"_Slice_"+(j-5)+".tif]"); close();	
			run("Save", "save=["+dirTemp + "Pos_"+k+"_Slice_"+(j-5)+".tif]"); close();
			}
//loop through each slicePosition  m and make montage
			for (m=15;m<40;m++){ 
			open(dirTemp + "Pos_"+k+"_Slice_"+(m-5)+".tif");
			run("Make Montage...", "columns=5 rows=5 scale=1 first=1 last=21 increment=1 border=0 font=12");
			run("Save", "save=["+dirTemp + "Montage_"+k+"_Slice_"+(m-5)+".tif]"); close();close();
			}
run("Image Sequence...", "open="+dirTemp+" number=90 starting=1 increment=1 scale=100 file=Mon or=[] sort");
run("Save", "save=["+parentPath+"Documents\\" + "Montage_"+position+".tif]"); close();
list2=getFileList(dirTemp);
//cleanup Temp dir	
	for (n=0;n<list2.length;n++){
			if (endsWith(list2[n],".tif")){
			ok=File.delete(dirTemp+list2[n]);
			print("Deleted "+dirTemp+list2[n]);
			}
	}
close();
}