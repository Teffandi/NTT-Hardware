#THIS CODE IS UNUSED FOR NOW AS IT HAS BEEN MERGED WITH RADIX_IO.PY

import math

N = int(input("enter 2th point : "))

# Constants
total_N = 2**N  # FFT size
modulo_mask = (total_N // 2) - 1  # implements modulo N/2 adding

# Variables
num_stages = N  # Example number of stages; set appropriately
#W = [0] * (total_N // 2)  # Example twiddle factor table; initialize as needed
W = [0,1,2,3]

def radix_2_twid(N,stages):
    step_size = 2**N
    current_twiddle = 0
    twiddle_index = 0
    modulo_mask = (total_N // 2) - 1
    step_size >>= 1*stages
    for b in range(int(2**N/2)):
        current_twiddle = twiddle_index  # Current twiddle factor from table
        print(current_twiddle)
        twiddle_index = (twiddle_index + step_size) & modulo_mask # Update the index: add step size and wrap it around if it exceeds N/2
    print("====================")
    

def radix_4_twid(N,stages):
    current_twiddle = [0]*4
    twiddle_index = 0
    step_size = 2**N
    modulo_mask = (2**N // 4) - 1
    step_size >>= 2*stages
    for b in range(int((2**N)/4)):
        current_twiddle[0] = 0 
        current_twiddle[1] = twiddle_index*1
        current_twiddle[2] = twiddle_index*2
        current_twiddle[3] = twiddle_index*3
        print(current_twiddle)
        # Update the index: add step size and wrap it around if it exceeds N/4
        twiddle_index = (twiddle_index + step_size) & modulo_mask
    print("====================")


def radix_8_twid(N,stages):
    current_twiddle = [0]*8
    twiddle_index = 0
    step_size = 2**N
    modulo_mask = (2**N // 8) - 1
    step_size >>= 3*stages
    for b in range(int((2**N)/8)):
        current_twiddle[0] = 0 
        current_twiddle[1] = twiddle_index*1
        current_twiddle[2] = twiddle_index*2
        current_twiddle[3] = twiddle_index*3
        current_twiddle[4] = twiddle_index*4
        current_twiddle[5] = twiddle_index*5
        current_twiddle[6] = twiddle_index*6
        current_twiddle[7] = twiddle_index*7

        print(current_twiddle)

        # Update the index: add step size and wrap it around if it exceeds N/8
        twiddle_index = (twiddle_index + step_size) & modulo_mask
    print("====================")

radix_8_twid(N,1)
radix_8_twid(N,2)


