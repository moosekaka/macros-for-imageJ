// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.ijm") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.

macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
	setKeyDown("Esc");
}


//----------------------------------------------------------------------------------------------------------------------------------------------
macro 
"addROItobigStack Action Tool-Cba8L00f0L0111C00fD21Cba8D31C00fD41Cba8L5161C00fL7191Cba8Da1C00fDb1Cba8Lc1f1L0212C00fL2232Cba8D42C00fD52Cba8D62C00fD72Cba8D82C00fD92Cba8Da2C00fDb2Cba8Lc2f2L0313C00fD23Cba8L3343C00fD53Cba8D63C00fD73Cba8D83C00fD93Cba8Da3C00fDb3Cba8Lc3f3L0414C00fD24Cba8L3464C00fD74Cba8D84C00fD94Cba8Da4C00fDb4Cba8Lc4f4L0515C00fD25Cba8L3565C00fL7595Cba8Da5C00fDb5Cba8Lc5f5L06f6L07f7L0818C00fL2858Cba8L68f8L0919C00fD29Cba8L3949C00fD59Cba8D69C00fL79a9Cba8Db9C00fLc9e9Cba8Df9L0a1aC00fD2aCba8L3a4aC00fD5aCba8D6aC00fD7aCba8L8a9aC00fDaaCba8DbaC00fDcaCba8LdafaL0b1bC00fL2b4bCba8L5b6bC00fL7babCba8DbbC00fLcbdbCba8LebfbL0c1cC00fD2cCba8L3c4cC00fD5cCba8D6cC00fD7cCba8L8cdcC00fDecCba8DfcL0d1dC00fD2dCba8L3d4dC00fD5dCba8D6dC00fL7dadCba8DbdC00fLcdedCba8DfdL0efeL0fff"
{selectImage(2)
id = getImageID()
slicename=getInfo("image.filename")
slicename = split(slicename,".");
slicename =slicename[0]
selectWindow("CombinedStack.tif");
condition = false
str = 0; im=0;
while (str != slicename){
	str = getInfo("slice.label");
	if (str == slicename)
		{
			slicenum = getSliceNumber();
			//print(str,': ',getSliceNumber());
		}
	
}
n=roiManager("Count");
selectImage("CombinedStack.tif");
roiManager("Select",n-1);
setSlice(slicenum);
roiManager("Add");
roiManager("Select",n-1);
roiManager("Delete");
roiManager("Select",n-1);
selectImage(id);
}
//--------------------------------SaveTracingRois------------------------------------------------------------------------------------------------------------------------
macro "SaveTracingRois Action Tool-C932L00f0D01Cf00L1141C932L51f1D02Cf00D12C932L22f2D03Cf00D13C932L2373Cf00L8393C932Da3Cf00Db3C932Lc3d3Cf00De3C932Df3D04Cf00L1444C932L5464Cf00D74C932D84Cf00D94C932Da4Cf00Lb4c4C932Dd4Cf00De4C932Df4L0535Cf00D45C932D55Cf00D65C932L7585Cf00D95C932La5b5Cf00Lc5e5C932Df5L0636Cf00D46C932D56Cf00D66C932L7686Cf00D96C932La6b6Cf00Lc6d6C932Le6f6D07Cf00L1747C932D57Cf00L6797C932La7c7Cf00Dd7C932Le7f7L08f8D09Cf00L1949C932D59Cf00L6999C932La9b9Cf00Dc9C932Ld9f9D0aCf00D1aC932L2a3aCf00D4aC932D5aCf00D6aC932L7a8aCf00D9aC932LaafaD0bCf00D1bC932L2b3bCf00D4bC932D5bCf00D6bC932L7b8bCf00D9bC932LabbbCf00DcbC932LdbfbD0cCf00L1c4cC932D5cCf00D6cC932L7c8cCf00D9cC932LacbcCf00DccC932LdcfcD0dCf00D1dC932D2dCf00D3dC932L4d5dCf00D6dC932L7d8dCf00D9dC932LadbdCf00DcdC932LddfdD0eCf00D1eC932L2e3eCf00D4eC932D5eCf00L6e9eC932LaebeCf00LcedeC932LeefeL0fff"
{
selectWindow("CombinedStack.tif");
_RootFolder = File.getParent(getInfo("image.directory"));
roiManager("Save", _RootFolder+"\\RoiSet.zip");
}

