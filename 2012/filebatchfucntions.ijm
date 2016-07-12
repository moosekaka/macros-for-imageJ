//Find all files in subdirectories CellOutput_xx and delete zip & txt files
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
count=1;
for (i=0; i<list.length; i++) {
	if (endsWith(list[i], "/")){
	list2=getFileList(dir+list[i]);
		for (j=0;j<list2.length;j++){
			if (endsWith(list2[j],".zip")||endsWith(list2[j],"Results.txt")){
			ok=File.delete(dir+list[i]+list2[j]);
			print("Deleted "+dir+list[i]+list2[j]);
			
			}
		}
	}
}