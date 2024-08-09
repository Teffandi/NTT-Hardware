import numpy as np


# N = int(input("enter total input point :")) #input size
# prime = int(input("enter prime number used :")) #input prime number

N = 4
prime = 7681

possible_primitive=[] 
verified_primitive=[] 

def primitive_search(prime) :
    for i in range(2,prime):
        if(pow(i,N)%prime==1):
            possible_primitive.append(i)
       
def primitive_verification(possible_primitve,prime,N):
    for scan in range(0,len(possible_primitive)-1):
        temp = int(possible_primitive[scan])
        for root_iterate in range(0,N+1):
            if(((pow(temp,root_iterate))%prime==1)&(root_iterate<N)):
                verified_primitive.append(temp)
            root_iterate = root_iterate+1
        scan = scan+1
            

primitive_search(prime)
print(possible_primitive)
primitive_verification(possible_primitive,prime,N)
print(verified_primitive)

# selected_primitive_positive = int(input("enter primitive number selected :")) #input selected primitive generated from list (PWC primitive)
selected_primitive_positive = 3383

#searching for NWC primitive
possible_primitive_negative=[] 


def primitive_search_negative(prime,selected_primitive_positive) :
    for i in range(2,prime):
        if(pow(i,2)%prime==selected_primitive_positive):
            possible_primitive_negative.append(i)

primitive_search_negative(prime,selected_primitive_positive)
print(possible_primitive_negative)
# selected_primitive_negative = int(input("enter negative primitive number selected :")) #input selected primitive generated from list (PWC primitive)
selected_primitive_negative = 1925
#scaling inverse
inv_N = pow(N,-1,prime)

#generating matrix 
matrix = np.zeros((int(N),int(N)))
inv_matrix = np.zeros((int(N),int(N)))
#scaling inverse
inv_N = pow(N,-1,prime)


#generating coeffient
for row in range(0,N):
    for col in range(0,N):
        power = (2*(row*col)+col) % (2*N)       # Periodicity      

        if (power//N) % 2 == 1:                 # Symmetricity
            power = power % N
            matrix[row][col] = -1
            inv_matrix[col][row] = -1           # Handle inverse NTT Matrix
        else:
            matrix[row][col] = 1
            inv_matrix[col][row] = 1            # Handle inverse NTT Matrix

        matrix[row][col] *= pow(selected_primitive_negative,power) % prime
        inv_matrix[col][row] *=  pow(selected_primitive_negative,-power,prime)  # Handle inverse NTT Matrix

        col=col+1
    row=row+1


check_result = []
check_result.append(pow(selected_primitive_negative,0) % prime)
check_result.append(pow(selected_primitive_negative,1) % prime)
check_result.append(pow(selected_primitive_negative,2) % prime)
check_result.append(pow(selected_primitive_negative,3) % prime)

check_result_inv = []
check_result_inv.append(pow(selected_primitive_negative,-0,prime))
check_result_inv.append(pow(selected_primitive_negative,-1,prime))
check_result_inv.append(pow(selected_primitive_negative,-2,prime))
check_result_inv.append(pow(selected_primitive_negative,-3,prime))

print(f'[INFO] Check Result Non Inverse:')
print(check_result)

print(f'[INFO] Result Non Inverse:')
print(matrix)

print(f'[INFO] Check Result Inverse:')
print(check_result_inv)

print(f'[INFO] Inverse Result Before Scaling:')
print(inv_matrix)
print(f'[INFO] Inverse Result After Scaling:')
print((inv_matrix * inv_N) % prime)
