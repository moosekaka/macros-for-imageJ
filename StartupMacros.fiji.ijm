// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.ijm") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.


function getFocal(id){
//returns the slice number with the best focus in BF
	selectImage(id);
	getDimensions(w, h, dummy, slices, dummy);
	run("Set Measurements...", "area mean standard modal min limit display redirect=None decimal=3");

		//set initial stdev value to that of frame 1
		frameToDup=1;
		setSlice(1);
		getStatistics(area, mean, min, max,stdev);
		minVal = stdev;

		for (n=2; n<=slices; n++) {
			setSlice(n);
			getStatistics(area, mean, min, max, stdev);
			if (stdev < minVal) {
			minVal = stdev;
			frameToDup = n;
			}
		}
		return frameToDup;
}


macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
	setKeyDown("Esc");
}

/*
 SaveRPTracingRois
 Macro to save ROI's from cell circling of max proj FP for Mitograph input
*/
macro "SaveFPTracingRois Action Tool-C932L00f0D01Cf00L1141C932L51f1D02Cf00D12C932L22f2D03Cf00D13C932L2373Cf00L8393C932Da3Cf00Db3C932Lc3d3Cf00De3C932Df3D04Cf00L1444C932L5464Cf00D74C932D84Cf00D94C932Da4Cf00Lb4c4C932Dd4Cf00De4C932Df4L0535Cf00D45C932D55Cf00D65C932L7585Cf00D95C932La5b5Cf00Lc5e5C932Df5L0636Cf00D46C932D56Cf00D66C932L7686Cf00D96C932La6b6Cf00Lc6d6C932Le6f6D07Cf00L1747C932D57Cf00L6797C932La7c7Cf00Dd7C932Le7f7L08f8D09Cf00L1949C932D59Cf00L6999C932La9b9Cf00Dc9C932Ld9f9D0aCf00D1aC932L2a3aCf00D4aC932D5aCf00D6aC932L7a8aCf00D9aC932LaafaD0bCf00D1bC932L2b3bCf00D4bC932D5bCf00D6bC932L7b8bCf00D9bC932LabbbCf00DcbC932LdbfbD0cCf00L1c4cC932D5cCf00D6cC932L7c8cCf00D9cC932LacbcCf00DccC932LdcfcD0dCf00D1dC932D2dCf00D3dC932L4d5dCf00D6dC932L7d8dCf00D9dC932LadbdCf00DcdC932LddfdD0eCf00D1eC932L2e3eCf00D4eC932D5eCf00L6e9eC932LaebeCf00LcedeC932LeefeL0fff"
{
selectWindow("MontageStack.tif");
_RootFolder = File.getParent(getInfo("image.directory"));
roiManager("Save", _RootFolder+"/RoiSet.zip");
}

/*
Max Proj macro - single z stack
*/
macro
"single Z stack Action Tool -Cbb4L00f0L0131C40fL41a1Cbb4Lb1f1L0272C40fL82a2Cbb4Lb2f2L0363C40fL7383Cbb4L93f3L0454C40fL6474Cbb4L84f4L0545C40fL5565Cbb4L75f5L0636C40fL46a6Cbb4Lb6f6L07f7D08C40fL1858Cbb4D68C40fD78Cbb4L88b8C40fDc8Cbb4Ld8f8D09C40fD19Cbb4L2969C40fD79Cbb4L89b9C40fDc9Cbb4Ld9f9D0aC40fD1aCbb4L2a6aC40fL7aaaCbb4DbaC40fDcaCbb4DdaC40fLeafaCbb4D0bC40fL1b5bCbb4D6bC40fD7bCbb4L8bbbC40fLcbdbCbb4LebfbL0c4cC40fD5cCbb4D6cC40fD7cCbb4L8cbcC40fDccCbb4DdcC40fDecCbb4DfcD0dC40fL1d5dCbb4D6dC40fL7dadCbb4DbdC40fDcdCbb4LddedC40fDfdCbb4L0efeL0fff"{
x=getImageID();
selectImage(x);
run("Z Project...", "start=1 stop=100 projection=[Max Intensity]");
}

/*
Macro make substack
*/
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

/*DEPRECATED UNUSED macro
/* open "CombinedStack, move to slice, run open_fullbfstck macro
* circle cell in the newly opened image, move back to CombinedStack.tif and
* PRESS CTRL+SHIFT+E before running this macro!
"add_resetROI [y]" {
		selectImage(2);
		id = getImageID();
		slicename=getInfo("image.filename");
		slicename = split(slicename,".");
		slicename =slicename[0];
		print(slicename);
		selectWindow("CombinedStack.tif");
		str = 0;
		slicenum = 0;
		while (str != slicename){
			slicenum++;
			setSlice(slicenum);
			str = getInfo("slice.label");

		}
		n=roiManager("Count");
		print("n= " + n);
		selectImage("CombinedStack.tif");
		roiManager("Select",n-1);
		setSlice(slicenum);
		roiManager("Add");
		roiManager("Select",n-1);
		roiManager("Delete");
		roiManager("Select",n-1);
		selectImage(id);
    }*/

macro
/* Macro opens the full BF stack for tracing and centers to the focal slice.
 * Open CombinedStack.tif, press 'r' key, circle in the opened image,
 * move back to CombinedStack and press CTRL+SHIFT+E, then press 'T'
 to add to ROI manager*/
"open_fullbfstck [r]" {
		setBatchMode(false);
		selectWindow("CombinedStack.tif");
		slicename = getInfo("slice.label");
		_RootFolder = getInfo("image.directory");
		open(_RootFolder+"/BF/cells/" + slicename+".tif");
		img_src = getImageID();
		fdup = getFocal(img_src);
		setSlice(fdup);

}

macro
"save_roi [u]" {
	selectWindow("CombinedStack.tif");
	_RootFolder = getInfo("image.directory");
	roiManager("Save", _RootFolder+"/Tracing.zip");
	print("ROI Saved to ", _RootFolder + "Tracing.zip");  // don't need '\' when printing
}
