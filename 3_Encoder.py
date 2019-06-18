import cv2 as cv
import numpy as np
import argparse


PC	=[0,0,0,1]
IR	=[1,1,1,1]
MAR	=[1,1,0,0]
AC	=[1,0,1,1]
R1	=[0,1,0,0]
R2	=[0,1,0,1]
R3	=[0,1,1,0]
SOR	=[1,0,0,1]
DSTR	=[1,0,1,0]
COUN	=[1,1,1,0]
NA      =[0,0,0,0]

def InstructionEncoder():
    
    count = 0

    M1 = 3 #First Memory Location of Orginal Image
    M2 = 4 #First Memory Location of Destination Image
    M3 = 5 #Last Memory Location of Original Image
    M4 = 6 #Memory Location containing width of original image

    
    #print ("Encoding Instructions")
    #print ("Algorithm in Binary")

    RSET(1,1,1,1,1)     #0
    LOAD(J=1, A = M1)   #1
    MVAO(SOR)           #2
    LOAD(J=1,A=M2)      #3
    MVAO(DSTR)          #4
    LOAD(J=1,A=M3)      #5
    MVAO(R2)            #6
    LOAD(J=1,A=M4)      #7
    SUB (AC, J=0, K = 2)#8 Changed to sort out line length issue
    MVAO (R3)           #9 Changed to sort out line length issue

    MVAR (0)            #10
    LOAD()              #11
    MVAO (R1)           #12
    INC (M=1)           #13
    LOAD()              #14
    SFTL ()             #15
    ADD (AC,R1)         #16
    MVAO (R1)           #17
    INC (M=1)           #18
    LOAD()              #19
    ADD (AC,R1)         #20
    SFTR()              #21
    SFTR()              #22
    JUMP(Z=1, N=0, Reg1 =MAR, Reg2 = R2, T = 33)#23
    MVAR (1)            #24
    STOR ()             #25
    INC (S=1,D=1,C=1)       #26 Changed to sort out line length issue
    JUMP(Z=1, N=0, Reg1 =COUN, Reg2 = R3, T = 29) #27  Changed to sort out line length issue
    JUMP (Z=0, N=0, T = 10)#28 Changed to updated instruction number

    #If reached end of line, should run, at this point, C = L-2, and SOR is pointing at the pixel before the last on that line
    INC (S=1)           #29
    INC (S=1)           #30
    RSET(C=1)           #31
    JUMP(T = 10)        #32

    #If end of image is reached, should run
    MVAR (1)            #33
    STOR()              #34
    MVAI (DSTR)         #35
    MVAO (R2)           #36
    LOAD (J=1, A = M2)  #37
    MVAO (SOR)          #38
    LOAD (J=1, A = M1)  #39
    MVAO (DSTR)         #40
    JUMP (Z=0, N=0, T = 42)#41

    #Begin Vertical Filtering
    MVAR (0)            #42
    LOAD()              #43
    MVAO (R1)           #44
    ADD (MAR,R3)        #45
    LOAD()              #46
    SFTL ()             #47
    ADD (AC,R1)         #48
    MVAO (R1)           #49
    ADD (MAR, R3)       #50
    LOAD()              #51
    ADD (AC,R1)         #52
    SFTR()              #53
    SFTR()              #54
    JUMP (Z=1, N=0, Reg1 =  MAR, Reg2 = R2, T = 60)#55
    MVAR (1)            #56
    STOR ()             #57
    INC (S=1, D=1)      #58
    JUMP (Z=0, N=0, T = 42)#59

    #Runs when vertical filtering finishes
    MVAR (1)            #60
    STOR()              #61
    MVAI (DSTR)         #62
    MVAO (R2)           #63
    LOAD (J=1, A = M1)  #64
    MVAO (SOR)          #65
    LOAD (J=1, A = M2)  #66
    MVAO (DSTR)         #67
    RSET(C=1)           #68
    JUMP (Z=0, N=0, T = 70)#69 Changed to updated instruction numbers

    #Downsampling begins
    MVAR(0)             #70
    LOAD()              #71
    MVAR(1)             #72
    STOR()              #73
    INC (S = 1, D = 1, C = 1)#74
    JUMP (Z = 1, N = 0, Reg2 = R2, Reg1 = SOR, T = 86)#75
    INC (S= 1, C = 1)#76
    #MVAI(COUN)
    JUMP (Z = 1, N = 0, Reg2 = R2, Reg1 = SOR, T = 86)#77
    #JUMP (Z = 1, N = 0, Reg2 = R3, Reg1 = AC, T= 76)
    JUMP (Z = 1, N = 0, Reg2 = R3, Reg1 = COUN, T = 80) #78Updated to reflect increaded capabilites of instructions
    JUMP (Z=0, N=0, T = 69) #79

    ADD (SOR, R3)       #80
    RSET (C=1)          #81
    #-------------------Test2---------------------------
    SUB(J = 0, K = 1, Reg1 = SOR)#82
    JUMP (Z = 1, N = 0, Reg2 = R2, Reg1 = SOR, T = 86)#83
    INC(S = 1)#84
    #-------------------Test2End-----------------------
    #-----------------------------Test1-------------------------
    '''
    Fail
    MVAI(SOR)   #83
    MVAO(R1)    #84
    MVAI(R3)    #85
    JUMP (Z = 1, N = 1, Reg2 = R1, Reg1 = AC, T = 88)#86
    '''
    #----------------------------EndTest1-----------------------
    JUMP (Z = 0, N = 0, T = 70)#85
    END() #86

    #print ("Instructions Encoded")
    return


