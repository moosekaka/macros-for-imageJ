Before circling cells, run :

`tracing_mitograph/Make_Stack_Repad_Max`

(optional, convenient to have BF and max proj in one image)

`tracing_mitograph/combine_fp_bf_stack_3 `

After circling cells in the RFP channel, run in order:

`tracing_mitograph/CropCells`

Send the individual cell stacks generated from CropCells to MitoGraph


After MitoGraph is finished:
Move individual FP and BF whole stack images into a folder structure like this:

	Stack
	|---BF
		|---cells
	|---GFP
		|---cells
	|---RFP
		|---cells

where the first level folders below root contain the whole stack images from the output of	Make_Stack_Repad_Max and the cells folder contain the individual cropped out images after circling cells in the RFP channel (and also represent the input for MitoGraph).
Note that the BF/cells folder will be empty as the brightfield stacks have not been cropped, run the following scripts:

```
tracing_mombud/00GenFramesBFFocal
tracing_mombud/01CropBFStack
tracing_mombud/02Crop_BFfocal_maxProj
tracing_mombud/04combinestack_for_mombud_circling
```

Begin tracing individual cells (mom/bud) and then run


`tracing_mombud/fit_ellipse_ROI`
