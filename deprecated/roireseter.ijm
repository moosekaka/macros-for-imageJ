selectImage(2)
id = getImageID()
slicename=getInfo("image.filename")
slicename = split(slicename,".");
slicename =slicename[0]
selectWindow("CombinedStack.tif");
condition = false
str = 0; im=0;
while (str != slicename){
	str = getInfo("slice.label");
	if (str == slicename)
		{
			slicenum = getSliceNumber();
			print(str,': ',getSliceNumber());
		}
	
}
n=roiManager("Count");
selectImage("CombinedStack.tif");
roiManager("Select",n-1);
setSlice(slicenum);
roiManager("Add");
//n=roiManager("Count");
selectImage(id);
close();