def Print(code):
    global f
    #print (len(code))
    #global count
    #print (count, end=" ")
    
    #print ("    memory[",count,"] <=32'b",end='')
    #f.write("    memory[")
    #f.write(str(count))
    #f.write("]   = 32'b")
    for i in code:
        #print (i, end="")
        f.write(str(i))
        
    #print ()
    #f.write(';\n')
    f.write('\n')
    #count+=1
    return

#---------------------- Assembly code compiler funcrions ---------------------#
def END():
    code = [0]*32
    code[0:5] = [0,0,0,1,1]
    Print (code)
    return
def NOP():
    #global PC,IR,MAR,AC,R1,R2,R3,SOR,DSTR,COUN
    code = [0]*32
    code[0:4] = [0,0,0,1]
    Print (code)
    return

def RSET(C=0,D=0,S=0,M=0,A=0):
    #global PC,IR,MAR,AC,R1,R2,R3,SOR,DSTR,COUN
    code = [0]*32
    code[0:4] = [0,0,1,0]
    code[5:10]=[C,D,S,M,A]
    Print (code)
    return

def LOAD(J=0, A=0):
    #global PC,IR,MAR,AC,R1,R2,R3,SOR,DSTR,COUN
    code = [0]*32
    code[0:4] = [0,0,1,1]
    if J ==0:
        Print (code)
        return
    else:
        code[4]=1
        A=[int(x) for x in str(bin(A)[2:])]
        for i in range (len(A)):
            code[-i-1] = A[-i-1]
        Print (code)
        return

def STOR(J=0, A=0):
    #global PC,IR,MAR,AC,R1,R2,R3,SOR,DSTR,COUN
    code = [0]*32
    code[0:4] = [0,1,0,0]
    if J ==0:
        Print (code)
        return
    else:
        code[4]=1
        A=[int(x) for x in str(bin(A)[2:])]
        for i in range (len(A)):
            code[-i-1] = A[-i-1]
        Print (code)
        return

def MVAR(J=0):
    #global PC,IR,MAR,AC,R1,R2,R3,SOR,DSTR,COUN
    code = [0]*32
    code[0:4] = [0,1,0,1]
    code[4]=J
    Print (code)
    return


def MVAO(Reg):
    code = [0]*32
    code[0:4] = [0,1,1,0]
    code[5:9] = Reg
    Print (code)
    return

def MVAI(Reg):
    code = [0]*32
    code[0:4] = [0,1,1,1]
    code[4]=int(not(Reg[0]))
    code[5:9] = Reg
    Print (code)
    return

def INC(C=0,D=0,S=0,M=0):
    code = [0]*32
    code[0:4] = [1,0,0,0]
    code[5:9]=[C,D,S,M]
    Print (code)
    return

def JUMP(N=0,Z=0,Reg1=NA,Reg2=NA,T=0):
    code = [0]*32
    code[0:4] = [1,1,0,0]
    code[5:9] = Reg1
    code[9:13] = Reg2
    code[13] = N
    code[14] = Z
    A=[int(x) for x in str(bin(T)[2:])]
    for i in range (len(A)):
        code[-i-1] = A[-i-1]
    Print (code)
    return

