
#Radix 2
def Radix_2_IO(stage,N):
    result = [0]*2
    for address in range(0,(2**N)-1,2*2**((stage-1))):
        for offset in range (0,2**(stage-1)):
            #print(str(address+offset),end='')
            #print(str(address+offset+2**(stage-1)),end='\n')
                                      
             
#Radix 4
def Radix_4_IO(stage,N):
    for address in range(0,(2**N)-1,(2**((stage-1)))*4*2**((stage-1))):
        for offset in range (0,4**(stage-1)):
            #print(str(address+offset),end='')
            #print(str(address+offset+2**(stage-1)*(2**(stage-1))),end='')
            #print(str(address+offset+2*2**(stage-1)*(2**(stage-1))),end='')
            #print(str(address+offset+3*2**(stage-1)*(2**(stage-1))),end='\n')

#Radix 8
def Radix_8_IO(stage,N):
    for address in range(0,(2**N)-1,(2**((stage-1)))*8**2**((stage-1))):
        for offset in range (0,8**(stage-1)):
            #print(str(address+offset),end=' ')
            #print(str(address+offset+2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end=' ')
            #print(str(address+offset+2*2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end=' ')
            #print(str(address+offset+3*2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end=' ')
            #print(str(address+offset+4*2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end=' ')
            #print(str(address+offset+5*2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end=' ')
            #print(str(address+offset+6*2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end=' ')
            #print(str(address+offset+7*2**(stage-1)*(2**(stage-1))*(2**(stage-1))),end='\n')
            
