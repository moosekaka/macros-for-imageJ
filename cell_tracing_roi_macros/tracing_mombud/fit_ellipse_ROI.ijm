//Macro to cut out 8 bit stacks from ROI's 
//print("this is just to make sure log is open");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
dir = getDirectory("Choose a Directory ");
open(dir + "CombinedStack.tif");
roiManager("reset");
roiManager("Open", dir + "Tracing.zip");
n = roiManager("count");
for (k=0; k<n; k++){
		roiManager("Select", k);
		run("Fit Ellipse");		
		run("Measure");		
		}
selectWindow("Results");
saveAs("Results", dir + "Results.txt");
run("Clear Results");
roiManager("reset");
run("Close");