def ADD(Reg1, Reg2 = NA,J=1,  K=0):
    code = [0]*32
    code[0:4] = [1,0,0,1]
    code[4]=J
    code[5:9] = Reg1
    code[9:13]=Reg2
    A=[int(x) for x in str(bin(K)[2:])]
    for i in range (len(A)):
        code[-i-1] = A[-i-1]
    Print (code)
    return

def SUB(Reg1, Reg2 = NA, J=1, K=0):
    code = [0]*32
    code[0:4] = [1,1,1,1]
    code[4]=J
    code[5:9] = Reg1
    code[9:13]=Reg2
    A=[int(x) for x in str(bin(K)[2:])]
    for i in range (len(A)):
        code[-i-1] = A[-i-1]
    Print (code)
    return

def MUL(Reg1, Reg2 = NA, J=1, K=0):
    code = [0]*32
    code[0:4] = [1,1,0,1]
    code[4]=J
    code[5:9] = Reg1
    code[9:13]=Reg2
    A=[int(x) for x in str(bin(K)[2:])]
    for i in range (len(A)):
        code[-i-1] = A[-i-1]
    Print (code)
    return

def DIV(Reg1, Reg2 = NA, J=1, K=0):
    code = [0]*32
    code[0:4] = [1,1,1,0]
    code[4]=J
    code[5:9] = Reg1
    code[9:13]=Reg2
    A=[int(x) for x in str(bin(K)[2:])]
    for i in range (len(A)):
        code[-i-1] = A[-i-1]
    Print (code)
    return

def SFTR():
    code = [0]*32
    code[0:4] = [1,0,1,0]
    Print (code)
    return

def SFTL():
    code = [0]*32
    code[0:4] = [1,0,1,1]
    Print (code)
    return

#-----------------------------------------------------------------------------#

#------------------------Encoding the cram data-------------------------------#
def ToHex_Long(pixel):
    x = str(hex(pixel)[2:])
    x = "0"*(5 - len(x))+x
    return x

def DataEncoder(Image):
    line_width = len(Image[0])
    depth = len(Image)

    f = open("Const_Mem.mif", "w+")
    f.write("DEPTH = 8;\n") #CRAM Depth is 8 bits - needs only 3 bits to get the reference
    f.write("WIDTH = 20;\n") #Width is 20 bits to hold the entire address locations
    f.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n")
    f.write("[0..7]: 00000;\n")

    f.write("3: 00000;\n") #First address of source image
    f.write("4: "+ToHex_Long(135000)+";\n") #First address of destination Image
    f.write("5: "+ToHex_Long(depth*line_width-1)+";\n") #Last address of source image
    f.write("6: "+ToHex_Long(line_width)+";\n") #Width of a Line
    f.write("END;\n")
    f.close()
    return

#--------------------------Encoding the image---------------------------------#
def ToHex(pixel):
    x = hex(pixel)[2:]
    if len(x) ==1:
        x = "0"+x
    return x

def ImageEncoder(Image):
    
    Image = np.array(Image)
    #print (Image)
    #print (len(Image))
    #print (len(Image[0]))
    Image = Image.flatten()
    
    depth = len(Image)
    if depth>135000:
        print ("Warning - Image too Big")
    f = open("Data_Mem.mif", "w+")
    f.write("DEPTH = 270000;\n")
    f.write("WIDTH = 8;\n")
    f.write("ADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\nCONTENT BEGIN\n")
    f.write("[0..269999]: 00;\n")

    for i in range (len(Image)):
        f.write(str(i)+": "+ToHex(Image[i])+";\n")

    f.write("END")
    f.close()
    return

Image = cv.imread("Image.jpg")
print ("Loaded Image")
Image = cv.resize(Image, (256,256))
print ("Resized Image to 256, 256")
red,blue,green = cv.split(Image)

print ("Initializing Instruction Memory")
f = open("Inst_mem.mem", "w+")
InstructionEncoder()
f.close()
print ("Initializing Constant Memory")
DataEncoder(green)
print ("Initializing Data Memory")
ImageEncoder(green)
print ("All memories initialized. Compile and run downsampler")
