if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
roiManager("reset") 
roiManager("Show All with labels");
roiManager("Show All");
     
      shift=1;
      ctrl=2; 
      rightButton=4;
      alt=8;
      leftButton=16;
      insideROI = 32; 
      if (getVersion>="1.37r")
      setOption("DisablePopupMenu", true);
     
logOpened = false;
x2=-1; y2=-1; z2=-1; flags2=-1;
xcoor=newArray(100);ycoor=newArray(100);mouse=newArray(100);
i=0;
//while (!logOpened || isOpen("Log")) {
getCursorLoc(x, y, z, flags);

while (flags!=1){
      getCursorLoc(x, y, z, flags);
      //print(flags);
        if (flags==4||flags==16) {
      	xcoor[i]=x;ycoor[i]=y;mouse[i]=flags;
      	i=i+1;
      	//print(x+" "+y+ " "+flags);
      	makePoint(x,y);
      	roiManager("Add");
	//logOpened = true;
	
	}
	x2=x; y2=y; z2=z; flags2=flags;
wait(100);
}
endarray=roiManager("count");
f = File.open("");
for (j=0;j<endarray;j++){
print(f,j+1 +" "+ xcoor[j]+ " " + ycoor[j] + " " + mouse[j]);
}

roiManager("Save", "C:\\Users\\sweel\\Desktop\\RoiSet.zip");