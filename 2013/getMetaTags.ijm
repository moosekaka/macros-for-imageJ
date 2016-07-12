Power=getTag("DAC2_561-Volts");
Gain=getTag("Hamamatsu_DCAM-EMGain");
AcqTime=getTag("Exposure-ms");

print(Power);
print(Gain);
print(AcqTime);

 function getTag(tag) {
      info = getImageInfo();
      index1 = indexOf(info, tag);
      if (index1==-1) return "";
      index1 = indexOf(info, ":", index1);
      if (index1==-1) return "";
      index2 = indexOf(info, "\n", index1);
      value = substring(info, index1+1, index2);
      return value;
  }