#Macro to save FP and BF  files into a stack

from ij import IJ
from ij.gui import Roi, ShapeRoi
import os
import os.path as op
import glob
import string
import shutil as sh
import fnmatch as fn
import errno
print ["%s\n"%i for i in dir(IJ)]
IJ.run("Close All");
"""
Power=getTag("DAC2_561-Volts");
Gain=getTag("Hamamatsu_DCAM-EMGain");
AcqTime=getTag("Exposure-ms");


def readMeta(tag) {
      info = getImageInfo();
      index1 = indexOf(info, tag);
      if (index1==-1) return "";
      index1 = indexOf(info, ":", index1);
      if (index1==-1) return "";
      index2 = indexOf(info, "\n", index1);
      value = substring(info, index1+1, index2);
    
   return value;
  }
"""
  
dr = IJ.getDirectory("Choose a Directory ");
for root, dirs, files in os.walk(dr):
    try:
	    for f in files:
	    	if fn.fnmatch(f, '*meta*'):
	        	with open(op.join(root,f), "r") as inpt:
	        		for i in inpt:
		        		print i
	        	
	
				