if (isOpen("Log")){
selectWindow("Log"); 
run("Close");
}
roiManager("reset") 
roiManager("Show All with labels");
roiManager("Show All");
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
ff=list.length+1;
     
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
     
        if (flags==18){xcoor[i]=x;ycoor[i]=y;mouse[i]="mother";}
      	if (flags==6){xcoor[i]=x;ycoor[i]=y;mouse[i]="child";}
      	if (flags==19){xcoor[i]=x;ycoor[i]=y;mouse[i]="g_child";}
      	if (flags==7){xcoor[i]=x;ycoor[i]=y;mouse[i]="gg_child";}
      	if (flags==27){xcoor[i]=x;ycoor[i]=y;mouse[i]="ggg_child";}
	      	if (flags==18||flags==6||flags==7||flags==19||flags==27){
	        //print(flags);
	       	i=i+1;      	
	      	makePoint(x,y);
	      	roiManager("Add");     		
		//x2=x; y2=y; z2=z; flags2=flags;
		wait(100);
	      	}
	}
endarray=roiManager("count");
f = File.open(dir+"Centers_"+ff+".txt");
for (j=0;j<endarray;j++){
print(f,j+1 +" "+ xcoor[j]+ " " + ycoor[j] + " " + mouse[j]);
}

//roiManager("Save", dir+"RoiSet.zip");