
#%matplotlib notebook
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

f = open("7.hex", "r")
length = 116//2
width = 68//2

total_length = length*width
lines = f.readlines()

image_decoded = np.zeros((15,15))
vector = []
i=10000
for j in range (total_length):
    a = lines[i+j][9:11]
    #print (a)
    a = '0x'+a
    pixel = int(a.encode(),16)
    vector.append(pixel)

vector = np.array(vector)
vector = vector.reshape((width,length))
vector = vector.astype('uint8')
plt.figure(0)
plt.imshow(vector)
print (vector)


Image = cv.imread('Ironman.jpg',0)
Image2 = cv.resize(Image,(length*2,width*2))
Image3 = np.zeros([width, length], dtype = 'uint8')
Image3 = cv.pyrDown(Image2, dstsize = (length,width)) 

mse = ((vector - Image3)**2).mean()
print (mse)

#Image = cv.resize(Image,(14,14))
plt.figure(1)
plt.imshow(Image2)
plt.figure(2)
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

