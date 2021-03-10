import cv2
import numpy as np
#read camera
capture = cv2.VideoCapture(0)
#check camera
if (capture.isOpened() == False):
  print("Unable to read camera feed")

frame_width = int(capture.get(3))
frame_height = int(capture.get(4))
fourcc = cv2.VideoWriter_fourcc(*'XVID')
#write video
out = cv2.VideoWriter('output.avi',fourcc, 20, (frame_width,frame_height))
#display video
while(True):
  ret, frame = capture.read()
  if ret == True:
    #write the frame into file 'output.avi'
    out.write(frame)
    #display the resulting frame
    cv2.imshow('frame',frame)
    #press Q on keyboard to stop recording
    if cv2.waitKey(1) & 0xFF == ord('q'):
      break
  else:
    break
#release the video capture and video write objects
capture.release()
out.release()
#close all frame
cv2.destroyAllWindows()
