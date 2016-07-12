//macro for creating 8bit z projection montage of png and stack of individual FP zstack

run("Close All");
print("this is just to make sure log is open");
selectWindow("Log"); 
run("Close"); 

_RootFolder = getDirectory("Choose a Directory");
setBatchMode(false);
item = 0;
ntiff = 0;
_List = getFileList(_RootFolder);
while (item < _List.length)  {
	if ( endsWith(_List[item],".png") ) {
		if (ntiff==0) {
			open(_RootFolder + _List[item]);
			print(_RootFolder +_List[item]);
			w = getWidth();
			h = getHeight();
			close();
		}
		ntiff++;
	}
	item++;
}

print(ntiff);

// Generating the max projection stack

newImage("temp", "8-bit black", w, h, 2);
newImage("zMaxpng", "8-bit black", 2*w, h, ntiff);
open(_RootFolder + "zMax.tif");
item = 0; im = 0;

while (item < _List.length)  {
	print(item);print(im);
	if ( endsWith(_List[item],".png") ) {
		im++;
		print(_RootFolder + _List[item]);
		open(_RootFolder + _List[item]);
		_FileName = split(_List[item],"."); 
		_FileName = _FileName[0];
		
		//run("Z Project...", "start=1 stop=500 projection=[Max Intensity]");
		run("Copy");
		//close();
		//close();
		
		selectWindow("temp");setSlice(1);run("Paste");
		selectWindow("zMax.tif");setSlice(im);run("Copy");
		selectWindow("temp");setSlice(2);run("Paste");
		run("Make Montage...", "columns=2 rows=1 scale=1 first=1 last=2 increment=1 border=0 font=12");
		selectWindow("Montage");run("Copy");
		selectWindow("zMaxpng");setSlice(im);run("Paste");
		selectWindow("Montage");close();
	}
	item++;
}

// Saving max projection stack

run("Save", "save=" +  _RootFolder + "zMaxPng.tif");
