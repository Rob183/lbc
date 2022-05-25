# YOLO object detection
import cv2
import config
import numpy as np

class Detector():

  def __init__(self):
    #load classes
    self.classes = []
    with open(config.names_path) as file:
      self.classes = [name.strip() for name in file.readlines()]

    #initialize network with cfg + weights file
    self.network = cv2.dnn.readNetFromDarknet(config.yolo_config_path, config.weights_path)
    self.network.setPreferableBackend(cv2.dnn.DNN_BACKEND_OPENCV)
    self.network.setPreferableTarget(cv2.dnn.DNN_TARGET_CPU)

  	#init output layers
    self.outputLayers = self.network.getLayerNames()
    self.outputLayers = [self.outputLayers[i[0]-1] for i in self.network.getUnconnectedOutLayers()]

    #set min confidence
    self.MIN_CONFIDENCE = 0.5

  def detectByImage(self, arr):
    #read image
    img = cv2.imdecode(arr, cv2.IMREAD_UNCHANGED)
    #img = cv2.imread(image)
    #construct blob from image
    blob = cv2.dnn.blobFromImage(img, 1/255.0, (416,416), swapRB=True, crop=False)

    self.network.setInput(blob)
    outputs = self.network.forward(self.outputLayers)

    detections = []

    for output in outputs:
      for detection in output:
        scores = detection[5:]
        classID = np.argmax(scores)
        confidence = scores[classID]

        if confidence > self.MIN_CONFIDENCE:
          detections.append({"class": str(self.classes[classID]), "confidence": ("%.2f" % confidence)})


    return {"detections": detections}
