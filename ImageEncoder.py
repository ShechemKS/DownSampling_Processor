import cv2 as cv
import numpy as np

Image = cv.imread("Ironman.jpg", 0)
#print (Image)
Image = cv.resize(Image, (118,70))
Image = np.array(Image)
#print (Image)
print (len(Image))
print (len(Image[0]))
Image = Image.flatten()
print (Image)

def ToHex(pixel):
    x = hex(pixel)[2:]
    if len(x) ==1:
        x = "0"+x
    return x
depth = len(Image)
f = open("Data_Mem.mif", "w+")
f.write("DEPTH = 270000;\n")
f.write("WIDTH = 8;\n")
f.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n")
f.write("[0:49999]: 00;\n")

for i in range (len(Image)):
    f.write(str(i)+": "+ToHex(Image[i])+";\n")

f.write("END")
f.close()



