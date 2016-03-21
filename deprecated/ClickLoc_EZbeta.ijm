if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
roiManager("reset") 
//roiManager("Show All");
path = File.openDialog("Select an image file to click centers for");
open(path);
dir = File.getParent(path);
name = File.getName(path);
list = getFileList(dir);
temp=split(name,"_.");
indexID=temp[1];

ff=list.length+1;
     
      shift=1;
      ctrl=2; 
      rightButton=4;
      alt=8;
      leftButton=16;
      insideROI = 32; 
      if (getVersion>="1.37r")
      setOption("DisablePopupMenu", true);
      
//store up to 100 points   
xcoor=newArray(100);ycoor=newArray(100);mouse=newArray(100);
endarray=0; //initialize endarray counter for ROI indexing
getCursorLoc(x, y, z, flags);
setFont("SansSerif", 10, "antiliased");	

while	(isOpen(name)){
	setColor("Green"); 	
	getCursorLoc(x, y, z, flags);      
	      
//accepts left,right,shft+lft,ctrl+lft,shft+rht,ctrl+rht
//LFT CLICK - 16, RHT CLICK - 4, SHIFT +LFT - 17, SHIFT +RHT - 5, CTRL + LFT - 18, CTRL + RHT - 6
		        if (flags==4||flags==16||flags==17||flags==18||flags==5||flags==6) {
		        //when a mouse event is pressed, do a recount of the number of ROI's incase of deletion
		        endarray=roiManager("count"); 
		        i=endarray;
		        makePoint(x,y);
		      	roiManager("Add");		      	       			    
		      			
		        xcoor[i]=x;ycoor[i]=y;mouse[i]=flags;		        
			temp=d2s(xcoor[i],0)+"_"+d2s(ycoor[i],0)+"_"+d2s(mouse[i],0);
			Overlay.drawString(d2s(i,0),xcoor[i],ycoor[i]); //draw the index at point clicked (this is not updated even after deletion)
			if(mouse[i]==16){
			  		Overlay.drawString("mom", xcoor[i]-5, ycoor[i]+5); }
			  	else	{
			  		Overlay.drawString("bud", xcoor[i]-5, ycoor[i]+5); }			  	
			Overlay.show();
			roiManager("select",i);
			roiManager("Rename",temp); //rename the ROI's to my format, x,y ,mom or bud label			      				
			}
	wait(100);	
	}
//do not forget the "\\" at the end of the directory!
endarray=roiManager("count"); //this is important in case a user deletes a point and immediately closes the image
f = File.open(dir+"\\"+"Centers_"+indexID+".txt");

for (j=0;j<endarray;j++){
	roiManager("select", j);
	text=call("ij.plugin.frame.RoiManager.getName", j);
	temp=split(text,"_");	
	print(f,j+1 +" "+ temp[0]+ " " + temp[1] + " " + temp[2]);
}

print("Your file is saved as "+"\\"+"Centers_"+indexID+".txt");