//Macro to save FP  files into a stack
run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 
		     
shift=1;
ctrl=2; 
rightButton=4;
alt=8;
leftButton=16;
insideROI = 32; 


parentPath = getDirectory("home");
//setBatchMode(true)
 dir = getDirectory("Choose a Directory ");
 dirP=File.getParent(dir);

 print(dir);
 list = getFileList(dir);
 x=list.length;
 print("number of files: "+x);
 temp=newArray();
//______________________________Find all timepoints for the current position and store in Array temp_________________________________________________________________________________
 
 for (i=0;i<list.length;i++){  	
 	text=split(list[i],"_");  	
	if(matches(text[1],"00")){
		temp=Array.concat(temp,list[i]);
	  	Array.print(temp);
	}	
 }

//______________________________For each timepoint manually input click the centers of the cells______________________________________________________________________________________

for (m=0;m<temp.length-15;m++){ 	
 
open(dir+temp[m]); 
setOption("DisablePopupMenu", true);
roiManager("reset")
name=getTitle();
delims=split(name,"_.");
posID=delims[1];
timeID=delims[3];
//store up to 100 points   
xcoor=newArray(100);ycoor=newArray(100);mouse=newArray(100);
endarray=0; //initialize endarray counter for ROI indexing
setFont("SansSerif", 10, "antiliased");	
	while	(isOpen(name)){
	setColor("Green"); 	
	getCursorLoc(x, y, z, flags);     if (flags==4||flags==16||flags==17||flags==18||flags==5||flags==6) {
		        //when a mouse event is pressed, do a recount of the number of ROI's incase of deletion
		        endarray=roiManager("count"); 
		        i=endarray;
		        makePoint(x,y);
		      	roiManager("Add");		      	       			    
		      			
		        xcoor[i]=x;ycoor[i]=y;mouse[i]=flags;		        
			temp2=d2s(xcoor[i],0)+"_"+d2s(ycoor[i],0)+"_"+d2s(mouse[i],0);
			Overlay.drawString(d2s(i,0),xcoor[i],ycoor[i]); //draw the index at point clicked (this is not updated even after deletion)
			if(mouse[i]==16){
			  		Overlay.drawString("mom", xcoor[i]-5, ycoor[i]+5); }
			 else if(mouse[i]==4)	{
			  		Overlay.drawString("D_1", xcoor[i]-5, ycoor[i]+5); }
			  else if(mouse[i]==17)	{
			  		Overlay.drawString("D_2", xcoor[i]-5, ycoor[i]+5); }
			  else  {
			  	Overlay.drawString("D_3", xcoor[i]-5, ycoor[i]+5);}			  	
			Overlay.show();
			roiManager("select",i);
			roiManager("Rename",temp2); //rename the ROI's to my format, x,y ,mom or bud label			      				
		        }
	wait(100);	
	}
	
	endarray=roiManager("count"); //this is important in case a user deletes a point and immediately closes the image
	
	f = File.open(dirP+"\\"+"Centers\\Ctr_"+posID+"_"+timeID+".txt");
	
	for (j=0;j<endarray;j++){
		roiManager("select", j);
		text2=call("ij.plugin.frame.RoiManager.getName", j);
		temp3=split(text2,"_");	
		print(f,j+1 +" "+ temp3[0]+ " " + temp3[1] + " " + temp3[2]);
	}
	File.close(f);
	print("Your file is saved as "+"\\"+"Centers\\Ctr_"+posID+"_"+timeID+".txt");
//___________________Plot the last center file________________________________________________________________________________________________________________________________________

iX = 1; 
iY = 2; 
iLabel = 3; 
			allText = File.openAsString(dirP+"\\"+"Centers\\Ctr_"+posID+"_"+timeID+".txt"); 
			text = split(allText, "\n"); 
			temp4=split(list[i],"_.");
			indexID=temp4[1]; // this is the number XX of Centers_XX.txt
			//print(indexID);								
			
			open(dir+temp[m]);
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