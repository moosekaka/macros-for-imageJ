if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
parentPath = getDirectory("home");
setBatchMode(true);
roiManager("reset");
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
print(list.length);
open("C:\\Users\\sweel\\Desktop\\TimecourseData\\masterFPstack.tif");
for (k=0;k<21;k++){

run("Make Substack...", "  slices="+(k+1)+"-630-21");
run("Save", "save=["+parentPath+"Documents\\" + "slicepositionBF_"+(k+1)+".tif]"); close();

}