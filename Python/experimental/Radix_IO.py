from Radix import *

#Radix 2
def Radix_2_IO(stage,N,buffer,twiddle):

    step_size = 2**N
    current_twiddle = 0
    twiddle_index = 0
    modulo_mask = (2**N // 2) - 1
    step_size >>= 1*stage
    
    for address in range(0,(2**N)-1,2*2**((stage-1))):
        for offset in range (0,2**(stage-1)):
            #handle i/o addressing
            temp_in = [0]*2
            temp_twid = 0
            temp_in[0]= buffer[address+offset]
            temp_in[1]= buffer[address+offset+2**(stage-1)]
            #handle twiddle
            temp_twid = twiddle[twiddle_index]  # Current twiddle factor from table
            #calling radix 2 butterfly
            temp_in = Core_Radix_2(temp,temp_twid,"NTT")
            #rewriting to buffer
            buffer[address+offset] = temp_in[0] #update value to data buffer
            buffer[address+offset+2**(stage-1)] = temp_in[1] #update value to data buffer
            #update twiddle index
            twiddle_index = (twiddle_index + step_size) & modulo_mask # Update the index: add step size and wrap it around if it exceeds N/2
    return buffer
             
#Radix 4
def Radix_4_IO(stage,N,buffer,twiddle,w):

    current_twiddle = [0]*4
    twiddle_index = 0
    step_size = 2**N
    modulo_mask = (2**N // 4) - 1
    step_size >>= 2*stage
    
    for address in range(0,(2**N)-1,(2**((stage-1)))*4*2**((stage-1))):
        for offset in range (0,4**(stage-1)):
            #handle i/o addressing
            temp_in = [0]*4
            temp_twid = [0]*4
            temp_in[0]= buffer[address+offset]
            temp_in[1]= buffer[address+offset+2**(stage-1)*(2**(stage-1)))]
            temp_in[2]= buffer[address+offset+2*2**(stage-1)*(2**(stage-1)]
            temp_in[3]= buffer[address+offset+3*2**(stage-1)*(2**(stage-1)]
            #handle twiddle
            temp_twid[0] = twiddle[0] 
            temp_twid[1] = twiddle[twiddle_index*1]
            temp_twid[2] = twiddle[twiddle_index*2]
            temp_twid[3] = twiddle[twiddle_index*3]
            #calling radix 4 butterfly
            temp_in = Core_Radix_4(temp,temp_twid,"NTT",w)
            #rewriting to buffer
            buffer[address+offset] = temp_in[0]
            buffer[address+offset+2**(stage-1)*(2**(stage-1)))] = temp_in[1]
            buffer[address+offset+2*2**(stage-1)*(2**(stage-1)] = temp_in[2]
            buffer[address+offset+3*2**(stage-1)*(2**(stage-1)] = temp_in[3]
            # Update the index: add step size and wrap it around if it exceeds N/4
            twiddle_index = (twiddle_index + step_size) & modulo_mask

    return buffer

#Radix 8
def Radix_8_IO(stage,N,buffer,twiddle,w):

    current_twiddle = [0]*8
    twiddle_index = 0
    step_size = 2**N
    modulo_mask = (2**N // 8) - 1
    step_size >>= 3*stage
    
    for address in range(0,(2**N)-1,(2**((stage-1)))*8**2**((stage-1))):
        for offset in range (0,8**(stage-1)):
            #handle i/o addressing
            temp_in = [0]*8
            temp_twid = [0]*8
            temp_in[0]= buffer[address+offset]
            temp_in[1]= buffer[address+offset+2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            temp_in[2]= buffer[address+offset+2*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            temp_in[3]= buffer[address+offset+3*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            temp_in[4]= buffer[address+offset+4*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            temp_in[5]= buffer[address+offset+5*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            temp_in[6]= buffer[address+offset+6*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            temp_in[7]= buffer[address+offset+7*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]
            #handle twiddle
            temp_twid[0] = twiddle[0] 
            temp_twid[1] = twiddle[twiddle_index*1]
            temp_twid[2] = twiddle[twiddle_index*2]
            temp_twid[3] = twiddle[twiddle_index*3]
            temp_twid[4] = twiddle[twiddle_index*4]
            temp_twid[5] = twiddle[twiddle_index*5]
            temp_twid[6] = twiddle[twiddle_index*6]
            temp_twid[7] = twiddle[twiddle_index*7]
            #calling radix 8 butterfly
            temp_in = Core_Radix_8(temp,temp_twid,"NTT",w)
            #rewriting to buffer
            buffer[address+offset] = temp_in[0]
            buffer[address+offset+2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[1]
            buffer[address+offset+2*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[2]
            buffer[address+offset+3*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[3]
            buffer[address+offset+4*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[4]
            buffer[address+offset+5*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[5]
            buffer[address+offset+6*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[6]
            buffer[address+offset+7*2**(stage-1)*(2**(stage-1))*(2**(stage-1)]= temp_in[7]
            #update twiddle index
            twiddle_index = (twiddle_index + step_size) & modulo_mask #update

    return buffer            
