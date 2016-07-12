/*macro for creating 8bit montage of bf and maxproj stack with label
for cell circling as input to MitoGraph*/
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log");
run("Close");

_RootFolder = getDirectory("Choose a Directory");
setBatchMode(true);
item = 0;
ntiff = 0;
open(_RootFolder + "/BF/zBFfocal.tif");
w = getWidth();
h = getHeight();
stak=getInfo("image.filename")
open(_RootFolder + "/RFP/Max_RFP.tif");
stak2=getInfo("image.filename")
open(_RootFolder + "/GFP/Max_GFP.tif");
stak3=getInfo("image.filename")


newImage("MontageStack", "8-bit black", 3*w, h, nSlices/2); //half of nSlices because two stacks
im = 0;
for (n=0; n<nSlices; n++) {
		im++;
		selectWindow(stak);
		setSlice(im);
		resetMinAndMax();
		run("Copy");
		slicename = getInfo("slice.label");
		print(slicename);
		selectWindow("MontageStack");setSlice(im);makeRectangle(0,0,w,h);run("Paste");
		setMetadata("Label",slicename);

		selectImage(stak2);
		setSlice(im);
		resetMinAndMax();
		run("Copy");
		selectWindow("MontageStack");setSlice(im);makeRectangle(w+1,0,w,h);run("Paste");

		selectImage(stak3);
		setSlice(im);
		resetMinAndMax();
		run("Copy");
		selectWindow("MontageStack");setSlice(im);makeRectangle(2*w+1,0,w,h);run("Paste");


	}

// Saving max projection stack

run("Save", "save=" +  _RootFolder + "MontageStack.tif");
print("AllDone");