//--------------------------------Open Full Stack and Focus Slice------------------------------------------------------------------------------------------------
macro "OpenStackandFocusSlice Action Tool - C3acL00f0D01C0ffL1141C3acD51C0ffL6191C3acLa1f1D02C0ffD12C3acL2232C0ffD42C3acD52C0ffD62C3acL7282C0ffD92C3acDa2C0ffLb2e2C3acDf2D03C0ffD13C3acL2333C0ffD43C3acD53C0ffL6393C3acDa3C0ffDb3C3acLc3d3C0ffDe3C3acDf3D04C0ffD14C3acL2434C0ffD44C3acD54C0ffD64C3acL74a4C0ffDb4C3acLc4d4C0ffDe4C3acDf4D05C0ffL1545C3acD55C0ffD65C3acL75a5C0ffDb5C3acLc5d5C0ffDe5C3acDf5L06f6L07f7D08C0ffL1848C3acD58C0ffL6898C3acDa8C0ffDb8C3acLc8d8C0ffDe8C3acDf8D09C0ffD19C3acL2979C0ffD89C3acL99a9C0ffDb9C3acDc9C0ffDd9C3acLe9f9D0aC0ffD1aC3acL2a7aC0ffD8aC3acL9aaaC0ffLbacaC3acLdafaD0bC0ffL1b4bC3acL5b7bC0ffD8bC3acL9babC0ffDbbC3acDcbC0ffDdbC3acLebfbL0c3cC0ffD4cC3acL5c7cC0ffD8cC3acL9cacC0ffDbcC3acLccdcC0ffDecC3acDfcL0d3dC0ffD4dC3acL5d7dC0ffD8dC3acL9dadC0ffDbdC3acLcdddC0ffDedC3acDfdD0eC0ffL1e4eC3acL5e7eC0ffD8eC3acL9eaeC0ffDbeC3acLcedeC0ffDeeC3acDfeL0fff"
{
// This macro finds opens the full stack for tracing and centers to the min stddev slice
selectWindow("CombinedStack.tif");
slicename = getInfo("slice.label");
_RootFolder = getInfo("image.directory");
open(_RootFolder+slicename+".tif");
setBatchMode(false);

setSlice(1);
getStatistics(area, mean, min, max,stdev);
minVal=stdev;frameToDup=1;
//iterate through all slices, measure the mean, and compare to the min stdev
for (n=1; n<=nSlices; n++) {
	setSlice(n);
	getStatistics(area, mean, min, max, stdev);
		if (stdev<minVal) {
		minVal = stdev;	//if it is smaller than minVal, then mark this slice as the new minVal
		frameToDup = n;
	}
	setSlice(frameToDup+3);
}
}

