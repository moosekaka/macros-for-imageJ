//Macro to batch fit Ellipse from output of MATLAB ROI's
// begin macro
//Macro to plot points from cell coordinates text file
run("Close All");
if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
roiManager("reset") 
roiManager("Show All with labels");
roiManager("Show All");
setBatchMode(false);

iX = 1; 
iY = 2; 
iLabel = 3; 

setBatchMode(false);
setForegroundColor(0,0,0);
setFont("SansSerif", 12, "antiliased"); 

dir = getDirectory("Choose a Directory that contains the centers coord text files and BFstacks "); 
list = getFileList(dir);
for (i = 0; i < (list.length); i++){
	//This section finds the ID of the centers file and opens the corresp. BFstack file {
  		if(matches(list[i],"max.FP_Project_..\\.tif")){ //opens txt file with Centers in the name
			print(dir+list[i]+" has index "+i);
			temp=split(list[i],"_.");
			indexID=temp[2]; // this is the number XX of Centers_XX.txt
			open(dir+list[i]);
			open(dir+"RFPstack_"+indexID+".zip");	
			counter=roiManager("count");
			print("number of rois "+counter);
			for (k=0;k<counter;k++){
			  		roiManager("select", k)
			  		getSelectionCoordinates(x,y);
			  		//Draws the coords as connected lines
			  		for (m=1; m<x.length; m++) {         				
         				Overlay.drawLine(x[m],y[m],x[m-1],y[m-1]);         				
			  		}
			  	}	 
			roiManager("reset");	
			Overlay.show();
		
  }

}
