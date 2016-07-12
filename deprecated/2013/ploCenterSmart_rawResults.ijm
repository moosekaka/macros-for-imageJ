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

//should only have BFstacks and center coords txt files
dir = getDirectory("Choose a Directory that contains the centers coord text files and BFstacks "); 
list = getFileList(dir);
for (i = 0; i < (list.length); i++){
  	
  	//This section finds the ID of the centers file and opens the corresp. BFstack file {
  		if(matches(list[i],"Centers.*txt")){ //opens txt file with Centers in the name
			print(dir+list[i]+" has index "+i);
			allText = File.openAsString(dir+list[i]); 
			text = split(allText, "\n"); 
			print(text.length);
			temp=split(list[i],"_.");
			indexID=temp[1]; // this is the number XX of Centers_XX.txt
			print(indexID);	
			open(dir+"BFstack_"+indexID+".tif");	
			dir2=getFileList(dir+"CellOutput_"+indexID);
			print(dir2[1]);						

			for(m=0;m<text.length;m++){				
				print(dir+"CellOutput_"+indexID+"\\"+dir2[m]);
				cell=File.openAsString(dir+"CellOutput_"+indexID+"\\"+dir2[m]);
				text2=split(cell,"\n");
	
				for(n=0;n<text2.length;n++){
					setColor("Yellow");
					point=split(text2[n]);
					Overlay.drawRect(parseInt(point[0]), parseInt(point[1]),2,2);				
				}
			}
			// opened the corresponding BFstack file     }

		//this section parses the coordinates in allText file and overlays them on the BF file	
			setColor("Green"); //can only set color AFTER image is open!
			  	for (j = 0; j < (text.length); j++){ 
			  	line = split(text[j]); 
			   	Overlay.drawRect(parseInt(line[iX]), parseInt(line[iY]),2,2); //size of rect is here
			   	Overlay.drawString(parseInt(line[0]),parseInt(line[iX]), parseInt(line[iY])); 
			  	if(parseInt(line[iLabel])==16)
			  		Overlay.drawString("mom", parseInt(line[iX])+5, parseInt(line[iY])+12); 
			  	else
			  		Overlay.drawString("bud", parseInt(line[iX])+5, parseInt(line[iY])+12); 
			  	}
			  	Overlay.show();//otherwise overlay wont show up			  	
			  	saveAs("tiff",dir+"CenterPlotted_"+indexID);// close();
  		}		
  	}
