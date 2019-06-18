
#%matplotlib notebook
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

f = open("Recieved_Memory_1.hex", "r")
depth = 254//2
line_width = 254//2

total_length = depth*line_width
lines = f.readlines()

image_decoded = np.zeros((15,15))
vector = []
i=135002

for j in range (total_length):
    a = lines[i+j][9:11]
    #print (a)
    a = '0x'+a
    pixel = int(a.encode(),16)
    vector.append(pixel)
f.close()
vector = np.array(vector)
vector = vector.reshape((depth,line_width))
red = vector.astype('uint8')
#plt.figure("Downsampled Image")
#plt.imshow(vector, cmap = 'gray')
#print (vector)

f = open("Recieved_Memory_2.hex", "r")

lines = f.readlines()

image_decoded = np.zeros((15,15))
vector = []
i=135002

for j in range (total_length):
    a = lines[i+j][9:11]
    #print (a)
    a = '0x'+a
    pixel = int(a.encode(),16)
    vector.append(pixel)
f.close()
vector = np.array(vector)
vector = vector.reshape((depth,line_width))
blue = vector.astype('uint8')
#plt.figure("Downsampled Image")
#plt.imshow(vector, cmap = 'gray')
#print (vector)

f = open("Recieved_Memory_3.hex", "r")

lines = f.readlines()

image_decoded = np.zeros((15,15))
vector = []
i=135002

for j in range (total_length):
    a = lines[i+j][9:11]
    #print (a)
    a = '0x'+a
    pixel = int(a.encode(),16)
    vector.append(pixel)
f.close()
vector = np.array(vector)
vector = vector.reshape((depth,line_width))
green = vector.astype('uint8')
#plt.figure("Downsampled Image")
#plt.imshow(vector, cmap = 'gray')
#print (vector)

Downsampled = cv.merge((red, blue, green))
plt.figure("Downsampled Image")
plt.imshow(Downsampled)

Image = cv.imread('Image.jpg')
Image2 = cv.resize(Image,(line_width*2,depth*2))

Image4 = cv.resize(Image, (line_width, depth))
#Image3 = np.zeros([width, length], dtype = 'uint8')
Image3 = cv.pyrDown(Image2, dstsize = (line_width,depth))
print (Image3)

mse = np.sqrt(((Downsampled - Image3)**2).mean())
print (mse)

#Image = cv.resize(Image,(14,14))

plt.figure("Original Image")
plt.imshow(Image3)

plt.show()

'''
Image = cv.imread("Ironman.jpg", 0)
#print (Image)
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
f.write("DEPTH = 500000;\n")
f.write("WIDTH = 8;\n")
f.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n")
f.write("[0:499999]: 00;\n")

for i in range (len(Image)):
    f.write(str(i)+": "+ToHex(Image[i])+";\n")

f.close()

'''

