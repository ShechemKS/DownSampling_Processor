import cv2 as cv
import numpy as np

Image = cv.imread("Ironman.jpg", 0)
length = 118
width = 70
#print (Image)
Image = np.array(Image)
print (len(Image))
Image = np.resize(Image, (length,width))
#print (Image)
print (len(Image))
print (len(Image[0]))
print (Image)
Image = Image.flatten()
print (Image)

def ToHex(pixel):
    x = str(hex(pixel)[2:])
    x = "0"*(5 - len(x))+x
    return x


f = open("Const_Mem.mif", "w+")
f.write("DEPTH = 8;\n") #CRAM Depth is 8 bits - needs only 3 bits to get the reference
f.write("WIDTH = 20;\n") #Width is 20 bits to hold the entire address locations
f.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n")
#f.write("[0:7]: 00000;\n")

f.write("3: 00000;\n") #First address of source image
f.write("4: "+ToHex(10000)+";\n") #First address of destination Image
f.write("5: "+ToHex(length*width)+";\n") #Last address of source image
f.write("6: "+ToHex(length)+";\n") #Length is hardcoded = 590 I think
f.write("END;\n")
f.close()