//--------------------------------single z stack ------------------------------------------------------------------------------
macro 
"single Z stack Action Tool -Cbb4L00f0L0131C40fL41a1Cbb4Lb1f1L0272C40fL82a2Cbb4Lb2f2L0363C40fL7383Cbb4L93f3L0454C40fL6474Cbb4L84f4L0545C40fL5565Cbb4L75f5L0636C40fL46a6Cbb4Lb6f6L07f7D08C40fL1858Cbb4D68C40fD78Cbb4L88b8C40fDc8Cbb4Ld8f8D09C40fD19Cbb4L2969C40fD79Cbb4L89b9C40fDc9Cbb4Ld9f9D0aC40fD1aCbb4L2a6aC40fL7aaaCbb4DbaC40fDcaCbb4DdaC40fLeafaCbb4D0bC40fL1b5bCbb4D6bC40fD7bCbb4L8bbbC40fLcbdbCbb4LebfbL0c4cC40fD5cCbb4D6cC40fD7cCbb4L8cbcC40fDccCbb4DdcC40fDecCbb4DfcD0dC40fL1d5dCbb4D6dC40fL7dadCbb4DbdC40fDcdCbb4LddedC40fDfdCbb4L0efeL0fff"{
x=getImageID();
selectImage(x);
run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
}
//--------------------------------make substack-----------------------------------------------------------------------------------------------
macro"make Substack Action Tool -C8f1L00f0D01C00fD11C8f1L2141C00fD51C8f1D61C00fD71C8f1L8191C00fDa1C8f1Db1C00fLc1f1C8f1D02C00fL1252C8f1D62C00fD72C8f1D82C00fD92C8f1La2b2C00fDc2C8f1Ld2f2D03C00fD13C8f1D23C00fD33C8f1D43C00fD53C8f1D63C00fL7383C8f1L93b3C00fLc3e3C8f1Df3D04C00fD14C8f1L2444C00fD54C8f1D64C00fD74C8f1D84C00fD94C8f1La4b4C00fDc4C8f1Ld4f4D05C00fD15C8f1L2545C00fD55C8f1D65C00fD75C8f1L8595C00fDa5C8f1Db5C00fLc5f5C8f1L06f6L07f7D08C00fL1858C8f1L68b8C00fDc8C8f1Ld8f8D09C00fD19C8f1L29b9C00fDc9C8f1Ld9f9D0aC00fD1aC8f1L2abaC00fDcaC8f1LdafaD0bC00fL1b5bC8f1D6bC00fD7bC8f1L8b9bC00fDabC8f1DbbC00fLcbfbC8f1L0c4cC00fD5cC8f1D6cC00fD7cC8f1L8c9cC00fDacC8f1DbcC00fDccC8f1LdcecC00fDfcC8f1L0d4dC00fD5dC8f1D6dC00fD7dC8f1L8d9dC00fDadC8f1DbdC00fDcdC8f1LddedC00fDfdC8f1D0eC00fL1e5eC8f1D6eC00fL7eaeC8f1DbeC00fLcefeC8f1L0fff"{
	x=getImageID();
	temp=getInfo("image.filename");
	temp2=split(temp,".");
	name=temp2[0];
	dir=getDirectory("image");
	//print(dir+name);
	selectImage(x);
	z=nSlices;
	y=getNumber("enter starting slice position", 0);
	
	run("Make Substack...", "  slices="+y+"-"+z);
	y=getImageID();
	selectImage(y);
	saveAs("tiff",dir+"sub"+name);
	run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
	
}

macro
"add_resetROI [y]" {
		selectImage(2)
		id = getImageID()
		slicename=getInfo("image.filename")
		slicename = split(slicename,".");
		slicename =slicename[0]
		selectWindow("CombinedStack.tif");
		condition = false
		str = 0; im=0;
		while (str != slicename){
			str = getInfo("slice.label");
			if (str == slicename)
				{
					slicenum = getSliceNumber();
					//print(str,': ',getSliceNumber());
				}
			
		}
		n=roiManager("Count");
		selectImage("CombinedStack.tif");
		roiManager("Select",n-1);
		setSlice(slicenum);
		roiManager("Add");
		roiManager("Select",n-1);
		roiManager("Delete");
		roiManager("Select",n-1);
		selectImage(id);
    }

macro
"open_fullbfstck [r]" {
	
		// This macro finds opens the full stack for tracing and centers to the min stddev slice
		selectWindow("CombinedStack.tif");
		slicename = getInfo("slice.label");
		
		_RootFolder = getInfo("image.directory");
		open(_RootFolder+slicename+".tif");
		setBatchMode(false);
		
		setSlice(1);
		getStatistics(area, mean, min, max,stdev);
		minVal=stdev;frameToDup=1;
		for (n=1; n<=nSlices; n++) {
			setSlice(n);
			getStatistics(area, mean, min, max, stdev);
				if (stdev<minVal) {
				minVal = stdev;	
				frameToDup = n;
			}
			setSlice(frameToDup+3);
		}
		
}

macro
"save_roi [u]" {
	selectWindow("CombinedStack.tif");
	_RootFolder = getInfo("image.directory")
	//_RootFolder = File.getParent(getInfo("image.directory"));
	roiManager("Save", _RootFolder+"\\Tracing.zip");
	print("ROI Saved to ", _RootFolder+"\\Tracing.zip");
}
