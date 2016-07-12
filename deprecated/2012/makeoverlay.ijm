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
fileList=getFileList(dir+list[k]);
//print("number of files in folder: "+fileList.length);
}
count=0;list2=newArray(list.length);
for (j=0;j<list.length;j++){
			if (endsWith(list[j],".tif")){
				count=count+1;list2[count]=list[j];
				print(list2[count]);print(count);
			}		
			
}
//OVERLAY BF and FP

for (m=1+(count/2);m<count+1;m++){
open(dir+list2[m]); open(dir+list2[m-(count/2)]);//RHS is the BF image
selectWindow(list2[m]);//select BF, overlay the FP
run("Add Image...", "image="+list2[m-(count/2)]+" x=0 y=0 opacity=50");
saveAs("Tiff", parentPath+"Documents\\Overlay_" +list2[m]);close();close();
}








//run("Add Image...", "image=MontageFP_Pos6.tif x=0 y=0 opacity=50");