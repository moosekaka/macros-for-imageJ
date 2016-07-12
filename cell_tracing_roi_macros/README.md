First ensure that the ALL data from a single day (i.e. all conditions) are in a single flat folder, for e.g. `preprocessed`. On this folder, run the macro:

`tracing_mitograph/Make_Stack_Repad_Max`

This will generate whole stack images for BF, RFP and GFP as well as a MaxGFP, MaxRFP and zBFfocal stack. Move these images into a `Stack/` folder with the structure below:

	Stack
	|---BF
		|---cells
	|---GFP
		|---cells
	|---RFP
		|---cells
		
where the first level folders below `Stack/` contain the whole stack images from the output of `Make_Stack_Repad_Max` and the `cells/` folders will contain the individual cropped out images from running `CropCells` (i.e. the input files for `MitoGraph`). _put the MaxGFP, MaxRFP , zBFfocal and Montage stack in the `Stack/` folder._

_(optionally,  run this macro to create a montage of BF and max proj RFP and GFP stacks)_

`tracing_mitograph/combine_fp_bf_stack_3 `

After circling cells in the RFP channel, run this macro on the `GFP/` and `RFP/` folder.:

`tracing_mitograph/CropCells`

Ensure that the `Stack/` folder contains the `RoiSet.zip` cell tracing data. Send the individual cell stacks generated from CropCells to MitoGraph.

In the `Stack/BF/` folder, run the following macros:

```
tracing_mombud/00GenFramesBFFocal
tracing_mombud/01CropBFStack
```
on the `BF/` folder to crop out the brightfield stacks. Then run:

```
tracing_mombud/02Crop_BFfocal_maxProj
tracing_mombud/04combinestack_for_mombud_circling
```
on the `Stack/` folder to generate a __CombinedStack__ montage of max project and focal slice of the individual cropped out stacks.

Begin tracing individual cells (mom/bud). Ensure that `Fiji` has `StartUpMacros.fiji.ijm` in the `macros/` folder. Check that hotkeys for __u__ and __r__ are assigned to macros `open_fullbfstck` and `save_roi`. ROI's will be saved to `Tracing.zip`.

_Tip: press **r** to open the BF stack, trace the cell on this stack and run ImageJ's Fit Ellipse (assign this command to a key, for e.g. **g**. Then activate the CombinedStack window and press Shift+E to transfer the circled ROI back to the CombinedStack image. This is important to have the correct ROI in the image stack._

Once tracing is complete, run on`Stack/` folder:

`tracing_mombud/fit_ellipse_ROI`
