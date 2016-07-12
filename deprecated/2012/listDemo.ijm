//  List Demo
//
// This macro demonstrates how to use the List.*
// functions added in ImageJ 1.41f.

  requires("1.41f");
  
  print("Opening 'blobs' sample image");
  run("Blobs (25K)");
  
  print("Saving list as 'Info' image propery");
  list = List.getList();
  setMetadata("info", list);
  path = getDirectory("temp")+"test.tif"
  print("Saving image as TIFF");
  save(path);
  close();
  
  print("Reseting list");
  List.clear;
  List.setMeasurements;
  print("Reopening image and recovering list");
  open(path);
  info = getMetadata("info");
  //List.setList(info);
  //List.getList;
  List.get("X");
  List.get("Y");
  List.get("YM");
  print("Size of list: "+ List.size);
  //close();
  print("current:"+ getDirectory("temp"));