//macro for creating 8bit montage of bf and maxproj stack with label

run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

_RootFolder = getDirectory("Choose a Directory");
setBatchMode(true);
item = 0;
ntiff = 0;
open(_RootFolder + "/BF/cropped_zBFfocal.tif");
w = getWidth();
h = getHeight();
stak=getInfo("image.filename")
open(_RootFolder + "/RFP/cropped_maxRFP.tif");
stak2=getInfo("image.filename")

print (stak2, stak)

newImage("CombinedStack", "8-bit black", 2*w, h, nSlices);
im = 0;
for (n=0; n<nSlices; n++) { 
		im++;
		selectWindow(stak);setSlice(im);run("Copy");
		slicename = getInfo("slice.label");
		print(slicename);
		selectWindow("CombinedStack");setSlice(im);makeRectangle(0,0,w,h);run("Paste");
		setMetadata("Label",slicename);
		
		selectImage(stak2);
		setSlice(im); run("Copy");
		selectWindow("CombinedStack");setSlice(im);makeRectangle(w+1,0,w,h);run("Paste");
		
	}

// Saving max projection stack

run("Save", "save=" +  _RootFolder + "CombinedStack.tif");
print("AllDone");