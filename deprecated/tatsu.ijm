// This macro demonstrates how to create a HyperStack
// and how to control it using the Stack macro functions.
setBatchMode(true);
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
numberOfPositions = 0;
info=File.openAsString(dir+list[1]+"metadata.txt");
index1 = indexOf(info,'Slices": ');
numberOfSlices=parseInt(substring(info,index1+9,index1+11));
index2 = indexOf(info,'Frames": ');
numberOfTimePoints=parseInt(substring(info,index2+9,index2+11));
index3=indexOf(info,'Positions": ');
numberOfPositions=parseInt(substring(info,index3+12,index3+13));

//get number of positions
list = getFileList(dir);
print(numberOfPositions);
print(numberOfTimePoints);
print(numberOfSlices);

for (h=1;h<numberOfPositions-3;h++){
	run("New HyperStack...", "title=Position_"+h+" type=16-bit width=512 height=512 channels=3 slices=numberOfPositions frames=numberOfTimePoints");
	posStack=getImageID;
	for (i=0;i<numberOfTimePoints;i++){	
		run("New HyperStack...", "title="+h+"_"+"time_"+i+" type=16-bit width=512 height=512 channels=3 slices=numberOfSlices");
		timeStack=getImageID;
		for (j=0;j<numberOfSlices-45;j++){	
			open(dir+list[h]+"img_"+IJ.pad(i,9)+"_BF_confocal_"+IJ.pad(j,3)+".tif");
			temp1=getImageID;run("Copy");selectImage(timeStack);Stack.setChannel(1);Stack.setSlice(j+1);run("Paste");
			open(dir+list[h]+"img_"+IJ.pad(i,9)+"_GFP_confocal_"+IJ.pad(j,3)+".tif");
			temp2=getImageID;run("Copy");selectImage(timeStack);Stack.setChannel(2);Stack.setSlice(j+1);run("Paste");
			open(dir+list[h]+"img_"+IJ.pad(i,9)+"_RFP_confocal_"+IJ.pad(j,3)+".tif");
			temp3=getImageID;run("Copy");selectImage(timeStack);Stack.setChannel(3);Stack.setSlice(j+1);run("Paste");		
			selectImage(temp1);close();
			selectImage(temp2);close();	
			selectImage(temp3);close();
			}
		selectImage(timeStack);Stack.setChannel(1);
		run("Z Project...", "start=1 stop=numberOfSlices projection=[Max Intensity]");
		tempMax=getImageID;run("Copy");
		selectImage(posStack);Stack.setSlice(h+1);Stack.setChannel(1);Stack.setFrame(i+1);run("Paste");
		selectImage(tempMax);close();
		
		selectImage(timeStack);Stack.setChannel(2);
		run("Z Project...", "start=1 stop=numberOfSlices projection=[Max Intensity]");
		tempMax=getImageID;run("Copy");
		selectImage(posStack);setSlice(h+1);Stack.setChannel(3);Stack.setFrame(i+1);run("Paste");
		selectImage(tempMax);close();
		
		selectImage(timeStack);Stack.setChannel(3);
		run("Z Project...", "start=1 stop=numberOfSlices projection=[Max Intensity]");
		tempMax=getImageID;run("Copy");
		selectImage(posStack);Stack.setSlice(h+1);Stack.setChannel(1);Stack.setFrame(i+1);run("Paste");
		selectImage(tempMax);close();	
		}
	selectImage(posStack);
	run("Save", "save=" +  dir + "MaxProjs_Position_"+h+".tif");

}
