
#%matplotlib inline 
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

def DS1(red):
    new_red = np.zeros((len(red), len(red[0]) -2))
    new_red_2 = np.zeros((len(red) - 2, len(red[0]) - 2))
    gaussian = [1,2,1]
    gaussian = np.array(gaussian)
    for i in range (0, len(red)):
        for j in range (1, len(red[i]) - 1):
            new_red[i][j-1] = np.sum(np.dot(gaussian, red[i,j-1:j+2]))/4
    for i in range (1, len(red)-1):
        for j in range (0, len(new_red[i])):
            new_red_2[i-1][j] = np.sum(np.dot(gaussian.T, new_red[i-1:i+2,j]))/4
    new_red_3 = np.zeros(((len(red) - 2)//2,(len(red[0]) - 2)//2))
    for i in range(len(new_red_3)):
        for j in range(len(new_red_3[i])):
            new_red_3[i,j] = new_red_2[2*i, 2*j]
    return new_red_3.astype('uint8')



def DownSample(Image):
    red, blue, green = cv.split(Image)
    red = DS1(red)
    blue = DS1(blue)
    green = DS1(green)
    image = cv.merge((green,blue,red))
    return image

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
#plt.figure("red")
#plt.imshow(vector, cmap = 'gray')
#print (red)

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
#plt.figure("blue")
#plt.imshow(vector, cmap = 'gray')
#print (blue)


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
#plt.figure("green")
#plt.imshow(vector, cmap = 'gray')
#print (green)

Downsampled = cv.merge((green, blue, red))
plt.imsave("Downsampled.png", Downsampled)
plt.figure("Downsampled Image")
plt.imshow(Downsampled)

Image = cv.imread('Image.jpg')
Image2 = cv.resize(Image,(line_width*2+2,depth*2+2))


#Image3 = np.zeros([width, length], dtype = 'uint8')
Image3 = cv.pyrDown(Image2, dstsize = (line_width,depth))
Image3 = cv.cvtColor(Image3, cv.COLOR_BGR2RGB)

print ("Image shape", Image3.shape)
#print (Image3)

mse = np.sqrt(((Downsampled - Image3)**2).mean())
print ("Error with OpenCV = ", mse)
Image4 = DownSample(Image2)
mse = np.sqrt(((Downsampled - Image4)**2).mean())
print ("Error with own Algorithm = ", mse)
#Image = cv.resize(Image,(14,14))

plt.figure("Original Image")
plt.imshow(Image3 )

plt.figure("Algo")
plt.imshow(Image4 )

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

