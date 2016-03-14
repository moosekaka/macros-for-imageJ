# macros-for-imageJ
These are some macro functions used to preprocess the raw images obtained from a spinning disk confocal microscope. The language is a Javascript compatible ImageJ macro language.

## What the files do:
- `Make_Stack_Repad_Max` takes a folder containing 16bit slice images of brightfield and fluorescent image stacks and returns the corresponind image stack in the respective channel. It also returns a stack containing the maximum intensity projection of the fluorescent stack images as well as the best focus brightfield slice stack.
