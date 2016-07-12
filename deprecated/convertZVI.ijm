
run("Close All");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}

setBatchMode(true);
// prompt for directory where list of BF images are stored
  dir = getDirectory("Choose a Directory ");
  list = getFileList(dir);

//Iterate through all BF image in the list        
for (k=0;k<list.length;k++){

print(list[k]);
run("Bio-Formats", "open=C:\\Users\\sweel\\Desktop\\SWEEOLIV\\swee0425\\zvu\\"+list[k]+" autoscale color_mode=Default view=Hyperstack stack_order=XYCZT");
saveAs("Tiff", "C:\\Users\\sweel\\Desktop\\SWEEOLIV\\swee0425\\"+list[k]);
close();

}