//Macro to save BF files into a stack
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

print("now on folder : "+dir+list[k]);
fileList=getFileList(dir+list[k]);
print("number of files in folder: "+fileList.length);
print(dir+list[k]+fileList[1]); //NOTE: directory cannot have spaces!!
run("Image Sequence...", "open="+dir+list[k]+fileList[1]+" number=80 starting=1 increment=1 scale=100 file=B sort");
iDent=IJ.pad(k+1,2); //pads the iterator to length 2 i.e. '3' becomes '03'
run("Save", "save=["+parentPath+"Documents\\" + "BFstack_"+iDent+".tif]"); close();

}
