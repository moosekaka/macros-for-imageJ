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
 
file = File.openDialog("Select the text file to read"); 
allText = File.openAsString(file); 
text = split(allText, "\n"); 
hdr = split(text[0]); 

//these are the column indices 
iX = 1; 
iY = 2; 
iLabel = 3; 

dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
setForegroundColor(255,255,255);
 //print(dir);
  //list = getFileList(dir);
  //x=list.length;
  //print("number of folders: "+x);
  //print(dir+list[1]);
  open(dir+list[1]);

  setFont("SansSerif", 20, "antiliased"); 
  for (i = 0; i < (text.length); i++){ 
   line = split(text[i]); 
    setColor("cyan");
   Overlay.drawRect(parseInt(line[iX]), parseInt(line[iY]),3,3); 
   setColor("yellow");
  Overlay.drawString(line[iLabel], parseInt(line[iX])+10, parseInt(line[iY])+25); 
  
} 