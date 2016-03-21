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
i=0;
getCursorLoc(x, y, z, flags);


while	(isOpen(name)){
	
	getCursorLoc(x, y, z, flags);      
	      
//accepts left,right,shft+lft,ctrl+lft,shft+rht,ctrl+rht
//LFT CLICK - 16, RHT CLICK - 4, SHIFT +LFT - 17, SHIFT +RHT - 5, CTRL + LFT - 18, CTRL + RHT - 6
		        if (flags==4||flags==16||flags==17||flags==18||flags==5||flags==6) {
		        i=roiManager("index");
		      	xcoor[i]=x;ycoor[i]=y;mouse[i]=flags;
		      	//i=i+1;
		      	
		      	makePoint(x,y);
		      	roiManager("Add");
		      	roiManager("Show all with labels");	
		      				
			}
	wait(100);
	}

endarray=roiManager("count");
print(endarray);
//do not forget the "\\" at the end of the directory!
f = File.open(dir+"\\"+"Centers_"+indexID+".txt");

//write coordinates to the text file f
for (j=0;j<endarray;j++){
print(f,j+1 +" "+ xcoor[j]+ " " + ycoor[j] + " " + mouse[j]);
}

print("Your file is saved as "+"\\"+"Centers_"+indexID+".txt");
//roiManager("Save", dir+"RoiSet.zip");