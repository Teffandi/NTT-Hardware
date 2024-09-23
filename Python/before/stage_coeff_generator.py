import numpy as np
import math
from colorama import Fore
from colorama import Style


N = 8           # Change base on input point
prime = 7681    # Change prime Q

possible_primitive=[]       # List of possible n-th root of unity
verified_primitive=[]       # LIst of verified n-th root of unity
selected_primitive_positive = 3383  # Selected n-th root of unity

possible_primitive_negative=[]      # List of possible 2n-th root of unity
selected_primitive_negative = 1925  # Selected 2n-th root of unity


def primitive_search(prime) :
    # Function to find all possible n-th root of unity
    for i in range(2,prime):
        if(pow(i,N)%prime==1):
            possible_primitive.append(i)

def primitive_verification(possible_primitve,prime,N):
    # Function to verify possible n-th root of unity
    for scan in range(0,len(possible_primitive)-1):
        temp = int(possible_primitive[scan])
        for root_iterate in range(0,N+1):
            if(((pow(temp,root_iterate))%prime==1)&(root_iterate<N)):
                verified_primitive.append(temp)
            root_iterate = root_iterate+1
        scan = scan+1

def primitive_search_negative(prime,selected_primitive_positive) :
    # Function to find possible 2n-th root of unity
    for i in range(2,prime):
        if(pow(i,2)%prime==selected_primitive_positive):
            possible_primitive_negative.append(i)


# matrix variables
matrix = [[0]*N for i in range(N)]
inv_matrix = [[0]*N for i in range(N)]
power = [[0]*N for i in range(N)]
inv_power = [[0]*N for i in range(N)]
inv_N = pow(N,-1,prime)

# Generating bare matrix
def bare_matrix(N):
    global matrix, inv_matrix, power, inv_power, inv_N
    matrix = [[0]*N for i in range(N)]
    inv_matrix = [[0]*N for i in range(N)]
    for row in range(0,N):
        for col in range(0,N):
            # Periodicity
            power[row][col] = ( (2*(row*col)+col) % (2*N) )
            inv_power[col][row] = ( (2*(row*col)+col) % (2*N) )

            if (power[row][col]//N) % 2 == 1: # Symmetricity
                power[row][col] = power[row][col] % N
                inv_power[col][row] = inv_power[col][row]  % N
                matrix[row][col] = -1
                inv_matrix[col][row] = -1
            else:
                matrix[row][col] = 1
                inv_matrix[col][row] = 1

def matrix_gen(num,N):
    # num = 0 to output as string
    global matrix, inv_matrix, power, inv_power, inv_N
    bare_matrix(N)
    if num == 0:
        for row in range(0,N):
            for col in range(0,N):
                if matrix[row][col] == -1:
                    matrix[row][col] = f'- \u03c8^{power[row][col]}'
                else:
                    matrix[row][col] = f'\u03c8^{power[row][col]}'

                if inv_matrix[col][row] == -1:
                    inv_matrix[col][row] = f'- \u03c8^-{inv_power[col][row]}'
                else:
                    inv_matrix[col][row] = f'\u03c8^-{inv_power[col][row]}'
    else:
        for row in range(0,N):
            for col in range(0,N):
                matrix[row][col] *= pow(selected_primitive_negative,power[row][col],prime)
                inv_matrix[col][row] =  (inv_matrix[col][row] * pow(selected_primitive_negative,-power[col][row],prime) * inv_N) % prime

        matrix = matrix * 1
        # inv_matrix = (inv_matrix * inv_N) % prime


def periodicity_symmetricity(num,N):
    # Function to handle periodicity and symmetricity in for 2n-th root of unity
    power = num % (2*N)
    if (num//N) % 2 == 1:
        power %= N
        value = -1
    else:
        value = 1
    return power, value


radix = 2       # Change to the desired radix
num_of_stage = int(math.log(N,radix))
idx_stages = []
stages_power = [[0]*(N//radix) for i in range(num_of_stage)]
stages_val = [[0]*(N//radix) for i in range(num_of_stage)]
stages = [['' for i in range(num_of_stage)] for i in range(N)]


def stage_coeff(N):
    bare_matrix(N)
    print(f'''{Fore.GREEN}[INFO] {Style.RESET_ALL}Printing value of twiddle factor for all row.
Each row in the matrix shows stages incrementally
======================================================''')


    for i in range(N):
        idx = 1
        # print(f'{Fore.CYAN}=============== Row {i} {Style.RESET_ALL}:')
        for j in range(num_of_stage-1,-1,-1):
            # print(f'{Fore.MAGENTA}[STAGE {j}] {Style.RESET_ALL}')
            for k in range(idx):
                # print(f'k value: {k} \t index value: {idx}')
                temp_power1, temp_val1 = periodicity_symmetricity(power[i][k] - power[i][k],N)
                temp_power2, temp_val2 = periodicity_symmetricity(power[i][k+idx] - power[i][k],N)
                # print(f'Value K: {k} \tIndex: {i},{k} and {i},{k+idx}')
                
                # print(f'{Fore.GREEN}Previous: {temp_val1},{temp_val2}{Style.RESET_ALL}')

                temp_val1 *= matrix[i][k]
                temp_val2 *= matrix[i][k+idx]

                # print(f'{Fore.YELLOW}AFTER: {temp_val1},{temp_val2}{Style.RESET_ALL}')

                stages[i][j] += f'{temp_val1}\u03c8^{temp_power1},{temp_val2}\u03c8^{temp_power2}\t'
                
                if idx != N:
                    temp_idx = idx
                    for l in range(k,N,temp_idx):
                        # print(f'l value: {l}')
                        # print(f'{Fore.GREEN}Previous Matrix: {matrix[i][l]}{Style.RESET_ALL}')
                        if (l % 2) == 0:
                            matrix[i][l] *= temp_val1
                        else:
                            matrix[i][l] *= temp_val2
                        # print(f'{Fore.YELLOW}After Matrix: {matrix[i][l]}{Style.RESET_ALL}')
            idx *= 2

                
    
    for row in range(N):
        print(f'{Fore.CYAN}Row {row} {Style.RESET_ALL}:')

        for col in range(num_of_stage):
            print(f'{Fore.MAGENTA}[STAGE {col+1}] {Style.RESET_ALL}{stages[row][col]}')


    print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Printing Finished')



prime_moduli = 65537
degree = 2
print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Possible primitve n-th root of unity :')
primitive_search(prime_moduli)
print(possible_primitive)
print()
print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Verified primitve n-th root of unity :')
primitive_verification(possible_primitive,prime_moduli,4)
print(verified_primitive)
print()
if(verified_primitive):
    selected_primitive_negative = verified_primitive[0]
print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Primitve 2n-th root of unity :')
primitive_search_negative(prime_moduli,selected_primitive_positive)
print(possible_primitive_negative)


# bare_matrix()
# print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Bare Non Inverse:')
# print(np.matrix(matrix))

print()
print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Twiddle Factor Matrix :')
matrix_gen(1,8)
# print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Result Non Inverse:')
print(np.matrix(matrix))
# print()
# print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Result Inverse:')
# print(np.matrix(inv_matrix))


# print()
# matrix_gen(1)
# print(f'{Fore.GREEN}[INFO] {Style.RESET_ALL}Result Non Inverse With Value {selected_primitive_negative}:')
# print(np.matrix(matrix))

# print()
# stage_coeff()


print(np.matrix(power))
